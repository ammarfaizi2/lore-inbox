Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319308AbSIKRRf>; Wed, 11 Sep 2002 13:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319243AbSIKRRf>; Wed, 11 Sep 2002 13:17:35 -0400
Received: from h-66-166-207-97.SNVACAID.covad.net ([66.166.207.97]:15810 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S319308AbSIKRRe>; Wed, 11 Sep 2002 13:17:34 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 11 Sep 2002 10:22:17 -0700
Message-Id: <200209111722.KAA03149@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.34 on Sony PictureBook fails to boot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Attempting to boot 2.5.34 compiled with SMP on a Sony
PictureBook results in the computer being reset before the kernel
activates the console.  The same kernel runs fine on a desktop PC.
This seems to occur regardless of whether or not enable
CONFIG_X86_NUMA{,Q} and CONFIG_MULTIQUAD.  My efforts to track down
the problem have been with these options off.  CONFIG_DISCONTIGMEM is
not set.

	By adding an infinite loop at various points in the initialization
process, I have determined that the reset occurs in this call chain:

init/main.c			start_kernel
arch/i386/kernel/setup.c	setup_arch
arch/i386/mm/init.c		paging_init
arch/i386/mm/init.c		zone_sizes_init
mm/page_alloc.c			free_area_init
mm/page_alloc.c			free_area_init_core
mm/bootmem.c			alloc_bootmem_node
mm/bootmem.c			__alloc_bootmem_core

	2.5.31 booted just fine on this computer, and I see that there
are some potentially related changes in .34, but I have not yet
verified that .32 and .33 work on this machine.

	I expect to investigate this problem further tonight if nobody
beats me to it.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
vi
