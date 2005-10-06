Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbVJFMrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbVJFMrF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 08:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbVJFMrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 08:47:05 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:13699 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S1750863AbVJFMrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 08:47:02 -0400
Date: Thu, 6 Oct 2005 14:46:51 +0200 (CEST)
From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
To: Brett Russ <russb@emc.com>
cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2 0/2] libata: Marvell SATA support (v0.23-0.24)
In-Reply-To: <20051005210610.EC31826369@lns1058.lss.emc.com>
Message-ID: <Pine.LNX.4.63.0510061441050.3140@dingo.iwr.uni-heidelberg.de>
References: <20051005210610.EC31826369@lns1058.lss.emc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2005, Brett Russ wrote:

> This patch series should fix up lockups that people were seeing due to
> improper spinlock placement (nested==bad).  Additionally, there are
> other changes to simplify things (complex=bad).  The second patch adds
> comment headers to functions that need it.

I guess that 0.24 was not supposed to fix any 50x1 problems, but I 
just wanted to provide more debug output. The disk (this time another 
one, but still connected to the first port) is still not detected:

sata_mv version 0.24
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 26 (level, low) -> IRQ 201
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err cause/mask=0x00000000/0x00001f7f
mv_host_init: HC0: HC config=0x11dcf013 HC IRQ cause (before clear)=0x00000111
mv_host_init: HC MAIN IRQ cause/mask=0x00000000/0x0007ffff PCI int cause/mask=0x00000000/0x00577fe6
mv_dump_pci_cfg: 00: 504111ab 02b00007 01000003 00002008 
mv_dump_pci_cfg: 10: f5000004 00000000 00000000 00000000 
mv_dump_pci_cfg: 20: 00000000 00000000 00000000 81241043 
mv_dump_pci_cfg: 30: 00000000 00000040 00000000 00000109 
mv_dump_pci_cfg: 40: 000a5001 00000000 00000000 00000000 
mv_dump_pci_cfg: 50: 00816005 fee01004 00000000 000040d9 
mv_dump_pci_cfg: 60: 00300007 01830240 
sata_mv(0000:02:08.0) 32 slots 4 ports SCSI mode IRQ via MSI
ata3: SATA max PIO4 cmd 0x0 ctl 0xF8A22120 bmdma 0x0 irq 201
ata4: SATA max PIO4 cmd 0x0 ctl 0xF8A24120 bmdma 0x0 irq 201
ata5: SATA max PIO4 cmd 0x0 ctl 0xF8A26120 bmdma 0x0 irq 201
ata6: SATA max PIO4 cmd 0x0 ctl 0xF8A28120 bmdma 0x0 irq 201
mv_phy_reset: ENTER, port 0, mmio 0xf8a22000
mv_phy_reset: S-regs after ATA_RST: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
mv_phy_reset: S-regs after PHY wake: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
ata3: no device found (phy stat 00000000)
scsi2 : sata_mv
mv_phy_reset: ENTER, port 1, mmio 0xf8a24000
mv_phy_reset: S-regs after ATA_RST: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
mv_phy_reset: S-regs after PHY wake: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
ata4: no device found (phy stat 00000000)
scsi3 : sata_mv
mv_phy_reset: ENTER, port 2, mmio 0xf8a26000
mv_phy_reset: S-regs after ATA_RST: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
mv_phy_reset: S-regs after PHY wake: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
ata5: no device found (phy stat 00000000)
scsi4 : sata_mv
mv_phy_reset: ENTER, port 3, mmio 0xf8a28000
mv_phy_reset: S-regs after ATA_RST: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
mv_phy_reset: S-regs after PHY wake: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
ata6: no device found (phy stat 00000000)
scsi5 : sata_mv

Thanks for working on this driver !

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De
