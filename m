Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263326AbTAWMGo>; Thu, 23 Jan 2003 07:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264683AbTAWMGn>; Thu, 23 Jan 2003 07:06:43 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:2058 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263326AbTAWMGl>; Thu, 23 Jan 2003 07:06:41 -0500
Date: Thu, 23 Jan 2003 13:15:27 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21pre3-ac4 ide trouble (HPT370 and IBM DTLA-30745)
Message-ID: <20030123121527.GA29958@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just upgraded to a new motherboard, and now I have a disk that
won't do DMA anymore. It used to work with the same kernel on a Promise
20265 controller, but on the new HPT370 it doesn't work (or at least,
doesn't do DMA):


Linux version 2.4.21-pre3-ac4 (root@middle) (gcc version 3.2.2 20030109 (Debian prerelease)) #1 SMP Wed Jan 22 20:16:48 CET 2003

00:0f.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366/368/370/370A/372 (rev 04)
	Subsystem: Triones Technologies, Inc. HPT370A
	Flags: bus master, 66Mhz, medium devsel, latency 120, IRQ 11
	I/O ports at a400 [size=8]
	I/O ports at a800 [size=4]
	I/O ports at ac00 [size=8]
	I/O ports at b000 [size=4]
	I/O ports at b400 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>


Linux version 2.4.21-pre3-ac4 (root@middle) (gcc version 3.2.2 20030109 (Debian prerelease)) #1 SMP Wed Jan 22 20:16:48 CET 2003
BIOS-provided physical RAM map:
<snip>
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT370A: IDE controller at PCI slot 00:0f.0
HPT370A: chipset revision 4
HPT370A: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0xb400-0xb407, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xb408-0xb40f, BIOS settings: hdg:DMA, hdh:DMA
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 33073H3, ATA DISK drive
hda: DMA disabled
blk: queue c03a2820, I/O limit 4095Mb (mask 0xffffffff)
hdc: LITE-ON LTR-40125W, ATAPI CD/DVD-ROM drive
hdc: DMA disabled
hde: IBM-DTLA-307045, ATA DISK drive
blk: queue c03a30f8, I/O limit 4095Mb (mask 0xffffffff)
hdg: Maxtor 4G120J6, ATA DISK drive
hdh: Maxtor 4G120J6, ATA DISK drive
blk: queue c03a3564, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c03a36b0, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xa400-0xa407,0xa802 on irq 11
ide3 at 0xac00-0xac07,0xb002 on irq 11
hda: host protected area => 1
hda: 60032448 sectors (30737 MB) w/2048KiB Cache, CHS=3736/255/63, UDMA(100)
hde: host protected area => 1
hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
hdg: host protected area => 1
hdg: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(100)
hdh: host protected area => 1
hdh: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(100)
ide-cd: passing drive hdc to ide-scsi emulation.
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 >
 hde:<4>hde: dma_timer_expiry: dma status == 0x21
hde: 0 bytes in FIFO
hde: timeout waiting for DMA
hde: timeout waiting for DMA
hde: 0 bytes in FIFO
hde: timeout waiting for DMA
hde: (__ide_dma_test_irq) called while not waiting
blk: queue c03a30f8, I/O limit 4095Mb (mask 0xffffffff)
 [PTBL] [5606/255/63] hde1 hde2
 hdg: hdg1 hdg2
 hdh: hdh1 hdh2
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 10, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c860 detected 
sym53c860-0: rev 0x13 on pci bus 0 device 10 function 0 irq 10
sym53c860-0: ID 7, Fast-20, Parity Checking
scsi0 : sym53c8xx-1.7.3c-20010512
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1401  Rev: 1007
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0N
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LITE-ON   Model: LTR-40125W        Rev: WS05
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 2, lun 0
Attached scsi CD-ROM sr2 at scsi0, channel 0, id 5, lun 0
Attached scsi CD-ROM sr3 at scsi1, channel 0, id 0, lun 0
sym53c860-0-<1,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 8)
sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sym53c860-0-<2,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 8)
sr1: scsi-1 drive
sym53c860-0-<5,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 7)
sr2: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
sr3: scsi3-mmc drive: 245x/48x writer cd/rw xa/form2 cdda tray
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 320k freed
Adding Swap: 1574328k swap-space (priority -1)
ide: no cache flush required.
ide: no cache flush required.
<snip>
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
hde: dma_timer_expiry: dma status == 0x21
hde: 0 bytes in FIFO
hde: timeout waiting for DMA
hde: timeout waiting for DMA
hde: 0 bytes in FIFO
hde: timeout waiting for DMA
hde: (__ide_dma_test_irq) called while not waiting
ide: no cache flush required.
hde: dma_timer_expiry: dma status == 0x21
hde: 0 bytes in FIFO
hde: timeout waiting for DMA
hde: timeout waiting for DMA
hde: 0 bytes in FIFO
hde: timeout waiting for DMA
hde: (__ide_dma_test_irq) called while not waiting
ide: no cache flush required.
hde: dma_timer_expiry: dma status == 0x21
hde: 0 bytes in FIFO
hde: timeout waiting for DMA
hde: timeout waiting for DMA
hde: 0 bytes in FIFO
hde: timeout waiting for DMA
hde: (__ide_dma_test_irq) called while not waiting
ide: no cache flush required.
<snip 27x repeat above line>

Net result:

                             HighPoint HPT366/368/370/372/374

Controller: 0
Chipset: HPT370A
--------------- Primary Channel --------------- Secondary Channel --------------
Enabled:        yes                             yes
Cable:          ATA-66                          ATA-66

--------------- drive0 --------- drive1 ------- drive0 ---------- drive1 -------
DMA capable:    no               no             yes               yes
Mode:           UDMA             off            UDMA              UDMA

:r

/dev/hde:
 Timing buffer-cache reads:   128 MB in  0.54 seconds =237.04 MB/sec
 Timing buffered disk reads:  64 MB in 25.94 seconds =  2.47 MB/sec

Ouch. 

/dev/hde:

 Model=IBM-DTLA-307045, FwRev=TX6OA50C, SerialNo=YM0YMLC3088
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=90069840
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  2 3 4 5

Is there something I can do about this?

Kind regards,
Jurriaan
-- 
"If we were faithful and happy we would never catch criminals," said
Bodwyn Wook. "That is why we are cruel and merciless. Tell us what you
know and be quick about it."
	Jack Vance - Araminta Station
GNU/Linux 2.4.21-pre3-ac4 SMP/ReiserFS 2x2824 bogomips load av: 0.21 0.55 0.44
