Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262603AbSJBVOZ>; Wed, 2 Oct 2002 17:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262602AbSJBVN3>; Wed, 2 Oct 2002 17:13:29 -0400
Received: from lab1.ISTS.dartmouth.edu ([129.170.248.130]:53121 "EHLO
	karaya.com") by vger.kernel.org with ESMTP id <S262598AbSJBVNE>;
	Wed, 2 Oct 2002 17:13:04 -0400
Message-Id: <200210022120.g92LKvU26986@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML bug fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 02 Oct 2002 17:20:57 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull http://jdike.stearns.org:5000/fixes-2.5

This fixes a number of UML bugs -
	fixes a crash in the network seen with slab poisoning
	fixes a timer bug and cleans up the code
	changes how IRQs are disabled and enabled
	fixes the semantics of PROT_NONE
	adds asm/xor.h so that raid drivers will build

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

ChangeSet@1.669, 2002-10-02 16:29:49-04:00, jdike@jdike.wstearns.org
  xor.h was created as asm-um/xor.h rather than include/asm-um/xor.h.
  Fixed.

ChangeSet@1.668, 2002-10-02 12:04:54-04:00, jdike@uml.karaya.com
  Back out a piece of the last merge which didn't apply in 2.5.

ChangeSet@1.667, 2002-10-02 11:39:20-04:00, jdike@uml.karaya.com
  A small network bug fix from 2.4.19-7.

ChangeSet@1.666, 2002-10-02 10:23:50-04:00, jdike@uml.karaya.com
  A set of small bug fixes brought over from 2.4.19-8.

ChangeSet@1.665, 2002-10-01 10:02:05-04:00, jdike@uml.karaya.com
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

