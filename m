Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318560AbSGZW2S>; Fri, 26 Jul 2002 18:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318572AbSGZW2S>; Fri, 26 Jul 2002 18:28:18 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:44300 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318560AbSGZW2P>;
	Fri, 26 Jul 2002 18:28:15 -0400
Date: Fri, 26 Jul 2002 15:30:54 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [BK PATCH] LSM changes for 2.5.28
Message-ID: <20020726223054.GA23483@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These changesets contain some changes to the different arch config.in
menus to pull in the security menu so they correctly use the
capabilities code, some CREDIT file updates, and the file specific LSM
hooks.

Please pull from:  bk://lsm.bkbits.net/linus-2.5

thanks,

greg k-h


 CREDITS                   |   32 ++
 arch/alpha/config.in      |    1 
 arch/arm/config.in        |    1 
 arch/cris/config.in       |    4 
 arch/ia64/config.in       |    2 
 arch/ia64/kernel/ptrace.c |    4 
 arch/m68k/config.in       |    2 
 arch/mips/config.in       |    1 
 arch/mips64/config.in     |    1 
 arch/parisc/config.in     |    1 
 arch/ppc/config.in        |    9 
 arch/ppc64/config.in      |    7 
 arch/s390/config.in       |    1 
 arch/s390x/config.in      |    1 
 arch/sh/config.in         |    1 
 arch/sparc/config.in      |    1 
 arch/sparc64/config.in    |    1 
 arch/x86_64/config.in     |    1 
 drivers/char/tty_io.c     |   44 +--
 fs/attr.c                 |   11 
 fs/dnotify.c              |    8 
 fs/dquot.c                |    3 
 fs/fcntl.c                |   25 +
 fs/file_table.c           |    9 
 fs/inode.c                |   12 
 fs/ioctl.c                |    8 
 fs/locks.c                |   20 +
 fs/namei.c                |  143 ++++++++--
 fs/namespace.c            |   27 ++
 fs/open.c                 |    4 
 fs/proc/base.c            |    4 
 fs/quota.c                |    4 
 fs/read_write.c           |   90 +++++-
 fs/readdir.c              |    5 
 fs/stat.c                 |   13 
 fs/super.c                |    9 
 fs/xattr.c                |   17 +
 include/linux/fs.h        |   43 +++
 include/linux/security.h  |  430 ++++++++++++++++++++++++++++++++
 init/do_mounts.c          |    1 
 kernel/acct.c             |    5 
 mm/filemap.c              |    9 
 mm/mmap.c                 |    5 
 mm/mprotect.c             |    5 
 net/core/scm.c            |    4 
 security/capability.c     |  608 ++++++++++++++++++++++++++++++++++++---------
 security/dummy.c          |  612 ++++++++++++++++++++++++++++++++++++----------
 47 files changed, 1916 insertions(+), 333 deletions(-)
------


ChangeSet@1.469, 2002-07-25 11:48:05-07:00, greg@kroah.com
  Merge kroah.com:/home/greg/linux/BK/bleeding_edge-2.5
  into kroah.com:/home/greg/linux/BK/lsm-2.5

 arch/ppc/config.in    |    3 +++
 drivers/char/tty_io.c |    4 ++++
 fs/proc/base.c        |    2 +-
 fs/read_write.c       |   45 +++++++++++++++++++++++++++++++++++----------
 include/linux/fs.h    |    5 +++++
 5 files changed, 48 insertions(+), 11 deletions(-)
------

ChangeSet@1.403.168.1, 2002-07-24 09:27:51-07:00, greg@kroah.com
  Merge kroah.com:/home/greg/linux/BK/bleeding_edge-2.5
  into kroah.com:/home/greg/linux/BK/lsm-2.5

 arch/m68k/config.in   |    1 +
 arch/ppc/config.in    |    3 +++
 arch/ppc64/config.in  |    6 ++++++
 drivers/char/tty_io.c |   10 +++++-----
 4 files changed, 15 insertions(+), 5 deletions(-)
------

ChangeSet@1.403.162.3, 2002-07-24 09:15:46-07:00, jmorris@intercode.com.au
  [PATCH] credits update
  
  Added LSM credit entry

 CREDITS |    8 ++++++++
 1 files changed, 8 insertions(+)
------

ChangeSet@1.403.162.2, 2002-07-22 14:44:56-07:00, greg@kroah.com
  LSM: fixed typo that happened in merge

 security/dummy.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.403.162.1, 2002-07-22 14:20:35-07:00, greg@kroah.com
  Merge kroah.com:/home/greg/linux/BK/bleeding_edge-2.5
  into kroah.com:/home/greg/linux/BK/work-2.5

 fs/namei.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)
------

ChangeSet@1.403.160.8, 2002-07-22 14:17:41-07:00, greg@kroah.com
  LSM: convert initializers to C99 style.

 security/capability.c |  106 ++++++++++++++++++++++++------------------------
 security/dummy.c      |  110 +++++++++++++++++++++++++-------------------------
 2 files changed, 108 insertions(+), 108 deletions(-)
