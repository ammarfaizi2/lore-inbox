Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318287AbSHEC1b>; Sun, 4 Aug 2002 22:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318288AbSHEC1b>; Sun, 4 Aug 2002 22:27:31 -0400
Received: from dnvrdslgw14poolA183.dnvr.uswest.net ([63.228.84.183]:2881 "EHLO
	q.dyndns.org") by vger.kernel.org with ESMTP id <S318287AbSHEC1a>;
	Sun, 4 Aug 2002 22:27:30 -0400
Date: Sun, 4 Aug 2002 20:31:01 -0600 (MDT)
From: Benson Chow <blc@q.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: PCI Resources: 2.4.19 fails 82801CAM IDE, but 2.4.18 goes anyway?
Message-ID: <Pine.LNX.4.44.0208042002420.363-100000@q.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a followup to a previous report, with more data.

Machine is a Gateway 2000, Solo 5350.  i830m chipset, P3, 256MB RAM, with
30.00.60 (latest according to Gateway's website).

Again, this is probably a bios/PCI setup issue, but it sounds like more
than one person was broken by this yet other versions of the kernel work
fine.  Intel probably did something wrong maybe, that's another
possibility?

Anyway:

lspci -vvv reports:



00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: Gateway 2000: Unknown device 5350
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at <unassigned> [size=8]
        Region 1: I/O ports at <unassigned> [size=4]
        Region 2: I/O ports at <unassigned> [size=8]
        Region 3: I/O ports at <unassigned> [size=4]
        Region 4: I/O ports at 88c0 [size=16]
        Region 5: Memory at 10000000 (32-bit, non-prefetchable) [disabled] [size=1K]



message log (2.4.19):



Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
ICH3M: (ide_setup_pci_device:) Could not enable device.
hda: IC25N020ATCS04-0, ATA DISK drive
hdc: CD-W28E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39070080 sectors (20004 MB) w/1768KiB Cache, CHS=2432/255/63



The unassigned ports are indeed concerning.  However, 2.4.18 works fine
with these regions 0-3 unassigned!

Same lspci -vvv, but the log (2.4.18):



Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x88c0-0x88c7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x88c8-0x88cf, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N020ATCS04-0, ATA DISK drive
hdc: CD-W28E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39070080 sectors (20004 MB) w/1768KiB Cache, CHS=2432/255/63, UDMA(100)



Seems both versions picked up an issue with the resource collisions but
2.4.18 enabled it anyway.  I have not seen any corruption issues even
under "heavy" use (100Mbit Network to Disk writes is sufficient?) with
2.4.18 so I suppose it's OK.  Gateway has not reported any BIOS updates.
Is there a clean way to revert back to the old behavior?  Disk speeds are
already pretty abysmal with this machine, but it's 1/5 the speed of 2.4.18
with 2.4.19 due to UDMA disabled (I'm getting around 19.3MB/sec with
hdparm -t on 2.4.18, around 4MB/sec with PIO mode on 2.4.19.)

I'm about to comment out that "resource collisions" warning to try :)
Also trying 2.4.19-ac1 since it seems that someone reports it works...

Yes, this is a laptop, so "heavy" is relative... hehe.

Thanks,

-bc

