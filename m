Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264294AbRFDOk6>; Mon, 4 Jun 2001 10:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264295AbRFDOks>; Mon, 4 Jun 2001 10:40:48 -0400
Received: from [194.128.63.73] ([194.128.63.73]:30119 "EHLO
	fuspcnjc.culham.ukaea.org.uk") by vger.kernel.org with ESMTP
	id <S264294AbRFDOkm>; Mon, 4 Jun 2001 10:40:42 -0400
Message-ID: <3B1B9E8E.B91A021E@ukaea.org.uk>
Date: Mon, 04 Jun 2001 15:43:26 +0100
From: Neil Conway <nconway.list@ukaea.org.uk>
Organization: UKAEA Fusion
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE corruption, 2.2, VIA chipset in PIO mode
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary:  we got IDE trashage in PIO mode with a VIA 686A IDE chipset,
using 2.2.12-20smp (RH6.1 stock).

Disk is an IBM 75GXP 75GB, mobo is Gigabyte GA-6VXDC7 (IIRC).

Story: had the system hooked up with SCSI disk, needed more disk space,
had IBM EIDE handy, stuck it in, no UDMA cable handy so used 40pin
cable.  Verified with hdparm that disk was using UDMA mode 2 (rather
than 3 or 4 which would have needed the 80pin cable).

Because it was an IDE disk in a box with a SCSI system disk, I made a
little /ideboot partition (50 megs or so) and avoided LILO hassles by
parking the kernel+initrd on that.  Rest of disk was just /data
partition.

Used for a while, copied about 7gigs onto it.  Then got lots of BadCRC
errors when reading from disk (from dma_intr).  Decided to disable DMA
as a result of this...  

Sometime later tried to reboot, couldn't.  Closer examination showed the
/ideboot partition was hosed.  No worries, we thought, it's just been
screwed by the DMA being on earlier.  So, I just rebuilt /ideboot (a
little optimistic of me) and got it booting again, and then compared
files on /data with the original data files.  When they failed to match,
I decided to blitz the whole lot, repartition both partitions and remake
the fs's (still thinking at this point that the main cause was the
original 7 gigs of copying while DMA was enabled).

All of this rebuilding was done in PIO mode.

So, having recopied the data onto the disk again, sometime later one of
us reboots it, and hey presto, it doesn't reboot, and yes, it's due to
the little partition /ideboot being hosed again (illegal triply indirect
blocks, bad inodes etc...).

So, I'm now left thinking that this final failure (and thus by inference
maybe the others too) really can't have been caused by DMA problems...

(The only little caveat is that when I blitzed the lot, rebuilding the
partition table and both filesystems, I didn't wipe out the entire boot
sector/cylinder, so in principle some tiny vestigial memories of the
corruption might have persisted??)

I've searched the web, and found plenty of people suffering from broken
DMA on the VIA chipsets, but no clear reports of PIO breakage.

It does seem incredible that a chipset could fail to work reliably in
PIO mode, but it's either that, or the 2.2.12-20smp kernel, or a broken
disk or motherboard.  Given VIA's apparent flakiness, the chipset seems
like a good candidate for suspicion...

Anyone out there got the answers?

Neil
PS: 2.2.12-20smp - argh puke, but not my machine so not my kernel
choice...
