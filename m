Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264901AbSK0XHQ>; Wed, 27 Nov 2002 18:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbSK0XHQ>; Wed, 27 Nov 2002 18:07:16 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:261 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264901AbSK0XHO>;
	Wed, 27 Nov 2002 18:07:14 -0500
Date: Wed, 27 Nov 2002 15:06:27 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [BK PATCH] More LSM changes for 2.5.49
Message-ID: <20021127230626.GB7187@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some patches that change the way I had previoulsy written the
if {} statments for the LSM hooks in the last round of patches.  This
should make them more readable, sorry for the previous version.  I've
also included a patch for a place where I had missed the conversion of
the hooks in the last merge in the hugetlbfs code.

Please pull from:
	bk://lsm.bkbits.net/linus-2.5

thanks,

greg k-h

 arch/arm/kernel/ptrace.c          |    3 +-
 arch/i386/kernel/ptrace.c         |    3 +-
 arch/ia64/kernel/ptrace.c         |    3 +-
 arch/ppc/kernel/ptrace.c          |    3 +-
 arch/ppc64/kernel/ptrace.c        |    3 +-
 arch/ppc64/kernel/ptrace32.c      |    3 +-
 arch/ppc64/kernel/sys_ppc32.c     |    3 +-
 arch/s390/kernel/ptrace.c         |    3 +-
 arch/s390x/kernel/ptrace.c        |    3 +-
 arch/sparc/kernel/ptrace.c        |    3 +-
 arch/sparc64/kernel/ptrace.c      |    3 +-
 arch/sparc64/kernel/sys_sparc32.c |    3 +-
 arch/um/kernel/ptrace.c           |    3 +-
 arch/x86_64/kernel/ptrace.c       |    3 +-
 fs/attr.c                         |    3 +-
 fs/dquot.c                        |    3 +-
 fs/exec.c                         |    9 +++++---
 fs/fcntl.c                        |    9 +++++---
 fs/hugetlbfs/inode.c              |    4 +--
 fs/ioctl.c                        |    3 +-
 fs/locks.c                        |   12 +++++++---
 fs/namei.c                        |   33 +++++++++++++++++++----------
 fs/namespace.c                    |   12 +++++++---
 fs/open.c                         |    3 +-
 fs/read_write.c                   |    6 +++--
 fs/readdir.c                      |    3 +-
 fs/stat.c                         |    6 +++--
 fs/xattr.c                        |   12 +++++++---
 ipc/msg.c                         |    3 +-
 ipc/sem.c                         |    3 +-
 ipc/shm.c                         |    3 +-
 kernel/acct.c                     |    3 +-
 kernel/fork.c                     |    3 +-
 kernel/ptrace.c                   |    3 +-
 kernel/sched.c                    |   15 +++++++++----
 kernel/signal.c                   |    3 +-
 kernel/sys.c                      |   42 +++++++++++++++++++++++++-------------
 kernel/uid16.c                    |    3 +-
 mm/mmap.c                         |    3 +-
 mm/mprotect.c                     |    3 +-
 net/core/scm.c                    |    3 +-
 41 files changed, 166 insertions(+), 84 deletions(-)
-----

ChangeSet@1.929, 2002-11-27 15:14:22-08:00, greg@kroah.com
  LSM: change if statements into something more readable for the arch/* files.

 arch/arm/kernel/ptrace.c          |    3 ++-
 arch/i386/kernel/ptrace.c         |    3 ++-
 arch/ia64/kernel/ptrace.c         |    3 ++-
 arch/ppc/kernel/ptrace.c          |    3 ++-
 arch/ppc64/kernel/ptrace.c        |    3 ++-
 arch/ppc64/kernel/ptrace32.c      |    3 ++-
 arch/ppc64/kernel/sys_ppc32.c     |    3 ++-
 arch/s390/kernel/ptrace.c         |    3 ++-
 arch/s390x/kernel/ptrace.c        |    3 ++-
 arch/sparc/kernel/ptrace.c        |    3 ++-
 arch/sparc64/kernel/ptrace.c      |    3 ++-
 arch/sparc64/kernel/sys_sparc32.c |    3 ++-
 arch/um/kernel/ptrace.c           |    3 ++-
 arch/x86_64/kernel/ptrace.c       |    3 ++-
 14 files changed, 28 insertions(+), 14 deletions(-)
------

ChangeSet@1.928, 2002-11-27 15:13:40-08:00, greg@kroah.com
  LSM: change if statements into something more readable for the kernel.* files.

 kernel/acct.c   |    3 ++-
 kernel/fork.c   |    3 ++-
 kernel/ptrace.c |    3 ++-
 kernel/sched.c  |   15 ++++++++++-----
 kernel/signal.c |    3 ++-
 kernel/sys.c    |   42 ++++++++++++++++++++++++++++--------------
 kernel/uid16.c  |    3 ++-
 7 files changed, 48 insertions(+), 24 deletions(-)
------

ChangeSet@1.927, 2002-11-27 15:12:52-08:00, greg@kroah.com
  LSM: change if statements into something more readable for the ipc/*, mm/*, and net/* files.

 ipc/msg.c      |    3 ++-
 ipc/sem.c      |    3 ++-
 ipc/shm.c      |    3 ++-
 mm/mmap.c      |    3 ++-
 mm/mprotect.c  |    3 ++-
 net/core/scm.c |    3 ++-
 6 files changed, 12 insertions(+), 6 deletions(-)
------

ChangeSet@1.926, 2002-11-27 15:11:25-08:00, greg@kroah.com
  LSM: change if statements into something more readable for the fs/* files.

 fs/attr.c       |    3 ++-
 fs/dquot.c      |    3 ++-
 fs/exec.c       |    9 ++++++---
 fs/fcntl.c      |    9 ++++++---
 fs/ioctl.c      |    3 ++-
 fs/locks.c      |   12 ++++++++----
 fs/namei.c      |   33 ++++++++++++++++++++++-----------
 fs/namespace.c  |   12 ++++++++----
 fs/open.c       |    3 ++-
 fs/read_write.c |    6 ++++--
 fs/readdir.c    |    3 ++-
 fs/stat.c       |    6 ++++--
 fs/xattr.c      |   12 ++++++++----
 13 files changed, 76 insertions(+), 38 deletions(-)
------

ChangeSet@1.925, 2002-11-27 15:09:52-08:00, greg@kroah.com
  LSM: fix conversions in hugetlbfs that I missed in the last merge.

 fs/hugetlbfs/inode.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

