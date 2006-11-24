Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757487AbWKXVkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757487AbWKXVkR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 16:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757603AbWKXVkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 16:40:17 -0500
Received: from smtp.etmail.cz ([160.218.43.220]:46806 "EHLO smtp.etmail.cz")
	by vger.kernel.org with ESMTP id S1757487AbWKXVkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 16:40:15 -0500
Subject: ICH6M SATA Controller, SATA2 NCQ disk and high iowait CPU time
From: "gary.czek" <gary@czek.info>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 24 Nov 2006 22:39:36 +0100
Message-Id: <1164404380.20334.37.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have problem with my notebook Fujitsu-Siemens V8010. It has Intel
ICH6M chipset with SATA Controller. And SATA II disk Fujitsu MHT2040BH
with NCQ. If there is request on disk, iowait time of CPU gets to 100%
and whole system gets totally unresponsible. For example apt upgrade (of
average 10 packages totaling 30MB in .debs) gets 30 minutes. CPU iowait
time gets about 95% for whole 30 minutes.

My notebook details:
CPU: Intel Celeron M 1,4GHz
MEM: 256MB 333MHz
HDD: Fujitsu MHT2040BH SATA II, NCQ, 5400rpm, 8MB buffer
SWP: 512MB swap partition
Chipset: ICH6M 82801FBM
GPU: Intel i915GM integrated

kernel: 2.6.19-rc5
SATA Controller/disk driver: ata_piix and ahci tested, but results of
both were almost the same.

