Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313416AbSFIQdJ>; Sun, 9 Jun 2002 12:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313421AbSFIQdI>; Sun, 9 Jun 2002 12:33:08 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:15623 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S313416AbSFIQdH>; Sun, 9 Jun 2002 12:33:07 -0400
Message-ID: <3D0382B7.20306@megapathdsl.net>
Date: Sun, 09 Jun 2002 09:30:47 -0700
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020606
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Gert Vervoort <Gert.Vervoort@wxs.nl>
Subject: 2.5.21: "ata_task_file: unknown command 50"
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gert wrote:
 > kernel 2.5.21 hangs with repeating the message "ata_task_file: 
unknown command 50" forever.

I am getting this hang as well.

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] 
System Controller (rev 25)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP 
Bridge (rev 01)
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ISA 
(rev 01)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-756 [Viper] IDE 
(rev 03)00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] 
ACPI (rev 03)

# ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=y

#
#   PCI host chip set support
#
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_ATAPI=y
CONFIG_IDEDMA_AUTO=y

idetool says:

keep settings: Invalid argument
'Model' 'QUANTUM FIREBALLP LM30'
'Firmware' 'A35.0700'
'Serial No.' '18600683'
'Geometry' '16383/16/63'
'Cache' '1900Kb (Dual Port Cache)'
'Status' 'Active/Idle'
'DMA Mode' 'Enabled'
'IO Mode' '32-bit'
'IRQ Unmask' 'Enabled'
'Multisector' 'No'
'On Reset' 'Keep settings'
keep settings: Invalid argument
multi: Invalid argument

This chunk of a 2.5.15 log should give a good idea of
the configuration:

md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
  [events: 000000f4]
  [events: 000000f4]
md: autorun ...
md: considering hda12 ...
md:  adding hda12 ...
md:  adding hda11 ...
md: created md0
md: bind<hda11,1>
md0: WARNING: hda12 appears to be on the same physical disk as hda11. True
      protection against single-disk failure might be compromised.
md: bind<hda12,2>
md: running: <hda12><hda11>
md: hda12's event counter: 000000f4
md: hda11's event counter: 000000f4
md0: max total readahead window set to 512k
md0: 2 data-disks, max readahead per data-disk: 256k
raid0: looking at hda11
raid0:   comparing hda11(1028032) with hda11(1028032)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hda12
raid0:   comparing hda12(1028032) with hda11(1028032)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: zone 0
raid0: checking hda11 ... contained as device 0
   (1028032) is smallest!.
raid0: checking hda12 ... contained as device 1
raid0: zone->nb_dev: 2, size: 2056064
raid0: current zone offset: 1028032
raid0: done.
raid0 : md_size is 2056064 blocks.
raid0 : conf->smallest->size is 2056064 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: updating md0 RAID superblock on device
md: hda12 [events: 000000f5]<6>(write) hda12's sb offset: 1028032
md: hda11 [events: 000000f5]<6>(write) hda11's sb offset: 1028032
md: ... autorun DONE.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: ide0(3,6): orphan cleanup on readonly fs
EXT3-fs: ide0(3,6): 18 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,6), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on md(9,0), internal journal
EXT3-fs: mounted filesystem with ordered data mode.

