Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275362AbTHGO7y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275374AbTHGO5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:57:43 -0400
Received: from dhcp75.ists.dartmouth.edu ([129.170.249.155]:48256 "EHLO
	uml.karaya.com") by vger.kernel.org with ESMTP id S275385AbTHGOy6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:54:58 -0400
Message-Id: <200308071459.h77Ex5Q4001959@uml.karaya.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: torvalds@odsl.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML updates 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Aug 2003 10:59:05 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/updates-2.5

This brings UML up to date with 2.6.0-test2.

				Jeff


updates-2.5
 arch/um/defconfig                  |    2 
 arch/um/drivers/line.c             |   61 +++++++-----
 arch/um/drivers/mconsole_kern.c    |    4 
 arch/um/drivers/net_kern.c         |   46 +++++----
 arch/um/drivers/port_kern.c        |   10 +-
 arch/um/drivers/ssl.c              |    5 -
 arch/um/drivers/stdio_console.c    |   28 +++--
 arch/um/drivers/ubd_kern.c         |  174 +++++++++++++++++++------------------
 arch/um/drivers/ubd_user.c         |    8 -
 arch/um/drivers/xterm_kern.c       |    8 +
 arch/um/include/irq_kern.h         |   28 +++++
 arch/um/include/line.h             |    7 +
 arch/um/include/ubd_user.h         |    1 
 arch/um/include/user.h             |    2 
 arch/um/kernel/init_task.c         |   15 ---
 arch/um/kernel/irq.c               |   83 +++++++----------
 arch/um/kernel/process_kern.c      |   23 ++--
 arch/um/kernel/ptrace.c            |    7 -
 arch/um/kernel/sigio_kern.c        |    7 +
 arch/um/kernel/signal_kern.c       |   49 +++++++++-
 arch/um/kernel/smp.c               |   42 +++++---
 arch/um/kernel/sys_call_table.c    |   62 ++++++++++---
 arch/um/kernel/syscall_kern.c      |   72 ++++-----------
 arch/um/kernel/sysrq.c             |    4 
 arch/um/kernel/time.c              |   12 +-
 arch/um/kernel/time_kern.c         |   11 +-
 arch/um/kernel/um_arch.c           |    7 +
 arch/um/sys-i386/bugs.c            |   16 +--
 include/asm-um/archparam-i386.h    |   59 ++++++++++++
 include/asm-um/cpufeature.h        |    6 +
 include/asm-um/current.h           |    6 -
 include/asm-um/fixmap.h            |    8 +
 include/asm-um/irq.h               |   13 --
 include/asm-um/local.h             |    6 +
 include/asm-um/page.h              |    1 
 include/asm-um/pgtable.h           |   68 +++++++++++---
 include/asm-um/processor-generic.h |    9 +
 include/asm-um/processor-i386.h    |    4 
 include/asm-um/sections.h          |    7 +
 include/asm-um/smp.h               |   10 +-
 include/asm-um/system-generic.h    |    6 -
 include/asm-um/thread_info.h       |   16 ++-
 include/asm-um/timex.h             |    2 
 43 files changed, 630 insertions(+), 385 deletions(-)

ChangeSet@1.1597, 2003-07-28 22:33:37-04:00, jdike@uml.karaya.com
  Updated to 2.6.0-test2.  There were a couple of new headers and {alloc,free}_t
hread_info
  are now defined in terms of kmalloc.

ChangeSet@1.1596, 2003-07-28 17:57:42-04:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/updates-2.5

ChangeSet@1.1455.16.3, 2003-07-28 12:31:54-04:00, jdike@uml.karaya.com
  Merged the 2.6.0 updates, which I seemed to have forgotten when I released the
 patch.

ChangeSet@1.1455.16.2, 2003-07-25 20:32:56-04:00, jdike@uml.karaya.com
  Copied time.c from another repo in hopes of getting a clean merge.

ChangeSet@1.1455.16.1, 2003-07-25 04:01:45-04:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.6.0-test1
  into uml.karaya.com:/home/jdike/linux/2.5/updates-2.5

ChangeSet@1.1310.128.2, 2003-07-23 23:37:17-04:00, jdike@uml.karaya.com
  Backed out the time.c change because it clashed with a change
  in another BK repo, and BK messed up the merge.

ChangeSet@1.1305.19.3, 2003-07-18 12:14:56-04:00, jdike@uml.karaya.com
  Updates to make 2.5.71 work.
  Some device naming changes, vsyscall placeholders, and a net driver change.

ChangeSet@1.1305.19.2, 2003-07-17 22:31:16-04:00, jdike@uml.karaya.com
  Added a bunch of FIXMAP stuff from i386.

ChangeSet@1.1305.19.1, 2003-07-17 17:18:01-04:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.5.71
  into uml.karaya.com:/home/jdike/linux/2.5/updates-2.5

ChangeSet@1.1215.148.2, 2003-07-17 15:07:43-04:00, jdike@uml.karaya.com
  Changed size_t to int in the declaration of strlcpy in user.h.

ChangeSet@1.1215.148.1, 2003-07-17 11:36:00-04:00, jdike@uml.karaya.com
  These are updates due to interface changes during 2.5.


