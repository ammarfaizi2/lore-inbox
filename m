Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135809AbRDYLHi>; Wed, 25 Apr 2001 07:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135841AbRDYLH3>; Wed, 25 Apr 2001 07:07:29 -0400
Received: from ns.caldera.de ([212.34.180.1]:57226 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S135809AbRDYLHO>;
	Wed, 25 Apr 2001 07:07:14 -0400
Date: Wed, 25 Apr 2001 13:06:24 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: Marcus Meissner <Marcus.Meissner@caldera.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: trident , pci_enable_device moved
Message-ID: <20010425130624.A3216@caldera.de>
In-Reply-To: <20010425090438.A12672@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010425090438.A12672@caldera.de>; from Marcus.Meissner@caldera.de on Wed, Apr 25, 2001 at 09:04:38AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2001 at 09:04:38AM +0200, Marcus Meissner wrote:
> Hi Alan, linux-kernel,
> 
> This moves pci_enable_device() in trident.c before any PCI resource access.
> Everything else appears to be ok in regards to 2.4 PCI API and return values.
> 
> Ciao, Marcus

Argh, actually the return value of pci_enable_device*() should be returned.

Ciao, Marcus

Index: drivers/sound/trident.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/sound/trident.c,v
retrieving revision 1.12
diff -u -r1.12 trident.c
--- drivers/sound/trident.c	2001/04/24 09:47:13	1.12
+++ drivers/sound/trident.c	2001/04/25 07:31:11
@@ -3308,7 +3308,11 @@
 	unsigned long iobase;
 	struct trident_card *card;
 	u8 revision;
+	int ret;
 
+	if ((ret=pci_enable_device(pci_dev)))
+	    return ret;
+
 	if (pci_set_dma_mask(pci_dev, TRIDENT_DMA_MASK)) {
 		printk(KERN_ERR "trident: architecture does not support"
 		       " 30bit PCI busmaster DMA\n");
@@ -3322,9 +3326,6 @@
 		       iobase);
 		return -ENODEV;
 	}
-
-	if (pci_enable_device(pci_dev))
-	    return -ENODEV;
 
 	if ((card = kmalloc(sizeof(struct trident_card), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "trident: out of memory\n");
