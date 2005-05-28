Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVE1XZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVE1XZq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 19:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVE1XTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 19:19:20 -0400
Received: from coderock.org ([193.77.147.115]:47238 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261201AbVE1XSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 19:18:04 -0400
Message-Id: <20050528231736.249183000@nd47.coderock.org>
Date: Sun, 29 May 2005 01:17:37 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Tobias Klauser <tklauser@nuerscht.ch>,
       domen@coderock.org
Subject: [patch 3/7] sound/oss/es1370: Use the DMA_32BIT_MASK constant
Content-Disposition: inline; filename=dma_mask-sound_oss_es1370
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Klauser <tklauser@nuerscht.ch>


Use the DMA_32BIT_MASK constant from dma-mapping.h
when calling pci_set_dma_mask() or pci_set_consistent_dma_mask()
See http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Domen Puncer <domen@coderock.org>

---
 es1370.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: quilt/sound/oss/es1370.c
===================================================================
--- quilt.orig/sound/oss/es1370.c
+++ quilt/sound/oss/es1370.c
@@ -156,6 +156,7 @@
 #include <linux/spinlock.h>
 #include <linux/gameport.h>
 #include <linux/wait.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/io.h>
 #include <asm/page.h>
@@ -2569,7 +2570,7 @@ static int __devinit es1370_probe(struct
 		return -ENODEV;
 	if (pcidev->irq == 0) 
 		return -ENODEV;
-	i = pci_set_dma_mask(pcidev, 0xffffffff);
+	i = pci_set_dma_mask(pcidev, DMA_32BIT_MASK);
 	if (i) {
 		printk(KERN_WARNING "es1370: architecture does not support 32bit PCI busmaster DMA\n");
 		return i;

--
