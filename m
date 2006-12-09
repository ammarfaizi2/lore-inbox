Return-Path: <linux-kernel-owner+w=401wt.eu-S1947616AbWLIBFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947616AbWLIBFL (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 20:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947617AbWLIBFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 20:05:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:42080 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947616AbWLIBFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 20:05:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jjQ2KyfBpc3RN0cAS/MzsJe/ezcPhbGJNayUVxJ2daYMdxYkLTxZQsEi2X+8hGS+FG+lJ1Um659bCUibc8ULySjOl+eKtdtuWEkyj80JM18LKn2TEUWs930x9mMjFJzLOlo0XwMwEVNAeF0aEgTYnSWhcFDoW+L5sWvgSrBlBb8=
Message-ID: <64d833020612081705p29c92e85i25f045ad87cb879e@mail.gmail.com>
Date: Fri, 8 Dec 2006 20:05:07 -0500
From: koan <koan00@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: BUG: warning at drivers/scsi/ahci.c:859/ahci_host_intr() [ 2.6.17.14 ]
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After 33 days of uptime, I noticed something in my dmesg output.

The system is 4 x SATA2 disks connected to the onboard SATA2
controller. They are all part of a linux software raid 5 volume.
According to /proc/mdstat , all of the disks are still online (?).
Right now the system is still up, so if more information is needed I
should be able to provide it (given some instruction). I am not on the
list, so please CC me.

Thanks, Jesse

This is the message:

ata4: handling error/timeout
ata4: port reset, p_is 0 is 0 pis 0 cmd 1c017 tf d0 ss 123 se 180001
BUG: warning at drivers/scsi/ahci.c:859/ahci_host_intr()
 <c0269946> ahci_interrupt+0xff/0x20b  <c0126bbc> handle_IRQ_event+0x21/0x4a
 <c0126c38> __do_IRQ+0x53/0x8f  <c025d622> scsi_error_handler+0x0/0xa1
 <c010424d> do_IRQ+0x19/0x24  <c0102cf2> common_interrupt+0x1a/0x20
 <c025d622> scsi_error_handler+0x0/0xa1  <c026983e> ahci_eng_timeout+0x55/0x5d
 <c0266d03> ata_scsi_error+0x89/0xd3  <c025d681> scsi_error_handler+0x5f/0xa1
 <c0121c21> kthread+0x75/0x9d  <c0121bac> kthread+0x0/0x9d
 <c0100cbd> kernel_thread_helper+0x5/0xb
ata4: status=0x50 { DriveReady SeekComplete }
sdd: Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
Info fld=0xf5a623e
ata2: handling error/timeout
ata2: port reset, p_is 0 is 0 pis 0 cmd 1c017 tf d0 ss 123 se 180001
BUG: warning at drivers/scsi/ahci.c:859/ahci_host_intr()
 <c0269946> ahci_interrupt+0xff/0x20b  <c0126bbc> handle_IRQ_event+0x21/0x4a
 <c0126c38> __do_IRQ+0x53/0x8f  <c025d622> scsi_error_handler+0x0/0xa1
 <c010424d> do_IRQ+0x19/0x24  <c0102cf2> common_interrupt+0x1a/0x20
 <c025d622> scsi_error_handler+0x0/0xa1  <c026983e> ahci_eng_timeout+0x55/0x5d
 <c0266d03> ata_scsi_error+0x89/0xd3  <c025d681> scsi_error_handler+0x5f/0xa1
 <c0121c21> kthread+0x75/0x9d  <c0121bac> kthread+0x0/0x9d
 <c0100cbd> kernel_thread_helper+0x5/0xb
ata2: status=0x50 { DriveReady SeekComplete }
sdb: Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
ata4: handling error/timeout
ata4: port reset, p_is 0 is 0 pis 0 cmd 1c017 tf 150 ss 123 se 0
ata4: status=0x50 { DriveReady SeekComplete }
ata4: error=0x01 { AddrMarkNotFound }
sdd: Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
Info fld=0x1
ata2: handling error/timeout
ata2: port reset, p_is 0 is 0 pis 0 cmd 1c017 tf 150 ss 123 se 0
ata2: status=0x50 { DriveReady SeekComplete }
ata2: error=0x01 { AddrMarkNotFound }
sdb: Current: sense key=0x0
    ASC=0x0 ASCQ=0x0


This is my normal boot message:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:16.0
ACPI: PCI Interrupt 0000:00:16.0[A] -> GSI 19 (level, low) -> IRQ 21
ALI15X3: chipset revision 199
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: IBM-DTTA-350430, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 8249472 sectors (4223 MB) w/469KiB Cache, CHS=8184/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2
libata version 1.20 loaded.
ahci 0000:00:16.1: version 1.2
ACPI: PCI Interrupt 0000:00:16.1[A] -> GSI 19 (level, low) -> IRQ 21
ahci 0000:00:16.1: AHCI 0001.0000 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:16.1: flags: ncq ilck pm led clo pmp pio slum part
ata1: SATA max UDMA/133 cmd 0xF8806100 ctl 0x0 bmdma 0x0 irq 21
ata2: SATA max UDMA/133 cmd 0xF8806180 ctl 0x0 bmdma 0x0 irq 21
ata3: SATA max UDMA/133 cmd 0xF8806200 ctl 0x0 bmdma 0x0 irq 21
ata4: SATA max UDMA/133 cmd 0xF8806280 ctl 0x0 bmdma 0x0 irq 21
ata1: SATA link up 3.0 Gbps (SStatus 123)
ata1: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 88:40ff
ata1: dev 0 ATA-7, max UDMA7, 586072368 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : ahci
ata2: SATA link up 3.0 Gbps (SStatus 123)
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata2: dev 0 ATA-7, max UDMA/133, 625142448 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : ahci
ata3: SATA link up 3.0 Gbps (SStatus 123)
ata3: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata3: dev 0 ATA-7, max UDMA/133, 586072368 sectors: LBA48
ata3: dev 0 configured for UDMA/133
scsi2 : ahci
ata4: SATA link up 3.0 Gbps (SStatus 123)
ata4: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata4: dev 0 ATA-7, max UDMA/133, 586072368 sectors: LBA48
ata4: dev 0 configured for UDMA/133
scsi3 : ahci
  Vendor: ATA       Model: SAMSUNG HD300LJ   Rev: ZT10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3320620AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3300822AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3300822AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
SCSI device sdc: 586072368 512-byte hdwr sectors (300069 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 586072368 512-byte hdwr sectors (300069 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1
sd 2:0:0:0: Attached scsi disk sdc
SCSI device sdd: 586072368 512-byte hdwr sectors (300069 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sdd: 586072368 512-byte hdwr sectors (300069 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
 sdd: sdd1
sd 3:0:0:0: Attached scsi disk sdd


lspci -vv ouput:

00:16.0 IDE interface: ALi Corporation M5229 IDE (rev c7) (prog-if 8a
[Master SecP PriP])
        Subsystem: ALi Corporation M5229 IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 21
        Region 4: I/O ports at ff00 [size=16]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:16.1 SATA controller: ALi Corporation ULi M5288 SATA (prog-if 01 [AHCI 1.0])
        Subsystem: EPoX Computer Co., Ltd. Unknown device 5004
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 21
        Region 0: I/O ports at fe00 [size=8]
        Region 1: I/O ports at fd00 [size=4]
        Region 2: I/O ports at fc00 [size=8]
        Region 3: I/O ports at fb00 [size=4]
        Region 4: I/O ports at fa00 [size=16]
        Region 5: Memory at dfffb000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
