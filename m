Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbTEVRrx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 13:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbTEVRrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 13:47:52 -0400
Received: from dhcp05.ists.dartmouth.edu ([129.170.249.105]:3714 "EHLO
	uml.karaya.com") by vger.kernel.org with ESMTP id S262931AbTEVRrA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 13:47:00 -0400
Message-Id: <200305221800.h4MHxxok013282@uml.karaya.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML updates
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 22 May 2003 13:59:59 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/updates-2.5

This brings UML up to date with 2.5.69:

	added cpufeature.h
	added pte_user()
	updated to the new IRQ interface
	fixed the creation of devfs entries in the drivers
	updated the linker scripts
	added the pte_file changes
	fixed show_interrupts
	added the console initialization section to the linker scripts
	include cleanups
	new system calls hooked up
	fixed the sigprocmask name conflict

				Jeff


 arch/um/Makefile                   |    6 ++-
 arch/um/drivers/Makefile           |    2 -
 arch/um/drivers/chan_kern.c        |    1 
 arch/um/drivers/line.c             |   22 +++++++----
 arch/um/drivers/mconsole_kern.c    |    4 +-
 arch/um/drivers/net_kern.c         |    6 ++-
 arch/um/drivers/port_kern.c        |   10 +++--
 arch/um/drivers/stdio_console.c    |    6 ++-
 arch/um/drivers/ubd_kern.c         |   26 +++++++++++---
 arch/um/drivers/xterm_kern.c       |    8 +++-
 arch/um/dyn.lds.S                  |    8 +++-
 arch/um/include/irq_kern.h         |   28 +++++++++++++++
 arch/um/include/line.h             |    6 ++-
 arch/um/kernel/init_task.c         |    9 ----
 arch/um/kernel/irq.c               |   68 +++++++++++++++----------------------
 arch/um/kernel/process_kern.c      |    4 ++
 arch/um/kernel/ptrace.c            |    7 +--
 arch/um/kernel/sigio_kern.c        |    7 ++-
 arch/um/kernel/signal_kern.c       |   49 +++++++++++++++++++++++---
 arch/um/kernel/smp.c               |   36 ++++++++++++-------
 arch/um/kernel/sys_call_table.c    |   18 +++++++++
 arch/um/kernel/syscall_kern.c      |   38 --------------------
 arch/um/kernel/tt/process_kern.c   |    5 ++
 arch/um/sys-i386/bugs.c            |   16 ++++----
 arch/um/uml.lds.S                  |    8 +++-
 include/asm-um/bug.h               |    4 +-
 include/asm-um/common.lds.S        |    4 ++
 include/asm-um/cpufeature.h        |    6 +++
 include/asm-um/current.h           |    6 ++-
 include/asm-um/irq.h               |   13 -------
 include/asm-um/module-generic.h    |    6 +++
 include/asm-um/module-i386.h       |   13 +++++++
 include/asm-um/module.h            |   13 -------
 include/asm-um/page.h              |    1 
 include/asm-um/pgtable.h           |   68 +++++++++++++++++++++++++++++--------
 include/asm-um/processor-generic.h |    4 --
 include/asm-um/processor-i386.h    |    4 +-
 include/asm-um/smp.h               |    3 +
 include/asm-um/system-generic.h    |    6 ++-
 include/asm-um/thread_info.h       |    3 +
 include/asm-um/timex.h             |    2 -
 41 files changed, 347 insertions(+), 207 deletions(-)

ChangeSet@1.1083, 2003-05-15 21:03:37-04:00, jdike@uml.karaya.com
  Added cpufeature.h

ChangeSet@1.1082, 2003-05-15 16:42:41-04:00, jdike@uml.karaya.com
  Added pte_user to make 2.5.69 build.

ChangeSet@1.1042.83.4, 2003-05-05 08:56:15-04:00, jdike@uml.karaya.com
  Added irq_kern.h, which declares um_request_irq.

ChangeSet@1.1042.83.3, 2003-05-05 08:52:18-04:00, jdike@uml.karaya.com
  2.5.68 updates -
  The drivers use the new IRQ interface.
  Fixed the creation of devfs entries.
  Updated the linker scripts.
  Added some __user and typecheck declarations.

ChangeSet@1.1042.83.2, 2003-05-02 12:21:54-04:00, jdike@uml.karaya.com
  Merge jdike.stearns.org:linux/updates-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/updates-2.5

ChangeSet@1.1042.83.1, 2003-05-02 11:26:14-04:00, jdike@jdike.wstearns.org
  Merge jdike.wstearns.org:/home/jdike/linux/linus-2.5
  into jdike.wstearns.org:/home/jdike/linux/updates-2.5

ChangeSet@1.971.113.3, 2003-04-10 13:36:21-04:00, jdike@uml.karaya.com
  Merge jdike.stearns.org:linux/updates-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/updates-2.5

ChangeSet@1.971.113.2, 2003-04-10 13:30:15-04:00, jdike@uml.karaya.com
  Small changes to update to 2.5.67.

ChangeSet@1.971.114.1, 2003-04-10 11:56:42-04:00, jdike@jdike.wstearns.org
  Merge jdike.wstearns.org:/home/jdike/linux/linus-2.5
  into jdike.wstearns.org:/home/jdike/linux/updates-2.5

ChangeSet@1.971.113.1, 2003-04-10 11:19:19-04:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/updates-2.5

ChangeSet@1.971.47.2, 2003-03-27 21:38:37-05:00, jdike@uml.karaya.com
  2.5.66 updates to irq.c and pgtable.h.

ChangeSet@1.889.410.3, 2003-03-27 13:46:11-05:00, jdike@uml.karaya.com
  Some small changes to get 2.5.65 working.

ChangeSet@1.889.410.2, 2003-03-27 10:28:06-05:00, jdike@uml.karaya.com
  Added the con_initcall section to common.lds.S.

ChangeSet@1.889.307.3, 2003-03-07 12:36:29-05:00, jdike@uml.karaya.com
  Added a bunch of include fixes from Oleg.

ChangeSet@1.889.309.2, 2003-03-05 12:47:32-05:00, jdike@uml.karaya.com
  Deleted free_task_struct since it is implemented in fork.c now.

ChangeSet@1.889.206.4, 2003-02-25 00:24:29-05:00, jdike@uml.karaya.com
  Added declarations for the new system calls and fixed the includes
  of asm/signal.h.

ChangeSet@1.889.206.3, 2003-02-24 23:00:04-05:00, jdike@uml.karaya.com
  Updated to 2.5.63 and made a minor build cleanup.

ChangeSet@1.889.206.2, 2003-02-23 14:49:44-05:00, jdike@uml.karaya.com
  Applied some minor updates to fix things that broke in .62.

ChangeSet@1.889.206.1, 2003-02-19 09:50:28-05:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/updates-2.5

ChangeSet@1.889.138.3, 2003-02-18 17:50:30-05:00, jdike@uml.karaya.com
  Copied a ptrace change from i386.

ChangeSet@1.889.138.2, 2003-02-18 16:39:59-05:00, jdike@uml.karaya.com
  Changed the kernel sigprocmask to kernel_sigprocmask to avoid a
  conflict with libc.

ChangeSet@1.889.138.1, 2003-02-12 09:40:44-05:00, jdike@uml.karaya.com
  Applied a bunch of patches from Oleg to get UML working in 2.5.60
  and to clean up some other things.

