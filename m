Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbULHKuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbULHKuf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 05:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbULHKuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 05:50:35 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:12691 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261179AbULHKu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 05:50:27 -0500
Date: Wed, 8 Dec 2004 11:49:18 +0100
From: Jens Axboe <axboe@suse.de>
To: Helge Hafting <helge.hafting@hist.no>
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: Time sliced CFQ io scheduler
Message-ID: <20041208104918.GO19522@suse.de>
References: <20041202130457.GC10458@suse.de> <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org> <20041202195232.GA26695@suse.de> <20041208003736.GD16322@dualathlon.random> <1102467253.8095.10.camel@npiggin-nld.site> <20041208013732.GF16322@dualathlon.random> <20041207180033.6699425b.akpm@osdl.org> <20041208065534.GF3035@suse.de> <41B6DCE8.5030304@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B6DCE8.5030304@hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08 2004, Helge Hafting wrote:
> >>AS needs another iteration of development to fix these things.  Right now
> >>it's probably the case that we need CFQ or deadline for servers and AS for
> >>desktops.   That's awkward.
> >>   
> >>
> >
> >Currently I think the time sliced cfq is the best all around. There's
> >still a few kinks to be shaken out, but generally I think the concept is
> >sounder than AS.
> > 
> >
> I wonder, would it make sense to add some limited anticipation
> to the cfq scheduler?  It seems to me that there is room to
> get some of the AS benefit without getting too unfair:
> 
> AS does a wait that is short compared to a seek, getting some
> more locality almost for free.  Consider if CFQ did this, with
> the added limitation that it only let a few extra read requests
> in this way before doing the next seek anyway.  For example,
> allowing up to 3 extra anticipated read requests before
> seeking could quadruple read bandwith in some cases.  This is
> clearly not as fair, but the extra reads will be almost free
> because those few reads take little time compared to the seek
> that follows anyway.  Therefore, the latency for other requests
> shouldn't change much and we get the best of both AS and CFQ.
> Or have I made a broken assumption?

This is basically what time sliced cfq does. For sync requests, cfq
allows a definable idle period where we give the process a chance to
submit a new request if it has enough time slice to do so. This
'anticipation' then is just an artifact of the design of time sliced
cfq, where we do assign a finite time period where a given process owns
the disk.

See my initial posting on time sliced cfq. That is why time sliced cfq
does as well (or better) then AS for the many client cases, while still
being fair.

-- 
Jens Axboe

