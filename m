Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310213AbSCKQxL>; Mon, 11 Mar 2002 11:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310209AbSCKQxE>; Mon, 11 Mar 2002 11:53:04 -0500
Received: from mx2.airmail.net ([209.196.77.99]:3342 "EHLO mx2.airmail.net")
	by vger.kernel.org with ESMTP id <S310208AbSCKQw5>;
	Mon, 11 Mar 2002 11:52:57 -0500
Date: Mon, 11 Mar 2002 11:04:34 -0600
From: Art Haas <ahaas@neosoft.com>
To: linux-kernel@vger.kernel.org
Subject: Troubles with ALI15X3 driver in 2.4 kernels
Message-ID: <20020311110434.B32667@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

In my ongoing effort to get the most from my old machine, I found
I'd been missing the ALI15X3 driver code (I'd unselected at some
point when configuring the kernel) ...

...
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 58
ALI15X3: detected chipset, but driver not compiled in!
PCI: No IRQ known for interrupt pin A of device 00:0b.0. Please try using pci=biosirq.
ALI15X3: chipset revision 32
ALI15X3: not 100% native mode: will probe irqs later
ALI15X3: simplex device:  DMA disabled
ide0: ALI15X3 Bus-Master DMA disabled (BIOS)
ALI15X3: simplex device:  DMA disabled
ide1: ALI15X3 Bus-Master DMA disabled (BIOS)
hda: ST33232A, ATA DISK drive
hdb: ATAPI CDROM, ATAPI CD/DVD-ROM drive
hdc: FUJITSU MPD3084AT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 6303024 sectors (3227 MB) w/128KiB Cache, CHS=781/128/63
hdc: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=16383/16/63
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
 hdc: [PTBL] [1027/255/63] hdc1 hdc2 < hdc5 hdc6 > hdc3
...

So, I reconfigure the kernel, rebuild, install my new kernel, and reboot, but
I've met with no success. The boot messages indicate the kernel has some
apparent problem setting up the hda drive ...

ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: status error: staus = 0x58 { DriveReady SeekComplete DataRequest}
... a few more of the same ...
hda: drive not ready for command

The boot up hangs at doing the partition check stuff ...

Partition check:
 hda: hda1 hda2 <

... and the hard drive light is on, but nothing happens. So, I'm back to
using a bootable kernel without the ALI15X3 driver.

There is another oddity with this drive ...

# hdparm -i /dev/hda

/dev/hda:

 Model=ST33232A, FwRev=3.02, SerialNo=GH593339
  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
  RawCHS=6253/16/63, TrkSize=0, SectSize=0, ECCbytes=4
  BuffType=unknown, BuffSize=128kB, MaxMultSect=16, MultSect=off
  CurCHS=6253/16/63, CurSects=6303024, LBA=yes, LBAsects=6303024
  IORDY=on/off, tPIO={min:383,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes: pio0 pio1 pio3 pio4 
  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 
  AdvancedPM=no
  Segmentation fault
#

This crash is due to the `minor_rev_num' of the drive being
reported as 0xFFFF, which is a little higher than hdparm-4.6
expects. :-)

# cat /proc/ide/hda/identify

0c5a 186d 0000 0010 0000 0000 003f 0000
0000 0000 2020 2020 2020 2020 2020 2020
4748 3539 3333 3339 0000 0100 0004 332e
3032 2020 2020 5354 3333 3233 3241 2020
2020 2020 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 0f01 0000 0100 0200 0007 186d 0010
003f 2d30 0060 0100 2d30 0060 0000 0007
0003 0078 0078 017f 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0007 ffff 0009 4000 0000 0000 0000 0000 <=== this line ...
0407 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0001 0000 0000 0041 0000 0002 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0080 0001 0311
0141 0401 0200 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000

I'd appreciate any help getting the kernel to boot with
the ALI15X3 driver in use. Perhaps the minor_rev_num
value is indicating a bug, or is my hard drive just
bizarre?

My system - i586-pc-linux-gnu
Compiler - gcc-3.0.5 (cvs)
Binutils - 2.12.90.0.1
Kernel - 2.4.19-pre2-ac4

I haven't tried any 2.5 kernels yet, and would like to
stick with 2.4, and with the "-ac" patches merging
in lots of neat things like the O(1) scheduler, rmap,
as well as other fixed, these kernels are my preference.

Even without the "right" driver in use, these kernels
have been performing well, and the addition of rmap
and O(1) has made things even better, so my thanks to
everyone working on these features.  Thanks in
advance for suggestions, reading info, patches to
try, etc.

-- 
They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
