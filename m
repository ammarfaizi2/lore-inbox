Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266316AbSKZOw1>; Tue, 26 Nov 2002 09:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266318AbSKZOw1>; Tue, 26 Nov 2002 09:52:27 -0500
Received: from heaven.kiyaviakrym.com.ua ([212.109.36.227]:7428 "EHLO
	heaven.kiyavia.crimea.ua") by vger.kernel.org with ESMTP
	id <S266316AbSKZOwY>; Tue, 26 Nov 2002 09:52:24 -0500
To: linux-kernel@vger.kernel.org
Subject: BUG in kernel 2.4.19
Message-Id: <20021126145931.1A6DAE012@heaven.kiyavia.crimea.ua>
Date: Tue, 26 Nov 2002 16:59:31 +0200 (EET)
From: fuzk@heaven.kiyavia.crimea.ua
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good evening!

Problem: the system hangs
The additional information: troubles with controller on hd (hardware problem)

After recompiling kernel 2.4.18 with patch 2.4.19 wtere was a trouble:
The system hangs after loading in place 'Partition check'. Fragment dmesg:

In kernel 2.4.19 it was so:

hda: WDC AC33200L, ATA DISK drive
hdc: SAMSUNG SV0511D, ATA DISK drive
hdd: SAMSUNG SCR-2430, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 6346368 sectors (3249 MB) w/256KiB Cache, CHS=787/128/63, UDMA(33)
hdc: 9965088 sectors (5102 MB) w/472KiB Cache, CHS=9886/16/63, UDMA(33)
hdd: ATAPI 20X CD-ROM drive, 0kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.97.sv
Partition check:
 hda: hda1
 hdc:           /* hdc: <-- trouble */


In kernel 2.4.18 it was so:

hda: WDC AC33200L, ATA DISK drive
hdc: SAMSUNG SV0511D, ATA DISK drive
hdd: SAMSUNG SCR-2430, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 6346368 sectors (3249 MB) w/256KiB Cache, CHS=787/128/63, UDMA(33)
hdc: 9965088 sectors (5102 MB) w/472KiB Cache, CHS=9886/16/63, UDMA(33)
hdd: ATAPI 20X CD-ROM drive, 0kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.97.sv
Partition check:
 hda: hda1
 hdc:hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
 [PTBL] [620/255/63] hdc1 hdc2 hdc3
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.

/* 
# ...and so on... 
#
# It works!!! Why does not work in 2.4.19 ???
*/

Other information that might be relevant to the problem:

root@electris (17:05:09):/# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Celeron (Covington)
stepping        : 0
cpu MHz         : 267.276
cache size      : 32 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 532.48

root@electris (17:05:15):/# lspci
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 02)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 02)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:10.0 Multimedia audio controller: ESS Technology ES1969 Solo-1 Audiodrive (rev 02)
00:11.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC AGP (rev 3a)

root@electris (17:29:18):/# cat /proc/devices
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 ttyS
  5 cua
  7 vcs
 10 misc
 14 sound
 29 fb
109 lvm
128 ptm
129 ptm
136 pts
137 pts
162 raw

Block devices:
  1 ramdisk
  2 fd
  3 ide0
  7 loop
  9 md
 22 ide1
 43 nbd
 58 lvm


I hope I help you. :,)

