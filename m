Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262387AbSJVJnO>; Tue, 22 Oct 2002 05:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262389AbSJVJnO>; Tue, 22 Oct 2002 05:43:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23980 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262387AbSJVJnN>;
	Tue, 22 Oct 2002 05:43:13 -0400
Date: Tue, 22 Oct 2002 11:49:11 +0200
From: Jens Axboe <axboe@suse.de>
To: Suparna Bhattacharya <suparna@sparklet.in.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.44: lkcd (9/9): dump driver and build files
Message-ID: <20021022094911.GE30597@suse.de>
References: <200210211016.g9LAG5J21214@nakedeye.aparity.com> <20021021172112.C14993@sgi.com> <pan.2002.10.22.20.35.36.992053.2611@sparklet.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2002.10.22.20.35.36.992053.2611@sparklet.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22 2002, Suparna Bhattacharya wrote:
> On Mon, 21 Oct 2002 19:43:20 +0530, Christoph Hellwig wrote:
> 
> 
> >> +
> >> +	if ((dump_bio = kmalloc(sizeof(struct bio), GFP_KERNEL)) == NULL) { +
> >> 	DUMP_PRINTF("Cannot allocate bio\n"); +		retval = -ENOMEM;
> >> +		goto err2;
> >> +	}
> > 
> > Shouldn't you use the generic bio allocator?
> > 
> 
> Not sure that this should come from the bio mempool. Objects
> allocated from the mem pool are expected to be released back to
> the pool within a reasonable period (after i/o is done), which is
> not quite the case here.
> 
> Dump preallocates the bio early when configured and holds on to 
> it all through the time the system is up (avoids allocs at 
> actual dump time). Doesn't seem like the right thing to hold
> on to a bio mempool element that long.

Definitely, one must not use the bio pool for long term allocations.

-- 
Jens Axboe

