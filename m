Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291401AbSCXM23>; Sun, 24 Mar 2002 07:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291531AbSCXM2U>; Sun, 24 Mar 2002 07:28:20 -0500
Received: from CPE-203-51-26-136.nsw.bigpond.net.au ([203.51.26.136]:2554 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S291401AbSCXM2G>; Sun, 24 Mar 2002 07:28:06 -0500
Message-ID: <3C9DC64F.DDC57F4D@eyal.emu.id.au>
Date: Sun, 24 Mar 2002 23:27:59 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre3-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18: many IDE errors
In-Reply-To: <Pine.LNX.4.10.10203240014430.2377-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I understand correctly, the basic answer is that this is not
a driver issue, and not a general kernel (irq's etc.) either, but
a true hardware problem.


Andre Hedrick wrote:
> 
> It is not a case of bad cables but maybe cable routing.

I am not clear on what cable routing means. Can you elaborate?

> Also, four 160GB disks eat power!

Well, these disks (4G160J8) are 5400rpm, They spin up just fine
and according to spec they each use under 300ma@12v and 400ma@5v
(active, 5.2W actually) which is not that much.

This is not to say that just because the power supply can deliver
the power, the power is clean enough.

> I have a box dual athlon similar setup w/ 460W ps
> I have to wait for the PS to warm up or there is not enough juice to
> properly spin up the last drive.  However if I replace the four 160GB's
> with four 20GB Seagate's no problem.

A bootup is always clean, and when not stressed it can go for a long
while
without any errors. However once pushed I start seeing these failures.

> 
> You are going to need at least a 400W PS w/ almost no ripple to make it
> work.  If you have this then check the cable routing.
> 
> Also hdparm -i /dev/hdX to see if their transfer rates are reduced.

I will check the situation. I know they come up ATA-5. Here are the
relevant bootup messages:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
CMD649: IDE controller on PCI bus 00 dev 50
PCI: Found IRQ 5 for device 00:0a.0
CMD649: chipset revision 1
CMD649: not 100% native mode: will probe irqs later
CMD649: ROM enabled at 0xdff00000
    ide2: BM-DMA at 0xc000-0xc007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xc008-0xc00f, BIOS settings: hdg:pio, hdh:pio
CMD649: IDE controller on PCI bus 00 dev 60
PCI: Found IRQ 12 for device 00:0c.0
CMD649: chipset revision 2
CMD649: not 100% native mode: will probe irqs later
CMD649: ROM enabled at 0xdfe80000
    ide4: BM-DMA at 0xac00-0xac07, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0xac08-0xac0f, BIOS settings: hdk:pio, hdl:pio
hda: WDC WD600BB-00BSA0, ATA DISK drive
hdc: WDC WD600BB-00BSA0, ATA DISK drive
hdd: ATAPI CD ROM DRIVE 50X MAX, ATAPI CD/DVD-ROM drive
hde: Maxtor 4G160J8, ATA DISK drive
hdg: Maxtor 4G160J8, ATA DISK drive
hdi: Maxtor 4G160J8, ATA DISK drive
hdk: Maxtor 4G160J8, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xd000-0xd007,0xcc02 on irq 5
ide3 at 0xc800-0xc807,0xc402 on irq 5
ide4 at 0xbc00-0xbc07,0xb802 on irq 12
ide5 at 0xb400-0xb407,0xb002 on irq 12
hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=7297/255/63,
UDMA(100)
hdc: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63,
UDMA(100)
hde: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63,
UDMA(100)
hdg: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63,
UDMA(100)
hdi: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63,
UDMA(100)
hdk: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63,
UDMA(100)

> Cheers,
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> On Sun, 24 Mar 2002, Eyal Lebedinsky wrote:
> 
> > I have six disks in the machine, each a master on the cable. Two are
> > on the on-board controller and Four are on two PCI ATA-100 cards.
> >
> > I am getting disk error (BadCRC) on all disks, intermittently.
> >
> > I upgraded from RH 2.4.9 (with SGI xfs) to 2.4.18+xfs. Same problem.
> > I then applied the 2.4.18-rc1 IDE patches with no improvement (well,
> > the four 160GB disks are now fully visible and not clipped to 28bits
> > which is a nice surprise).
> >
> > I checked the memory, replaced the power supply with a hefty 400W,
> > I even used a recent mobo (Gigabyte GA-6VTXE). No beef, practically
> > the same rate of errors.
> >
> > I do not believe all six cables are bad (80w all). This is a UP, and
> > I did not enalbe local APIC. Should I?
> >
> > Any ideas where to go from here? On request I have boot messages
> > (with errors) and lspci output - I prefer not to overload the list.
> >
> > The setup is two WD 60GB disks (hda/hdc) which host the root fs (ext2)
> > a working area (md2=RAID0, most of the space) and an xfs log
> > (md1=RAID1).
> >
> > hde/g/i/k are Maxtor 160GB, RAID5, xfs (with external log on md0).
> >
> > I get errors intermittently on all, here is an example after a boot
> > following the creation of the raid5 (so a sync was running for about
> > two hours).
> >
> > hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
[errors trimmed]

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
