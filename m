Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270739AbTGNRWe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 13:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270659AbTGNRTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 13:19:50 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:1031 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S270712AbTGNRQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 13:16:53 -0400
Date: Mon, 14 Jul 2003 12:31:37 -0500
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Subject: Trying to get DMA working with IDE alim15x3 controller
Message-ID: <20030714173137.GB719@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

After recent success with getting a Turtle Beach Malibu sound card
working on my machine, I'm looking again at trying to get DMA working.
I've been booting with 'ide=nodma' for a long time now as the boot
sequence gets stuck after probing for the hard drives and partitions.
I should clarify "getting stuck" by saying the machine prints out lots
of "hda: drive not ready" and "hda: lost interrupt" messages but continues 
limp along.  With the release of 2.6.0-test1 (running it now) I tried again
to boot without 'ide=nodma' on the command line and sadly still saw the same
boot problems.

Here's some hdparm output describing the machine ...

$ hdparm /dev/hd?

/dev/hda:

 Model=ST33232A, FwRev=3.02, SerialNo=GH593339
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=6253/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=128kB, MaxMultSect=16, MultSect=off
 CurCHS=6253/16/63, CurSects=6303024, LBA=yes, LBAsects=6303024
 IORDY=on/off, tPIO={min:383,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 *udma2 
 AdvancedPM=no
 Drive conforms to: unknown:  0 1 2


/dev/hdb:

 Model=ATAPI CDROM, FwRev=V1.80, SerialNo=
 Config={ Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=16384kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=yes, tPIO={min:227,w/IORDY:180}, tDMA={min:150,rec:150}
 PIO modes:  pio0 pio1 pio2 pio4 
 DMA modes:  sdma0 sdma1 *sdma2 mdma0 mdma1 
 AdvancedPM=no


/dev/hdc:

 Model=FUJITSU MPD3084AT, FwRev=DD-03-47, SerialNo=05043987
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=512kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=16514064
 IORDY=yes, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 *udma2 udma3 udma4 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: device does not report version:  1 2 3 4

Here's the IDE config bits for my 2.6.0-test1 kernel. I _do_ have the
alim15x3 driver compiled in ...

....
#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=y
...

BTW, the IDE taskfile stuff seems to work here without a problem.

When I boot with the 'ide=nodma' argument the kernel prints out the
following:

...
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:0b.0
ALI15X3: chipset revision 32
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
hda: ST33232A, ATA DISK drive
hdb: ATAPI CDROM, ATAPI CD/DVD-ROM drive
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: FUJITSU MPD3084AT, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 6303024 sectors (3227 MB) w/128KiB Cache, CHS=6253/16/63
 hda: hda1 hda2 < hda5 hda6 hda7 >
hdc: max request size: 128KiB
hdc: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=16383/16/63
 hdc: hdc1 hdc2 < hdc5 hdc6 > hdc3
....

I noticed when booting up my new kernel without the 'nodma' argument
that the /dev/hdc drive seemed to present no problem at all when it was
being examined. The partition stuff was found quickly, and there was a
"(U)DMA" at the end of the line giving the sector count, cache size, and
CHS breakdown of the drive, so it looks like the problem is just
something regarding the hard drive and cdrom on the ide0 controller.
Looking at the 'ide.c' file for clues or bootup arguments I don't see a
way to specify activating DMA on only hda while not on hdb. Maybe it is
there and I'm missing something.

Perhaps the problem I'm seeing is a bug in the alim15x3 driver? Maybe
some configuration flag I've missed, or a combination of options given
in the ide.c file? Something else?

Suggestions welcomed, and any info that I can provide I will.

Thanks in advance.

Art Haas

-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
