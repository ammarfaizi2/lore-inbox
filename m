Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264038AbTE3Wcq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 18:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbTE3Wcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 18:32:46 -0400
Received: from [65.198.37.67] ([65.198.37.67]:24786 "EHLO gghcwest.com")
	by vger.kernel.org with ESMTP id S264038AbTE3Wco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 18:32:44 -0400
Date: Fri, 30 May 2003 15:46:03 -0700
From: Jeffrey Baker <jwbaker@acm.org>
To: linux-kernel@vger.kernel.org
Subject: Different geometry settings for identical drives
Message-ID: <20030530224603.GA21297@heat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having some IDE troubles on 2.4.21-rc3 on amd64
platform.  The problem is I've got these two drives:

hda: WDC WD1200JB-75CRA0, ATA DISK drive
blk: queue ffffffff80442aa0, no I/O memory limit
hdc: WDC WD1200JB-75CRA0, ATA DISK drive
hdd: MATSHITA CR-177, ATAPI CD/DVD-ROM drive
blk: queue ffffffff80443238, no I/O memory limit
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: setmax LBA 234441648, native  234375000
hda: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=232514/16/63, UDMA(100)
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: setmax LBA 234441648, native  234375000
hdc: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=232514/16/63, UDMA(100)
hdd: attached ide-cdrom driver.
hdd: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)

which are configured identically in the BIOS and recognized identically
at bootup, but the geometry is getting setup differently:

prime:~# hdparm /dev/hda /dev/hdc | grep geometry
 geometry     = 14589/255/63, sectors = 234375000, start = 0
 geometry     = 35906/16/63, sectors = 234375000, start = 0
prime:~# cat /proc/ide/ide0/hda/geometry 
physical     232514/16/63
logical      14589/255/63
prime:~# cat /proc/ide/ide1/hdc/geometry 
physical     232514/16/63
logical      232514/16/63

The result is that hda works fine but hdc doesn't.  When I try to mke2fs
on the latter I see:

hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=234441583, sector=232343808

You can see that LBAsect (234441583) is higher than the "native" sectors
quoted by the kernel (234375000, difference 66583 sectors).  Why are
these two disks being addressed differently?  

IDE controller is AMD 8111.

Cheers,
jwb
