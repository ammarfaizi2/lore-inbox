Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVALV3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVALV3m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVALV3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:29:32 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:43185 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261468AbVALV17
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:27:59 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, kraxel@bytesex.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050112212818.12453.70029.28827@localhost.localdomain>
Subject: [PATCH] vino: Remove cli()/sti() in drivers/media/video/vino.c
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [209.158.220.243] at Wed, 12 Jan 2005 15:27:58 -0600
Date: Wed, 12 Jan 2005 15:27:58 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know this driver isn't working, but cleanup is cleanup :)

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm2-original/drivers/media/video/vino.c linux-2.6.10-mm2/drivers/media/video/vino.c
--- linux-2.6.10-mm2-original/drivers/media/video/vino.c	2005-01-08 12:16:37.000000000 -0500
+++ linux-2.6.10-mm2/drivers/media/video/vino.c	2005-01-12 16:14:54.940750449 -0500
@@ -48,7 +48,7 @@
 	unsigned long virt_addr = KSEG1ADDR(addr + VINO_BASE);
 	unsigned long flags;
 
-	save_and_cli(flags);
+	local_irq_save(flags);
 	__asm__ __volatile__(
 		".set\tmips3\n\t"
 		".set\tnoat\n\t"
@@ -60,7 +60,7 @@
 		:"r" (virt_addr),
 		 "r" (&ret)
 		:"$1");
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return ret;
 }
@@ -74,7 +74,7 @@
 	/* we might lose the upper parts of the registers which are not saved
 	 * if there comes an interrupt in our way, play safe */
 
-	save_and_cli(flags);
+	local_irq_save(flags);
 	__asm__ __volatile__(
 		".set\tmips3\n\t"
 		".set\tnoat\n\t"
@@ -86,7 +86,7 @@
 		:"r" (&value),
 		 "r" (virt_addr)
 		:"$1");
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static __inline__ void vino_reg_and(unsigned long long value,
@@ -95,7 +95,7 @@
 	unsigned long virt_addr = KSEG1ADDR(addr + VINO_BASE);
 	unsigned long flags;
 
-	save_and_cli(flags);
+	local_irq_save(flags);
 	__asm__ __volatile__(
 		".set\tmips3\n\t"
 		".set\tnoat\n\t"
@@ -109,7 +109,7 @@
 		:"r" (virt_addr),
 		 "r" (&value)
 		:"$1","$2");
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static __inline__ void vino_reg_or(unsigned long long value,
@@ -118,7 +118,7 @@
 	unsigned long virt_addr = KSEG1ADDR(addr + VINO_BASE);
 	unsigned long flags;
 
-	save_and_cli(flags);
+	local_irq_save(flags);
 	__asm__ __volatile__(
 		".set\tmips3\n\t"
 		".set\tnoat\n\t"
@@ -132,7 +132,7 @@
 		:"r" (virt_addr),
 		 "r" (&value)
 		:"$1","$2");
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static int vino_dma_setup(void)
