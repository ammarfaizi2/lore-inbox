Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317135AbSFFTsm>; Thu, 6 Jun 2002 15:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317137AbSFFTsl>; Thu, 6 Jun 2002 15:48:41 -0400
Received: from internal-bristol34.naxs.com ([216.98.66.34]:26664 "EHLO
	coredump.electro-mechanical.com") by vger.kernel.org with ESMTP
	id <S317135AbSFFTsk>; Thu, 6 Jun 2002 15:48:40 -0400
Date: Thu, 6 Jun 2002 15:44:05 -0400
From: William Thompson <wt@electro-mechanical.com>
To: Samuel Flory <sflory@rackable.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PDC20267 + RAID can't find raid device
Message-ID: <20020606154405.I7291@coredump.electro-mechanical.com>
In-Reply-To: <20020606111918.F7291@coredump.electro-mechanical.com> <1023391095.3423.112.camel@flory.corp.rackablelabs.com> <20020606152051.H7291@coredump.electro-mechanical.com> <1023391925.3700.142.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Are you sure you have the raid array configured in the fasttrak bios? 
> I don't think enabling brust should matter.  It's working for me:

Actually, I don't know, but it says it's there according to it's bios.

> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> PDC20267: IDE controller on PCI bus 00 dev 18
> PDC20267: chipset revision 2
> PDC20267: not 100% native mode: will probe irqs later
> PDC20267: ROM enabled at 0xfeae0000
> PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
> Mode.
>     ide2: BM-DMA at 0xdf00-0xdf07, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0xdf08-0xdf0f, BIOS settings: hdg:pio, hdh:pio
> SvrWks OSB4: IDE controller on PCI bus 00 dev 79
> SvrWks OSB4: chipset revision 0
> SvrWks OSB4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
> hde: ST320410A, ATA DISK drive
> hdg: ST320410A, ATA DISK drive
> ide2 at 0xdfe0-0xdfe7,0xdfae on irq 31
> ide3 at 0xdfa0-0xdfa7,0xdfaa on irq 31
> hde: host protected area => 1
> hde: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63,
> UDMA(100)
> hdg: host protected area => 1
> hdg: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63,
> UDMA(100)
> ide-floppy driver 0.99.newide
> Partition check:
>  hde: [PTBL] [2434/255/63] hde1 hde2 hde3
>  hdg: [PTBL] [2434/255/63] hdg1 hdg2 hdg3
> Floppy drive(s): fd0 is 1.44M
> Partition check:
>  hde: [PTBL] [2434/255/63] hde1 hde2 hde3
>  hdg: [PTBL] [2434/255/63] hdg1 hdg2 hdg3
> ...
>  ataraid/d0: ataraid/d0p1 ataraid/d0p2 ataraid/d0p3
> Drive 0 is 19092 Mb (33 / 0)
> Drive 1 is 19092 Mb (34 / 0)
> Raid1 array consists of 2 drives.
> Promise Fasttrak(tm) Softwareraid driver for linux version 0.03beta
> Highpoint HPT370 Softwareraid driver for linux version 0.01
> No raid array found
> 
> On Thu, 2002-06-06 at 12:20, William Thompson wrote:
> > >   It works for me once I got the right options.  Did you enable the
> > > "fasttrak feature"
> > > 
> > > I'm using the following options in my .config:
> > > CONFIG_BLK_DEV_PDC202XX=y
> > > CONFIG_PDC202XX_BURST=y
> > > CONFIG_PDC202XX_FORCE=y
> > > CONFIG_BLK_DEV_ATARAID_PDC=y
> > 
> > Only difference is the fact I didn't enable BURST.  your other 3 options are
> > the same as mine.
> > 
> > The thing says:
> > Promise Fasttrak(tm) Softwareraid driver 0.03beta: No raid array found
> > 
> > > /dev/ataraid/d0 devices, and the /dev/hd devices.  This makes for lots
> > > of fun in the Red Hat installer, and Cerberus.   
> > 
> > I'm using debian, but I'm not actually installing the system, I'm copying
> > from another.
> > 
> > > > After trying 2.4.19-pre10-ac2 I can finally use the PDC20267 controller,
> > > > however, it doesn't find any raid devices.
> > > > 
> > > > I have 2 quantum fireballlct10 05 on the controller (hde and hdg) and
> > > > created a stripe between these 2 disks in the controller's bios.
> > > > 
> > > > I can see both disks w/o problems.
> > > > 
> > > > I'd rather not use the linux software raid since you can't partition it.
> > > > 
> > > > IDE, PDC20267, FastTrak, and the raid driver are all compiled into the
> > > > kernel.
> > > > 
> > > > More info is available at request.
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > Please read the FAQ at  http://www.tux.org/lkml/
> > > > 
> > > 
> > > 
> > > 
> > 
> 
> 
> 
