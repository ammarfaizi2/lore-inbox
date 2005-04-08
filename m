Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262740AbVDHIAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbVDHIAY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 04:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbVDHH6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 03:58:32 -0400
Received: from coderock.org ([193.77.147.115]:17376 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262743AbVDHHvu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:51:50 -0400
Subject: [patch 1/1] block/cpqarray: Use the DMA_32BIT_MASK constant
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, tklauser@nuerscht.ch
From: domen@coderock.org
Date: Fri, 08 Apr 2005 09:51:39 +0200
Message-Id: <20050408075139.8237C1EE91@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Use the DMA_32BIT_MASK constant from dma-mapping.h when calling
pci_set_dma_mask() or pci_set_consistent_dma_mask() instead of custom
macros.
This patch includes dma-mapping.h explicitly because it caused errors
on some architectures otherwise.
See http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/block/cpqarray.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff -puN drivers/block/cpqarray.c~dma_mask-drivers_block_cpqarray drivers/block/cpqarray.c
--- kj/drivers/block/cpqarray.c~dma_mask-drivers_block_cpqarray	2005-04-05 12:57:44.000000000 +0200
+++ kj-domen/drivers/block/cpqarray.c	2005-04-05 12:57:44.000000000 +0200
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
_
