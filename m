Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265439AbUEUHyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265439AbUEUHyA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 03:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265441AbUEUHx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 03:53:59 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61397 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265439AbUEUHxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 03:53:55 -0400
Date: Fri, 21 May 2004 09:53:42 +0200
From: Jens Axboe <axboe@suse.de>
To: FabF <Fabian.Frederick@skynet.be>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.6-mm4-ff1] I/O context isolation
Message-ID: <20040521075342.GP1952@suse.de>
References: <1085124268.8064.15.camel@bluerhyme.real3> <40ADB20C.8090204@yahoo.com.au> <1085125564.8071.23.camel@bluerhyme.real3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085125564.8071.23.camel@bluerhyme.real3>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21 2004, FabF wrote:
> On Fri, 2004-05-21 at 09:38, Nick Piggin wrote:
> > FabF wrote:
> > > Jens,
> > > 
> > > 	Here's ff1 patchset to have generic I/O context.
> > > ff1 : Export io context operations from blkdev/ll_rw_blk (ok)
> > > ff2 : Make io_context generic plateform by importing IO stuff from
> > > as_io.
> > > 
> > 
> > Can I just ask why you want as_io_context in generic code?
> > It is currently nicely hidden away in as-iosched.c where
> > nobody else needs to ever see it.
> I do want I/O context to be generic not the whole as_io.
> That export should bring:
> 	-All elevators to use io_context

For?

> 	-source tree to be more self-explanatory
> 	-have a stronger elevator interface

Those aren't real arguments :-)

> > > 	AFAICS, cfq_queue for instance could disappear when using io_context
> > > but I think elv_data should remain elevator side....
> > > I don't want to go in the wild here so if you've got suggestions, don't
> > > hesitate ;)
> > > 
> > 
> > cfq_queue is per-queue-per-process. io_context is just
> > per-process, so it isn't a trivial replacement.
> But I guess we can merge that stuff to have "a one way, one place" code
> rather than repeat code in all elv.

That's another pit fall, don't design for a need that isn't there. Using
io contexts in cfq does not get any easier with the code moved to
iocontext.c file, it's fine where it is.

-- 
Jens Axboe

