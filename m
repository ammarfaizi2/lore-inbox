Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131204AbRCGUkx>; Wed, 7 Mar 2001 15:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131202AbRCGUkn>; Wed, 7 Mar 2001 15:40:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:49677 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131200AbRCGUk3>;
	Wed, 7 Mar 2001 15:40:29 -0500
Date: Wed, 7 Mar 2001 21:36:32 +0100
From: Jens Axboe <axboe@suse.de>
To: Pozsar Balazs <pozsy@sch.bme.hu>
Subject: Re: can't read DVD (under 2.4.[12] & 2.2.17)
Message-ID: <20010307213632.H4653@suse.de>
In-Reply-To: <20010307210848.E4653@suse.de> <Pine.GSO.4.30.0103072128180.6575-100000@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.30.0103072128180.6575-100000@balu>; from pozsy@sch.bme.hu on Wed, Mar 07, 2001 at 09:32:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07 2001, Pozsar Balazs wrote:
> Details: (dmesg)
> 
> Linux version 2.4.2-3mdk (jgarzik@no.mandrakesoft.com) (gcc version
> egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Tue Feb 27 02:14:17
> CET 2001
> ...
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> VP_IDE: IDE controller on PCI bus 00 dev 39
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
>     ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:pio, hdd:DMA
> HPT370: IDE controller on PCI bus 00 dev 70
> PCI: Found IRQ 11 for device 00:0e.0
> HPT370: chipset revision 3
> HPT370: not 100% native mode: will probe irqs later
>     ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:DMA, hdh:pio
> hdd: Pioneer DVD-ROM ATAPIModel DVD-105S 012, ATAPI CD/DVD-ROM drive
> hdg: QUANTUM FIREBALLlct20 20, ATA DISK drive
> ide1 at 0x170-0x177,0x376 on irq 15
> ide3 at 0xe400-0xe407,0xe802 on irq 11
> hdg: 39876480 sectors (20417 MB) w/418KiB Cache, CHS=39560/16/63,
> UDMA(100)
> hdd: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.12
> Partition check:
>  hdg: hdg1 hdg2 hdg3 hdg4
> ...
> 
> 
> 
> When I run "dvdinfo /dev/hdd" I get:
> Disc is encrypted.
> Layer 0[3]
>  Book Version:   0
>  Book Type:      13
>  Min Rate:       0
>  Disc Size:      0
>  Layer Type:     0
>  Track Path:     1
>  Num Layers:     2
>  Track Density:  0
>  Linear Density: 0
>  BCA:            1
>  Start Sector    0xd000
>  End Sector      0xd000
>  End Sector L0   0xd000
> Layer 1[3]
>  Book Version:   0
>  Book Type:      13
>  Min Rate:       0
>  Disc Size:      0
>  Layer Type:     0
>  Track Path:     1
>  Num Layers:     2
>  Track Density:  0
>  Linear Density: 0
>  BCA:            1
>  Start Sector    0xd000
>  End Sector      0x1d000
>  End Sector L0   0xd000
> hdd: packet command error: status=0x51 { DriveReady SeekComplete Error }
> hdd: packet command error: error=0x50
> ATAPI device hdd:
>   Error: Illegal request -- (Sense key=0x05)
>   Invalid field in command packet -- (asc=0x24, ascq=0x00)
>   The failed "Send DVD Structure" packet command was:
>   "ad 00 00 00 00 00 02 00 00 54 00 00 "
> Could not read Physical layer 2
> Copyright: CPST=1, RMI=0xfd

I don't know the program you mention, but it's definitely buggy. It
sets byte 6 to 0x02 which is not valid at all. Byte 7 is the format
code, but 0x02 is reserved there too. Who wrote this program? Tell
him it's buggy, it's not the driver.

-- 
Jens Axboe

