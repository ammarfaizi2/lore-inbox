Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314485AbSFXRcB>; Mon, 24 Jun 2002 13:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314514AbSFXRcA>; Mon, 24 Jun 2002 13:32:00 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:3592 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S314485AbSFXRb7>;
	Mon, 24 Jun 2002 13:31:59 -0400
Date: Mon, 24 Jun 2002 13:23:14 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <jfbeam@bluetronic.net>
Subject: [PATCH] 2.5.24 : drivers/scsi/dpt_i2o.c (DMA Rev. 2)
Message-ID: <Pine.LNX.4.44.0206241320180.901-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  I've added the check for 64-bit DMA addressing per Rick's comment. 
Regards,
Frank

--- drivers/scsi/dpt_i2o.c.old	Mon Jun 10 12:18:59 2002
+++ drivers/scsi/dpt_i2o.c	Mon Jun 24 13:18:03 2002
@@ -879,6 +879,21 @@
 	if(pci_enable_device(pDev)) {
 		return -EINVAL;
 	}
+	int using_dac;
+	
+	if(!pci_set_dma_mask(pDev, 0xffffffffffffffff))
+	{	
+		using_dac = 1;
+		printk("dpt_i2o : Using 64-bit DMA addressing\n");
+
+	}else if(!pci_set_dma_mask(pDev, 0xffffffff))
+	{
+		using_dac = 0;
+		printk("dpt_i2o : Using 32-bit DMA addressing\n");
+
+	}else {
+		printk(KERN_WARNING "dpt_i2o : No suitable DMA available\n");
+	}	
 	pci_set_master(pDev);
 
 	base_addr0_phys = pci_resource_start(pDev,0);

