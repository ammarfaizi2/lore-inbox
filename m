Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275907AbSIUMGb>; Sat, 21 Sep 2002 08:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275908AbSIUMGb>; Sat, 21 Sep 2002 08:06:31 -0400
Received: from hera.cwi.nl ([192.16.191.8]:51873 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S275907AbSIUMGb>;
	Sat, 21 Sep 2002 08:06:31 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 21 Sep 2002 14:11:38 +0200 (MEST)
Message-Id: <UTC200209211211.g8LCBcW16848.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.37 oopses at boot in ide_toggle_bounce
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.37 oopses at boot in ide_toggle_bounce().
With

--- linux-2.5.37/linux/drivers/ide/ide-lib.c    Sat Sep 21 11:39:48 2002
+++ linux-2.5.37a/linux/drivers/ide/ide-lib.c   Sat Sep 21 14:06:45 2002
@@ -394,7 +394,7 @@
        if (on && drive->media == ide_disk) {
                if (!PCI_DMA_BUS_IS_PHYS)
                        addr = BLK_BOUNCE_ANY;
-               else
+               else if (HWIF(drive)->pci_dev)
                        addr = HWIF(drive)->pci_dev->dma_mask;
        }

it boots for me. I have not investigated a proper fix.

Andries
