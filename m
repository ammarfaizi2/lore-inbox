Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWEWR7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWEWR7v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 13:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWEWR7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 13:59:51 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:35211 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932186AbWEWR7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 13:59:50 -0400
Date: Tue, 23 May 2006 19:59:49 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] -mm: cyrix code CONFIG_PCI fix / add __initdata
Message-ID: <20060523175949.GC24461@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

PCI code was outside of CONFIG_PCI, add __initdata at cyrix_55x0
(since accessed within __init function only).

i386 run-tested on 2.6.17-rc4-mm3. However since this is no Cyrix here,
not ultimately sure whether it really works.


Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-rc4-mm3.orig/arch/i386/kernel/cpu/cyrix.c linux-2.6.17-rc4-mm3.my/arch/i386/kernel/cpu/cyrix.c
--- linux-2.6.17-rc4-mm3.orig/arch/i386/kernel/cpu/cyrix.c	2006-05-23 17:50:00.000000000 +0200
+++ linux-2.6.17-rc4-mm3.my/arch/i386/kernel/cpu/cyrix.c	2006-05-23 17:26:25.000000000 +0200
@@ -184,7 +184,7 @@
 
 
 #ifdef CONFIG_PCI
-static struct pci_device_id cyrix_55x0[] = {
+static struct pci_device_id __initdata cyrix_55x0[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5510) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520) },
 	{ },
@@ -272,15 +272,16 @@
 
 		printk(KERN_INFO "Working around Cyrix MediaGX virtual DMA bugs.\n");
 		isa_dma_bridge_buggy = 2;
-#endif		
-		c->x86_cache_size=16;	/* Yep 16K integrated cache thats it */
- 
+
+
 		/*
 		 *  The 5510/5520 companion chips have a funky PIT.
 		 */  
 		if (pci_dev_present(cyrix_55x0))
 			pit_latch_buggy = 1;
-
+#endif		
+		c->x86_cache_size=16;	/* Yep 16K integrated cache thats it */
+ 
 		/* GXm supports extended cpuid levels 'ala' AMD */
 		if (c->cpuid_level == 2) {
 			/* Enable cxMMX extensions (GX1 Datasheet 54) */
