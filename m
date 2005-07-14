Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262609AbVGNWYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbVGNWYk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 18:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262822AbVGNWXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 18:23:31 -0400
Received: from coderock.org ([193.77.147.115]:47777 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262609AbVGNWVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 18:21:05 -0400
Message-Id: <20050714222058.000777000@homer>
Date: Fri, 15 Jul 2005 00:20:58 +0200
From: domen@coderock.org
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, Tobias Klauser <tklauser@nuerscht.ch>,
       domen@coderock.org
Subject: [patch 2/2] drivers/block/umem.c: Use DMA_{32,64}BIT_MASK and correct call to pci_set_dma_mask()
Content-Disposition: inline; filename=dma_mask-drivers_block_umem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Klauser <tklauser@nuerscht.ch>


Since nobody replied to Domen's request for clarification [1], here's a
patch to fix drivers/block/umem.c to correctly evaluate the return value
of pci_set_dma_mask() both times. The function returns non-null on
error, so this seems to be correct.

[1] http://lists.osdl.org/mailman/htdig/kernel-janitors/2005-May/004119.html

Use the DMA_{64,32}BIT_MASK constants from dma-mapping.h when calling
pci_set_dma_mask()
This patch includes dma-mapping.h explicitly because it caused errors
on some architectures otherwise.
See http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Domen Puncer <domen@coderock.org>

---
 umem.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: quilt/drivers/block/umem.c
===================================================================
--- quilt.orig/drivers/block/umem.c
+++ quilt/drivers/block/umem.c
@@ -892,8 +892,8 @@ static int __devinit mm_pci_probe(struct
 	printk(KERN_INFO "Micro Memory(tm) controller #%d found at %02x:%02x (PCI Mem Module (Battery Backup))\n",
 	       card->card_number, dev->bus->number, dev->devfn);
 
-	if (pci_set_dma_mask(dev, 0xffffffffffffffffLL) &&
-	    !pci_set_dma_mask(dev, 0xffffffffLL)) {
+	if (pci_set_dma_mask(dev, DMA_64BIT_MASK) &&
+	    pci_set_dma_mask(dev, DMA_32BIT_MASK)) {
 		printk(KERN_WARNING "MM%d: NO suitable DMA found\n",num_cards);
 		return  -ENOMEM;
 	}

--
