Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264225AbUFFXHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264225AbUFFXHA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 19:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264208AbUFFXHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 19:07:00 -0400
Received: from mail014.syd.optusnet.com.au ([211.29.132.160]:36243 "EHLO
	mail014.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264228AbUFFXG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 19:06:57 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [OT] Who has record no. of  DriveReady SeekComplete DataRequest errors?
Date: Mon, 7 Jun 2004 09:06:46 +1000
User-Agent: KMail/1.6.1
Cc: Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <200406060007.10150.kernel@kolivas.org> <Pine.LNX.4.58.0406061408090.202@neptune.local> <20040606203942.GA20267@suse.de>
In-Reply-To: <20040606203942.GA20267@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406070906.46392.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2004 06:39, Jens Axboe wrote:
> I could easily imagine some vendors not setting the field, but setting
> it to some "buggy" value is far less likely. But might as well add the
> check.
>
> Con later confirmed that it was 2.6.2 that introduced the breakage, so
> the patch isn't the culprit after all. There are a few seperate things
> to look at there - Con, what are you doing when these messages trigger?
> Is the drive permanently mounted, or does it happen on open?

It only happens on boot and never again. During this part:
ICH4: IDE controller at PCI slot 0000:00:1f.1
ICH4: chipset revision 2
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST340014A, ATA DISK drive
hdb: ST340014A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: JLMS XJ-HD165H, ATAPI CD/DVD-ROM drive
hdd: RICOH CD-R/RW MP7163A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 >
hdb: max request size: 1024KiB
hdb: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 hdb: hdb2 < hdb5 hdb6 hdb7 >
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
hdd: status error: error=0x20LastFailedSense 0x02
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
..etc

I'll try that other patch when I get a chance later today.

Con
