Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265133AbUD3MST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265133AbUD3MST (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 08:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265168AbUD3MST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 08:18:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20868 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265133AbUD3MSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 08:18:14 -0400
Date: Fri, 30 Apr 2004 14:18:03 +0200
From: Jens Axboe <axboe@suse.de>
To: FabF <Fabian.Frederick@skynet.be>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.6-rc3] as-io isolation ?
Message-ID: <20040430121801.GW2150@suse.de>
References: <1083183861.4618.13.camel@bluerhyme.real3> <40904EAA.6010501@yahoo.com.au> <1083253117.4624.3.camel@bluerhyme.real3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083253117.4624.3.camel@bluerhyme.real3>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29 2004, FabF wrote:
> On Thu, 2004-04-29 at 02:39, Nick Piggin wrote:
> > FabF wrote:
> > > Hi,
> > > 
> > > 	Here's a patch _idea_ to isolate anticipatory I/O from normal I/O
> > > scheduler process by adding a specific put io context method so that
> > > ll_rw_blk stuff could be as-iosched transparent.I guess we could point
> > > as iosched exit instead of exit_io_context as well ...
> > 
> > Hi,
> > This makes ll_rw_blk.c aware of an AS specific function though.
> > as-iosched.c is actually a CONFIG option under CONFIG_EMBEDDED.
> > What is the actual problem?
> 
> AFAICS cfq and other elevators don't interact with ll_rw stuff (?)

Hmm? That looks like nonsense. AS/CFQ/deadline/etc all use the same
interface between the block layer and driver. AS is the only in-tree
user of io contexts, the implementation is open for other additions as
well though.

> but we could release something like the asio later so I was thinking
> about somekind of abstraction within ll_rw.This abstraction would
> require the patch ad hoc as well as a specific exit point.

I think you have to explain yourself a bit more clearly. The patch, as
posted, doesn't make much sense to me. It's making it a lot worse.

If you want to isolate the entire anticipation from AS to be used
generically, then you are going about it the wrong way. I'd suggest
thinking a lot harder about how anticipation interacts with the various
entry points into the io scheduler. And then see if you can isolate that
successfully, then apply it to eg CFQ, and then post something when you
are happy with how it panned out.

I don't think it's a bad idea at all, in fact I originally wanted it
implemented this way.

-- 
Jens Axboe

