Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbWBWAAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWBWAAG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 19:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWBWAAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 19:00:06 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:59298 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932465AbWBWAAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 19:00:05 -0500
Subject: [PATCH] fix the cpu_possible_map to make voyager boot again.
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 17:58:03 -0600
Message-Id: <1140652683.10417.11.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right at the moment (thanks to a patch from Andrew), cpu_possible_map on
voyager is CPU_MASK_NONE, which means the machine always thinks it has
no CPUs.  Fix that by doing an early initialisation of the
cpu_possible_map from the cpu_phys_present_map.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

---

James

Index: BUILD-2.6/arch/i386/mach-voyager/voyager_smp.c
===================================================================
--- BUILD-2.6.orig/arch/i386/mach-voyager/voyager_smp.c	2006-02-22 14:57:45.000000000 -0600
+++ BUILD-2.6/arch/i386/mach-voyager/voyager_smp.c	2006-02-22 15:38:13.000000000 -0600
@@ -402,6 +402,7 @@
 	cpus_addr(phys_cpu_present_map)[0] |= voyager_extended_cmos_read(VOYAGER_PROCESSOR_PRESENT_MASK + 1) << 8;
 	cpus_addr(phys_cpu_present_map)[0] |= voyager_extended_cmos_read(VOYAGER_PROCESSOR_PRESENT_MASK + 2) << 16;
 	cpus_addr(phys_cpu_present_map)[0] |= voyager_extended_cmos_read(VOYAGER_PROCESSOR_PRESENT_MASK + 3) << 24;
+	cpu_possible_map = phys_cpu_present_map;
 	printk("VOYAGER SMP: phys_cpu_present_map = 0x%lx\n", cpus_addr(phys_cpu_present_map)[0]);
 	/* Here we set up the VIC to enable SMP */
 	/* enable the CPIs by writing the base vector to their register */


