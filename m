Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbVKOPCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVKOPCY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 10:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVKOPCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 10:02:24 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:62907 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S932121AbVKOPCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 10:02:23 -0500
Date: Tue, 15 Nov 2005 16:02:18 +0100 (CET)
From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Marvell SATA fixes v2
In-Reply-To: <4379F31D.4000508@pobox.com>
Message-ID: <Pine.LNX.4.63.0511151554330.3015@dingo.iwr.uni-heidelberg.de>
References: <20051114050404.GA18144@havoc.gtf.org>
 <Pine.LNX.4.63.0511151437320.3015@dingo.iwr.uni-heidelberg.de>
 <4379F31D.4000508@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2005, Jeff Garzik wrote:

> any chance you could obtain additional debugging output by turning on
> #undef ATA_DEBUG                /* debugging output */
> #undef ATA_VERBOSE_DEBUG        /* yet more debugging output */
>
> in include/linux/libata.h?  this would help us see where it is stuck in 'D' 
> state.

Recompiled only the driver after modification and the output is:

sata_mv 0000:02:08.0: version 0.25
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 26 (level, low) -> IRQ 177
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err cause/mask=0x00000000/0x00001f7f
mv_init_host: HC0: HC config=0x11dcf013 HC IRQ cause (before clear)=0x00000000
mv_init_host: HC MAIN IRQ cause/mask=0x00000000/0x0007ffff PCI int cause/mask=0x00000000/0x00577fe6
mv_dump_pci_cfg: 00: 504111ab 02b00003 01000003 00002008 
mv_dump_pci_cfg: 10: f5000004 00000000 00000000 00000000 
mv_dump_pci_cfg: 20: 00000000 00000000 00000000 81241043 
mv_dump_pci_cfg: 30: 00000000 00000040 00000000 00000109 
mv_dump_pci_cfg: 40: 000a5001 00000000 00000000 00000000 
mv_dump_pci_cfg: 50: 00816005 fee00000 00000000 000040c1 
mv_dump_pci_cfg: 60: 00300007 01830240 
sata_mv 0000:02:08.0: 32 slots 4 ports SCSI mode IRQ via MSI
ata7: SATA max UDMA/133 cmd 0x0 ctl 0xF8C22120 bmdma 0x0 irq 177
ata8: SATA max UDMA/133 cmd 0x0 ctl 0xF8C24120 bmdma 0x0 irq 177
ata9: SATA max UDMA/133 cmd 0x0 ctl 0xF8C26120 bmdma 0x0 irq 177
ata10: SATA max UDMA/133 cmd 0x0 ctl 0xF8C28120 bmdma 0x0 irq 177
mv_phy_reset: ENTER, port 0, mmio 0xf8c22000
mv_phy_reset: S-regs after ATA_RST: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
mv_phy_reset: S-regs after PHY wake: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
mv_phy_reset: EXIT
ATA: abnormal status 0x80 on port 0xF8C2211C
ata7: dev 0 cfg 49:2f00 82:74eb 83:7feb 84:4123 85:74e9 86:3c03 87:4123 88:007f
ata7: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48

I don't think that this is really what you wanted - you probably 
wanted the place in libata where insmod stops, but the root FS is on 
another SATA disk connected to the ICH6, so if I enable DEBUG for 
libata this controller/disk will log quite a lot, right ?

> Also, you might try turning off CONFIG_PCI_MSI, in case MSI is 
> problematic on your machine, or on this card.

I'll try, but this requires recompiling the kernel. But I'll wait for 
the confirmation on whether the whole libata should be DEBUG-ed before 
starting the recompilation.

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De
