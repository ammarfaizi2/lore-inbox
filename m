Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317269AbSFXEZC>; Mon, 24 Jun 2002 00:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317270AbSFXEZB>; Mon, 24 Jun 2002 00:25:01 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:260 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S317269AbSFXEZA>;
	Mon, 24 Jun 2002 00:25:00 -0400
Date: Mon, 24 Jun 2002 00:12:59 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.24 : drivers/scsi/eata_dma.c PCI DMA probe
Message-ID: <Pine.LNX.4.44.0206240010580.971-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  This patch is a probe for the eata_dma for DMA capability. This is the 
1st step for DMA-mapping.txt compliance.

Regards,
Frank

--- drivers/scsi/eata_dma.c.old	Wed Feb 13 21:26:58 2002
+++ drivers/scsi/eata_dma.c	Mon Jun 24 00:10:03 2002
@@ -1421,6 +1421,11 @@
 		printk("eata_dma: find_PCI, HBA at %s\n", dev->name));
 	    if (pci_enable_device(dev))
 	    	continue;
+	    if(pci_set_dma_mask(dev, 0xffffffff))
+	    {
+		printk(KERN_WARNING "eata_dma : No suitable DMA available\n");
+	    }
+	    
 	    pci_set_master(dev);
 	    base = pci_resource_flags(dev, 0);
 	    if (base & IORESOURCE_MEM) {

