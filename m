Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268844AbTBZSCW>; Wed, 26 Feb 2003 13:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268850AbTBZSCW>; Wed, 26 Feb 2003 13:02:22 -0500
Received: from dhcp63.ists.dartmouth.edu ([129.170.249.163]:10369 "EHLO
	uml.karaya.com") by vger.kernel.org with ESMTP id <S268844AbTBZSCV>;
	Wed, 26 Feb 2003 13:02:21 -0500
Message-Id: <200302261816.h1QIG3511220@uml.karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML fixes 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 26 Feb 2003 13:16:03 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/fixes-2.5

This fixes some UML bugs, including
	some signal blocking bugs
	a 'tracing myself' bug
	a uaccess fencepost bug
	call schedule_tail correctly
	block signals correctly in the timer handler

Also, there were a number of code cleanups, particularly in the ubd driver.
That driver now locks the host files that it uses to prevent multiple UMLs
from booting on the same filesystem.

stdout is now flushed before entering the kernel to ensure that early messages
appear before printk output.

				Jeff

 arch/um/drivers/line.c                |    6 
 arch/um/drivers/ubd_kern.c            |  227 +++++++++++++++++++---------------
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
 13 files changed, 230 insertions(+), 138 deletions(-)

ChangeSet@1.1022.1.2, 2003-02-25 00:44:11-05:00, jdike@uml.karaya.com
  Fixed the calls to schedule_tail to not be conditional on CONFIG_SMP,
  to be conditional on current->thread.prev_sched being non-NULL,
  and to pass current->thread.prev_sched in to schedule_tail.

ChangeSet@1.914.185.4, 2003-02-24 21:59:25-05:00, jdike@uml.karaya.com
  Fixed a bug with the initialization of the mode that a device file
  is opened with.

ChangeSet@1.914.185.3, 2003-02-24 01:48:30-05:00, jdike@uml.karaya.com
  Fixed a deadlock caused by not disabling interrupts around a call
  to update_process_times.

ChangeSet@1.914.185.2, 2003-02-23 14:50:33-05:00, jdike@uml.karaya.com
  Made some minor fixes to get rid of some unneeded code, improve
  a panic message, and fix a signal blocking bug.

ChangeSet@1.914.185.1, 2003-02-19 11:05:33-05:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/fixes-2.5

ChangeSet@1.914.118.2, 2003-02-19 09:55:14-05:00, jdike@uml.karaya.com
  Fixed signal blocking and cleaned up the code a bit.

ChangeSet@1.914.93.32, 2003-02-07 13:48:13-05:00, jdike@uml.karaya.com
  Fixed a few compilation bugs in the ubd changes.

ChangeSet@1.914.93.31, 2003-02-07 12:52:23-05:00, jdike@uml.karaya.com
  Merged in changes from 2.4 up to 2.4.19-50.
  The ubd driver locks its files.
  Merged a bunch of ubd fixes from James McMechan.
  stdout is now flushed before entering the kernel.
  Fixed a uaccess fencepost bug.
  Fixed a 'tracing myself' bug.
  Various other cleanups and error message fixes.

