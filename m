Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264475AbTDXWBg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 18:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264482AbTDXWBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 18:01:35 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:21252 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S264475AbTDXWBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 18:01:00 -0400
Date: Thu, 24 Apr 2003 17:12:42 -0500
From: mikem@beardog.cca.cpqcorp.net
Message-Id: <200304242212.h3OMCgc01143@beardog.cca.cpqcorp.net>
To: axboe@suse.de
Subject: RE:cciss patches for 2.4.21-rc1, 4 of 4
Cc: linux-kernel@vger.kernel.org, mike.miller@hp.com, steve.cameron@hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

20030424

Changes:
	1. Sets the DMA mask to 64 bits. Removes RH's code for the DMA mask.

diff -urN lx2421rc1-p3/drivers/block/cciss.c lx2421rc1/drivers/block/cciss.c
--- lx2421rc1-p3/drivers/block/cciss.c	Wed Apr 23 14:40:48 2003
+++ lx2421rc1/drivers/block/cciss.c	Wed Apr 23 14:51:55 2003
@@ -106,7 +106,7 @@
 #define NR_CMDS		 128 /* #commands that can be outstanding */
 #define MAX_CTLR 8
 
-#define CCISS_DMA_MASK	0xFFFFFFFF	/* 32 bit DMA */
+#define CCISS_DMA_MASK 0xFFFFFFFFFFFFFFFF /* 64 bit DMA */
 
 static ctlr_info_t *hba[MAX_CTLR];
 
@@ -2861,17 +2861,6 @@
 	hba[i]->ctlr = i;
 	hba[i]->pdev = pdev;
 
-	/* configure PCI DMA stuff */
-	if (!pci_set_dma_mask(pdev, (u64) 0xffffffffffffffff))
-		printk("cciss: using DAC cycles\n");
-	else if (!pci_set_dma_mask(pdev, (u64) 0xffffffff))
-		printk("cciss: not using DAC cycles\n");
-	else {
-		printk("cciss: no suitable DMA available\n");
-		free_hba(i);
-		return -ENODEV;
-	}
-		
 	if (register_blkdev(MAJOR_NR+i, hba[i]->devname, &cciss_fops)) {
 		printk(KERN_ERR "cciss:  Unable to get major number "
 			"%d for %s\n", MAJOR_NR+i, hba[i]->devname);
