Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284732AbSAVPSo>; Tue, 22 Jan 2002 10:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285593AbSAVPSe>; Tue, 22 Jan 2002 10:18:34 -0500
Received: from skiathos.physics.auth.gr ([155.207.123.3]:32438 "EHLO
	skiathos.physics.auth.gr") by vger.kernel.org with ESMTP
	id <S284732AbSAVPSb>; Tue, 22 Jan 2002 10:18:31 -0500
Date: Tue, 22 Jan 2002 17:18:27 +0200 (EET)
From: Liakakis Kostas <kostas@skiathos.physics.auth.gr>
To: linux-kernel@vger.kernel.org
cc: Liakakis Kostas <kostas@skiathos.physics.auth.gr>
Subject: 2.4.17: Hang after IDE detection
In-Reply-To: <Pine.LNX.4.33.0201221421050.20914-100000@aither.zcu.cz>
Message-ID: <Pine.GSO.4.21.0201221547420.18952-100000@skiathos.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I recently got an older k6-2/333 with a SiS chipset and tried to install
linux on it.

Every recent distro I tryed with a 2.4.x kernel would hang after detecting
the SiS5513 controller.

Annoyed I took 2.4.17 compiled it on another machine. The IDE config was:
#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
 
It would hang exactly the same as the distros (written down from display
by hand):

Blah blah blah...
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33mhz etc etc
SIS5513: IDE controller on PCI bus 00 dev 09
PCI: Assigned IRQ 14 for device 00:01.1
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5597
    ide0: BM-DMA at 0x4000-0x4007, BIOS settings hda:pio, hdb:pio
    ide1: BM-DMA at 0x4008-0x400f, BIOS settings hdc:pio, hdb:pio
hda: ST34321A, ATA DISK drive
hdc: CD-540E, ATAPI CD/DVD-DROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on ira 15
<hang>

Keyboard is dead (no num-lock, no magic sysrq)

Things I have tryed and failed:
- Not using dma by default in kernel or nodma option
- Not enabling support for SiS5513 in kernel
- specifing hda geometry (hda=...), hdc=cdrom, hdb,hdd=noprobe
- kernels 2.4.11pre5 and redhat 7.1, Mandrake 8.0, 8.1 boot disks
- Andre's latest patches for 2.4.17 with SiS5513 configured

Things that succeeded:
- 2.2.x kernels were fine (x=10, 16 that were handy)
- 2.4.0test1-ac22 was also fine (tested without SiS5513 configured...)
- Andre's letest patches without SiS5513 configured

The /proc/pci of the machine after booting 2.4.17+Andre+no-SIS5513
injected into the Mandrake 8.1 bootdisk (again by hand):

PCI devices found:
   Bus 0, device 0, function 0:
       Host bridge: Silicon Integrated Systems [SiS] 5597 [SiS5582]
(rev2).
         Master capable. Latency=255.
   Bus 0, device 1, function 0:
       ISA bridge: Silicon Inte... etc [SiS] 82C503/5513 (rev 1).
   Bus 0, device 1, function 1:
       IDE interface: Silicon ... etc [SiS] 5513 [IDE] (rev 208).
         IRQ 14.
         Master Capable. Latency=64.
         I/O at 0x40000 [0x400f].
   Bus 0, device 10, function 0:
       VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 1).
         IRQ 12.
         Master Capable. Latency=64.   Min Gnt=4.Max Lat=255.
         Non-prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].

Thanks for any help guys...

(now off to convince that Mandrake distro to install...)

-K.


