Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVEWK0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVEWK0U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 06:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVEWK0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 06:26:20 -0400
Received: from mxb.rambler.ru ([81.19.66.30]:53259 "EHLO mxb.rambler.ru")
	by vger.kernel.org with ESMTP id S261879AbVEWKZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 06:25:39 -0400
From: "Ivan G" <g-i-v@rambler.ru>
Subject: DMA not works in Linux 2.6.12, but in Windows works fine.
To: linux-kernel@vger.kernel.org
Cc: g-i-v@rambler.ru
X-Mailer: CommuniGate Pro WebUser Interface v.4.2.10
Date: Mon, 23 May 2005 14:25:32 +0400
Message-ID: <web-135595327@mail5.rambler.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1251"; format="flowed"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem descrition:

DMA not works in Linux 2.6.12, but in Windows works fine.

DMA not works with HDD and CD drives connected by 80-conductor
cable to secondary IDE port (ide1).


Hardware description:

   1) Motherboard has chipset Intel, Giga-byte
   2) HDD Seagate ST3160023AS (Serial ATA)
   3) HDD Seagate ST3200822A (IDE ATA)
   4) SONY CD-RW CRX320E, IDE ATAPI CD/DVD-ROM


Hardware connections:

   ST3160023AS ---> SATA0 ---> BIOS mapping ---> ide0 Pri master 
 (hda)
                    SATA1 ---> BIOS mapping ---> ide0 Pri slave
   CRX320E     --------------------------------> ide1 Sec master 
 (hdc)
   ST3200822A  --------------------------------> ide1 Sec slave 
  (hdd)


==============================================================================
=== hdparm output 
============================================================

# hdparm -V
hdparm v5.5

# hdparm -d1 /dev/hdd
/dev/hdd:
   setting using_dma to 1 (on)
   HDIO_SET_DMA failed: Operation not permitted
   using_dma    =  0 (off)

# hdparm -d1 /dev/hdc
/dev/hdd:
   setting using_dma to 1 (on)
   HDIO_SET_DMA failed: Operation not permitted
   using_dma    =  0 (off)

# hdparm -I /dev/hdd

/dev/hdd:

ATA device, with non-removable media
         Model Number:       ST3200822A
         Serial Number:      5LJ1JK9L
         Firmware Revision:  3.01
Standards:
         Used: ATA/ATAPI-6 T13 1410D revision 2
         Supported: 6 5 4 3
Configuration:
         Logical         max     current
         cylinders       16383   65535
         heads           16      1
         sectors/track   63      63
         --
         CHS current addressable sectors:    4128705
         LBA    user addressable sectors:  268435455
         LBA48  user addressable sectors:  390721968
         device size with M = 1024*1024:      190782 MBytes
         device size with M = 1000*1000:      200049 MBytes (200 GB)
Capabilities:
         LBA, IORDY(can be disabled)
         bytes avail on r/w long: 4      Queue depth: 1
         Standby timer values: spec'd by Standard, no device specific 
minimum
         R/W multiple sector transfer: Max = 16  Current = 16
         Recommended acoustic management value: 128, current value: 0
         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
              Cycle time: min=120ns recommended=120ns
         PIO: pio0 pio1 pio2 pio3 pio4
              Cycle time: no flow control=240ns  IORDY flow 
control=120ns
Commands/features:
         Enabled Supported:
            *    READ BUFFER cmd
            *    WRITE BUFFER cmd
            *    Host Protected Area feature set
            *    Look-ahead
            *    Write cache
            *    Power Management feature set
                 Security Mode feature set
                 SMART feature set
            *    FLUSH CACHE EXT command
            *    Mandatory FLUSH CACHE command
            *    Device Configuration Overlay feature set
            *    48-bit Address feature set
                 SET MAX security extension
            *    DOWNLOAD MICROCODE cmd
            *    SMART self-test
            *    SMART error logging
Security:
         Master password revision code = 65534
                 supported
         not     enabled
         not     locked
         not     frozen
         not     expired: security count
         not     supported: enhanced erase
HW reset results:
         CBLID- above Vih
         Device num = 1 determined by CSEL
Checksum: correct


==============================================================================
=== some lines from .config 
==================================================

CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set

CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y


==============================================================================
=== Some lines from `lspci -v` output 
========================================

0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P Processor to I/O 
Controller (rev 02)
         Subsystem: Giga-byte Technology: Unknown device 2570
         Flags: bus master, fast devsel, latency 0
         Memory at e0000000 (32-bit, prefetchable)
         Capabilities: [e4] #09 [1106]

0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 
c2) (prog-if 00 [Normal decode])
         Flags: bus master, fast devsel, latency 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
         I/O behind bridge: 0000a000-0000afff
         Memory behind bridge: f8000000-f80fffff

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller 
(rev 02)
         Flags: bus master, medium devsel, latency 0

0000:00:1f.2 IDE interface: Intel Corp. 82801EB Ultra ATA Storage 
Controller (rev 02) (prog-if 8a [Master SecP PriP])
         Subsystem: Giga-byte Technology: Unknown device 24d1
         Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 18
         I/O ports at <unassigned>
         I/O ports at <unassigned>
         I/O ports at <unassigned>
         I/O ports at <unassigned>
         I/O ports at f000 [size=16]

0000:00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
         Subsystem: Giga-byte Technology: Unknown device 24d2
         Flags: medium devsel, IRQ 9
         I/O ports at 1400 [size=32]


==============================================================================
=== Some lines of kernel-bool messages 
=======================================

Linux version 2.6.12-rc2 (root@wcm-5) (gcc version 3.3.3 (SuSE Linux)) 
#1 SMP Mon May 23 11:05:23 EEST 2005
Kernel command line: BOOT_IMAGE=Linux-2.6.12 ro root=806 
resume=/dev/sda5 ide1=dma
ide_setup: ide1=dma -- OBSOLETE OPTION, WILL BE REMOVED SOON!
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
ide0: I/O resource 0x1F0-0x1F7 not free.
ide0: ports already in use, skipping probe
Probing IDE interface ide1...
hdc: SONY CD-RW CRX320E, ATAPI CD/DVD-ROM drive
hdd: ST3200822A, ATA DISK drive
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
ide1 at 0x170-0x177,0x376 on irq 15
hdd: max request size: 1024KiB
hdd: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63
hdd: cache flushes supported
  hdd: hdd1 hdd2
hdc: ATAPI 52X DVD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
libata version 1.10 loaded.
ata_piix version 1.03
ata_piix: combined mode detected
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
ata: 0x170 IDE port busy
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3468 86:3c01 
87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 312579695 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
   Vendor: ATA       Model: ST3160023AS       Rev: 3.00
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312579695 512-byte hdwr sectors (160041 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 312579695 512-byte hdwr sectors (160041 MB)
SCSI device sda: drive cache: write back
  sda: sda1 sda2 < sda5 sda6 > sda3 sda4
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0


==============================================================================
==============================================================================


Please, help!


p.s. I am not in mailing-list, so please add me to CC.
