Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265790AbTL3NNf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 08:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265791AbTL3NNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 08:13:35 -0500
Received: from math.ut.ee ([193.40.5.125]:15589 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S265790AbTL3NNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 08:13:32 -0500
Date: Tue, 30 Dec 2003 15:13:30 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: cdrecord & /dev/hdc - problems
Message-ID: <Pine.GSO.4.44.0312301504580.27497-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried the new SG_IO interface to ATAPI devices, with 2.6.0 pristine
and todays BK. Same problems: cdrecord gets bogsu answer and CD drive is
hosed.

cdrecord is Cdrecord-Clone 2.01a19 from Debian unstable.

[...]
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.7'
scsibus0:
        0,0,0     0) '' '' '' NON CCS Disk
        0,1,0     1) *
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *

And at the same time, dmesg gets the following:

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

... and the last 5 lines repeat until the machine is rebooted.

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 2
ICH2: not 100%% native mode: will probe irqs later
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
Uniform CD-ROM driver Revision: 3.12

This DMA timeout appeared in about 2.4.21 (the drive worked fine with
DMA before that) and as the same IDE driveers are used in 2.6, it's in
2.6 too. It may be confusing the kernel when the reset happens during
SG_IO.

Notice that I do not have CD-writer, just a normal IDE CD that I'm
trying to see with cdrecord -scanbus.

-- 
Meelis Roos (mroos@linux.ee)

