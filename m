Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbTI2RH1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263797AbTI2RGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:06:53 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:28343 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263796AbTI2RE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:04:57 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ULL fixes for qlogicfc
Message-Id: <E1A41Rq-0000NJ-00@hardwired>
Date: Mon, 29 Sep 2003 18:04:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/scsi/qlogicfc.c linux-2.5/drivers/scsi/qlogicfc.c
--- bk-linus/drivers/scsi/qlogicfc.c	2003-09-08 00:47:00.000000000 +0100
+++ linux-2.5/drivers/scsi/qlogicfc.c	2003-09-08 01:30:56.000000000 +0100
@@ -718,8 +718,8 @@ int isp2x00_detect(Scsi_Host_Template * 
 				continue;
 
 			/* Try to configure DMA attributes. */
-			if (pci_set_dma_mask(pdev, (u64) 0xffffffffffffffff) &&
-			    pci_set_dma_mask(pdev, (u64) 0xffffffff))
+			if (pci_set_dma_mask(pdev, 0xffffffffffffffffULL) &&
+			    pci_set_dma_mask(pdev, 0xffffffffULL))
 					continue;
 
 		        host = scsi_register(tmpt, sizeof(struct isp2x00_hostdata));
