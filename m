Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261329AbSJHXDm>; Tue, 8 Oct 2002 19:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbSJHXDm>; Tue, 8 Oct 2002 19:03:42 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:43017 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261329AbSJHXDM>;
	Tue, 8 Oct 2002 19:03:12 -0400
Date: Tue, 8 Oct 2002 16:05:06 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [BK PATCH] LSM changes for 2.5.40
Message-ID: <20021008230506.GA11247@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some patches against the latest 2.5 BK tree that add some
further LSM hooks and documenation to the tree.  There is also one minor
change to fs/inode.c to allow security modules to know more information
about newly created inodes.

Please pull from bk://lsm.bkbits.net/linus-2.5

thanks,

greg k-h


 Documentation/DocBook/Makefile        |    2 
 Documentation/DocBook/kernel-api.tmpl |    5 
 Documentation/DocBook/lsm.tmpl        |  285 ++++++++++++++++++++++++++++++++++
 fs/inode.c                            |   16 -
 include/linux/ipc.h                   |    1 
 include/linux/security.h              |   55 ++++++
 ipc/msg.c                             |   11 +
 ipc/sem.c                             |   11 +
 ipc/shm.c                             |   10 +
 ipc/util.c                            |    3 
 security/capability.c                 |   46 +++++
 security/dummy.c                      |   47 +++++
 12 files changed, 482 insertions(+), 10 deletions(-)
-----

ChangeSet@1.707, 2002-10-08 14:53:21-07:00, chris@wirex.com
  [PATCH] LSM: move the inode_alloc_security hook.
  
  This moves the inode_alloc_security() hook so that we have all of the
  inode information at the moment of the hook.

 fs/inode.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)
------

ChangeSet@1.706, 2002-10-08 14:48:44-07:00, greg@kroah.com
  LSM: added lsm documentation to the tree.

 Documentation/DocBook/Makefile        |    2 
 Documentation/DocBook/kernel-api.tmpl |    5 
 Documentation/DocBook/lsm.tmpl        |  285 ++++++++++++++++++++++++++++++++++
 3 files changed, 291 insertions(+), 1 deletion(-)
------

ChangeSet@1.705, 2002-10-08 14:10:38-07:00, sds@tislabs.com
  [PATCH] Base set of LSM hooks for SysV IPC
  
  The patch below adds the base set of LSM hooks for System V IPC to the
  2.5.41 kernel.  These hooks permit a security module to label
  semaphore sets, message queues, and shared memory segments and to
  perform security checks on these objects that parallel the existing
  IPC access checks.  Additional LSM hooks for labeling and controlling
  individual messages sent on a single message queue and for providing
  fine-grained distinctions among IPC operations will be submitted
  separately after this base set of LSM IPC hooks has been accepted.

 include/linux/ipc.h      |    1 
 include/linux/security.h |   55 +++++++++++++++++++++++++++++++++++++++++++++++
 ipc/msg.c                |   11 +++++++++
 ipc/sem.c                |   11 +++++++++
 ipc/shm.c                |   10 ++++++++
 ipc/util.c               |    3 +-
 security/capability.c    |   46 +++++++++++++++++++++++++++++++++++++++
 security/dummy.c         |   47 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 183 insertions(+), 1 deletion(-)
------

