Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265317AbUHMNw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265317AbUHMNw1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 09:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265315AbUHMNw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 09:52:27 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32226 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265288AbUHMNvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 09:51:14 -0400
Date: Fri, 13 Aug 2004 15:50:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Chris Clayton <chris@theclaytons.giointernet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CDMRW in 2.6
Message-ID: <20040813135036.GR2663@suse.de>
References: <200408091625.31210.chris@theclaytons.giointernet.co.uk> <200408131253.49321.chris@theclaytons.giointernet.co.uk> <20040813115426.GN2663@suse.de> <200408131435.17362.chris@theclaytons.giointernet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408131435.17362.chris@theclaytons.giointernet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13 2004, Chris Clayton wrote:
> > > I'll try a full (as opposed to quick) blank with cdrwtool plus a
> > > forced format with cdmrw and report back when that has finished.
> >
> > Yes please do that, if that doesn't work it's really screwed.
> 
> Ok, here's the results:
> 
> [chris:~]$ cdrwtool -t 10 -d /dev/hdc -b full
> setting speed to 10
> using device /dev/hdc
> full blank
> 1386KB internal buffer
> setting write speed to 10x
> 
> <<no new messages from dmesg>>
> 
> [chris:~]$ cdmrw -d /dev/hdc -f full -F
> not a mrw formatted disc
> LBA space: DMA
> 
> <<no new messages from dmesg>>
> 
> [chris:~]$ while cdmrw -d /dev/hdc -f full | grep "mrw format running" ; do 
> sleep 20; done
> mrw format running
> <snip>
> mrw format running
> 
> <<no new messages from dmesg>>
> 
> [chris:~]$ mkudffs --media-type=cdrw /dev/hdc
> start=0, blocks=16, type=RESERVED
> start=16, blocks=3, type=VRS
> start=19, blocks=237, type=USPACE
> start=256, blocks=1, type=ANCHOR
> start=257, blocks=31, type=USPACE
> start=288, blocks=32, type=PVDS
> start=320, blocks=32, type=LVID
> start=352, blocks=32, type=STABLE
> start=384, blocks=1024, type=SSPACE
> start=1408, blocks=256480, type=PSPACE
> start=257888, blocks=31, type=USPACE
> start=257919, blocks=1, type=ANCHOR
> start=257920, blocks=160, type=USPACE
> start=258080, blocks=32, type=STABLE
> start=258112, blocks=32, type=RVDS
> start=258144, blocks=31, type=USPACE
> start=258175, blocks=1, type=ANCHOR
> 
> <<the following new messages from dmesg>>
> 
> cdrom: hdc: mrw address space DMA selected
> cdrom open: mrw_status 'mrw complete'
> hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> hdc: command error: error=0x54

Ok yes, same error. It's the drive doing something odd, I have no idea
what...

> I'll try the same process (except the blanking) with a brand new piece of 
> media and report when that is complete.

I doubt it'll help.

-- 
Jens Axboe

