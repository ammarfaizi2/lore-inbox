Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbTEVNfq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 09:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTEVNfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 09:35:45 -0400
Received: from ns2.jaj.com ([66.93.21.106]:19643 "EHLO ns2.jaj.com")
	by vger.kernel.org with ESMTP id S261846AbTEVNfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 09:35:44 -0400
Date: Thu, 22 May 2003 09:48:47 -0400
From: Phil Edwards <phil@jaj.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 SMP, a PDC20269, and a huge Maxtor disk.  Am I doomed?
Message-ID: <20030522134847.GA20179@disaster.jaj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the aftermath of a horrible crash (one minute all was well, the next
minute all the active ext3 filesystems behaved like they'd been run through a
cheese grater), I've installed a 200GB Maxtor drive, and a Promise Ultra133
TX2 card to let me actually use all of it.

The mobo BIOS doesn't speak 48-bit LBA, so it sees a 137 GB drive.  That's
fine, I'm guessing, since (I'm told) Linux doesn't get its information
from the BIOS.

Windows 2000 sees the whole drive, and uses it with no problems.  (Using
Promise's supplied drivers.)  I mention this only to point out that there
doesn't /seem/ to be anything physically wrong with the drive, the card,
the cable, etc.

So, for starters:

Booting 2.4.20 with "ide2=0x10d8,0x10d2" lets me see the new drive, along
with a smaller drive on the same channel as slave:

    PDC20269: IDE controller on PCI bus 00 dev 48
    PDC20269: chipset revision 2
    PDC20269: not 100% native mode: will probe irqs later
    PDC20269: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
    PDC20269: FORCING BURST BIT 0x08 -> 0x09 ACTIVE
        ide2: BM-DMA at 0x10b0-0x10b7, BIOS settings: hde:pio, hdf:pio
    hde: Maxtor 6Y200P0, ATA DISK drive
    hdf: WDC WD600BB-00CAA1, ATA DISK drive
    ide2 at 0x10d8-0x10df,0x10d2 on irq 5
    blk: queue c037fdcc, I/O limit 4095Mb (mask 0xffffffff)
    hde: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(133)
    blk: queue c037ff18, I/O limit 4095Mb (mask 0xffffffff)
    hdf: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, UDMA(100)

Now, dmesg shows that both hde and hdf are in PIO mode, but hdparm -I
reports that the smaller/older drive is using udma5, and the huge drive
is using udma6.  Which is also what the PDC20269 card-BIOS reports during
system boot.  So I'm assuming that they really are using DMA.

The problem:

At seemingly random times, these occur:

    May 22 03:11:02 fenric kernel: hde: lost interrupt
    May 22 03:11:02 fenric kernel: hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }
    May 22 03:11:02 fenric kernel: hde: drive not ready for command

and

    May 22 04:34:11 fenric kernel: hde: write_intr error1: nr_sectors=1, stat=0x51
    May 22 04:34:11 fenric kernel: hde: write_intr: status=0x51 { DriveReady SeekComplete Error }
    May 22 04:34:11 fenric kernel: hde: write_intr: error=0x04 { DriveStatusError }

Which leads to all kinds of problems, especially ifit happens during boot
(system hangs).

Recall that this doesn't happen under win2k, so presumably (?) the hardware
is not at fault.

Anybody have any suggestions as to what I can do to prevent/solve this?
I will cheerfully give more information, and a summary writeup if I ever
get it working properly.


(Please cc me; I can't keep up with the list mail so I'm not subscribed.)

Phil

-- 
What you don't know can hurt you, only you won't know it.
