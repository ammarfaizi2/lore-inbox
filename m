Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbSKWTHz>; Sat, 23 Nov 2002 14:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267044AbSKWTHz>; Sat, 23 Nov 2002 14:07:55 -0500
Received: from va.cs.wm.edu ([128.239.2.31]:23562 "EHLO va.cs.wm.edu")
	by vger.kernel.org with ESMTP id <S267043AbSKWTHx>;
	Sat, 23 Nov 2002 14:07:53 -0500
Date: Sat, 23 Nov 2002 14:15:04 -0500
From: Bruce Lowekamp <lowekamp@CS.WM.EDU>
To: linux-kernel@vger.kernel.org
Subject: enabling AMD_PM768 causes boot hang in 2.4.20-rc3
Message-ID: <6320000.1038078904@localhost.localdomain>
X-Mailer: Mulberry/3.0.0a5 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With a dual-processor A7M266-D MB (two AMD XP-MP 1900+), enabling 
CONFIG_AMD_PM768 causes the machine to hang on boot.

I don't think this is a major concern for the release because the 
description of this parameter includes EXPERIMENTAL (although it is not 
flagged to be selectable on when experimental options are enabled).

A few details:  The kernel is booted with noapic (has always hung 
otherwise).  It hangs right after listing the drives and ide interfaces, 
and right before it prints out the geometry of the first drive.  This is 
the output prior to hanging:

    ide9: BM-DMA at 0x4408-0x440f, BIOS settings: hds:pio, hdt:pio
hda: IC35L120AVVA07-0, ATA DISK drive
hdc: IC35L120AVVA07-0, ATA DISK drive
hde: IC35L120AVVA07-0, ATA DISK drive
hdf: IC35L120AVVA07-0, ATA DISK drive
hdg: IC35L120AVVA07-0, ATA DISK drive
hdh: IC35L120AVVA07-0, ATA DISK drive
hdi: IC35L120AVVA07-0, ATA DISK drive
hdj: IC35L120AVVA07-0, ATA DISK drive
hdk: IC35L120AVVA07-0, ATA DISK drive
hdl: IC35L120AVVA07-0, ATA DISK drive
hdn: ASUS CD-S520/A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xb400-0xb407,0xb002 on irq 11
ide3 at 0xa800-0xa807,0xa402 on irq 11
ide4 at 0x9800-0x9807,0x9402 on irq 10
ide5 at 0x9000-0x9007,0x8802 on irq 10
ide6 at 0x7400-0x7407,0x7002 on irq 10
blk: queue c0394184, I/O limit 4095Mb (mask 0xffffffff)
<HANG>

(I'm extracting this output from a working 2.4.20-rc3 compiled without 
AMD_PM768.  The output is the same except that the last line says queue 
c03941e4 instead of the value above.)

The next line should have been:
hda: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=239340/16/63, 
UDMA(100)

ide0 is a
AMD7441: IDE controller on PCI bus 00 dev 39
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
AMD7441: disabling single-word DMA support (revision < C4)
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio

I'll be happy to help if someone needs more debugging information.

Bruce



