Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbTEZUYt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 16:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbTEZUYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 16:24:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29158 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262220AbTEZUYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 16:24:47 -0400
Date: Mon, 26 May 2003 22:38:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
Message-ID: <20030526203800.GP845@suse.de>
References: <1053976644.2298.194.camel@mulgrave> <Pine.LNX.4.44.0305261317520.12186-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305261317520.12186-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26 2003, Linus Torvalds wrote:
> 
> On 26 May 2003, James Bottomley wrote:
> >
> > On Mon, 2003-05-26 at 15:07, Jens Axboe wrote:
> > > Alright, so what do you need? Start out with X tags, shrink to Y (based
> > > on repeated queue full conditions)? Anything else?
> > 
> > Actually, it's easier than that: just an API to alter the number of tags
> > in the block layer (really only the size of your internal hash table). 
> > The actual heuristics of when to alter the queue depth is the province
> > of the individual drivers (although Doug Ledford was going to come up
> > with a generic implementation).
> 
> Talking about tagged queueing - does the SCSI layer still remove the
> request from the request list when it starts executing it?

Yes

> At least historically that's a major mistake, and generates a crappy 
> elevator, because it removes information from the block layer about where 
> the disk is (or is going to be).

Not necessarily, the io schedulers keep track of where we are going. You
don't need an active front request for that.

> I know Andrew thinks that SCSI tagged queuing is a bunch of crap, and he 
> has the latency numbers to prove it. He blames the SCSI disks themselves, 
> but I think it might be the fact that SCSI makes it impossible to make a 
> fair queuing algorithm for higher levels by hiding information.
> 
> Has anybody looked at just removing the request at command _completion_ 
> time instead? That's what IDE does, and it's the _right_ thing to do.

I know this is a pet peeve of yours (must be, I remember you bringing it
up at least 3 time before :), but I don't think that's necessarily true.
It shouldn't matter _one_ bit whether you leave the request there or
not, it's unmergeable. As long as the io scheduler keeps track of this
(and it does!) we are golden.

-- 
Jens Axboe

