Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317268AbSFXEEy>; Mon, 24 Jun 2002 00:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317269AbSFXEEx>; Mon, 24 Jun 2002 00:04:53 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:30731 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S317268AbSFXEEw>;
	Mon, 24 Jun 2002 00:04:52 -0400
Date: Sun, 23 Jun 2002 23:56:08 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.24 : drivers/scsi/dpt_i2o.c for PCI DMA
Message-ID: <Pine.LNX.4.44.0206232353390.909-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  Here's another 1st step patch for DMA usage for the dpt_i2o driver. 
Please review. 

Regards,
Frank

--- drivers/scsi/dpt_i2o.c.old	Mon Jun 10 12:18:59 2002
+++ drivers/scsi/dpt_i2o.c	Sun Jun 23 23:52:48 2002
@@ -879,6 +879,11 @@
 	if(pci_enable_device(pDev)) {
 		return -EINVAL;
 	}
+
+	if(pci_set_dma_mask(pDev, 0xffffffff))
+	{
+		printk(KERN_WARNING "dpt_i2o : No suitable DMA available\n");
+	}
 	pci_set_master(pDev);
 
 	base_addr0_phys = pci_resource_start(pDev,0);

