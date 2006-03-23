Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWCWIJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWCWIJZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 03:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWCWIJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 03:09:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:59172 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030193AbWCWIJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 03:09:24 -0500
Date: Thu, 23 Mar 2006 09:09:26 +0100
From: Jens Axboe <axboe@suse.de>
To: "Ryan M." <kubisuro@att.net>
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: -mm merge plans
Message-ID: <20060323080925.GP4285@suse.de>
References: <20060322205305.0604f49b.akpm@osdl.org> <4422554D.6000602@att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4422554D.6000602@att.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23 2006, Ryan M. wrote:
> Hello,
> 
> Andrew Morton wrote:
> > A look at the -mm lineup for 2.6.17:
> >
> 
> >
> > mm-implement-swap-prefetching.patch
> > mm-implement-swap-prefetching-fix.patch
> > mm-implement-swap-prefetching-tweaks.patch
> >
> >   Still don't have a compelling argument for this, IMO.
> 
> I hate to make a comparison based on the little information there is, 
> but Windows Vista will have something like prefetch, albeit, 
> exponentially more intrusive (read MS' explanation on their website). 
> However, when I see that such technology is being embraced by the 
> competitor to help improve the desktop (and it follows, the server 
> space) and I see this better, non-invasive solution nearly rejected, I 
> can't help but feel rather disappointed.
> 
> To prefetch applications from swap to physical memory when there is 
> little activity seems so obvious that I can't believe it hasn't been 
> implemented before.

It's a heuristic, and sometimes that will work well and sometimes it
will not. What if during this period of inactivity, you start bringing
everything in from swap again, only to page it right out because the
next memory hog starts running? From a logical standpoint, swap prefetch
and the vm must work closely together to avoid paging in things which
really aren't needed.

I've been running with the clockpro for the past week, which seems to
handle this sort of thing extremely well. On a 1GB machine, running the
vanilla kernels usually didn't see my use any swap. With the workload I
use, I typically had about ~100MiB of page cache and the rest of memory
full. Running clockpro, it's stabilized at ~288MiB of swap leaving me
more room for cache - with very rare paging activity going on. Hardly a
scientific test, but the feel is good.

-- 
Jens Axboe

