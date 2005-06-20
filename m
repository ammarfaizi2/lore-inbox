Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVFUGTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVFUGTE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 02:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVFUGM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 02:12:29 -0400
Received: from coderock.org ([193.77.147.115]:16281 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261740AbVFTVzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:55:14 -0400
Message-Id: <20050620215139.825371000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:51:41 +0200
From: domen@coderock.org
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, Tobias Klauser <tklauser@nuerscht.ch>,
       domen@coderock.org
Subject: [patch 11/12] drivers/block/umem.c: Use the DMA_{64, 32}BIT_MASK constants
Content-Disposition: inline; filename=dma_mask-drivers_block_umem.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Klauser <tklauser@nuerscht.ch>



Use the DMA_{64,32}BIT_MASK constants from dma-mapping.h when calling
pci_set_dma_mask() or pci_set_consistent_dma_mask()
These patches include dma-mapping.h explicitly because it caused errors
on some architectures otherwise.
See http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 umem.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

Index: quilt/drivers/block/umem.c
===================================================================
--- quilt.orig/drivers/block/umem.c
+++ quilt/drivers/block/umem.c
@@ -50,6 +50,7 @@
 #include <linux/timer.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/dma-mapping.h>
 
 #include <linux/fcntl.h>        /* O_ACCMODE */
 #include <linux/hdreg.h>  /* HDIO_GETGEO */
@@ -892,8 +893,8 @@ static int __devinit mm_pci_probe(struct
 	printk(KERN_INFO "Micro Memory(tm) controller #%d found at %02x:%02x (PCI Mem Module (Battery Backup))\n",
 	       card->card_number, dev->bus->number, dev->devfn);
 
-	if (pci_set_dma_mask(dev, 0xffffffffffffffffLL) &&
-	    !pci_set_dma_mask(dev, 0xffffffffLL)) {
+	if (pci_set_dma_mask(dev, DMA_64BIT_MASK) &&
+	    !pci_set_dma_mask(dev, DMA_32BIT_MASK)) {
 		printk(KERN_WARNING "MM%d: NO suitable DMA found\n",num_cards);
 		return  -ENOMEM;
 	}

--
