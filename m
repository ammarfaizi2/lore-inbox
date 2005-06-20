Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVFUGLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVFUGLr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 02:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVFUGLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 02:11:46 -0400
Received: from coderock.org ([193.77.147.115]:18585 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261742AbVFTVzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:55:25 -0400
Message-Id: <20050620215140.909269000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:51:42 +0200
From: domen@coderock.org
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, Tobias Klauser <tklauser@nuerscht.ch>,
       domen@coderock.org
Subject: [patch 12/12] block/cpqarray: Use the DMA_32BIT_MASK constant
Content-Disposition: inline; filename=dma_mask-drivers_block_cpqarray.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Klauser <tklauser@nuerscht.ch>



Use the DMA_32BIT_MASK constant from dma-mapping.h when calling
pci_set_dma_mask() or pci_set_consistent_dma_mask() instead of custom
macros.
This patch includes dma-mapping.h explicitly because it caused errors
on some architectures otherwise.
See http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 cpqarray.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

Index: quilt/drivers/block/cpqarray.c
===================================================================
--- quilt.orig/drivers/block/cpqarray.c
+++ quilt/drivers/block/cpqarray.c
@@ -39,6 +39,7 @@
 #include <linux/spinlock.h>
 #include <linux/blkdev.h>
 #include <linux/genhd.h>
+#include <linux/dma-mapping.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
@@ -65,8 +66,6 @@ MODULE_LICENSE("GPL");
 #define MAX_CTLR	8
 #define CTLR_SHIFT	8
 
-#define CPQARRAY_DMA_MASK	0xFFFFFFFF	/* 32 bit DMA */
-
 static int nr_ctlr;
 static ctlr_info_t *hba[MAX_CTLR];
 
@@ -626,7 +625,7 @@ static int cpqarray_pci_init(ctlr_info_t
 	for(i=0; i<6; i++)
 		addr[i] = pci_resource_start(pdev, i);
 
-	if (pci_set_dma_mask(pdev, CPQARRAY_DMA_MASK) != 0)
+	if (pci_set_dma_mask(pdev, DMA_32BIT_MASK) != 0)
 	{
 		printk(KERN_ERR "cpqarray: Unable to set DMA mask\n");
 		return -1;

--
