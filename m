Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263142AbTC1UmL>; Fri, 28 Mar 2003 15:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263140AbTC1UlM>; Fri, 28 Mar 2003 15:41:12 -0500
Received: from mnh-1-18.mv.com ([207.22.10.50]:50949 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S263135AbTC1UlG>;
	Fri, 28 Mar 2003 15:41:06 -0500
Message-Id: <200303282050.PAA03200@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Mar 2003 15:50:42 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/fixes-2.5

This fixes a number of UML bugs:
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

 arch/um/drivers/line.c                |    6 
 arch/um/drivers/ubd_kern.c            |  224 +++++++++++++++++++---------------
 arch/um/drivers/ubd_user.c            |   44 ++++--
 arch/um/include/os.h                  |    2 
 arch/um/kernel/mem.c                  |    2 
 arch/um/kernel/process.c              |    3 
 arch/um/kernel/skas/include/uaccess.h |    2 
 arch/um/kernel/skas/process_kern.c    |   10 -
 arch/um/kernel/time_kern.c            |    2 
 arch/um/kernel/tt/process_kern.c      |   26 +--
 arch/um/kernel/um_arch.c              |    1 
 arch/um/os-Linux/file.c               |   31 ++++
 include/asm-um/common.lds.S           |   12 +
 13 files changed, 230 insertions(+), 135 deletions(-)

ChangeSet@1.1080, 2003-03-27 23:13:21-05:00, jdike@uml.karaya.com
  Fixed a call to devfs_mk_dir.

ChangeSet@1.1079, 2003-03-27 21:40:19-05:00, jdike@uml.karaya.com
  Fixed the ubd driver call to devfs_mk_symlink.

ChangeSet@1.1078, 2003-03-27 15:29:35-05:00, jdike@uml.karaya.com
  .66 conflict fixes.

ChangeSet@1.889.363.2, 2003-03-27 13:44:02-05:00, jdike@uml.karaya.com
  Fixed a register_blkdev call.

ChangeSet@1.889.363.1, 2003-03-22 15:37:52-05:00, jdike@uml.karaya.com
  Merged the 2.5.65 conflicts.

ChangeSet@1.889.247.2, 2003-02-25 00:44:11-05:00, jdike@uml.karaya.com
  Fixed the calls to schedule_tail to not be conditional on CONFIG_SMP,
  to be conditional on current->thread.prev_sched being non-NULL,
  and to pass current->thread.prev_sched in to schedule_tail.

ChangeSet@1.889.203.4, 2003-02-24 21:59:25-05:00, jdike@uml.karaya.com
  Fixed a bug with the initialization of the mode that a device file
  is opened with.

ChangeSet@1.889.203.3, 2003-02-24 01:48:30-05:00, jdike@uml.karaya.com
  Fixed a deadlock caused by not disabling interrupts around a call
  to update_process_times.

ChangeSet@1.889.203.2, 2003-02-23 14:50:33-05:00, jdike@uml.karaya.com
  Made some minor fixes to get rid of some unneeded code, improve
  a panic message, and fix a signal blocking bug.

ChangeSet@1.889.203.1, 2003-02-19 11:05:33-05:00, jdike@uml.karaya.com
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

