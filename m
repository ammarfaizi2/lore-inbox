Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbSJPTq4>; Wed, 16 Oct 2002 15:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261374AbSJPTq4>; Wed, 16 Oct 2002 15:46:56 -0400
Received: from lab1.ists.dartmouth.edu ([129.170.248.130]:6529 "EHLO
	karaya.com") by vger.kernel.org with ESMTP id <S261371AbSJPTqz>;
	Wed, 16 Oct 2002 15:46:55 -0400
Message-Id: <200210161955.g9GJtOZ06687@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML updates
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 16 Oct 2002 15:55:24 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/fixes-2.5

This patch contains updates to 2.5.43 and syncs the 2.5 UML up with my 2.4
tree.

The 2.5.43 updates are build fixes, and updated defconfig, and an entry for
lookup_dcookie.

The other stuff includes
	not calling request_irq from an interrupt handler
	fix a hang caused by xterm not running successfully
	exporting rwlock symbols
	killing off all the idle threads on halt
	other small updates, fixes, and cleanups

				Jeff

 arch/um/Makefile                |    9 ++---
 arch/um/Makefile-i386           |    7 ++-
 arch/um/defconfig               |    8 ++++
 arch/um/drivers/Makefile        |    2 -
 arch/um/drivers/mconsole_kern.c |    2 +
 arch/um/drivers/port_kern.c     |   62 +++++++++++++++++++++++++---------
 arch/um/drivers/ssl.c           |    1 
 arch/um/drivers/stdio_console.c |    1 
 arch/um/drivers/ubd_kern.c      |    3 +
 arch/um/drivers/xterm.c         |   26 ++++++++++----
 arch/um/drivers/xterm.h         |   22 ++++++++++++
 arch/um/drivers/xterm_kern.c    |   71 ++++++++++++++++++++++++++++++++++++++++
 arch/um/include/chan_user.h     |    1 
 arch/um/include/kern_util.h     |    2 +
 arch/um/include/user_util.h     |    1 
 arch/um/kernel/Makefile         |    4 +-
 arch/um/kernel/irq_user.c       |    1 
 arch/um/kernel/ksyms.c          |   14 +++++++
 arch/um/kernel/reboot.c         |   19 ++++++++++
 arch/um/kernel/signal_user.c    |   24 ++++++-------
 arch/um/kernel/smp.c            |    4 ++
 arch/um/kernel/sys_call_table.c |    4 +-
 arch/um/kernel/trap_kern.c      |    1 
 include/asm-um/irq.h            |    3 +
 include/asm-um/system-generic.h |   12 +++---
 25 files changed, 248 insertions(+), 56 deletions(-)

ChangeSet@1.858, 2002-10-16 13:39:53-04:00, jdike@uml.karaya.com
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

