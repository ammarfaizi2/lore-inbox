Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265264AbSIWJfY>; Mon, 23 Sep 2002 05:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265267AbSIWJfY>; Mon, 23 Sep 2002 05:35:24 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19593 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265264AbSIWJfY>;
	Mon, 23 Sep 2002 05:35:24 -0400
Date: Mon, 23 Sep 2002 11:40:20 +0200
From: Jens Axboe <axboe@suse.de>
To: Witek Krecicki <adasi@kernel.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.38] IDE oopses on vmware
Message-ID: <20020923094020.GD15479@suse.de>
References: <Pine.LNX.4.44L.0209221225180.3713-100000@ep09.kernel.pl> <000a01c26223$90b2ce90$0201a8c0@witek>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000a01c26223$90b2ce90$0201a8c0@witek>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22 2002, Witek Krecicki wrote:
> ----- Original Message -----
> From: "Witek Krecicki" <adasi@kernel.pl>
> > Oops happens after:
> > Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> > ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> > hda: VMware Virtual IDE Hard Drive, ATA DISK drive
> > hdc: VMware Virtual IDE CDROM Drive, ATAPI CD/DVD-ROM drive
> > ide2: ports already in use, skipping probe
> {cut}
> Just checked: the same oops happens on 'physical' Asus A7M266

The patch from Andries should fix this, did you check? It's in current
BK, I've attached it for you as well. Note that it has white space
damage, so needs to be applied manually.

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

-- 
Jens Axboe

