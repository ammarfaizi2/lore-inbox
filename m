Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbULHG4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbULHG4e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 01:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbULHG4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 01:56:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27803 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261991AbULHG42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 01:56:28 -0500
Date: Wed, 8 Dec 2004 07:55:34 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: Time sliced CFQ io scheduler
Message-ID: <20041208065534.GF3035@suse.de>
References: <20041202130457.GC10458@suse.de> <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org> <20041202195232.GA26695@suse.de> <20041208003736.GD16322@dualathlon.random> <1102467253.8095.10.camel@npiggin-nld.site> <20041208013732.GF16322@dualathlon.random> <20041207180033.6699425b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041207180033.6699425b.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07 2004, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > The desktop is ok with "as" simply because it's
> >  normally optimal to stop writes completely
> 
> AS doesn't "stop writes completely".  With the current settings it
> apportions about 1/3 of the disk's bandwidth to writes.
> 
> This thing Jens has found is for direct-io writes only.  It's a bug.

Indeed. It's a special case one, but nasty for that case.

> The other problem with AS is that it basically doesn't work at all with a
> TCQ depth greater than four or so, and lots of people blindly look at
> untuned SCSI benchmark results without realising that.  If a distro is

That's pretty easy to fix. I added something like that to cfq, and it's
not a lot of lines of code (grep for rq_in_driver and cfq_max_depth).

> always selecting CFQ then they've probably gone and deoptimised all their
> IDE users.  

Andrew, AS has other issues, it's not a case of AS always being faster
at everything.

> AS needs another iteration of development to fix these things.  Right now
> it's probably the case that we need CFQ or deadline for servers and AS for
> desktops.   That's awkward.

Currently I think the time sliced cfq is the best all around. There's
still a few kinks to be shaken out, but generally I think the concept is
sounder than AS.

-- 
Jens Axboe

