Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbTBSXij>; Wed, 19 Feb 2003 18:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbTBSXij>; Wed, 19 Feb 2003 18:38:39 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:29714 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262038AbTBSXig>;
	Wed, 19 Feb 2003 18:38:36 -0500
Date: Wed, 19 Feb 2003 15:41:40 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [BK PATCH] LSM changes for 2.5.62
Message-ID: <20030219234140.GA18590@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the LSM changes that have been posted in the past.  They fix a
few bugs in some of the existing security hooks, and add a few more.
All of these patches have been discussed on lkml with no known
outstanding issues remaining about them.

Please pull from:
	bk://lsm.bkbits.net/linus-2.5

thanks,

greg k-h

 fs/dcache.c              |    9 +++
 fs/exportfs/expfs.c      |    5 -
 fs/file_table.c          |   35 +++++++++--
 fs/namei.c               |   27 +++------
 fs/nfsd/vfs.c            |    9 +--
 fs/super.c               |   28 +++++++--
 include/linux/fs.h       |   15 ++++-
 include/linux/security.h |  141 ++++++++++++++++++++++++++++++++++++-----------
 kernel/ksyms.c           |   12 ++--
 kernel/printk.c          |    7 +-
 kernel/sys.c             |   42 ++++++++++----
 kernel/sysctl.c          |    5 +
 security/capability.c    |   21 +++++++
 security/dummy.c         |   66 ++++++++++++++++++----
 14 files changed, 319 insertions(+), 103 deletions(-)
-----

ChangeSet@1.994, 2003-02-19 14:58:39-08:00, greg@kroah.com
  LSM: fix merge where we lost a prototype in security.h

 include/linux/security.h |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.993, 2003-02-19 14:13:12-08:00, greg@kroah.com
  Merge kroah.com:/home/greg/linux/BK/bleeding_edge-2.5
  into kroah.com:/home/greg/linux/BK/lsm-2.5

 kernel/ksyms.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)
------

ChangeSet@1.914.163.3, 2003-02-17 14:32:23-08:00, sds@epoch.ncsc.mil
  [PATCH] LSM: coding style fixups in sb_kern_mount
  
  This patch moves the error handling code for the sb_kern_mount hook call
  out of line, per Christoph Hellwig's suggestion.

 fs/super.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)
------

ChangeSet@1.914.163.2, 2003-02-17 12:08:28-08:00, greg@kroah.com
  Merge kroah.com:/home/greg/linux/BK/bleeding_edge-2.5
  into kroah.com:/home/greg/linux/BK/lsm-2.5

 security/capability.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.914.163.1, 2003-02-16 08:54:55-08:00, greg@kroah.com
  merge

 fs/dcache.c              |    3 ++
 fs/namei.c               |    9 ++----
 include/linux/fs.h       |    5 ++-
 include/linux/security.h |   69 ++++++++++++++++++++++++++++++++++++-----------
 kernel/ksyms.c           |    3 +-
 kernel/sys.c             |   21 ++++++++++----
 security/capability.c    |   10 ++++++
 security/dummy.c         |   33 ++++++++++++++++++----
 8 files changed, 118 insertions(+), 35 deletions(-)
------

ChangeSet@1.914.81.3, 2003-02-05 14:37:12+11:00, sds@epoch.ncsc.mil
  [PATCH] LSM: Add LSM syslog hook to 2.5.59
  
  This patch adds the LSM security_syslog hook for controlling the
  syslog(2) interface relative to 2.5.59 plus the previously posted
  security_sysctl patch.  In response to earlier comments by Christoph,
  the existing capability check for syslog(2) is moved into the
  capability security module hook function, and a corresponding dummy
  security module hook function is defined that provides traditional
  superuser behavior.  The LSM hook is placed in do_syslog rather than
  sys_syslog so that it is called when either the system call interface
  or the /proc/kmsg interface is used.  SELinux uses this hook to
  control access to the kernel message ring and to the console log
  level.

 include/linux/security.h |   18 ++++++++++++++++++
 kernel/printk.c          |    7 +++++--
 security/capability.c    |   10 ++++++++++
 security/dummy.c         |    8 ++++++++
 4 files changed, 41 insertions(+), 2 deletions(-)
------

