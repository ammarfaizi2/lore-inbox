Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263338AbSJFF42>; Sun, 6 Oct 2002 01:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263339AbSJFF42>; Sun, 6 Oct 2002 01:56:28 -0400
Received: from adsl-64-123-59-158.dsl.stlsmo.swbell.net ([64.123.59.158]:14720
	"EHLO base.torri.linux") by vger.kernel.org with ESMTP
	id <S263338AbSJFF40>; Sun, 6 Oct 2002 01:56:26 -0400
Subject: ext3 mount failed [2.5.40-ac3]
From: Stephen Torri <storri@sbcglobal.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Oct 2002 01:01:59 -0500
Message-Id: <1033884119.1125.14.camel@base.torri.linux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the clip of the boot message from trying to start 2.5.40-ac3
kernel. gcc-3.2 used. I can do whatever setup and configuration you
require. 

mounting root filesystem
request_module[block-major-33]: not ready
mount: error 6 mounting ext 3
pivotroot: pivot_root(/sysroot,/sysroot/initrd) failed: 2
unmount /initrd/proc failed: 2
Freeing unused Kernel memory: 176K freed
Kernel panic: no init found

Kernel config:


# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_IDEDMA_AUTO=y

#
# File systems
#
CONFIG_QUOTA=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_PROC_INFO=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_CRAMFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_JFS_FS=y
CONFIG_JFS_DEBUG=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_ROMFS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=y


The system has two IBM HDs, one Seagate and a DVD/CRW. It has a IDE
controller on the motherboard and a Promise ATA100 card. Below are the
print outs of the devices:

(hdparm -i /dev/hda)
* /dev/hda1 /mnt/win98 (vfat)
* /dev/hda2 /boot (ext3)
dev/hda:

 Model=ST310232A, FwRev=3.09, SerialNo=6BQ032H9
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=512kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=20005650
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2 udma3 udma4
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: device does not report version:  1 2 3 4

(hdparm -i /dev/hde)
dev/hde:
* /dev/hde1 	/ (root) (ext3)
* /dev/hde2	swap (swap)
* /dev/hde5	/usr (ext3)
* /dev/hde6	/home (ext3)
dev/hdf: (same drive as hde)
* /dev/hdf1	/usr/src (ext3)
* /dev/hdf2	/mnt/misc_1 (ext3)

 Model=IBM-DTLA-307045, FwRev=TX6OA50C, SerialNo=YMDYMT5M619
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=90069840
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  2 3 4 5

(lspci -v)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
(prog-if 80
[Master])
        Flags: bus master, medium devsel, latency 64
        [virtual] I/O ports at 01f0
        [virtual] I/O ports at 03f4
        [virtual] I/O ports at 0170
        [virtual] I/O ports at 0374
        I/O ports at ffa0 [size=16]

00:14.0 Unknown mass storage controller: Promise Technology, Inc. 20267
(rev 02)        Subsystem: Promise Technology, Inc. Ultra100
        Flags: bus master, medium devsel, latency 64, IRQ 10
        I/O ports at efe0 [size=8]
        I/O ports at efac [size=4]
        I/O ports at efa0 [size=8]
        I/O ports at efa8 [size=4]
        I/O ports at ef00 [size=64]
        Memory at febe0000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at febd0000 [disabled] [size=64K]
        Capabilities: [58] Power Management version 1

Stephen Torri
storri@sbcglobal.net
