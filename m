Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264253AbTEaJVM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 05:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbTEaJVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 05:21:12 -0400
Received: from 81-86-149-174.dsl.pipex.com ([81.86.149.174]:38273 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264253AbTEaJVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 05:21:10 -0400
Subject: Re: siimage driver status
From: Inigo Surguy <inigosurguy@hotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054373673.5655.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 31 May 2003 10:34:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: lk@trolloc.com (lk@trolloc.com)
> I reinstalled my SiImage controller this morning because I hadn't
> documented using the -X66 switch during my previous testing.  It actually
> makes a bit of a difference- the DMA enables and THEN the machine locks
> hard when any reasonable amount of data is written to the drives on the
> controller.
> 
> I get two console messages before the machine locks hard:
> hde: dma_timer_expiry: dma status == 0x22
> hde: dma_timer_expiry status = 0xd8 { Busy }
> 

I have the same problem - I have an Asus A7N8X using the SiI3112A, with a
Seagate Barracuda SATA ST380023AS. It comes up (and works, but very slowly)
in pio.

When I enable DMA with hdparm -d1 /dev/hde, or hdparm -Xudma2 -d1,
then I get the dma_timer_expiry messages above, and then a hard lock.

When I enable DMA with hdparm -Xudma6 -d1, or hdparm -Xudma5 -d1, then the
DMA enables, I can hdparm -t to see that transfer rate is much better (25x)
than before, but as soon as I write to the drive I get the dma_timer_expiry
messages above. 

(Dual-boot Windows XP is using UDMA6 for this drive)

There's similar behaviour under 2.4.20, 2.4.21rc5ac2 and 2.4.21rc6.

Inigo

---

/var/log/messages

May 29 19:53:22 localhost kernel: NFORCE2: IDE controller at PCI slot 00:09.0
May 29 19:53:22 localhost kernel: NFORCE2: chipset revision 162
May 29 19:53:22 localhost kernel: NFORCE2: not 100%% native mode: will probe irqs later
May 29 19:53:22 localhost kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
May 29 19:53:22 localhost kernel: AMD_IDE: PCI device 10de:0065 (nVidia Corporation) (rev a2) UDMA100 controller on pci00:09.0
May 29 19:53:22 localhost kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
May 29 19:53:22 localhost kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
May 29 19:53:22 localhost kernel: SiI3112 Serial ATA: IDE controller at PCI slot 01:0b.0
May 29 19:53:22 localhost kernel: SiI3112 Serial ATA: chipset revision 2
May 29 19:53:22 localhost kernel: SiI3112 Serial ATA: not 100%% native mode: will probe irqs later
May 29 19:53:22 localhost kernel:     ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
May 29 19:53:22 localhost kernel:     ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
May 29 19:53:22 localhost autofs: automount startup succeeded
May 29 19:53:22 localhost automount[1145]: starting automounter version 3.1.7, path = /automount/cabbit, maptype = file, mapname = /etc/auto.cabbit
May 29 19:53:22 localhost kernel: hda: Pioneer DVD-ROM ATAPIModel DVD-104S 020, ATAPI CD/DVD-ROM drive
May 29 19:53:22 localhost kernel: hdd: Maxtor 98196H8, ATA DISK drive
May 29 19:53:22 localhost kernel: blk: queue c033b030, I/O limit 4095Mb (mask 0xffffffff)
May 29 19:53:22 localhost kernel: hde: ST380023AS, ATA DISK drive
May 29 19:53:22 localhost kernel: hdg: no response (status = 0xfe)
May 29 19:53:22 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
May 29 19:53:22 localhost kernel: ide1 at 0x170-0x177,0x376 on irq 15
May 29 19:53:22 localhost kernel: ide2 at 0xf880d080-0xf880d087,0xf880d08a on irq 11

---

hdparm -i /dev/hde
/dev/hde:
 
 Model=ST380023AS, FwRev=3.01, SerialNo=3KB18AAX
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=8192kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=156301488
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 udma6
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2:  1 2 3 4 5 6

---

The console messages after enabling DMA (these are copied down from my 
digital camera, so may not be exact, but I think they're pretty close)

hde: dma_timer_expiry: dma_status == 0x21
hde: timeout waiting for DMA
hde: status timeout: status=0xd8 { Busy }
ide2: reset phy, status=0x00000113,siimage_reset
hde: drive not ready for command
ide2: reset timed-out, statux 0xd8 { Busy }
hde: status timeout: status=0xd8 { Busy }
ide2: reset phy, status=0x00000113,siimage_reset
hde: drive not ready for command
ide2: reset timed-out, statux 0xd8 { Busy }
end_request: I/O error, dev 21:01 (hde), sector (something)
end_request: I/O error, dev 21:01 (hde), sector (something)
journal-601, buffer write failed
kernel BUG at prints.c:334!
invalid operand: 0000
(and then some stack information and call trace information - if this 
is useful, I can type it in too, but it looks essentially like reiserfs
complaining that the disk isn't working)


