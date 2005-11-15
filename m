Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbVKOUON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbVKOUON (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 15:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbVKOUOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 15:14:12 -0500
Received: from relay2.uni-heidelberg.de ([129.206.210.211]:24780 "EHLO
	relay2.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S965030AbVKOUOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 15:14:10 -0500
Date: Tue, 15 Nov 2005 21:13:35 +0100 (CET)
From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Marvell SATA fixes v2
In-Reply-To: <4379F31D.4000508@pobox.com>
Message-ID: <Pine.LNX.4.63.0511152108140.3015@dingo.iwr.uni-heidelberg.de>
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
> Also, you might try turning off CONFIG_PCI_MSI, in case MSI is problematic on 
> your machine, or on this card.

With ATA*DEBUG _and_ CONFIG_PCI_MSI, I get again the insmod problem; 
the logs are:

sata_mv 0000:02:08.0: version 0.25
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 26 (level, low) -> IRQ 201
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err cause/mask=0x00000000/0x00001f7f
mv_init_host: HC0: HC config=0x11dcf013 HC IRQ cause (before clear)=0x00000000
mv_init_host: HC MAIN IRQ cause/mask=0x00000000/0x0007ffff PCI int cause/mask=0x00000000/0x00577fe6
mv_dump_pci_cfg: 00: 504111ab 02b00007 01000003 00002008 
mv_dump_pci_cfg: 10: f5000004 00000000 00000000 00000000 
mv_dump_pci_cfg: 20: 00000000 00000000 00000000 81241043 
mv_dump_pci_cfg: 30: 00000000 00000040 00000000 00000109 
mv_dump_pci_cfg: 40: 000a5001 00000000 00000000 00000000 
mv_dump_pci_cfg: 50: 00816005 fee00000 00000000 000040d9 
mv_dump_pci_cfg: 60: 00300007 01830240 
sata_mv 0000:02:08.0: 32 slots 4 ports SCSI mode IRQ via MSI
ata_device_add: ENTER
ata_host_add: ENTER
ata1: SATA max UDMA/133 cmd 0x0 ctl 0xF8BA2120 bmdma 0x0 irq 201
ata_host_add: ENTER
ata2: SATA max UDMA/133 cmd 0x0 ctl 0xF8BA4120 bmdma 0x0 irq 201
ata_host_add: ENTER
ata3: SATA max UDMA/133 cmd 0x0 ctl 0xF8BA6120 bmdma 0x0 irq 201
ata_host_add: ENTER
ata4: SATA max UDMA/133 cmd 0x0 ctl 0xF8BA8120 bmdma 0x0 irq 201
ata_device_add: probe begin
ata_device_add: ata1: probe begin
mv_phy_reset: ENTER, port 0, mmio 0xf8ba2000
mv_phy_reset: S-regs after ATA_RST: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
mv_phy_reset: S-regs after PHY wake: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
ata_dev_classify: found ATA device by sig
mv_phy_reset: EXIT
ata_dev_identify: ENTER, host 1, dev 0
ata_dev_select: ENTER, ata1: device 0, wait 1
ATA: abnormal status 0x80 on port 0xF8BA211C
ata_dev_identify: do ATA identify
ata_dev_select: ENTER, ata1: device 0, wait 1
ata_exec_command_mmio: ata1: cmd 0xEC
ata_pio_sector: data read
ata_qc_complete: EXIT
ata1: dev 0 cfg 49:2f00 82:74eb 83:7feb 84:4123 85:74e9 86:3c03 87:4123 88:007f
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0407  64==0x0003  75==0x001f 
ata_dump_id: 80==0x00fc  81==0x001a  82==0x74eb  83==0x7feb  84==0x4123 
ata_dump_id: 88==0x007f  93==0x0000
ata1: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48
ata_dev_identify: EXIT, drv_stat = 0x50
ata_dev_identify: ENTER/EXIT (host 1, dev 1) -- nodev
ata_host_set_pio: base 0x8 xfer_mode 0xc mask 0x1f x 4
ata_dev_set_xfermode: set features - xfer mode
ata_dev_select: ENTER, ata1: device 0, wait 1
ata_tf_load_mmio: feat 0x3 nsect 0x46 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xA0
ata_exec_command_mmio: ata1: cmd 0xEF


So, the insmod problem seem to be related to using MSI. OTOH, using 
MSI goes a bit further in identifying the attached disk...

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De
