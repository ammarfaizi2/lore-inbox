Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268488AbTBWPOd>; Sun, 23 Feb 2003 10:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268485AbTBWPMp>; Sun, 23 Feb 2003 10:12:45 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11537 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268483AbTBWPKU>; Sun, 23 Feb 2003 10:10:20 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] [6/6] Always re-read vendor for each function
Message-Id: <20020223151806@raistlin.arm.linux.org.uk>
References: <20020223151805@raistlin.arm.linux.org.uk>
In-Reply-To: <20020223151805@raistlin.arm.linux.org.uk>
Date: Sun, 23 Feb 2003 15:20:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch appears not to be in 2.5.62, but applies cleanly.

Subject: [6/6] Always re-read vendor for each function
We should probably always read the vendor ID from each function
rather than assuming that it is identical to function 0.

 drivers/pcmcia/cardbus.c |    4 ++--
 1 files changed, 2 insertions, 2 deletions

diff -ur -x sa11* -x Kconfig -x Makefile orig/drivers/pcmcia/cardbus.c linux/drivers/pcmcia/cardbus.c
--- orig/drivers/pcmcia/cardbus.c	Sun Feb 23 14:12:57 2003
+++ linux/drivers/pcmcia/cardbus.c	Sun Feb 23 14:15:26 2003
@@ -263,9 +263,9 @@
 		dev->sysdata = bus->sysdata;
 		dev->dev.parent = bus->dev;
 		dev->dev.bus = &pci_bus_type;
-
 		dev->devfn = i;
-		dev->vendor = vend;
+
+		pci_read_config_word(dev, PCI_VENDOR_ID, &dev->vendor);
 		pci_read_config_word(dev, PCI_DEVICE_ID, &dev->device);
 		dev->hdr_type = hdr & 0x7f;
 		dev->dma_mask = 0xffffffff;
