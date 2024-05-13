#!/usr/bin/bash

make pack -C ../2024csc-projects/project_3/
cp ../2024csc-projects/project_3/109550014-109611087.zip .
docker build -t csc2024-project3 -f csc2024-project3.Dockerfile .
docker compose -f csc2024-project3-docker-compose.yml down
docker compose -f csc2024-project3-docker-compose.yml up -d
rm -f ./109550014-109611087.zip

SESSION="csc2024-project3"

tmux -2 new-session -d -s $SESSION

tmux new-window -t $SESSION:1 -n 'test'

tmux split-window -h

tmux select-pane -t 0
tmux send-keys 'docker exec -it victim /bin/bash' C-m

tmux select-pane -t 1
tmux send-keys 'docker exec -it attacker /bin/bash' C-m

tmux select-window $SESSION:1

tmux -2 attach-session -t $SESSION
