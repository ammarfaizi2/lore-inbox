Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbTA2HRj>; Wed, 29 Jan 2003 02:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbTA2HRj>; Wed, 29 Jan 2003 02:17:39 -0500
Received: from a3hr6fay45cl.bc.hsia.telus.net ([216.232.206.119]:265 "EHLO
	cyclops.implode.net") by vger.kernel.org with ESMTP
	id <S264956AbTA2HRi>; Wed, 29 Jan 2003 02:17:38 -0500
Date: Tue, 28 Jan 2003 23:26:58 -0800
From: John Wong <kernelATimplodeDOT!net@gambit.implode.net>
To: linux-kernel@vger.kernel.org
Subject: nForce2 IDE UDMA locked to mode 2 on 2.4.21-pre4
Message-ID: <20030129072658.GA790@gambit.implode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.4.21-pre4, the nForce2 chipset board I have has the IDE detected,
but not quite properly.  It seems my UDMA 100 drives as only UDMA 33.
When I use hdparm to try to change its mode, it fails with the following
error.

ide0: Speed warnings UDMA 3/4/5 is not functional.

When I used the current 2.4.20 kernel, the IDE is detected as a generic
IDE and DMA is not enabled by default.  However, after using hdparm to
to enable DMA, it operates at the UDMA 5 level.  But with 2.4.21-pre4 and
using the recently integrated nForce driver, DMA is set by default, but
the UDMA mode is locked to 2 and cannot be changed with hdparm.

With the generic PCI IDE driver, giving hdparm -c1 -d1 -u1 /dev/hda and
then performing a hdparm -t, I get about 40.51MB/s.  It would be running at
UDMA mode 5.  With the nForce driver, DMA is set by default, but giving 
the drive the same parameters yields 17.78 MB/s.  When trying to change 
the mode with -X 69 or even anthing higher than 66, it claims to "setting 
xfermode to 69 (UltraDMA mode5)", but dmesg reports otherwise (ide0: Speed 
warnings UDMA 3/4/5 is not functional.)

Furthermore, the 3c920 onbard NIC is now detected by the 3c59x driver.
It looks like nForce2 support is improving.  Hoping for an agpgart for
the nForce[2] soon.  Not holding my breath since the original nForce has
been out for quite a while and still no agpgart for those who aren't
using nVidia for the video, but then with nForce, I don't think there
was an option for not having integrated video.  With the 3c59x working, 
the nvnet driver for the nVidia NIC is less of an issue.

Below is the snippet from dmesg for the relevant IDE info (and yes, the
UDMA 100 drives are on a 80pin IDE cable.)

Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
NFORCE2: IDE controller at PCI slot 00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hdb: C/H/S=22075/16/255 from BIOS ignored
hda: ST360021A, ATA DISK drive
hdb: IBM-DTLA-307045, ATA DISK drive
blk: queue c02f3c40, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c02f3d7c, I/O limit 4095Mb (mask 0xffffffff)
hdc: JLMS DVD-ROM LTD-166S, ATAPI CD/DVD-ROM drive
hdd: LITE-ON LTR-32123S, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=7297/255/63,
UDMA(33)
hdb: host protected area => 1
hdb: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63,
UDMA(33)
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 40X CD-ROM CD-R/RW drive, 1984kB Cache, UDMA(33)

