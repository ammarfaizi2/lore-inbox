Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbULHHJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbULHHJI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 02:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbULHHJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 02:09:07 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:7101 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262040AbULHHIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 02:08:48 -0500
Subject: Re: Time sliced CFQ io scheduler
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041208065534.GF3035@suse.de>
References: <20041202130457.GC10458@suse.de>
	 <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org>
	 <20041202195232.GA26695@suse.de> <20041208003736.GD16322@dualathlon.random>
	 <1102467253.8095.10.camel@npiggin-nld.site>
	 <20041208013732.GF16322@dualathlon.random>
	 <20041207180033.6699425b.akpm@osdl.org>  <20041208065534.GF3035@suse.de>
Content-Type: text/plain
Date: Wed, 08 Dec 2004 18:08:39 +1100
Message-Id: <1102489719.8095.56.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 07:55 +0100, Jens Axboe wrote:
> On Tue, Dec 07 2004, Andrew Morton wrote:
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > >
> > > The desktop is ok with "as" simply because it's
> > >  normally optimal to stop writes completely
> > 
> > AS doesn't "stop writes completely".  With the current settings it
> > apportions about 1/3 of the disk's bandwidth to writes.
> > 
> > This thing Jens has found is for direct-io writes only.  It's a bug.
> 
> Indeed. It's a special case one, but nasty for that case.
> 
> > The other problem with AS is that it basically doesn't work at all with a
> > TCQ depth greater than four or so, and lots of people blindly look at
> > untuned SCSI benchmark results without realising that.  If a distro is
> 
> That's pretty easy to fix. I added something like that to cfq, and it's
> not a lot of lines of code (grep for rq_in_driver and cfq_max_depth).
> 
> > always selecting CFQ then they've probably gone and deoptimised all their
> > IDE users.  
> 
> Andrew, AS has other issues, it's not a case of AS always being faster
> at everything.
> 
> > AS needs another iteration of development to fix these things.  Right now
> > it's probably the case that we need CFQ or deadline for servers and AS for
> > desktops.   That's awkward.
> 
> Currently I think the time sliced cfq is the best all around. There's
> still a few kinks to be shaken out, but generally I think the concept is
> sounder than AS.
> 

But aren't you basically unconditionally allowing a 4ms idle time after
reads? The complexity of AS (other than all the work we had to do to get
the block layer to cope with it), is getting it to turn off at (mostly)
the right times. Other than that, it is basically the deadline
scheduler.

I could be wrong, but it looks like you'll just run into the same sorts
of performance problems as AS initially had.


