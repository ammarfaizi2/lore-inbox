Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135830AbRDYHFz>; Wed, 25 Apr 2001 03:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135826AbRDYHFg>; Wed, 25 Apr 2001 03:05:36 -0400
Received: from ns.caldera.de ([212.34.180.1]:45704 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S135825AbRDYHF0>;
	Wed, 25 Apr 2001 03:05:26 -0400
Date: Wed, 25 Apr 2001 09:04:38 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: PATCH: trident , pci_enable_device moved
Message-ID: <20010425090438.A12672@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan, linux-kernel,

This moves pci_enable_device() in trident.c before any PCI resource access.
Everything else appears to be ok in regards to 2.4 PCI API and return values.

Ciao, Marcus

Index: trident.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/sound/trident.c,v
retrieving revision 1.12
diff -u -r1.12 trident.c
--- trident.c	2001/04/24 09:47:13	1.12
+++ trident.c	2001/04/24 10:19:36
@@ -3309,6 +3309,9 @@
 	struct trident_card *card;
 	u8 revision;
 
+	if (pci_enable_device(pci_dev))
+	    return -ENODEV;
+
 	if (pci_set_dma_mask(pci_dev, TRIDENT_DMA_MASK)) {
 		printk(KERN_ERR "trident: architecture does not support"
 		       " 30bit PCI busmaster DMA\n");
@@ -3322,9 +3325,6 @@
 		       iobase);
 		return -ENODEV;
 	}
-
-	if (pci_enable_device(pci_dev))
-	    return -ENODEV;
 
 	if ((card = kmalloc(sizeof(struct trident_card), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "trident: out of memory\n");
