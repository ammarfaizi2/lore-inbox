Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264389AbUFGKRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUFGKRj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 06:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264385AbUFGKRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 06:17:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19164 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264389AbUFGKRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 06:17:37 -0400
Date: Mon, 7 Jun 2004 12:17:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Who has record no. of  DriveReady SeekComplete DataRequest errors?
Message-ID: <20040607101732.GI13836@suse.de>
References: <200406060007.10150.kernel@kolivas.org> <200406071950.55511.kernel@kolivas.org> <20040607095408.GH13836@suse.de> <200406072008.07176.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406072008.07176.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07 2004, Con Kolivas wrote:
> On Mon, 7 Jun 2004 19:54, Jens Axboe wrote:
> > I don't see how that command gets generated if you commented out
> > cdrom_is_mrw() in ide-cd. It's the only place we call it, and it's the
> > only place that issues that command...
> 
> Ok I get the picture :P

:)

> > Can you repeat with the debug cdrom_queue_packet_command() patch still
> > applied? Thanks!
> 
> Here's the whole shebang in case I miss something:
> 
> hdd: RICOH CD-R/RW MP7163A, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: max request size: 1024KiB
> hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
>  hda: hda1 hda2 < hda5 hda6 hda7 >
> hdb: max request size: 1024KiB
> hdb: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
>  hdb: hdb2 < hdb5 hdb6 hdb7 >
> ide-cd: queueing cdb: 5a 00 2a 00 00 00 00 00 18 00 00 00
> ide-cd: queueing cdb: 46 00 00 28 00 00 00 00 08 00 00 00
> ide-cd: queueing cdb: 46 00 00 28 00 00 00 00 44 00 00 00
> ide-cd: queueing cdb: 5a 00 03 00 00 00 00 00 10 00 00 00
> ide-cd: queueing cdb: 5a 00 2c 00 00 00 00 00 10 00 00 00
> ide-cd: queueing cdb: 46 00 00 20 00 00 00 00 18 00 00 00
> hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> ide-cd: queueing cdb: 00 00 00 00 00 00 00 00 00 00 00 00
> ide-cd: queueing cdb: 25 00 00 00 00 00 00 00 00 00 00 00
> ide-cd: queueing cdb: 43 02 00 00 00 00 00 00 04 00 00 00
> ide-cd: queueing cdb: 5a 00 2a 00 00 00 00 00 18 00 00 00
> ide-cd: queueing cdb: 46 00 00 28 00 00 00 00 08 00 00 00
> hdd: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hdd: status error: error=0x20LastFailedSense 0x02
> hdd: drive not ready for command

So that didn't help at all... Hmm I wonder what to do about this. So
last failure was NOT_READY - does it make a difference if you have a
medium loaded or not?

-- 
Jens Axboe