------

ChangeSet@1.403.160.7, 2002-07-22 14:06:28-07:00, greg@kroah.com
  merge

 drivers/char/tty_io.c |   26 ++++++-----------
 fs/namei.c            |   10 +-----
 include/linux/fs.h    |   33 ++++++++++++++++++++-
 security/capability.c |   76 +++++++++++++++++++++++++-------------------------
 security/dummy.c      |   70 +++++++++++++++++++++++-----------------------
 5 files changed, 117 insertions(+), 98 deletions(-)
------

ChangeSet@1.403.161.1, 2002-07-22 13:50:01-07:00, sds@tislabs.com
  [PATCH] LSM: file related LSM hooks
  
  The below patch adds the filesystem-related LSM hooks, specifically the
  super_block, inode, and file hooks, to the 2.5.27 kernel.

 drivers/char/tty_io.c    |    4 
 fs/attr.c                |   11 -
 fs/dnotify.c             |    8 
 fs/dquot.c               |    3 
 fs/fcntl.c               |   25 ++
 fs/file_table.c          |    9 
 fs/inode.c               |   12 +
 fs/ioctl.c               |    8 
 fs/locks.c               |   20 ++
 fs/namei.c               |  127 ++++++++++---
 fs/namespace.c           |   27 ++
 fs/open.c                |    4 
 fs/proc/base.c           |    2 
 fs/quota.c               |    4 
 fs/read_write.c          |   45 +++-
 fs/readdir.c             |    5 
 fs/stat.c                |   13 +
 fs/super.c               |    9 
 fs/xattr.c               |   17 +
 include/linux/fs.h       |    5 
 include/linux/security.h |  430 +++++++++++++++++++++++++++++++++++++++++++++++
 init/do_mounts.c         |    1 
 kernel/acct.c            |    5 
 mm/filemap.c             |    9 
 mm/mmap.c                |    5 
 mm/mprotect.c            |    5 
 net/core/scm.c           |    4 
 security/capability.c    |  362 +++++++++++++++++++++++++++++++++++++++
 security/dummy.c         |  366 ++++++++++++++++++++++++++++++++++++++++
 29 files changed, 1501 insertions(+), 44 deletions(-)
------

ChangeSet@1.403.160.6, 2002-07-22 13:21:07-07:00, chris@wirex.com
  [PATCH] LSM: CREDITS entry
  

 CREDITS |    8 ++++++++
 1 files changed, 8 insertions(+)
------

ChangeSet@1.403.160.5, 2002-07-22 12:32:00-07:00, greg@kroah.com
  added ptrace hook for ia64

 arch/ia64/kernel/ptrace.c |    4 ++++
 1 files changed, 4 insertions(+)
------

ChangeSet@1.403.160.4, 2002-07-22 12:29:42-07:00, greg@kroah.com
  updated my CREDITS entry.

 CREDITS |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.403.160.3, 2002-07-22 12:26:00-07:00, sds@tislabs.com
  [PATCH] LSM: CREDITS entries
  
  Here are CREDITS entries for myself and my two colleagues who also
  contributed to LSM.

 CREDITS |   15 +++++++++++++++
 1 files changed, 15 insertions(+)
------

ChangeSet@1.403.160.2, 2002-07-22 11:55:00-07:00, greg@kroah.com
  LSM: fixed up all of the other archs (non i386) to include the security config menu.

 arch/alpha/config.in   |    1 +
 arch/arm/config.in     |    1 +
 arch/cris/config.in    |    4 +++-
 arch/ia64/config.in    |    2 ++
 arch/m68k/config.in    |    1 +
 arch/mips/config.in    |    1 +
 arch/mips64/config.in  |    1 +
 arch/parisc/config.in  |    1 +
 arch/ppc/config.in     |    3 +++
 arch/ppc64/config.in   |    1 +
 arch/s390/config.in    |    1 +
 arch/s390x/config.in   |    1 +
 arch/sh/config.in      |    1 +
 arch/sparc/config.in   |    1 +
 arch/sparc64/config.in |    1 +
 arch/x86_64/config.in  |    1 +
 16 files changed, 21 insertions(+), 1 deletion(-)
------

ChangeSet@1.403.160.1, 2002-07-22 10:11:56-07:00, adam@skullslayer.rod.org
  [PATCH] LSM to designated initializers
  
  Over the last few days there has been discussion on the
  LKML list about converting struct initializers from the
      field:    val,
  format into
      .field =  val,
  
  I have included a patch that will do this for both the
  dummy and capabilities files.

except that the repository that you are pushing to is 20 changesets
ahead of your repository. Please do a "bk pull" to get 
these changes or do a "bk pull -nl" to see what they are.
 security/capability.c |   64 +++++++++++++++++++++++++-------------------------
 security/dummy.c      |   64 +++++++++++++++++++++++++-------------------------
 2 files changed, 64 insertions(+), 64 deletions(-)
------
