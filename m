Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbTEVRsY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 13:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbTEVRsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 13:48:19 -0400
Received: from dhcp05.ists.dartmouth.edu ([129.170.249.105]:1666 "EHLO
	uml.karaya.com") by vger.kernel.org with ESMTP id S262903AbTEVRqV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 13:46:21 -0400
Message-Id: <200305221759.h4MHxIEL013265@uml.karaya.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML fixes 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 22 May 2003 13:59:18 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/fixes-2.5

This fixes a number of UML bugs:

	fixed a couple stray instances of hard-coded kernel stack sizes
	the special root hostfs support is gone since it was unneeded
	skas mode now has sound and SIGWINCH support
	fixed a timer deadlock
	fixed some signal blocking bugs
	updated the ubd driver to the new block and devfs APIs
	fixed calls to schedule_tail
	fixed a few SMP deadlocks
	the ubd driver locks its device files
	flush stdout before entering the kernel
	fix a uaccess fencepost bug
	fix a 'tracing myself' bug
	code cleanup
	error message fixes

				Jeff

 arch/um/drivers/chan_user.c           |    4 
 arch/um/drivers/hostaudio_kern.c      |   77 ++++++++++++++++-
 arch/um/drivers/line.c                |   36 ++++----
 arch/um/drivers/ssl.c                 |    4 
 arch/um/drivers/ubd_kern.c            |  148 ++++++++++++++++------------------
 arch/um/drivers/ubd_user.c            |   58 +++++++------
 arch/um/include/kern_util.h           |    7 -
 arch/um/include/mem.h                 |    1 
 arch/um/include/os.h                  |    2 
 arch/um/include/ubd_user.h            |    1 
 arch/um/include/user_util.h           |    1 
 arch/um/kernel/exec_kern.c            |    5 +
 arch/um/kernel/init_task.c            |    6 -
 arch/um/kernel/irq.c                  |   12 +-
 arch/um/kernel/mem.c                  |   11 --
 arch/um/kernel/mem_user.c             |   10 +-
 arch/um/kernel/process.c              |    4 
 arch/um/kernel/process_kern.c         |   18 ++--
 arch/um/kernel/skas/include/mode.h    |    1 
 arch/um/kernel/skas/include/uaccess.h |    2 
 arch/um/kernel/skas/process.c         |   16 +++
 arch/um/kernel/skas/process_kern.c    |   12 +-
 arch/um/kernel/sys_call_table.c       |   36 +++++---
 arch/um/kernel/time.c                 |    7 -
 arch/um/kernel/time_kern.c            |    9 +-
 arch/um/kernel/trap_kern.c            |    6 +
 arch/um/kernel/trap_user.c            |    2 
 arch/um/kernel/tt/include/uaccess.h   |   31 ++++---
 arch/um/kernel/tt/process_kern.c      |   32 +++----
 arch/um/kernel/tt/tracer.c            |    4 
 arch/um/kernel/tt/uaccess_user.c      |   14 +++
 arch/um/kernel/tty_log.c              |  111 ++++++++++++++++++++++---
 arch/um/kernel/um_arch.c              |   19 ++--
 arch/um/kernel/umid.c                 |   47 ++++++----
 arch/um/kernel/user_util.c            |   11 --
 arch/um/os-Linux/file.c               |   31 +++++++
 include/asm-um/common.lds.S           |   12 ++
 include/asm-um/thread_info.h          |    9 +-
 38 files changed, 533 insertions(+), 284 deletions(-)

ChangeSet@1.1082, 2003-05-15 16:17:32-04:00, jdike@uml.karaya.com
  Got rid of set_kmem_end since no one calls it.

ChangeSet@1.1042.83.5, 2003-05-13 13:45:50-04:00, jdike@uml.karaya.com
  Fixed a couple instances of hard-coded stack sizes.

ChangeSet@1.1042.83.4, 2003-05-05 08:54:23-04:00, jdike@uml.karaya.com
  Updates to 2.5.68, which are going in this pool to keep the merging
  clean.

ChangeSet@1.1042.83.3, 2003-05-02 14:12:46-04:00, jdike@uml.karaya.com
  Merged a bunch of fixes from 2.4.

ChangeSet@1.1042.83.2, 2003-05-02 13:06:24-04:00, jdike@uml.karaya.com
  Merged a bunch of fixes from 2.4.
  skas mode has sound and SIGWINCH support.
  root hostfs is gone.
  Some small code cleanups.

ChangeSet@1.1042.83.1, 2003-05-02 11:00:41-04:00, jdike@jdike.wstearns.org
  Merged hch's devfs-ectomy.

ChangeSet@1.971.47.3, 2003-03-27 23:13:21-05:00, jdike@uml.karaya.com
  Fixed a call to devfs_mk_dir.

ChangeSet@1.971.47.2, 2003-03-27 21:40:19-05:00, jdike@uml.karaya.com
  Fixed the ubd driver call to devfs_mk_symlink.

ChangeSet@1.971.47.1, 2003-03-27 15:29:35-05:00, jdike@uml.karaya.com
  .66 conflict fixes.

ChangeSet@1.889.410.2, 2003-03-27 13:44:02-05:00, jdike@uml.karaya.com
  Fixed a register_blkdev call.

ChangeSet@1.889.410.1, 2003-03-22 15:37:52-05:00, jdike@uml.karaya.com
  Merged the 2.5.65 conflicts.

ChangeSet@1.889.258.2, 2003-02-25 00:44:11-05:00, jdike@uml.karaya.com
  Fixed the calls to schedule_tail to not be conditional on CONFIG_SMP,
  to be conditional on current->thread.prev_sched being non-NULL,
  and to pass current->thread.prev_sched in to schedule_tail.

ChangeSet@1.889.206.4, 2003-02-24 21:59:25-05:00, jdike@uml.karaya.com
  Fixed a bug with the initialization of the mode that a device file
  is opened with.

ChangeSet@1.889.206.3, 2003-02-24 01:48:30-05:00, jdike@uml.karaya.com
  Fixed a deadlock caused by not disabling interrupts around a call
  to update_process_times.

ChangeSet@1.889.206.2, 2003-02-23 14:50:33-05:00, jdike@uml.karaya.com
  Made some minor fixes to get rid of some unneeded code, improve
  a panic message, and fix a signal blocking bug.

ChangeSet@1.889.206.1, 2003-02-19 11:05:33-05:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/fixes-2.5

ChangeSet@1.889.124.2, 2003-02-19 09:55:14-05:00, jdike@uml.karaya.com
  Fixed signal blocking and cleaned up the code a bit.

ChangeSet@1.889.99.32, 2003-02-07 13:48:13-05:00, jdike@uml.karaya.com
  Fixed a few compilation bugs in the ubd changes.

ChangeSet@1.889.99.31, 2003-02-07 12:52:23-05:00, jdike@uml.karaya.com
  Merged in changes from 2.4 up to 2.4.19-50.
  The ubd driver locks its files.
  Merged a bunch of ubd fixes from James McMechan.
  stdout is now flushed before entering the kernel.
  Fixed a uaccess fencepost bug.
  Fixed a 'tracing myself' bug.
  Various other cleanups and error message fixes.

