Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130432AbRCWJLr>; Fri, 23 Mar 2001 04:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130433AbRCWJLi>; Fri, 23 Mar 2001 04:11:38 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:30883 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S130432AbRCWJLZ>; Fri, 23 Mar 2001 04:11:25 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 23 Mar 2001 01:10:43 -0800
Message-Id: <200103230910.BAA06574@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.3-pre6: agpart.o causes arch/i386/mm/ioremap.c hang
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Under linux-2.4.3-pre6 compiled for SMP, loading agpgart.o
hangs the system in remap_area_pages (arch/i386/mm/ioremap.c) at
the call to spin_lock(&init_mm.page_table_lock), which is not in 2.4.2.

	When I load agpgart.o, I get the following messages:

Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 690M
agpgart: Detected Via Apollo Pro chipset

	After that, the console keys (RightAlt ScrollLock, Alt-F2, etc.)
but there is not other response to my keystrokes and the system is no
longer pingable.  The call graphic is basically:

	agp_backend_initialize
	agp_generic_create_gatt_table
	io_remap_nocache
	__ioremap
	remap_area_pages

	I've made a cursory search through the kernel sources for what
else might be holding this lock, but I have not yet found anything.

	I'm rebuilding the kernel now with a modified spin_lock()
routine that should tell me who acquired the lock previously; however,
I really do not understand this part of the kernel enough to know
what the changes were intended to do in the first place.  So, knowing
where else the lock was acquired will not necessarily be enough for
me to be able to generate a patch.  Anyhow, I imagine that this
lock is being held by some code that can block.  We'll see.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