ChangeSet@1.914.81.2, 2003-02-05 14:32:08+11:00, sds@epoch.ncsc.mil
  [PATCH] LSM: Add LSM sysctl hook to 2.5.59
  
  This patch adds a LSM sysctl hook for controlling access to
  sysctl variables to 2.5.59, split out from the lsm-2.5 BitKeeper tree.
  SELinux uses this hook to control such accesses in accordance with the
  security policy configuration.

 include/linux/security.h |   17 +++++++++++++++++
 kernel/sysctl.c          |    5 +++++
 security/dummy.c         |    6 ++++++
 3 files changed, 28 insertions(+)
------

ChangeSet@1.914.81.1, 2003-02-04 15:07:23-08:00, gregkh@kernel.bkbits.net
  Merge bk://lsm.bkbits.net/linus-2.5
  into kernel.bkbits.net:/home/gregkh/linux/lsm-2.5

 fs/dcache.c        |    3 +++
 fs/namei.c         |    9 +++------
 fs/super.c         |    8 ++++++++
 include/linux/fs.h |    5 ++++-
 kernel/ksyms.c     |    3 ++-
 5 files changed, 20 insertions(+), 8 deletions(-)
------

ChangeSet@1.914.34.4, 2003-01-16 14:54:42-08:00, sds@epoch.ncsc.mil
  [PATCH] Restore LSM hook calls to setpriority and setpgid
  
  This patch restores the LSM hook calls in setpriority and setpgid to
  2.5.58.  These hooks were previously added as of 2.5.27, but the hook
  calls were subsequently lost as a result of other changes to the code
  as of 2.5.37.
  
  Ingo has signed off on this patch, and no one else has objected.

 kernel/sys.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)
------

ChangeSet@1.914.34.3, 2003-01-16 14:35:24-08:00, sds@epoch.ncsc.mil
  [PATCH] allocate and free security structures for private files
  
  This patch adds a security_file_alloc call to init_private_file and
  creates a close_private_file function to encapsulate the release of
  private file structures.  These changes ensure that security
  structures for private files will be allocated and freed
  appropriately.  Per Andi Kleen's comments, the patch also renames
  init_private_file to open_private_file to force updating of all
  callers, since they will also need to be updated to use
  close_private_file to avoid a leak of the security structure.  Per
  Christoph Hellwig's comments, the patch also replaces the 'mode'
  argument with a 'flags' argument, computing the f_mode from the flags,
  and it explicitly tests f_op prior to dereferencing, as in
  dentry_open().

 fs/exportfs/expfs.c |    5 ++---
 fs/file_table.c     |   35 +++++++++++++++++++++++++++--------
 fs/nfsd/vfs.c       |    9 +++------
 include/linux/fs.h  |    5 ++++-
 kernel/ksyms.c      |    3 ++-
 5 files changed, 38 insertions(+), 19 deletions(-)
------

ChangeSet@1.914.34.2, 2003-01-16 14:23:59-08:00, sds@epoch.ncsc.mil
  [PATCH] Replace inode_post_lookup hook with d_instantiate hook
  
  This patch removes the security_inode_post_lookup hook entirely and
  adds a security_d_instantiate hook call to the d_instantiate function
  and the d_splice_alias function.  The inode_post_lookup hook was
  subject to races since the inode is already accessible through the
  dcache before it is called, didn't handle filesystems that directly
  populate the dcache, and wasn't always called in the desired context
  (e.g. for pipe, shmem, and devpts inodes).  The d_instantiate hook
  enables initialization of the inode security information.  This hook
  is used by SELinux and by DTE to setup the inode security state, and
  eliminated the need for the inode_precondition function in SELinux.

 fs/dcache.c              |    3 +++
 fs/namei.c               |    9 +++------
 include/linux/security.h |   25 ++++++++++---------------
 security/dummy.c         |   13 +++++++------
 4 files changed, 23 insertions(+), 27 deletions(-)
------

ChangeSet@1.914.34.1, 2003-01-16 14:18:05-08:00, sds@epoch.ncsc.mil
  [PATCH] Add LSM hook to do_kern_mount
  
  This patch adds a security_sb_kern_mount hook call to the do_kern_mount
  function.  This hook enables initialization of the superblock security
  information of all superblock objects.  Placing a hook in do_kern_mount
  was originally suggested by Al Viro.  This hook is used by SELinux to
  setup the superblock security state and eliminated the need for the
  superblock_precondition function.

 fs/super.c               |    8 ++++++++
 include/linux/security.h |   11 +++++++++++
 security/dummy.c         |    6 ++++++
 3 files changed, 25 insertions(+)
------

