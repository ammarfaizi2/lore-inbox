Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVE1XZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVE1XZq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 19:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVE1XS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 19:18:59 -0400
Received: from coderock.org ([193.77.147.115]:46214 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261200AbVE1XSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 19:18:01 -0400
Message-Id: <20050528231735.405271000@nd47.coderock.org>
Date: Sun, 29 May 2005 01:17:36 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Tobias Klauser <tklauser@nuerscht.ch>,
       domen@coderock.org
Subject: [patch 2/7] sound/oss/es1371: Use the DMA_32BIT_MASK constant
Content-Disposition: inline; filename=dma_mask-sound_oss_es1371
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Klauser <tklauser@nuerscht.ch>


Use the DMA_32BIT_MASK constant from dma-mapping.h
when calling pci_set_dma_mask() or pci_set_consistent_dma_mask()
See http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Domen Puncer <domen@coderock.org>

---
 es1371.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: quilt/sound/oss/es1371.c
===================================================================
--- quilt.orig/sound/oss/es1371.c
+++ quilt/sound/oss/es1371.c
@@ -128,6 +128,7 @@
 #include <linux/ac97_codec.h>
 #include <linux/gameport.h>
 #include <linux/wait.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/io.h>
 #include <asm/page.h>
@@ -2804,7 +2805,7 @@ static int __devinit es1371_probe(struct
 		return -ENODEV;
 	if (pcidev->irq == 0) 
 		return -ENODEV;
-	i = pci_set_dma_mask(pcidev, 0xffffffff);
+	i = pci_set_dma_mask(pcidev, DMA_32BIT_MASK);
 	if (i) {
 		printk(KERN_WARNING "es1371: architecture does not support 32bit PCI busmaster DMA\n");
 		return i;

--
