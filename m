Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315529AbSE2VZM>; Wed, 29 May 2002 17:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315530AbSE2VZL>; Wed, 29 May 2002 17:25:11 -0400
Received: from esteel10.client.dti.net ([209.73.14.10]:17752 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP
	id <S315529AbSE2VZK>; Wed, 29 May 2002 17:25:10 -0400
Date: Wed, 29 May 2002 17:24:25 -0400
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
To: linux-kernel@vger.kernel.org
Cc: andre@linux-ide.org
Subject: 2.4.19-pre9, IDE on Sparc, Big Disks
Message-ID: <20020529172425.A15749@shookay.newview.com>
Mail-Followup-To: Mathieu Chouquet-Stringer <mathieu@newview.com>,
	linux-kernel@vger.kernel.org, andre@linux-ide.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	  Hello Andre and LKML!

I just pulled a copy of Marcello's tree from bk and compiled it on my sparc
(that's a sun ultra 5). Everything went well but the IDE.
I have a large ide disk connected to this guy (around 120GB if memory
serves) and it used to work properly in the 2.4.17 era.
Now when I boot, I got this:

========>8========>8========>8========>8========>8========>8========>8========>8
PROMLIB: Sun IEEE Boot Prom 3.31.0 2001/07/25 20:36
Linux version 2.4.19-pre9 (mchouque@rugby) (gcc version egcs-2.92.11 19980921 (gcc2 ss-980609 experimental)) #2 Wed May 29 16:45:15 EDT 2002
ARCH: SUN4U
[...]
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
CMD646: IDE controller on PCI bus 01 dev 18
CMD646: chipset revision 3
CMD646: chipset revision 0x03, MultiWord DMA Force Limited
CMD646: 100% native mode on irq 4,7e0
    ide0: BM-DMA at 0x1fe02c00020-0x1fe02c00027, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1fe02c00028-0x1fe02c0002f, BIOS settings: hdc:pio, hdd:pio
hda: ST39111A, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdc: Maxtor 4G120J6, ATA DISK drive
hdd: CRD-8322B, ATAPI CD/DVD-ROM drive
ide0 at 0x1fe02c00000-0x1fe02c00007,0x1fe02c0000a on irq 4,7e0
ide1 at 0x1fe02c00010-0x1fe02c00017,0x1fe02c0001a on irq 4,7e0 (shared with ide0)
hda: 17803297 sectors (9115 MB) w/2048KiB Cache, CHS=17662/16/63, (U)DMA
hdc: -612473816857182208 sectors (9131146371508413 MB) w/2048KiB Cache, CHS=-1102014018/255/63, (U)DMA
hdd: ATAPI 32X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3
 hdc:<6>attempt to access beyond end of device
16:00: rw=0, want=1, limit=-2147483648
attempt to access beyond end of device
16:00: rw=0, want=2, limit=-2147483648
attempt to access beyond end of device
16:00: rw=0, want=3, limit=-2147483648
attempt to access beyond end of device
16:00: rw=0, want=4, limit=-2147483648
attempt to access beyond end of device
16:00: rw=0, want=5, limit=-2147483648
attempt to access beyond end of device
16:00: rw=0, want=6, limit=-2147483648
attempt to access beyond end of device
16:00: rw=0, want=7, limit=-2147483648
attempt to access beyond end of device
16:00: rw=0, want=8, limit=-2147483648
attempt to access beyond end of device
[... Repeat this block one more time ...]
 unable to read partition table
========>8========>8========>8========>8========>8========>8========>8========>8

This what I have in my config file:
#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
CONFIG_BLK_DEV_CMD64X=y
# CONFIG_BLK_DEV_CMD680 is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

Finally the output of lspci:
00:00.0 Host bridge: Sun Microsystems Computer Corp. Ultra IIi
00:01.0 PCI bridge: Sun Microsystems Computer Corp. Simba Advanced PCI Bridge (rev 13)
00:01.1 PCI bridge: Sun Microsystems Computer Corp. Simba Advanced PCI Bridge (rev 13)
01:01.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
01:01.1 Ethernet controller: Sun Microsystems Computer Corp. Happy Meal (rev 01)
01:02.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro 215GP (rev 5c)
01:03.0 IDE interface: CMD Technology Inc PCI0646 (rev 03)

Right now I'm recompiling the kernel without DMA to see it changes
anything.
If you need anything from me, be my guest.

Cheers, Mathieu.
-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
    It is exactly because a man cannot do a thing that he is a
                      proper judge of it.
                      -- Oscar Wilde
