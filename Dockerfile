# Elmer FEM (CSC) with gmsh, headless, for multiphysics incl. thermal radiation (view factors).
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends software-properties-common gpg-agent \
    && add-apt-repository -y ppa:elmer-csc-ubuntu/elmer-csc-ppa \
    && apt-get update && apt-get install -y --no-install-recommends \
        elmerfem-csc gmsh python3 python3-numpy openmpi-bin openssh-server rsync wget ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && ElmerSolver -v | head -5

# Vast.ai (and similar hosts) add SSH keys at start-up; sshd refuses them if /root has loose modes
RUN chmod 700 /root && mkdir -p /root/.ssh && chmod 700 /root/.ssh \
    && printf "StrictModes no\n" > /etc/ssh/sshd_config.d/10-hosted-keys.conf

WORKDIR /workspace
