Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267520AbSKQQDu>; Sun, 17 Nov 2002 11:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267521AbSKQQDu>; Sun, 17 Nov 2002 11:03:50 -0500
Received: from mnh-1-09.mv.com ([207.22.10.41]:27140 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S267520AbSKQQDs>;
	Sun, 17 Nov 2002 11:03:48 -0500
Message-Id: <200211171614.LAA01735@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Update UML to 2.5.47
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 17 Nov 2002 11:14:43 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/updates-2.5

The only functional UML changes are those that are left over from my
last pull request:

	build cleanups
	an updated defconfig
	bug fixes in the console and serial line drivers
	the block driver again supports partitions
	more symbols exported
	SMP fixes
	interrupt handling fixes
	hook in the new system calls

				Jeff

 arch/um/Makefile                |    8 
 arch/um/Makefile-i386           |   10 -
 arch/um/defconfig               |    8 
 arch/um/drivers/Makefile        |    4 
 arch/um/drivers/mconsole_kern.c |    2 
 arch/um/drivers/port_kern.c     |   70 ++++++--
 arch/um/drivers/ssl.c           |    1 
 arch/um/drivers/stdio_console.c |    1 
 arch/um/drivers/ubd_kern.c      |  341 ++++++++++++++++++----------------------
 arch/um/drivers/xterm.c         |   26 ++-
 arch/um/drivers/xterm.h         |   22 ++
 arch/um/drivers/xterm_kern.c    |   77 +++++++++
 arch/um/include/chan_user.h     |    1 
 arch/um/include/kern_util.h     |    2 
 arch/um/kernel/Makefile         |    4 
 arch/um/kernel/irq_user.c       |    1 
 arch/um/kernel/ksyms.c          |   27 +++
 arch/um/kernel/process_kern.c   |    2 
 arch/um/kernel/reboot.c         |   19 ++
 arch/um/kernel/signal_user.c    |   24 +-
 arch/um/kernel/smp.c            |    4 
 arch/um/kernel/sys_call_table.c |   14 +
 arch/um/kernel/sysrq.c          |   10 +
 arch/um/kernel/trap_kern.c      |    1 
 arch/um/os-Linux/Makefile       |    4 
 arch/um/os-Linux/file.c         |    7 
 arch/um/sys-i386/Makefile       |   11 -
 arch/um/uml.lds.S               |    7 
 include/asm-um/irq.h            |    3 
 include/asm-um/system-generic.h |   12 -
 include/asm-um/unistd.h         |    2 
 31 files changed, 475 insertions, 250 deletions

ChangeSet@1.826, 2002-11-16 22:06:20-05:00, jdike@uml.karaya.com
  Updates to 2.5.47.

ChangeSet@1.786.189.2, 2002-11-16 16:01:17-05:00, jdike@uml.karaya.com
  Merged a Makefile conflict.

ChangeSet@1.781.43.6, 2002-11-16 15:58:04-05:00, jdike@uml.karaya.com
  A small Makefile change.

ChangeSet@1.786.188.2, 2002-11-15 21:12:59-05:00, jdike@uml.karaya.com
  Updated to 2.5.45.

ChangeSet@1.786.188.1, 2002-11-15 20:12:21-05:00, jdike@uml.karaya.com
  Merged conflicts between 2.5.45 and my 2.5.44.

ChangeSet@1.781.43.5, 2002-10-19 21:19:54-04:00, jdike@uml.karaya.com
  Updated to work as 2.5.44.

ChangeSet@1.781.43.4, 2002-10-19 19:04:52-04:00, jdike@uml.karaya.com
  Merged the 2.5.44 ubd driver changes.

ChangeSet@1.781.43.3, 2002-10-19 15:43:15-04:00, jdike@uml.karaya.com
  The block driver supports partitions again.
  Removed an unused field from cpu_tasks.

ChangeSet@1.781.43.2, 2002-10-17 12:58:06-04:00, jdike@uml.karaya.com
  A number of small fixes.
  The port and xterm drivers handle -EAGAIN from os_rcv_fd gracefully,
  fixing a crash in the xterm driver.
  The ubd driver handles devfs_register failures better.
  More symbols were exported.

ChangeSet@1.781.43.1, 2002-10-16 13:39:53-04:00, jdike@uml.karaya.com
  A bunch of miscellaneous changes - mostly fixes from 2.4 and updates
  to 2.5.43.
  Added some Makefile fixes so the build works.
  Brought the xterm not hanging fix from 2.4.
  Updated the signal code from 2.4.
  Fixed port_interrupt to not allocate IRQs.
  The idle threads for the secondary processors are now killed off
  on shutdown.
  Some rwlock symbols are exported.
  Added a system call entry for lookup_dcookie.

