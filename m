Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265462AbUEUILm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265462AbUEUILm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 04:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265426AbUEUILm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 04:11:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21211 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265462AbUEUILj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 04:11:39 -0400
Date: Fri, 21 May 2004 10:11:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: FabF <Fabian.Frederick@skynet.be>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.6-mm4-ff1] I/O context isolation
Message-ID: <20040521081137.GR1952@suse.de>
References: <1085124268.8064.15.camel@bluerhyme.real3> <40ADB20C.8090204@yahoo.com.au> <1085125564.8071.23.camel@bluerhyme.real3> <40ADB671.8060904@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ADB671.8060904@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21 2004, Nick Piggin wrote:
> FabF wrote:
> >On Fri, 2004-05-21 at 09:38, Nick Piggin wrote:
> >
> >>FabF wrote:
> >>
> >>>Jens,
> >>>
> >>>	Here's ff1 patchset to have generic I/O context.
> >>>ff1 : Export io context operations from blkdev/ll_rw_blk (ok)
> >>>ff2 : Make io_context generic plateform by importing IO stuff from
> >>>as_io.
> >>>
> >>
> >>Can I just ask why you want as_io_context in generic code?
> >>It is currently nicely hidden away in as-iosched.c where
> >>nobody else needs to ever see it.
> >
> >I do want I/O context to be generic not the whole as_io.
> >That export should bring:
> >	-All elevators to use io_context
> >	-source tree to be more self-explanatory
> >	-have a stronger elevator interface
> >
> 
> Sorry, my mistake. as_io_context is not nicely hidden away at
> the moment. I can't remember why, I think it is only needed
> for the declaration... I'll look into moving it into as-iosched.c
> 
> *But*, io_context is already exported to all elevators and generic
> code.

That was my initial complaint about it as well, however solving it makes
it even more ugly I think. It's a layering violation. I guess with a
simply ->dtor and ->exit + io_private_data it would be fine, but I'd say
don't bother now (it's 2.6.6).

-- 
Jens Axboe

