Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRCHOp2>; Thu, 8 Mar 2001 09:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129078AbRCHOpS>; Thu, 8 Mar 2001 09:45:18 -0500
Received: from mx-03.carambole.com ([213.180.68.11]:22799 "HELO
	mx-03.carambole.com") by vger.kernel.org with SMTP
	id <S129066AbRCHOpC>; Thu, 8 Mar 2001 09:45:02 -0500
Message-ID: <3AA79A1D.49E5ADC@opensource.se>
Date: Thu, 08 Mar 2001 15:41:33 +0100
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.2.18 corruption: IDE + PCMCIA ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've experienced some disk corruption on my laptop.

Scenario:
I'm cross-compiling tons of sources and I felt the need
to insert a CompactFlash card (via PCMCIA) in my laptop.
So I did, no problem: 
mounted, touched a file, umounted, cardctl-ejected.

Pretty soon my compilation stops:
bash: /usr/bin/sort: cannot execute binary file

Okey. The date on /usr/bin/sort is unchanged. Must be root to write.
I am NOT compiling as root. 
"File" on /usr/bin/sort says "data". No elf.
The only thing that the logs say:

modprobe: Can't locate module binfmt-464c

The filesystem on /usr is ext2.

I downloaded a new textutils.deb and installed it.
(But I made a backup of the corrupted file for some reason)
Searched the net and found some previous problem with
2.2.10 and DMA + CompactFlash.
Started to write a mail like this. 
Tried to do a ls -> Segmentation fault.
Then the entire machine crashed.
I rebooted the machine and fsck.ext2 complained about
my largest partition, did a manual check and now I'm back.

I wonder how many corrupted files there are left...

The machine is usually very stable, but I haven't done
much PCMCIA activity with it.

Maybe this is not even related to PCMCIA...

Anyway, this is what I do to my disk/controller:

/sbin/hdparm -c1 -d1 -m16 -a0 -S4 -u1 /dev/hda

I don't know if that has anything to do with it.

I've used this computer about three months now
and another Portege (3440CT) six months.
Never experienced anything like that...

So, all Portege users out there - be careful!

Cheers /

Magnus


Software:

linux-2.2.18
pcmcia-cs-3.1.23

Hardware:

Toshiba Portege 3480CT:

CPU and memory:

600MHz Speedstep PII 
192MByte ram.

Harddisk and controller:

PCI_IDE: unknown IDE controller on PCI bus 00 device 39, VID=8086,
DID=7199
PCI_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xbff0-0xbff7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xbff8-0xbfff, BIOS settings: hdc:pio, hdd:pio
hda: TOSHIBA MK1214GAP, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: TOSHIBA MK1214GAP, 11513MB w/0kB Cache, CHS=1467/255/63, UDMA

Pcmcia/pccard:

Linux PCMCIA Card Services 3.1.23
  kernel build: 2.2.18 #2 Mon Jan 15 23:56:28 CET 2001
  options:  [pci] [cardbus] [apm]
PCI routing table version 1.0 at 0xf0190
  00:0b.0 -> irq 11
  00:0b.1 -> irq 11
Intel PCIC probe: 
  Toshiba ToPIC100 rev 20 PCI-to-CardBus at slot 00:0b, mem 0x68000000
    host opts [0]: [slot 0xf0] [ccr 0x16] [cdr 0x86] [rcr 0xc000000]
[pci irq 11] [lat 64/176] [bus 20/20]
    host opts [1]: [slot 0xf0] [ccr 0x26] [cdr 0x86] [rcr 0xc000000]
[pci irq 11] [lat 64/176] [bus 21/21]

Compact Flash:

hdc: Hitachi CV 7.2.2, ATA DISK drive
hdc: Hitachi CV 7.2.2, 30MB w/1kB Cache, CHS=492/4/32
