Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161264AbVKRVuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161264AbVKRVuQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 16:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161263AbVKRVuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 16:50:15 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:59551 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S1161264AbVKRVuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 16:50:12 -0500
Date: Fri, 18 Nov 2005 22:50:04 +0100 (CET)
From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-ide@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Marvell SATA fixes v2
In-Reply-To: <437D2DED.5030602@pobox.com>
Message-ID: <Pine.LNX.4.44.0511182241420.5095-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2005, Jeff Garzik wrote:

> See if you can give the latest git tree a try (what will be 
> 2.6.15-rc1-git6, later tonight).  I think I've killed most of the 
> sata_mv bugs, and have it working here on both 50xx and 60xx.

I can report success as well on a 504x. However it only works without 
MSI, with MSI I get the same insmod blocked in D state as before.

I'll try some torture tests with the 2 disks currently attached (on
port 1 and port 3), but I'll have to revert to a non-DEBUG libata to 
get rid of the logging...

Many thanks!

--------------------------------------------------------
Without MSI:

sata_mv 0000:02:08.0: version 0.5
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 26 (level, low) -> IRQ 20
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
mv_dump_pci_cfg: 50: 00806005 00000000 00000000 00000000 
mv_dump_pci_cfg: 60: 00300007 01830240 
sata_mv 0000:02:08.0: 32 slots 4 ports SCSI mode IRQ via INTx
ata_device_add: ENTER
ata_host_add: ENTER
ata1: SATA max UDMA/133 cmd 0x0 ctl 0xF8BA2120 bmdma 0x0 irq 20
ata_host_add: ENTER
ata2: SATA max UDMA/133 cmd 0x0 ctl 0xF8BA4120 bmdma 0x0 irq 20
ata_host_add: ENTER
ata3: SATA max UDMA/133 cmd 0x0 ctl 0xF8BA6120 bmdma 0x0 irq 20
ata_host_add: ENTER
ata4: SATA max UDMA/133 cmd 0x0 ctl 0xF8BA8120 bmdma 0x0 irq 20
ata_device_add: probe begin
ata_device_add: ata1: probe begin
__mv_phy_reset: ENTER, port 0, mmio 0xf8ba2000
__mv_phy_reset: S-regs after ATA_RST: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
__mv_phy_reset: S-regs after PHY wake: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
ata_dev_classify: found ATA device by sig
__mv_phy_reset: EXIT
ata_dev_identify: ENTER, host 1, dev 0
ata_dev_select: ENTER, ata1: device 0, wait 1
ata_dev_identify: do ATA identify
ata_dev_select: ENTER, ata1: device 0, wait 1
ata_exec_command_mmio: ata1: cmd 0xEC
mv_host_intr: ENTER, hc0 relevant=0x00000002 HC IRQ cause=0x00000100
mv_host_intr: port 0 IRQ found for qc, ata_status 0x58
mv_host_intr: EXIT
mv_host_intr: ENTER, hc0 relevant=0x00000002 HC IRQ cause=0x00000100
mv_host_intr: port 0 IRQ found for qc, ata_status 0x58
mv_host_intr: EXIT
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
mv_host_intr: ENTER, hc0 relevant=0x00000002 HC IRQ cause=0x00000100
mv_host_intr: port 0 IRQ found for qc, ata_status 0x50
ata_qc_complete: EXIT
mv_host_intr: EXIT
mv_host_intr: ENTER, hc0 relevant=0x00000002 HC IRQ cause=0x00000100
mv_host_intr: EXIT
ata_dev_set_xfermode: EXIT
ata_dev_set_mode: idx=6 xfer_shift=0, xfer_mode=0x46, base=0x40, offset=6
ata1: dev 0 configured for UDMA/133
ata_device_add: ata1: probe end
scsi0 : sata_mv
ata_device_add: ata2: probe begin
__mv_phy_reset: ENTER, port 1, mmio 0xf8ba4000
__mv_phy_reset: S-regs after ATA_RST: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
__mv_phy_reset: S-regs after PHY wake: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
ata2: no device found (phy stat 00000000)
ata_device_add: ata2: probe end
scsi1 : sata_mv
ata_device_add: ata3: probe begin
__mv_phy_reset: ENTER, port 2, mmio 0xf8ba6000
__mv_phy_reset: S-regs after ATA_RST: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
__mv_phy_reset: S-regs after PHY wake: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
ata3: no device found (phy stat 00000000)
ata_device_add: ata3: probe end
scsi2 : sata_mv
ata_device_add: ata4: probe begin
__mv_phy_reset: ENTER, port 3, mmio 0xf8ba8000
__mv_phy_reset: S-regs after ATA_RST: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
__mv_phy_reset: S-regs after PHY wake: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
ata_dev_classify: found ATA device by sig
__mv_phy_reset: EXIT
ata_dev_identify: ENTER, host 4, dev 0
ata_dev_select: ENTER, ata4: device 0, wait 1
ata_dev_identify: do ATA identify
ata_dev_select: ENTER, ata4: device 0, wait 1
ata_exec_command_mmio: ata4: cmd 0xEC
mv_host_intr: ENTER, hc0 relevant=0x00000080 HC IRQ cause=0x00000800
mv_host_intr: port 3 IRQ found for qc, ata_status 0x58
mv_host_intr: EXIT
mv_host_intr: ENTER, hc0 relevant=0x00000080 HC IRQ cause=0x00000800
mv_host_intr: port 3 IRQ found for qc, ata_status 0x58
mv_host_intr: EXIT
ata_pio_sector: data read
ata_qc_complete: EXIT
ata4: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 88:407f
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0407  64==0x0003  75==0x0000  
ata_dump_id: 80==0x00fe  81==0x001e  82==0x7c6b  83==0x7b09  84==0x4003  
ata_dump_id: 88==0x407f  93==0x0000
ata4: dev 0 ATA-7, max UDMA/133, 240121728 sectors: LBA
ata_dev_identify: EXIT, drv_stat = 0x50
ata_dev_identify: ENTER/EXIT (host 4, dev 1) -- nodev
ata_host_set_pio: base 0x8 xfer_mode 0xc mask 0x1f x 4
ata_dev_set_xfermode: set features - xfer mode
ata_dev_select: ENTER, ata4: device 0, wait 1
ata_tf_load_mmio: feat 0x3 nsect 0x46 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xA0
ata_exec_command_mmio: ata4: cmd 0xEF
mv_host_intr: ENTER, hc0 relevant=0x00000080 HC IRQ cause=0x00000800
mv_host_intr: port 3 IRQ found for qc, ata_status 0x50
ata_qc_complete: EXIT
mv_host_intr: EXIT
mv_host_intr: ENTER, hc0 relevant=0x00000080 HC IRQ cause=0x00000800
mv_host_intr: EXIT
ata_dev_set_xfermode: EXIT
ata_dev_set_mode: idx=6 xfer_shift=0, xfer_mode=0x46, base=0x40, offset=6
ata4: dev 0 configured for UDMA/133
ata_device_add: ata4: probe end
scsi3 : sata_mv
ata_device_add: probe begin
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 24 00 5a 5a 5a
ata_scsiop_inq_std: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 60 00 5a 5a 5a
ata_scsiop_inq_std: ENTER
  Vendor: ATA       Model: HDS724040KLSA80   Rev: KFAO
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 5a 5a 5a
ata_scsiop_noop: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
SCSI device sda: 781422768 512-byte hdwr sectors (400088 MB)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 24
ata_scsiop_mode_sense: ENTER
SCSI device sda: drive cache: write back
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 5a 5a 5a
ata_scsiop_noop: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
SCSI device sda: 781422768 512-byte hdwr sectors (400088 MB)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 24
ata_scsiop_mode_sense: ENTER
SCSI device sda: drive cache: write back
 sda:<3>ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 00 00 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ata_scsi_translate: EXIT
