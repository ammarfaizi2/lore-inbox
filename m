Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286350AbRL0Qvo>; Thu, 27 Dec 2001 11:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286349AbRL0Qve>; Thu, 27 Dec 2001 11:51:34 -0500
Received: from fepF.post.tele.dk ([195.41.46.135]:39866 "EHLO
	fepF.post.tele.dk") by vger.kernel.org with ESMTP
	id <S286357AbRL0QvR>; Thu, 27 Dec 2001 11:51:17 -0500
Date: Thu, 27 Dec 2001 17:51:05 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>, Daniel Stodden <stodden@in.tum.de>,
        linux-kernel@vger.kernel.org
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Message-ID: <20011227175105.E1730@suse.de>
In-Reply-To: <20011227155403.A1730@suse.de> <E16JdbY-00061d-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16JdbY-00061d-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27 2001, Alan Cox wrote:
> > retries belong at the low level, once you pass up info of failure to the
> > upper layers it's fatal. time for FS to shut down.
> 
> Thats definitely not the case. Just because your file system is too dumb to
> use the information please don't assume everyone elses isnt - in fact one
> of the side properties of Daniel Phillips stuff is that it should be able
> to sanely handle a bad block problem.

That's ok too, the fs can do whatever it wants in case of I/O failure.
It's not up to the fs to reissue failed requests, _that's_ stupid.

> EVMS, MD, multipath all need to know about and do their own bad block 
> handling. If the block driver knows how to recover stuff then great it
> can recover it, but we should ensure its possible for the fs internals
> to recover and work around a bad block. 

Need to know, fine I'm not arguing with that. I don't want to hide
information from anyone.

> > Irk, software managed bad block remapping is horrible.
> 
> IBM have it working, so however horrible doesn't matter that much, someone
> has done the work for you.

Then it must be The Right Thing.

I've written a block driver that handles (or wants to) bad block
remapping too, which just made me even more sure that this is definitely
a hw issue.

-- 
Jens Axboe

