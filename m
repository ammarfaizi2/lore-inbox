Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267968AbTBYPUx>; Tue, 25 Feb 2003 10:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267970AbTBYPUx>; Tue, 25 Feb 2003 10:20:53 -0500
Received: from [195.223.140.107] ([195.223.140.107]:48006 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267968AbTBYPUv>;
	Tue, 25 Feb 2003 10:20:51 -0500
Date: Tue, 25 Feb 2003 16:32:13 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dejan Muhamedagic <dejan@hello-penguin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vm issues (2)
Message-ID: <20030225153213.GI29467@dualathlon.random>
References: <20030225131328.A8651@smp.colors.kwc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225131328.A8651@smp.colors.kwc>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 01:13:28PM +0100, Dejan Muhamedagic wrote:
> Hello,
> 
> The new kernel 2.4.21-pre4aa3 is running now, but the box behaves
> similarly.  It still swaps quite a lot and much more than the rmap
> vm.  Both servers are under the same load.
> 
> One difference is the amount of free memory:
> 
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in cs  us  sy  id
> aa:
>  0  7  0 5773620 202416 118076 2069716 5330 746  5330   766 4845 5597  12  14  74
> rmap:
>  0  0  0 3498044  13572   4144 4754596  74   0    75     6  642 598   5   3  92
> 
> The aa kernel keeps ~200MB out of 6GB of memory unused.  I'm not
> sure, but if we could reduce it perhaps there would be much less
> swapping.  Is there a way to achieve this?

that is a feature, it guarantees highmem unfreeable allocations like
pagetables can't eat all your normal zone. You can reduce the 200MB with
this boot command:

	lower_zone_reserve=256,256

As to decrease the swapping I just told you how to do that tweaking
vm_mapped_ratio.

> 
> Another notable difference between the two vm versions is that the
> rmap vm maintains about 80% of memory on the active list and the
> aa vm much less: between 4% and 12%.  The rmap vm must use more
> CPU, but these servers have a lot of processing power so it is not
> noticeable.

the theory was that rmap would reduce the cpu utilization but of course
the patch don't do juts rmap.

Andrea
