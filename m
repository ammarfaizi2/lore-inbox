Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUFGJyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUFGJyX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 05:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUFGJyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 05:54:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:980 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264377AbUFGJyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 05:54:17 -0400
Date: Mon, 7 Jun 2004 11:54:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Who has record no. of  DriveReady SeekComplete DataRequest errors?
Message-ID: <20040607095408.GH13836@suse.de>
References: <200406060007.10150.kernel@kolivas.org> <200406071918.16166.kernel@kolivas.org> <20040607093622.GG13836@suse.de> <200406071950.55511.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406071950.55511.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07 2004, Con Kolivas wrote:
> On Mon, 7 Jun 2004 19:36, Jens Axboe wrote:
> > On Mon, Jun 07 2004, Con Kolivas wrote:
> > > On Mon, 7 Jun 2004 17:24, Jens Axboe wrote:
> > > > On Mon, Jun 07 2004, Con Kolivas wrote:
> > > > > hdd: status error: status=0x59 { DriveReady SeekComplete DataRequest
> > > > > Error } hdd: status error: error=0x20LastFailedSense 0x02
> > > > > hdd: drive not ready for command
> > > > > hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest
> > > > > } hdd: status error: error=0x00
> > > > > ..etc
> > > >
> > > > Con, please try with this debug patch.
> > >
> > > Here is the output:
> > > hdd: RICOH CD-R/RW MP7163A, ATAPI CD/DVD-ROM drive
> > > ide1 at 0x170-0x177,0x376 on irq 15
> > > hda: max request size: 1024KiB
> > > hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=16383/255/63,
> > > UDMA(100) hda: hda1 hda2 < hda5 hda6 hda7 >
> > > hdb: max request size: 1024KiB
> > > hdb: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=16383/255/63,
> > > UDMA(100) hdb: hdb2 < hdb5 hdb6 hdb7 >
> > > ide-cd: queueing cdb: 5a 00 2a 00 00 00 00 00 18 00 00 00
> > > ide-cd: queueing cdb: 46 00 00 28 00 00 00 00 10 00 00 00
> > > ide-cd: queueing cdb: 5a 00 03 00 00 00 00 00 10 00 00 00
> > > ide-cd: queueing cdb: 5a 00 2c 00 00 00 00 00 10 00 00 00
> > > ide-cd: queueing cdb: 46 00 00 20 00 00 00 00 18 00 00 00
> > > hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
> > > Uniform CD-ROM driver Revision: 3.20
> > > ide-cd: queueing cdb: 00 00 00 00 00 00 00 00 00 00 00 00
> > > ide-cd: queueing cdb: 25 00 00 00 00 00 00 00 00 00 00 00
> > > ide-cd: queueing cdb: 43 02 00 00 00 00 00 00 04 00 00 00
> > > ide-cd: queueing cdb: 5a 00 2a 00 00 00 00 00 18 00 00 00
> > > ide-cd: queueing cdb: 46 00 00 28 00 00 00 00 10 00 00 00
> > > hdd: status error: status=0x59 { DriveReady SeekComplete DataRequest
> > > Error } hdd: status error: error=0x20LastFailedSense 0x02
> > > hdd: drive not ready for command
> >
> > Hmm, that is GET_CONFIGURATION with CDF_MRW as the feature - that must
> > have gone away if you disabled cdrom_is_mrw in ide-cd like I suggested,
> > did you botch that test?
> 
> I'm hopeless but not _that_ hopeless I hope.

I don't see how that command gets generated if you commented out
cdrom_is_mrw() in ide-cd. It's the only place we call it, and it's the
only place that issues that command...

> > Can you check if this changes the behaviour for you (should apply on -bk
> > as well):
> 
> no such luck
> 
> Uniform CD-ROM driver Revision: 3.20
> hdd: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hdd: status error: error=0x20LastFailedSense 0x02
> hdd: drive not ready for command
> hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> hdd: status error: error=0x00
> hdd: drive not ready for command
> hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> hdd: status error: error=0x00
> hdd: drive not ready for command
> hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> hdd: status error: error=0x00
> hdd: DMA disabled

Can you repeat with the debug cdrom_queue_packet_command() patch still
applied? Thanks!

-- 
Jens Axboe

