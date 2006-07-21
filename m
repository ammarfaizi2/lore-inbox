Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161001AbWGUGTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbWGUGTT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 02:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161003AbWGUGTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 02:19:19 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:30080 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161001AbWGUGTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 02:19:18 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com
Subject: 2.6.18-rc2 Intermittent failures to detect sata disks
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 21 Jul 2006 16:18:47 +1000
Message-ID: <20339.1153462727@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing an intermittent failures to detect sata disks on
2.6.18-rc2.  Dell SC1425, PIIX chipset, gcc 4.1.0 (opensuse 10.1).
Sometimes it will detect both disks, sometimes only one, sometimes none
at all.  AFAICT it only occurs after a soft reboot, and possibly only
after an emergency reboot.  Alas the problem is so intermittent that it
is hard to tell what conditions will trigger it.

Setting ATA_DEBUG gives these differences:

works:

  Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
  ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
  ICH5: IDE controller at PCI slot 0000:00:1f.1
  PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
  ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
  ICH5: chipset revision 2
  ICH5: not 100% native mode: will probe irqs later
      ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
  hda: TEAC CD-ROM CD-224E, ATAPI CD/DVD-ROM drive
  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
  piix_init: pci_module_init
  ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
  ata_pci_init_one: ENTER
  ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
  ata_device_add: ENTER
  ata_host_add: ENTER
  ata_port_start: prd alloc, virt f7b2e000, dma 37b2e000
  ata1: SATA max UDMA/133 cmd 0xCCB8 ctl 0xCCB2 bmdma 0xCC80 irq 17
  __ata_port_freeze: ata1 port frozen
  ata_host_add: ENTER
  ata_port_start: prd alloc, virt f7b1c000, dma 37b1c000
  ata2: SATA max UDMA/133 cmd 0xCCA0 ctl 0xCC9A bmdma 0xCC88 irq 17
  __ata_port_freeze: ata2 port frozen
  ata_device_add: probe begin
  scsi0 : ata_piix
  ata_port_schedule_eh: port EH scheduled
  ata_scsi_error: ENTER
  ata_port_flush_task: ENTER
  ata_port_flush_task: flush #1
  ata_eh_autopsy: ENTER
  ata_eh_recover: ENTER
  ata_eh_prep_resume: ENTER
  ata_eh_prep_resume: EXIT
  __ata_port_freeze: ata1 port frozen
  piix_sata_prereset: ata1: ENTER, pcs=0x33 base=0
  piix_sata_prereset: ata1: LEAVE, pcs=0x33 present_mask=0x1
  ata_std_softreset: ENTER
  ata_std_softreset: about to softreset, devmask=1
  ata_bus_softreset: ata1: bus reset via SRST
  ata_dev_classify: found ATA device by sig
  ata_std_softreset: EXIT, classes[0]=1 [1]=0
  ata_std_postreset: ENTER
  ata_std_postreset: EXIT
  ata_eh_thaw_port: ata1 port thawed
  ata_eh_revalidate_and_attach: ENTER
  ata_exec_command_pio: ata1: cmd 0xEC
  ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
  ata_pio_sector: data read
  ata_hsm_move: ata1: protocol 2 task_state 3 (dev_stat 0x50)
  ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
  ata_port_flush_task: ENTER
  ata_port_flush_task: flush #1
  ata1.00: ATA-6, max UDMA/100, 156250000 sectors: LBA 
  ata1.00: ata1: dev 0 multi count 8
  ata_eh_revalidate_and_attach: EXIT
  ata_eh_resume: ENTER
  ata_eh_resume: EXIT
  ata_dev_set_xfermode: set features - xfer mode
  ata_exec_command_pio: ata1: cmd 0xEF
  ata_hsm_move: ata1: protocol 1 task_state 3 (dev_stat 0x50)
  ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
  ata_port_flush_task: ENTER
  ata_port_flush_task: flush #1
  ata_dev_set_xfermode: EXIT, err_mask=0
  ata_exec_command_pio: ata1: cmd 0xEC
  ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
  ata_pio_sector: data read
  ata_hsm_move: ata1: protocol 2 task_state 3 (dev_stat 0x50)
  ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
  ata_port_flush_task: ENTER
  ata_port_flush_task: flush #1
  ata_dev_set_mode: xfer_shift=8, xfer_mode=0x45
  ata1.00: configured for UDMA/100
  ata_eh_suspend: ENTER
  ata_eh_suspend: EXIT
  ata_eh_recover: EXIT, rc=0
  ata_scsi_error: EXIT
  scsi1 : ata_piix
  ata_port_schedule_eh: port EH scheduled
  ata_scsi_error: ENTER
  ata_port_flush_task: ENTER
  ata_port_flush_task: flush #1
  ata_eh_autopsy: ENTER
  ata_eh_recover: ENTER
  ata_eh_prep_resume: ENTER
  ata_eh_prep_resume: EXIT
  __ata_port_freeze: ata2 port frozen
  piix_sata_prereset: ata2: ENTER, pcs=0x33 base=2
  piix_sata_prereset: ata2: LEAVE, pcs=0x33 present_mask=0x1
  ata_std_softreset: ENTER
  ata_std_softreset: about to softreset, devmask=1
  ata_bus_softreset: ata2: bus reset via SRST
  ata_dev_classify: found ATA device by sig
  ata_std_softreset: EXIT, classes[0]=1 [1]=0
  ata_std_postreset: ENTER
  ata_std_postreset: EXIT
  ata_eh_thaw_port: ata2 port thawed
  ata_eh_revalidate_and_attach: ENTER
  ata_exec_command_pio: ata2: cmd 0xEC
  ata_hsm_move: ata2: protocol 2 task_state 2 (dev_stat 0x58)
  ata_pio_sector: data read
  ata_hsm_move: ata2: protocol 2 task_state 3 (dev_stat 0x50)
  ata_hsm_move: ata2: dev 0 command complete, drv_stat 0x50
  ata_port_flush_task: ENTER
  ata_port_flush_task: flush #1
  ata2.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 0/32)
  ata2.00: ata2: dev 0 multi count 8

