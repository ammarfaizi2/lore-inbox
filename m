Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbTI2RH0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbTI2RHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:07:11 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:20407 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263792AbTI2REy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:04:54 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] megaraid ULL fix.
Message-Id: <E1A41Rq-0000NG-00@hardwired>
Date: Mon, 29 Sep 2003 18:04:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/scsi/megaraid.c linux-2.5/drivers/scsi/megaraid.c
--- bk-linus/drivers/scsi/megaraid.c	2003-09-08 00:46:59.000000000 +0100
+++ linux-2.5/drivers/scsi/megaraid.c	2003-09-08 01:30:56.000000000 +0100
@@ -586,7 +586,7 @@ mega_find_card(Scsi_Host_Template *host_
 
 		/* Set the Mode of addressing to 64 bit if we can */
 		if((adapter->flag & BOARD_64BIT)&&(sizeof(dma_addr_t) == 8)) {
-			pci_set_dma_mask(pdev, 0xffffffffffffffff);
+			pci_set_dma_mask(pdev, 0xffffffffffffffffULL);
 			adapter->has_64bit_addr = 1;
 		}
 		else  {
