Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265801AbUBJKDt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 05:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbUBJKDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 05:03:49 -0500
Received: from math.ut.ee ([193.40.5.125]:29321 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S265801AbUBJKDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 05:03:46 -0500
Date: Tue, 10 Feb 2004 12:03:44 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: cdrecord & /dev/hdc & scanbus - still problems
Message-ID: <Pine.GSO.4.44.0402101155260.24441-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel 2.6.3-rc1, Intel ICH2 IDE with piix driver, using CD with ide-cd.

# cdrecord -dev=/dev/hdc -scanbus
Cdrecord-Clone 2.01a25 (i686-pc-linux-gnu) Copyright (C) 1995-2004 Jörg Schilling
NOTE: this version of cdrecord is an inofficial (modified) release of cdrecord
      and thus may have bugs that are not present in the original version.
      Please send bug reports and support requests to <cdrtools@packages.debian.org>.
      The original author should not be bothered with problems of this version.

scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.8'.
scsibus1:
        1,0,0   100) '' '' '' NON CCS Disk
        1,1,0   101) *
        1,2,0   102) *
        1,3,0   103) *
        1,4,0   104) *
        1,5,0   105) *
        1,6,0   106) *
        1,7,0   107) *

... and hangs here. dmesg tells

hdc: DMA interrupt recovery
hdc: lost interrupt
hdc: status timeout: status=0xd0 { Busy }
hdc: status timeout: error=0x00
hdc: DMA disabled
hdc: drive not ready for command
hdc: ATAPI reset complete
cdrom_pc_intr, write: dev hdc: flags = REQ_STARTED REQ_PC
sector 0, nr/cnr 0/0
bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
cdb: 1e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x02)
ide-cd: cmd 0x1e timed out
hdc: lost interrupt
cdrom_pc_intr, write: dev hdc: flags = REQ_STARTED REQ_PC REQ_FAILED
sector 0, nr/cnr 0/0
bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
cdb: 1e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x02)
ide-cd: cmd 0x1e timed out
hdc: lost interrupt
cdrom_pc_intr, write: dev hdc: flags = REQ_STARTED REQ_PC REQ_FAILED
sector 0, nr/cnr 0/0
bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
cdb: 1e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x02)
ide-cd: cmd 0x1e timed out
hdc: lost interrupt
cdrom_pc_intr, write: dev hdc: flags = REQ_STARTED REQ_PC REQ_FAILED
sector 0, nr/cnr 0/0
bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
cdb: 1e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x02)

(and keeps telling so on until reboot).

Maybe it has to do with the initial DMA error. The error itself is
another thing, it appeared in about 2.4.21 and also in 2.6 kernels with
the new ide drivers. Note that this is normal CD-ROM, not a CD-R nor
CD-RW:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 2
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: ST380011A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CDU5211, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 52X CD-ROM drive, 120kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20

And, there is no media in the drive if this matters.

-- 
Meelis Roos (mroos@linux.ee)