mv_host_intr: ENTER, hc0 relevant=0x00000102 HC IRQ cause=0x00000011
mv_host_intr: port 0 IRQ found for qc, ata_status 0x0
ata_sg_clean: unmapping 1 sg elements
ata_qc_complete: EXIT
mv_host_intr: EXIT

sd 0:0:0:0: Attached scsi disk sda
ata_scsi_dump_cdb: CDB (4:0,0,0) 12 00 00 00 24 00 5a 5a 5a
ata_scsiop_inq_std: ENTER
ata_scsi_dump_cdb: CDB (4:0,0,0) 12 00 00 00 60 00 5a 5a 5a
ata_scsiop_inq_std: ENTER
  Vendor: ATA       Model: Maxtor 6Y120M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata_scsi_dump_cdb: CDB (4:0,0,0) 00 00 00 00 00 00 5a 5a 5a
ata_scsiop_noop: ENTER
ata_scsi_dump_cdb: CDB (4:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
SCSI device sdb: 240121728 512-byte hdwr sectors (122942 MB)
ata_scsi_dump_cdb: CDB (4:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (4:0,0,0) 5a 00 08 00 00 00 00 00 24
ata_scsiop_mode_sense: ENTER
SCSI device sdb: drive cache: write back
ata_scsi_dump_cdb: CDB (4:0,0,0) 00 00 00 00 00 00 5a 5a 5a
ata_scsiop_noop: ENTER
ata_scsi_dump_cdb: CDB (4:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
SCSI device sdb: 240121728 512-byte hdwr sectors (122942 MB)
ata_scsi_dump_cdb: CDB (4:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (4:0,0,0) 5a 00 08 00 00 00 00 00 24
ata_scsiop_mode_sense: ENTER
SCSI device sdb: drive cache: write back
 sdb:<3>ata_scsi_dump_cdb: CDB (4:0,0,0) 28 00 00 00 00 00 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata4
ata_sg_setup: 1 sg elements mapped
ata_scsi_translate: EXIT
mv_host_intr: ENTER, hc0 relevant=0x00000180 HC IRQ cause=0x00000018
mv_host_intr: port 3 IRQ found for qc, ata_status 0x0
ata_sg_clean: unmapping 1 sg elements
ata_qc_complete: EXIT
mv_host_intr: EXIT
 sdb1 sdb2
sd 3:0:0:0: Attached scsi disk sdb
ata_device_add: EXIT, returning 4

----------------------------------------------------------
With MSI:

sata_mv 0000:02:08.0: version 0.5
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
__mv_phy_reset: ENTER, port 0, mmio 0xf8ba2000
__mv_phy_reset: S-regs after ATA_RST: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
__mv_phy_reset: S-regs after PHY wake: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
ata_dev_classify: found ATA device by sig
__mv_phy_reset: EXIT
ata_dev_identify: ENTER, host 1, dev 0
ata_dev_select: ENTER, ata1: device 0, wait 1
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


--
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

