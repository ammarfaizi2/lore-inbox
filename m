Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315923AbSIIAtK>; Sun, 8 Sep 2002 20:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315925AbSIIAtK>; Sun, 8 Sep 2002 20:49:10 -0400
Received: from host.greatconnect.com ([209.239.40.135]:49156 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S315923AbSIIAtI>; Sun, 8 Sep 2002 20:49:08 -0400
Subject: Second ide interface doesn't do udma5
From: Samuel Flory <sflory@rackable.com>
To: Alan Cox <alan@redhat.com>, Andre Hedrick <andre@linux-ide.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 08 Sep 2002 17:54:41 -0700
Message-Id: <1031532882.15951.149.camel@sflory>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan, and Andre.  2.4.20-pre5-ac4 seems to be working well for me on
the promise, and OSB4.

  There is one strangeness on the intel clearwater (cw2) with an ICH3
ide chipset.  The second ICH3 interface only seems to want to do udma2,
while the 1st does udma5 by default.  Hdparm -X69 /dev/hdc only result
in an error about mode 3,4,5 not being available.  

  I'm not sure is this a linux bug or is the 2nd interface really not
udma100?


hdparm -t
/dev/hda:
 Timing buffered disk reads:  64 MB in  1.76 seconds = 36.36 MB/sec

/dev/hdc:
 Timing buffered disk reads:  64 MB in  2.21 seconds = 28.96 MB/sec

hdparm -vi:
/dev/hda:
 multcount    = 16 (on)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 4863/255/63, sectors = 78125000, start = 0

 Model=Maxtor 5T040H4, FwRev=TAH71DP0, SerialNo=T4HTESFC
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=78125000
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: disabled (255)
 Drive Supports : ATA/ATAPI-6 T13 1410D revision 0 : ATA-1 ATA-2 ATA-3
ATA-4 ATA-5 ATA-6 


/dev/hdc:
 multcount    = 16 (on)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 77504/16/63, sectors = 78125000, start = 0

 Model=Maxtor 5T040H4, FwRev=TAH71DP0, SerialNo=T4HTFP8C
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=78125000
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 
 AdvancedPM=yes: disabled (255)
 Drive Supports : ATA/ATAPI-6 T13 1410D revision 0 : ATA-1 ATA-2 ATA-3
ATA-4 ATA-5 ATA-6 

dmesg:
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH3: IDE controller at PCI slot 00:1f.1
PCI: Device 00:1f.1 not available because of resource collisions
ICH3: Not fully BIOS configured!
ICH3: chipset revision 2
ICH3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x6c60-0x6c67, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x6c68-0x6c6f, BIOS settings: hdc:pio, hdd:pio
PDC20267: IDE controller at PCI slot 04:06.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.
    ide2: BM-DMA at 0x7480-0x7487, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x7488-0x748f, BIOS settings: hdg:pio, hdh:pio
hda: Maxtor 5T040H4, ATA DISK drive
blk: queue c04498e0, I/O limit 4095Mb (mask 0xffffffff)
hdc: Maxtor 5T040H4, ATA DISK drive
blk: queue c0449d78, I/O limit 4095Mb (mask 0xffffffff)
hde: Maxtor 5T040H4, ATA DISK drive
blk: queue c044a210, I/O limit 4095Mb (mask 0xffffffff)
hdg: Maxtor 5T040H4, ATA DISK drive
blk: queue c044a6a8, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x74d0-0x74d7,0x74c6 on irq 22
ide3 at 0x74c8-0x74cf,0x74c2 on irq 22
hda: host protected area => 1
hda: setmax LBA 80043264, native  78125000
hda: 78125000 sectors (40000 MB) w/2048KiB Cache, CHS=4863/255/63,
UDMA(100)
hdc: host protected area => 1
hdc: setmax LBA 80043264, native  78125000
hdc: 78125000 sectors (40000 MB) w/2048KiB Cache, CHS=77504/16/63,
UDMA(33)
hde: host protected area => 1
hde: setmax LBA 80043264, native  78125000
hde: 78125000 sectors (40000 MB) w/2048KiB Cache, CHS=77504/16/63,
UDMA(100)
hdg: host protected area => 1
hdg: setmax LBA 80043264, native  78125000
hdg: 78125000 sectors (40000 MB) w/2048KiB Cache, CHS=77504/16/63,
UDMA(100)
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2 hda3 hda4
 hdc: hdc1
 hde: hde1
 hdg: hdg1

-- 
Make sure your best systems look as bad
as possible from the outside.
(The Third Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

