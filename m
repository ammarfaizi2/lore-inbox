Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUATF4e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 00:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbUATF4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 00:56:34 -0500
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:49198 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id S265051AbUATF4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 00:56:30 -0500
Message-ID: <3E1282EF.30300@mindspring.com>
Date: Tue, 31 Dec 2002 21:55:59 -0800
From: manu <hislen@mindspring.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SiI2112 + Seagate + nFroce2: no DMA!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Forgive me for intruding in this list as an outsider.

I'm about to give up on my SATA drive as I can't get it to work properly.
So I thought I may try asking the experts before falling back to PATA.

I have seen many mails reporting the same issue, some of them 6-month old:

- SATA drive comes up in pio mode, not in dma
- trying to turn on dma with hdparm is a nightmare: I/O errors, crash 
with data corruption... I tried both:

  hddarm -d1 /dev/hde

and:

  hdparm -u1 -c3 -d1 -X66 /dev/hde


crash in both cases :-((


Here's my equipment:


ABIT AN7 motherboard (nForce2 chipset, SiI3112 SATA controller)
AMD Athlon XP 2600+ (+ 512 DDR / 400 MHz)
SATA HD Seagate Barracuda 160 Gb

The SATA HD is my only drive. The only thing connected to my IDE 
controllers is a DVD/CD combo.

Running Linux Redhat 9.0
kernel 2.4.20-28.9


Traces from dmesg:

<<<<<<<<<<
...
Uniform Multi-Platform E-IDE driver Revision: 7.00beta3-.2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
AMD_IDE: PCI device 10de:0065 (nVidia Corporation) (rev a2) UDMA100 
controller o
n pci00:09.0
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
SiI3112 Serial ATA: IDE controller at PCI slot 01:0b.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
, BIOS settings: hde:pio, hdf:pio
, BIOS settings: hdg:pio, hdh:pio
hda: PIONEER DVD-RW DVR-106D, ATAPI CD/DVD-ROM drive
hde: ST3160023AS, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xe080d080-0xe080d087,0xe080d08a on irq 11
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 312581808 sectors (160042 MB) w/8192KiB Cache, CHS=19457/255/63
ide-floppy driver 0.99.newide
Partition check:
 hde: hde1 hde2 hde3
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
 >>>>>>>>>>


I've been googling for days now and could not come accross a solution, 
on the contrary I came under the impression that the combination of 
SiI3112 +and Seagate was doomed.

I cannot use this brand new computer for anything else then mail and 
web, performance is catastrophic:

<<<<<<<<<<
[root]# hdparm -Tt /dev/hde

/dev/hde:
 Timing buffer-cache reads:   128 MB in  0.33 seconds =387.88 MB/sec
 Timing buffered disk reads:  64 MB in 48.49 seconds =  1.32 MB/sec
 >>>>>>>>>>

1.32 MB !!!!! I should be getting 50 MB at least.


Isn't there a solution??

I am willing to try patches of experimental code. At this point I am 
looking at reinstalling everything on a PATA drive anyway, so  I have 
nothing to loose.


Thanks,

Emmanuel.

PS: please CC me in the reply as I am not subscribed to this list.