fails:

  Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
  ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
  ICH5: IDE controller at PCI slot 0000:00:1f.1
  PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
  ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
  ICH5: chipset revision 2
  ICH5: not 100% native mode: will probe irqs later
      ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
  hda: TEAC CD-ROM CD-224E, ATAPI CD/DVD-ROM drive
  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
  piix_init: pci_module_init
  ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
  ata_pci_init_one: ENTER
  ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
  ata_device_add: ENTER
  ata_host_add: ENTER
  ata_port_start: prd alloc, virt f7879000, dma 37879000
  ata1: SATA max UDMA/133 cmd 0xCCB8 ctl 0xCCB2 bmdma 0xCC80 irq 17
  __ata_port_freeze: ata1 port frozen
  ata_host_add: ENTER
  ata_port_start: prd alloc, virt f787b000, dma 3787b000
  ata2: SATA max UDMA/133 cmd 0xCCA0 ctl 0xCC9A bmdma 0xCC88 irq 17
  __ata_port_freeze: ata2 port frozen
  ata_device_add: probe begin
  scsi0 : ata_piix
  ata_port_schedule_eh: port EH scheduled
  ata_scsi_error: ENTER
  ata_port_flush_task: ENTER
  ata_port_flush_task: flush #1
  ata_eh_autopsy: ENTER
  ata_eh_recover: ENTER
  ata_eh_prep_resume: ENTER
  ata_eh_prep_resume: EXIT
  __ata_port_freeze: ata1 port frozen
  piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
  piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
  ata1: SATA port has no device.
  ata_eh_thaw_port: ata1 port thawed
  ata_eh_revalidate_and_attach: ENTER
  ata_eh_revalidate_and_attach: EXIT
  ata_eh_resume: ENTER
  ata_eh_resume: EXIT
  ata_eh_suspend: ENTER
  ata_eh_suspend: EXIT
  ata_eh_recover: EXIT, rc=0
  ata_scsi_error: EXIT
  scsi1 : ata_piix
  ata_port_schedule_eh: port EH scheduled
  ata_scsi_error: ENTER
  ata_port_flush_task: ENTER
  ata_port_flush_task: flush #1
  ata_eh_autopsy: ENTER
  ata_eh_recover: ENTER
  ata_eh_prep_resume: ENTER
  ata_eh_prep_resume: EXIT
  __ata_port_freeze: ata2 port frozen
  piix_sata_prereset: ata2: ENTER, pcs=0x33 base=2
  piix_sata_prereset: ata2: LEAVE, pcs=0x33 present_mask=0x1
  ata_std_softreset: ENTER
  ata_std_softreset: about to softreset, devmask=1
  ata_bus_softreset: ata2: bus reset via SRST
  ata_dev_classify: found ATA device by sig
  ata_std_softreset: EXIT, classes[0]=1 [1]=0
  ata_std_postreset: ENTER
  ata_std_postreset: EXIT
  ata_eh_thaw_port: ata2 port thawed
  ata_eh_revalidate_and_attach: ENTER
  ata_exec_command_pio: ata2: cmd 0xEC
  ata_hsm_move: ata2: protocol 2 task_state 2 (dev_stat 0x58)
  ata_pio_sector: data read
  ata_hsm_move: ata2: protocol 2 task_state 3 (dev_stat 0x50)
  ata_hsm_move: ata2: dev 0 command complete, drv_stat 0x50
  ata_port_flush_task: ENTER
  ata_port_flush_task: flush #1
  ata2.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 0/32)
  ata2.00: ata2: dev 0 multi count 8
  ata_eh_revalidate_and_attach: EXIT
  ata_eh_resume: ENTER
  ata_eh_resume: EXIT
  ata_dev_set_xfermode: set features - xfer mode
  ata_exec_command_pio: ata2: cmd 0xEF
  ata_hsm_move: ata2: protocol 1 task_state 3 (dev_stat 0x50)
  ata_hsm_move: ata2: dev 0 command complete, drv_stat 0x50
  ata_port_flush_task: ENTER
  ata_port_flush_task: flush #1
  ata_dev_set_xfermode: EXIT, err_mask=0
  ata_exec_command_pio: ata2: cmd 0xEC
  ata_hsm_move: ata2: protocol 2 task_state 2 (dev_stat 0x58)
  ata_pio_sector: data read
  ata_hsm_move: ata2: protocol 2 task_state 3 (dev_stat 0x50)
  ata_hsm_move: ata2: dev 0 command complete, drv_stat 0x50
  ata_port_flush_task: ENTER
  ata_port_flush_task: flush #1
  ata_dev_set_mode: xfer_shift=8, xfer_mode=0x46
  ata2.00: configured for UDMA/133
  ata_eh_suspend: ENTER
  ata_eh_suspend: EXIT
  ata_eh_recover: EXIT, rc=0
  ata_scsi_error: EXIT
  ata_device_add: host probe begin
  ata_scsi_dump_cdb: CDB (2:0,0,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (2:0,0,0) 12 00 00 00 60 00 00 00 00
    Vendor: ATA       Model: ST3300622AS       Rev: 3.AA
    Type:   Direct-Access                      ANSI SCSI revision: 05
  piix_init: done
  ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
  ata_scsi_dump_cdb: CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
  SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
  ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 3f 00 00 00 00 00 08
  sda: Write Protect is off
  ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 08
  ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 24
  SCSI device sda: drive cache: write back
  ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 24
  ata_scsi_dump_cdb: CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
  SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
  ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 3f 00 00 00 00 00 08
  sda: Write Protect is off
  ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 08
  ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 24
  SCSI device sda: drive cache: write back
   sda:<3>ata_scsi_dump_cdb: CDB (2:0,0,0) 28 00 00 00 00 00 00 00 08
  ata_sg_setup: 1 sg elements mapped
  ata_exec_command_pio: ata2: cmd 0xC8
  ata_hsm_move: ata2: protocol 3 task_state 3 (dev_stat 0x50)
  ata_hsm_move: ata2: dev 0 command complete, drv_stat 0x50
   sda1 <<3>ata_scsi_dump_cdb: CDB (2:0,0,0) 28 00 00 00 00 38 00 00 08
  ata_sg_setup: 1 sg elements mapped
  ata_exec_command_pio: ata2: cmd 0xC8
  ata_hsm_move: ata2: protocol 3 task_state 3 (dev_stat 0x50)
  ata_hsm_move: ata2: dev 0 command complete, drv_stat 0x50
   sda5<3>ata_scsi_dump_cdb: CDB (2:0,0,0) 28 00 00 0f 71 78 00 00 08
  ata_sg_setup: 1 sg elements mapped
  ata_exec_command_pio: ata2: cmd 0xC8
  ata_hsm_move: ata2: protocol 3 task_state 3 (dev_stat 0x50)
  ata_hsm_move: ata2: dev 0 command complete, drv_stat 0x50
   sda6<3>ata_scsi_dump_cdb: CDB (2:0,0,0) 28 00 00 f4 a4 60 00 00 08
  ata_sg_setup: 1 sg elements mapped
  ata_exec_command_pio: ata2: cmd 0xC8
  ata_hsm_move: ata2: protocol 3 task_state 3 (dev_stat 0x50)
  ata_hsm_move: ata2: dev 0 command complete, drv_stat 0x50
   sda7<3>ata_scsi_dump_cdb: CDB (2:0,0,0) 28 00 01 04 15 e0 00 00 08
  ata_sg_setup: 1 sg elements mapped
  ata_exec_command_pio: ata2: cmd 0xC8
  ata_hsm_move: ata2: protocol 3 task_state 3 (dev_stat 0x50)
  ata_hsm_move: ata2: dev 0 command complete, drv_stat 0x50
   sda8 >
  sd 1:0:0:0: Attached scsi disk sda
  serio: i8042 AUX port at 0x60,0x64 irq 12
  serio: i8042 KBD port at 0x60,0x64 irq 1
  mice: PS/2 mouse device common for all mice
  TCP bic registered
  NET: Registered protocol family 1
  Starting balanced_irq
  Using IPI No-Shortcut mode
  ACPI: (supports<6>Time: tsc clocksource has been installed.
  input: AT Translated Set 2 keyboard as /class/input/input0
   S0 S4 S5)
  VFS: Cannot open root device "sda10" or unknown-block(8,10)

