Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbVIZSvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbVIZSvX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 14:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbVIZSvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 14:51:23 -0400
Received: from pimout7-ext.prodigy.net ([207.115.63.58]:1674 "EHLO
	pimout7-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S932475AbVIZSvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 14:51:22 -0400
X-ORBL: [69.225.172.73]
Subject: Re: [PATCH 2.6.14-rc2] libata: Marvell SATA support (DMA mode)
From: Michael Madore <Michael.Madore@aslab.com>
To: Brett Russ <russb@emc.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Pasi Pirhonen <upi@papat.org>,
       Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>,
       "Mr. Berkley Shands" <bshands@exegy.com>,
       Jim Edwards <jim@networkdesigning.com>
In-Reply-To: <20050923194222.C13101CD3F@lns1058.lss.emc.com>
References: <20050923194222.C13101CD3F@lns1058.lss.emc.com>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 11:49:01 -0700
Message-Id: <1127760541.22826.14.camel@drevil.aslab.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-23 at 15:42 -0400, Brett Russ wrote:
> This is my libata compatible low level driver for the Marvell SATA
> family.  Currently it runs in DMA mode on a 6081 chip with caveats
> (see below).
> 
> The 5xxx series parts are not yet DMA capable in this driver because
> the registers have differences that haven't been accounted for yet.
> Basically, I'm focused on the 6xxx series right now.  There are
> numerous improvements in the driver that will affect PIO mode for all
> parts, so it's worth running the new driver for all users.
> 
> Caveats...there is an outstanding panic in the scsi layer when hitting
> error conditions.  I've also seen a hang, also apparently during error
> conditions.  I will reply to this message with details of the panics
> and will cc the scsi list as well.  Basically, error handling has a
> bug.
> 
> All failures are under active debug but I wanted to get this out for
> review sooner rather than later.
> 
> Thank you,
> BR

Hi Brett,

Here are the results of a quick test of the driver patch applied to
2.6.14-rc2.  Both tests were performed on a dual Xeon with
hyperthreading enabled.  A single Western Digital WD360 raptor drive was
attached to the controller:

MV88SX5081 8-port SATA I PCI-X Controller:

CPU 3: Machine Check Exception: 0000000000000004
CPU 2: Machine Check Exception: 0000000000000004

There are no other messages, and the machine locks up solid.

MV88SX6081 8-port SATA II PCI-X Controller (rev 09):

libata version 1.12 loaded.
sata_mv version 0.19
ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 28 (level, low) -> IRQ 209
sata_mv(0000:03:03.0) 32 slots 8 ports SCSI mode IRQ via MSI
ata1: SATA max UDMA/133 cmd 0x0 ctl 0xF8BA2120 bmdma 0x0 irq 209
ata2: SATA max UDMA/133 cmd 0x0 ctl 0xF8BA4120 bmdma 0x0 irq 209
ata3: SATA max UDMA/133 cmd 0x0 ctl 0xF8BA6120 bmdma 0x0 irq 209
ata4: SATA max UDMA/133 cmd 0x0 ctl 0xF8BA8120 bmdma 0x0 irq 209
ata5: SATA max UDMA/133 cmd 0x0 ctl 0xF8BB2120 bmdma 0x0 irq 209
ata6: SATA max UDMA/133 cmd 0x0 ctl 0xF8BB4120 bmdma 0x0 irq 209
ata7: SATA max UDMA/133 cmd 0x0 ctl 0xF8BB6120 bmdma 0x0 irq 209
ata8: SATA max UDMA/133 cmd 0x0 ctl 0xF8BB8120 bmdma 0x0 irq 209
ata1: no device found (phy stat 00000000)
scsi0 : sata_mv
ata2: no device found (phy stat 00000000)
scsi1 : sata_mv
ata3: no device found (phy stat 00000000)
scsi2 : sata_mv
ata4: no device found (phy stat 00000000)
scsi3 : sata_mv
ATA: abnormal status 0x80 on port 0xF8BB211C
ATA: abnormal status 0x80 on port 0xF8BB211C
ATA: abnormal status 0x80 on port 0xF8BB211C
ATA: abnormal status 0x80 on port 0xF8BB211C
ATA: abnormal status 0x80 on port 0xF8BB211C
ATA: abnormal status 0x80 on port 0xF8BB211C
ata5: PIO error, drv_stat 0x50
ata5: dev 0 cfg 49:0000 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000
88:0000
ata5: no dma/lba
ata5: dev 0 not supported, ignoring
scsi4 : sata_mv
ata6: no device found (phy stat 00000000)
scsi5 : sata_mv
ata7: no device found (phy stat 00000000)
scsi6 : sata_mv
ata8: no device found (phy stat 00000000)
scsi7 : sata_mv

Mike

