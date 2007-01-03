Return-Path: <linux-kernel-owner+w=401wt.eu-S932151AbXACW0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbXACW0m (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 17:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbXACW0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 17:26:42 -0500
Received: from brick.kernel.dk ([62.242.22.158]:9897 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932151AbXACW0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 17:26:41 -0500
Date: Wed, 3 Jan 2007 23:29:31 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Nick Piggin <npiggin@suse.de>
Subject: Re: [PATCH] 4/4 block: explicit plugging
Message-ID: <20070103222930.GL11203@kernel.dk>
References: <20070103082202.GG11203@kernel.dk> <98F3657447CE934E9ADA3A348D854FB602858A4F@scsmsx414.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98F3657447CE934E9ADA3A348D854FB602858A4F@scsmsx414.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03 2007, Chen, Kenneth W wrote:
> Jens Axboe wrote on Wednesday, January 03, 2007 12:22 AM
> > > Do you have any benchmarks which got faster with these changes?
> > 
> > On the hardware I have immediately available, I see no regressions wrt
> > performance. With instrumentation it's simple to demonstrate that most
> > of the queueing activity of an io heavy benchmark spends less time in
> > the kernel (most merging activity takes place outside of the queue
> lock,
> > hence queueing is lock free).
> > 
> > I've asked Ken to run this series on some of his big iron, I hope
> he'll
> > have some results for us soonish.
> 
> We are having some trouble with the patch set that some of our fiber
> channel
> host controller doesn't initialize properly anymore and thus lost whole
> bunch
> of disks (somewhere around 200 disks out of 900) at boot time.
> Presumably FC
> loop initialization command are done through block layer etc.  I haven't
> looked into the problem closely.
> 
> Jens, I assume the spin lock bug in __blk_run_queue is fixed in this
> patch
> set?

It is. Are you still seeing problems after the initial mail exchange we
had prior to christmas, or are you referencing that initial problem?

It's not likely to be a block layer issue, more likely the SCSI <->
block interactions. If you mail me a new dmesg (if your problem is with
the __blk_run_queue() fixups), I can take a look. Otherwise please do
test with the __blk_run_queue() fixup, just use the current patchset.

-- 
Jens Axboe

