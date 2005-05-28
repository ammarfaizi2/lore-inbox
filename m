Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVE1XSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVE1XSe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 19:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVE1XSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 19:18:33 -0400
Received: from coderock.org ([193.77.147.115]:45190 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261199AbVE1XRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 19:17:51 -0400
Message-Id: <20050528231734.739466000@nd47.coderock.org>
Date: Sun, 29 May 2005 01:17:35 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Tobias Klauser <tklauser@nuerscht.ch>,
       domen@coderock.org
Subject: [patch 1/7] sound/oss/esssolo1: Use the DMA_32BIT_MASK constant
Content-Disposition: inline; filename=dma_mask-sound_oss_esssolo1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Klauser <tklauser@nuerscht.ch>


Use the DMA_32BIT_MASK constant from dma-mapping.h
when calling pci_set_dma_mask() or pci_set_consistent_dma_mask()
See http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Domen Puncer <domen@coderock.org>

---
 esssolo1.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: quilt/sound/oss/esssolo1.c
===================================================================
--- quilt.orig/sound/oss/esssolo1.c
+++ quilt/sound/oss/esssolo1.c
@@ -104,6 +104,7 @@
 #include <linux/smp_lock.h>
 #include <linux/gameport.h>
 #include <linux/wait.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/io.h>
 #include <asm/page.h>
@@ -2326,7 +2327,7 @@ static int __devinit solo1_probe(struct 
 	 * to 24 bits first, then 32 bits (playback only) if that fails.
 	 */
 	if (pci_set_dma_mask(pcidev, 0x00ffffff) &&
-	    pci_set_dma_mask(pcidev, 0xffffffff)) {
+	    pci_set_dma_mask(pcidev, DMA_32BIT_MASK)) {
 		printk(KERN_WARNING "solo1: architecture does not support 24bit or 32bit PCI busmaster DMA\n");
 		return -ENODEV;
 	}

--
