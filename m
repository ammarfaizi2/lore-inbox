Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317107AbSFFTQP>; Thu, 6 Jun 2002 15:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317114AbSFFTQO>; Thu, 6 Jun 2002 15:16:14 -0400
Received: from internal-bristol34.naxs.com ([216.98.66.34]:19059 "EHLO
	coredump.electro-mechanical.com") by vger.kernel.org with ESMTP
	id <S317107AbSFFTPm>; Thu, 6 Jun 2002 15:15:42 -0400
Date: Thu, 6 Jun 2002 15:10:31 -0400
From: William Thompson <wt@electro-mechanical.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PDC20267 + RAID can't find raid device
Message-ID: <20020606151031.G7291@coredump.electro-mechanical.com>
In-Reply-To: <20020606111918.F7291@coredump.electro-mechanical.com> <1023392854.23013.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have 2 quantum fireballlct10 05 on the controller (hde and hdg) and
> > created a stripe between these 2 disks in the controller's bios
> > I can see both disks w/o problems.
> 
> Do you have the ataraid driver loaded - what did it report ?

here's what's in my .config:
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_PDC202XX_FORCE=y
CONFIG_BLK_DEV_ATARAID=y
CONFIG_BLK_DEV_ATARAID_PDC=y

As you can see, it's compiled into the kernel, it's not a loadable module. 
However, I can change this.  The machine is booting via network at the
moment while I'm testing it.

here's dmesg output (minus the network messages):
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20267: IDE controller on PCI bus 00 dev 60
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
    ide2: BM-DMA at 0xd800-0xd807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xd808-0xd80f, BIOS settings: hdg:pio, hdh:pio
VP_IDE: IDE controller on PCI bus 00 dev 89
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:pio, hdd:DMA
hdd: CD-532E-B, ATAPI CD/DVD-ROM drive
hde: QUANTUM FIREBALLlct10 05, ATA DISK drive
hdg: QUANTUM FIREBALLlct10 05, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xc800-0xc807,0xcc02 on irq 11
ide3 at 0xd000-0xd007,0xd402 on irq 11
hde: host protected area => 1
hde: 10002825 sectors (5121 MB) w/418KiB Cache, CHS=10585/15/63, UDMA(33)
hdg: host protected area => 1
hdg: 10002825 sectors (5121 MB) w/418KiB Cache, CHS=10585/15/63, UDMA(33)
Partition check:
 hde: unknown partition table
 hdg: unknown partition table
[network messages remvoed]
Promise Fasttrak(tm) Softwareraid driver 0.03beta: No raid array found



The disks at hde and hdg were blanked prior to creating the array.  The array
is a RAID0
