Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbVFJPer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbVFJPer (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 11:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbVFJPe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 11:34:29 -0400
Received: from palrel13.hp.com ([156.153.255.238]:55697 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262575AbVFJPeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 11:34:20 -0400
Date: Fri, 10 Jun 2005 09:34:53 -0500
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] cciss 2.6; replaces DMA masks with kernel defines
Message-ID: <20050610143453.GA26476@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes our homegrown DMA masks and uses the ones defined in
the kernel instead.
Thanks to Jens Axboe for the code. Please consider this for inclusion.

Signed-off-by: Mike Miller <mike.miller@hp.com>

 cciss.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

--------------------------------------------------------------------------------
diff -burNp lx2612-rc6.orig/drivers/block/cciss.c lx2612-rc6/drivers/block/cciss.c
--- lx2612-rc6.orig/drivers/block/cciss.c	2005-06-10 08:43:05.516957392 -0500
+++ lx2612-rc6/drivers/block/cciss.c	2005-06-10 08:56:44.302483072 -0500
@@ -126,8 +126,6 @@ static struct board_type products[] = {
 #define MAX_CTLR_ORIG 	8
 
 
-#define CCISS_DMA_MASK	0xFFFFFFFF	/* 32 bit DMA */
-
 static ctlr_info_t *hba[MAX_CTLR];
 
 static void do_cciss_request(request_queue_t *q);
@@ -2747,9 +2745,9 @@ static int __devinit cciss_init_one(stru
 	hba[i]->pdev = pdev;
 
 	/* configure PCI DMA stuff */
-	if (!pci_set_dma_mask(pdev, 0xffffffffffffffffULL))
+	if (!pci_set_dma_mask(pdev, DMA_64BIT_MASK))
 		printk("cciss: using DAC cycles\n");
-	else if (!pci_set_dma_mask(pdev, 0xffffffff))
+	else if (!pci_set_dma_mask(pdev, DMA_32BIT_MASK))
 		printk("cciss: not using DAC cycles\n");
 	else {
 		printk("cciss: no suitable DMA available\n");