dmesg: 
[   12.746000] ata_piix 0000:00:1f.1: version 2.00ac6
[   12.746000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
[   12.746000] PCI: Setting latency timer of device 0000:00:1f.1 to 64
[   12.746000] ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x1810 irq 14
[   12.746000] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x1818 irq 15
[   12.746000] scsi0 : ata_piix
[   13.049000] ata1.00: ATAPI, max UDMA/33
[   13.201000] ata1.00: configured for UDMA/33
[   13.201000] scsi1 : ata_piix
[   13.201000] ata2: port disabled. ignoring.
[   13.201000] ATA: abnormal status 0xFF on port 0x177
[   13.204000] scsi 0:0:0:0: CD-ROM            HL-DT-ST RW/DVD GCC-4243N 1.03 PQ: 0 ANSI: 5
[   13.206000] sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
[   13.206000] Uniform CD-ROM driver Revision: 3.20
[   13.206000] sr 0:0:0:0: Attached scsi CD-ROM sr0
[   13.206000] ata_piix 0000:00:1f.2: MAP [ P0 P2 XX XX ]
[   13.206000] ata_piix 0000:00:1f.2: invalid MAP value 128
[   13.206000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
[   13.206000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   13.206000] ata3: SATA max UDMA/133 cmd 0x2088 ctl 0x2082 bmdma 0x18B0 irq 19
[   13.206000] ata4: SATA max UDMA/133 cmd 0x18A8 ctl 0x180E bmdma 0x18B8 irq 19
[   13.206000] scsi2 : ata_piix
[   13.359000] ata3.00: ATA-7, max UDMA/100, 78140160 sectors: LBA48 NCQ (depth 0/32)
[   13.359000] ata3.00: ata3: dev 0 multi count 16
[   13.362000] ata3.00: configured for UDMA/100
[   13.362000] scsi3 : ata_piix
[   13.513000] ATA: abnormal status 0x7F on port 0x18AF
[   13.514000] scsi 2:0:0:0: Direct-Access     ATA      FUJITSU MHT2040B 0000 PQ: 0 ANSI: 5
[   13.514000] SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
[   13.514000] sda: Write Protect is off
[   13.514000] sda: Mode Sense: 00 3a 00 00
[   13.514000] SCSI device sda: drive cache: write back
[   13.514000] SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
[   13.514000] sda: Write Protect is off
[   13.514000] sda: Mode Sense: 00 3a 00 00
[   13.514000] SCSI device sda: drive cache: write back
[   13.514000]  sda: sda1 sda2 sda3
[   13.574000] sd 2:0:0:0: Attached scsi disk sda
[   13.880000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   13.880000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   13.880000] ide0: I/O resource 0x1F0-0x1F7 not free.
[   13.880000] ide0: ports already in use, skipping probe
[   13.880000] ide1: I/O resource 0x170-0x177 not free.
[   13.880000] ide1: ports already in use, skipping probe

hdparm: 
gary@ntb:~$ sudo hdparm -tT -d1 -v /dev/sda

/dev/sda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Inappropriate ioctl for device
 IO_support   =  0 (default 16-bit)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 4864/255/63, sectors = 78140160, start = 0
 Timing cached reads:   1920 MB in  2.00 seconds = 960.43 MB/sec
 Timing buffered disk reads:   88 MB in  3.02 seconds =  29.11 MB/sec

my measures has
average buffered disk: 22 MB/sec
maximal buffered disk: 34 MB/sec

On cnet is said that this hdd has maximum internal data transfer rate
(how fast it can actually pull data off the disk surface) of 53.9 MBps.

lshw: 
gary@ntb:~$ sudo lshw -class ide -class storage -class disk
  *-storage               
       description: Mass storage controller
       product: PCIxx21 Integrated FlashMedia Controller
       vendor: Texas Instruments
       physical id: 9.3
       bus info: pci@06:09.3
       version: 00
       width: 32 bits
       clock: 33MHz
       capabilities: storage bus_master cap_list
       configuration: driver=tifm_7xx1
       resources: iomemory:b0106000-b0107fff irq:17
  *-ide
       description: IDE interface
       product: 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller
       vendor: Intel Corporation
       physical id: 1f.1
       bus info: pci@00:1f.1
       logical name: scsi0
       version: 04
       width: 32 bits
       clock: 33MHz
       capabilities: ide bus_master emulated
       configuration: driver=ata_piix
       resources: ioport:1810-181f irq:18
     *-cdrom UNCLAIMED
          description: SCSI CD-ROM
          product: RW/DVD GCC-4243N
          vendor: HL-DT-ST
          physical id: 0.0.0
          bus info: scsi@0:0.0.0
          version: 1.03
          capabilities: removable
          configuration: ansiversion=5
  *-storage
       description: SATA controller
       product: 82801FBM (ICH6M) SATA Controller
       vendor: Intel Corporation
       physical id: 1f.2
       bus info: pci@00:1f.2
       logical name: scsi2
       version: 04
       width: 32 bits
       clock: 66MHz
       capabilities: storage ahci_1.0 bus_master cap_list emulated
       configuration: driver=ata_piix
       resources: ioport:2088-208f ioport:2080-2083 ioport:18a8-18af ioport:180c-180f ioport:18b0-18bf iomemory:b0040c00-b0040fff irq:19
     *-disk
          description: SCSI Disk
          product: FUJITSU MHT2040B
          vendor: ATA
          physical id: 0.0.0
          bus info: scsi@2:0.0.0
          logical name: /dev/sda
          version: 0000
          serial: NR29T5A26VMV
          size: 37GB
          capabilities: partitioned partitioned:dos
          configuration: ansiversion=5
        *-volume:0
             description: Linux filesystem partition
             physical id: 1
             bus info: scsi@2:0.0.0,1
             logical name: /dev/sda1
             capacity: 9538MB
             capabilities: primary bootable
        *-volume:1
             description: Linux swap / Solaris partition
             physical id: 2
             bus info: scsi@2:0.0.0,2
             logical name: /dev/sda2
             capacity: 517MB
             capabilities: primary nofs
        *-volume:2
             description: Linux filesystem partition
             physical id: 3
             bus info: scsi@2:0.0.0,3
             logical name: /dev/sda3
             capacity: 27GB
             capabilities: primary

I have no other idea how to solve this problem. I'm not sure whether
disk uses correct driver. Friend told me that it may be solved by
increasing RAM (i plan buy additional 1024MB RAM for christmas).
I'm nearly hopeless. I'm trying to find the solution for more than
4months.
Thanks in advance for every hint.

