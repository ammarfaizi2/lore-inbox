Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263170AbSJHWno>; Tue, 8 Oct 2002 18:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263139AbSJHWml>; Tue, 8 Oct 2002 18:42:41 -0400
Received: from jdike.solana.com ([198.99.130.100]:31618 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S263143AbSJHWm1>;
	Tue, 8 Oct 2002 18:42:27 -0400
Message-Id: <200210082250.g98Mojv18203@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Oct 2002 18:50:44 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull http://jdike.stearns.org/fixes-2.5

It fixes a number of UML bugs
	a network driver crash
	a possible slip driver buffer overrun
	incorrect disabling of descriptors in poll
	a crash caused by alarms piling up on a busy host
	fixing PROT_NONE semantics
	Creating an arch xor.h for the raid drivers
	Some code cleanup

				Jeff

 arch/um/drivers/net_kern.c    |   36 +++++++++++++++++++++++++++++++-----
 arch/um/drivers/port_kern.c   |    2 +-
 arch/um/drivers/port_user.c   |    5 +++--
 arch/um/drivers/slip.h        |    5 ++++-
 arch/um/include/kern.h        |    1 +
 arch/um/include/time_user.h   |   17 +++++++++++++++++
 arch/um/include/user_util.h   |    6 ------
 arch/um/kernel/irq_user.c     |   11 ++++++-----
 arch/um/kernel/mem.c          |    2 +-
 arch/um/kernel/process.c      |    1 +
 arch/um/kernel/process_kern.c |    1 +
 arch/um/kernel/time.c         |   22 ++++++++++++++++++++++
 arch/um/kernel/time_kern.c    |    1 +
 arch/um/kernel/tlb.c          |    2 +-
 arch/um/kernel/trap_user.c    |    8 ++++++++
 arch/um/os-Linux/file.c       |    8 ++++----
 include/asm-um/pgtable.h      |   20 +++++++++++++++++---
 include/asm-um/xor.h          |    6 ++++++
 18 files changed, 125 insertions(+), 29 deletions(-)

ChangeSet@1.663.3.5, 2002-10-02 16:29:49-04:00, jdike@jdike.wstearns.org
  xor.h was created as asm-um/xor.h rather than include/asm-um/xor.h.
  Fixed.

ChangeSet@1.663.3.4, 2002-10-02 12:04:54-04:00, jdike@uml.karaya.com
  Back out a piece of the last merge which didn't apply in 2.5.

ChangeSet@1.663.3.3, 2002-10-02 11:39:20-04:00, jdike@uml.karaya.com
  A small network bug fix from 2.4.19-7.

ChangeSet@1.663.3.2, 2002-10-02 10:23:50-04:00, jdike@uml.karaya.com
  A set of small bug fixes brought over from 2.4.19-8.

ChangeSet@1.663.3.1, 2002-10-01 10:02:05-04:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/fixes-2.5

ChangeSet@1.579.15.2, 2002-09-23 21:09:49-04:00, jdike@uml.karaya.com
  Removed from user_util.h the declarations that are now in time_user.h.

ChangeSet@1.579.15.1, 2002-09-23 20:38:01-04:00, jdike@uml.karaya.com
  A number of bug fixes from UML 2.4.19-6 -
  
  Fixed the net crash seen when slab debugging is enabled
  Fixed PROT_NONE
  Fixed the 'tracing myself' bug seen on umlcoop.  This was caused by
  a number of SIGALRM handlers nesting on the idle thread stack because
  the system was busy enough that UML couldn't clear one before the
  next arrived.

