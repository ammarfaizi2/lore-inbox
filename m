Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265238AbTBFCOV>; Wed, 5 Feb 2003 21:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265140AbTBFCOU>; Wed, 5 Feb 2003 21:14:20 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:14980 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S265063AbTBFCOL>;
	Wed, 5 Feb 2003 21:14:11 -0500
Date: Thu, 6 Feb 2003 03:24:10 +0100 (CET)
From: Stephan van Hienen <raid@a2000.nu>
To: Hans-Peter Jansen <hp@lisa-gmbh.de>
cc: Shawn Evans <shawnwe@hotmail.com>, linux-raid@vger.kernel.org,
       Andre Hedrick <andre@aslab.com>, linux-kernel@vger.kernel.org
Subject: Re: Promise FastTrak TX4 losing interrupts (with apic mode)
In-Reply-To: <20011031162116.AF5A41018@shrek.lisa.de>
Message-ID: <Pine.LNX.4.53.0302060313490.9702@ddx.a2000.nu>
References: <F14meUdm8TihuWkpKyG0001ebd3@hotmail.com> <20011031162116.AF5A41018@shrek.lisa.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

replying on an old thread
looks like i have the same problem as below

kernel 2.4.20 intel sc7500cw mainbord (dual xeon)
booting with noapic appended resolves the lost interrupt messages
(only happens on the TX4 disks (there is also an onboard
FastTrak100(2channel)which works ok)

I don't use the promise raid code, just using the card to use some extra
ide channels for my sw raid5

i get exactly the same error when booting :

hde: lost interrupt
hde: lost interrupt
ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hde: lost interrupt
unknown partition table
hdg: lost interrupt
hdg: lost interrupt
ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hdg: lost interrupt
unknown partition table
hdi: lost interrupt
hdi: lost interrupt
ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hdi: lost interrupt
unknown partition table

moved arround the tx4 card between pci slots (and busses (mainbord has 3
pci busses)) but keeps getting the same error
the tx4 always gets irq48 (not shared with anything else)

only booting with noapic fixes it
(are there any negative point when running in 'noapic mode' ?(besides
losing high irq's))


On Wed, 31 Oct 2001, Hans-Peter Jansen wrote:

> On Wednesday, 31. October 2001 15:14, Shawn Evans wrote:
> > Hans,
> >
> >   I have a TX4 and have been unsuccessful in getting it to work 100%... The
> > second card losses interrupts...  The board... if you don't already have
> > one... seems as if it is just 2 TX2 on one board... ( turning off the slave
> > ).  The chips say 20270... but everything that sees then says 20268...
> > here is some info.. maybe it will help you and maybe you can help me.
> > Running 2.4.12 with patches from redhat ata-raid site.  (also I have an hpt
> > on board which you can see.. but no drives are hooked up)
> >
> >    I have been thinking.. that if Linux software raid is better than the
> > drivers in the kernel... it might be possible to set up a TX4 to control 8
> > drives... :-)
>
> Looks like you mean the ataraid stuff here. I'm trying to avoid that.
> Haven't tried to slave some drives on the TX4 either, but to my experience,
> a slaved drive on PDC20268 sucks performance wise...
>
> >
> > dmesg:
> >
> > ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> > VP_IDE: IDE controller on PCI bus 00 dev 39
> > VP_IDE: chipset revision 6
> > VP_IDE: not 100% native mode: will probe irqs later
> > VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
> >     ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:pio
> >     ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:DMA, hdd:pio
> > HPT370A: IDE controller on PCI bus 00 dev 70
> > HPT370A: chipset revision 4
> > HPT370A: not 100% native mode: will probe irqs later
> >     ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:pio, hdf:pio
> >     ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:pio, hdh:pio
> > PDC20268: IDE controller on PCI bus 03 dev 08
> > PDC20268: chipset revision 2
> > PDC20268: not 100% native mode: will probe irqs later
> > PDC20268: pci-config space interrupt mirror fixed.
> > PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
> > Mode.
> >     ide4: BM-DMA at 0xa000-0xa007, BIOS settings: hdi:pio, hdj:pio
> >     ide5: BM-DMA at 0xa008-0xa00f, BIOS settings: hdk:pio, hdl:pio
> > PDC20268: IDE controller on PCI bus 03 dev 10
> > PDC20268: chipset revision 2
> > PDC20268: not 100% native mode: will probe irqs later
> > PDC20268: ROM enabled at 0x000dc000
> > PDC20268: pci-config space interrupt mirror fixed.
> > PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
> > Mode.
> >     ide6: BM-DMA at 0xb400-0xb407, BIOS settings: hdm:pio, hdn:pio
> >     ide7: BM-DMA at 0xb408-0xb40f, BIOS settings: hdo:pio, hdp:pio
> > hda: WDC WD800BB-00BSA0, ATA DISK drive
> > hdc: YAMAHA CRW2100E, ATAPI CD/DVD-ROM drive
> > hdi: WDC WD800BB-00BSA0, ATA DISK drive
> > hdk: WDC WD800BB-00BSA0, ATA DISK drive
> > hdm: WDC WD800BB-00BSA0, ATA DISK drive
> > hdo: WDC WD800BB-00BSA0, ATA DISK drive
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > ide1 at 0x170-0x177,0x376 on irq 15
> > ide4 at 0x9000-0x9007,0x9402 on irq 11
> > ide5 at 0x9800-0x9807,0x9c02 on irq 11
> > ide6 at 0xa400-0xa407,0xa802 on irq 10
> > ide7 at 0xac00-0xac07,0xb002 on irq 10
> > hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63,
> > UDMA(100)
> > hdi: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63,
> > UDMA(66)
> > hdk: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63,
> > UDMA(66)
> > hdm: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63,
> > UDMA(66)
> > hdo: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63,
> > UDMA(66)
> > Partition check:
> > hda: hda1 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 >
> > hdi: [PTBL] [9729/255/63] hdi1
> > hdk: unknown partition table
> > hdm:hdm: lost interrupt
> > hdm: lost interrupt
> > hdm: lost interrupt
> > ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
> > hdm: lost interrupt
> > unknown partition table
> > hdo:hdo: lost interrupt
> > hdo: lost interrupt
> > hdo: lost interrupt
> > ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
> > hdo: lost interrupt
> > unknown partition table
> > loop: loaded (max 8 devices)
> > Linux agpgart interface v0.99 (c) Jeff Hartmann
> > agpgart: Maximum main memory to use for agp memory: 816M
> > agpgart: Detected Via Apollo Pro chipset
> > agpgart: AGP aperture is 64M @ 0xd0000000
> > ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
> > hdm: lost interrupt
> > ataraid/d0: ataraid/d0p1
> > Drive 0 is 76319 Mb (56 / 0)
> > Drive 1 is 76319 Mb (57 / 0)
> > Drive 2 is 76319 Mb (88 / 0)
> > Raid0 array consists of 3 drives.
> > Promise Fasttrak(tm) Softwareraid driver for linux version 0.03beta
> > Highpoint HPT370 Softwareraid driver for linux version 0.01
> > No raid array found
> >
>
> Your problem is different to mine. BTW, Andre made a new patch at
> http://www.linuxdiskcert.org. It drives the TX4 in UDMA(100) mode
> at least.
>
> > cat /proc/io:
> > iomem    ioports
> > [root@god root]# cat /proc/ioports
> > 0000-001f : dma1
> > 0020-003f : pic1
> > 0040-005f : timer
> > 0060-006f : keyboard
> > 0080-008f : dma page reg
> > 00a0-00bf : pic2
> > 00c0-00df : dma2
> > 00f0-00ff : fpu
> > 0170-0177 : ide1
> > 01f0-01f7 : ide0
> > 02f8-02ff : serial(auto)
> > 0376-0376 : ide1
> > 0378-037a : parport0
> > 03c0-03df : vga+
> > 03f6-03f6 : ide0
> > 03f8-03ff : serial(auto)
> > 0cf8-0cff : PCI conf1
> > 5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
> > 6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
> > 9000-bfff : PCI Bus #03
> >   9000-9007 : PCI device 105a:6268 (Promise Technology, Inc.)
> >     9000-9007 : ide4
> >   9400-9403 : PCI device 105a:6268 (Promise Technology, Inc.)
> >     9402-9402 : ide4
> >   9800-9807 : PCI device 105a:6268 (Promise Technology, Inc.)
> >     9800-9807 : ide5
> >   9c00-9c03 : PCI device 105a:6268 (Promise Technology, Inc.)
> >     9c02-9c02 : ide5
> >   a000-a00f : PCI device 105a:6268 (Promise Technology, Inc.)
> >     a000-a007 : ide4
> >     a008-a00f : ide5
> >   a010-a01f : PDC20268
> >   a400-a407 : PCI device 105a:6268 (Promise Technology, Inc.)
> >     a400-a407 : ide6
> >   a800-a803 : PCI device 105a:6268 (Promise Technology, Inc.)
> >     a802-a802 : ide6
> >   ac00-ac07 : PCI device 105a:6268 (Promise Technology, Inc.)
> >     ac00-ac07 : ide7
> >   b000-b003 : PCI device 105a:6268 (Promise Technology, Inc.)
> >     b002-b002 : ide7
> >   b400-b40f : PCI device 105a:6268 (Promise Technology, Inc.)
> >     b400-b407 : ide6
> >     b408-b40f : ide7
> >   b410-b41f : PDC20268
> > c000-cfff : PCI Bus #02
> >   c000-c07f : 3Com Corporation 3c980-TX 10/100baseTX NIC [Python-T]
> >     c000-c07f : 02:04.0
> >   c400-c47f : 3Com Corporation 3c980-TX 10/100baseTX NIC [Python-T] (#2)
> >     c400-c47f : 02:05.0
> > d000-d01f : VIA Technologies, Inc. UHCI USB (#2)
> > d400-d40f : VIA Technologies, Inc. Bus Master IDE
> >   d400-d407 : ide0
> >   d408-d40f : ide1
> > d800-d81f : VIA Technologies, Inc. UHCI USB
> > dc00-dc07 : Triones Technologies, Inc. HPT366 / HPT370
> > e000-e003 : Triones Technologies, Inc. HPT366 / HPT370
> > e400-e407 : Triones Technologies, Inc. HPT366 / HPT370
> > e800-e803 : Triones Technologies, Inc. HPT366 / HPT370
> > ec00-ecff : Triones Technologies, Inc. HPT366 / HPT370
> >   ec00-ec07 : ide2
> >   ec08-ec0f : ide3
> >   ec10-ecff : HPT370A
> >
> >
> > cat /proc/interrupts
> >            CPU0       CPU1
> >   0:    4088270    4605986    IO-APIC-edge  timer
> >   1:        208        203    IO-APIC-edge  keyboard
> >   2:          0          0          XT-PIC  cascade
> >   9:      21438      21722   IO-APIC-level  eth0
> > 10:          0          0   IO-APIC-level  ide6, ide7, eth1
> > 11:    5093433    5093439   IO-APIC-level  ide4, ide5
> > 12:      26352      29204    IO-APIC-edge  PS/2 Mouse
> > 14:      75567      56241    IO-APIC-edge  ide0
> > 15:        187         99    IO-APIC-edge  ide1
> > NMI:          0          0
> > LOC:    8694029    8694028
> > ERR:          0
> > MIS:          0
> >
>
> Disabling eth1 may help you. What mobo you're using?
>
> > for i in hdi hdk hdm hdo; do hdparm -tT /dev/$i; done
> >
> > /dev/hdi:
> > Timing buffer-cache reads:   128 MB in  0.70 seconds =182.86 MB/sec
> > Timing buffered disk reads:  64 MB in  2.03 seconds = 31.53 MB/sec
> >
> > /dev/hdk:
> > Timing buffer-cache reads:   128 MB in  0.69 seconds =185.51 MB/sec
> > Timing buffered disk reads:  64 MB in  2.03 seconds = 31.53 MB/sec
> >
> > /dev/hdm:
> > dies here.....
> >
> > Shawn
> >
>
> Cheers,
> hp
> -
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
