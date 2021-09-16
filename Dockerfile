FROM python:3.8-alpine

RUN echo "===> Installing sudo to emulate normal OS behavior..."  && \
    apk --update add sudo                                         && \
    \
    \
    echo "===> Adding Packages runtime..."                 && \
    apk --update add openssl ca-certificates bash curl git && \
    apk --update add --virtual build-dependencies \
                               libffi-dev openssl-dev build-base  && \
    pip install --upgrade pip cffi cryptography==3.3.2            && \
    \
    \
    echo "===> Installing Ansible..."  && \
    pip install ansible==2.9.22        && \
    \
    \
    echo "===> Installing handy tools (not absolutely required)..."  && \
    pip install --upgrade pycrypto pywinrm         && \
    apk --update add sshpass openssh-client rsync  && \
    \
    \
    echo "===> Removing package list..."  && \
    apk del build-dependencies            && \
    rm -rf /var/cache/apk/*               && \
    \
    \
    echo "===> Adding hosts for convenience..."  && \
    mkdir -p /etc/ansible                        && \
    echo 'localhost' > /etc/ansible/hosts


# default command: display Ansible version
CMD [ "ansible", "--version" ]
