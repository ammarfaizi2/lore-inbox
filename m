Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbVAEB7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVAEB7z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 20:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVAEB7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 20:59:55 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:37864 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S262175AbVAEB7a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 20:59:30 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org
Cc: spyro@f2s.com, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050105015946.22220.43127.86751@localhost.localdomain>
Subject: [PATCH] arm26: update irq handling code in arch/arm26/machine/dma.c
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 19:59:26 -0600
Date: Tue, 4 Jan 2005 19:59:28 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove to-be-deprecated function save_flags() and nonexistent function local_save_flags_cli()

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/arm26/machine/dma.c linux-2.6.10-mm1/arch/arm26/machine/dma.c
--- linux-2.6.10-mm1-original/arch/arm26/machine/dma.c	2005-01-03 18:42:35.631091938 -0500
+++ linux-2.6.10-mm1/arch/arm26/machine/dma.c	2005-01-04 20:52:17.051263510 -0500
@@ -40,7 +40,7 @@
 	case DMA_MODE_READ: { /* read */
 		unsigned long flags;
 		DPRINTK("enable_dma fdc1772 data read\n");
-		local_save_flags_cli(flags);
+		local_irq_save(flags);
 		clf();
 			
 		memcpy ((void *)0x1c, (void *)&fdc1772_dma_read,
@@ -54,7 +54,7 @@
 	case DMA_MODE_WRITE: { /* write */
 		unsigned long flags;
 		DPRINTK("enable_dma fdc1772 data write\n");
-		local_save_flags_cli(flags);
+		local_irq_save(flags);
 		clf();
 		memcpy ((void *)0x1c, (void *)&fdc1772_dma_write,
 			&fdc1772_dma_write_end - &fdc1772_dma_write);
@@ -85,7 +85,7 @@
 
 	DPRINTK("arc_floppy_cmdend_enable_dma\n");
 	/*printk("enable_dma fdc1772 command end FIQ\n");*/
-	save_flags(flags);
+	local_irq_save(flags);
 	clf();
 	
 	/* B fdc1772_comendhandler */
