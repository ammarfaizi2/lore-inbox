Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313057AbSDCF1D>; Wed, 3 Apr 2002 00:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313058AbSDCF0x>; Wed, 3 Apr 2002 00:26:53 -0500
Received: from www.wen-online.de ([212.223.88.39]:57606 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S313057AbSDCF0s>;
	Wed, 3 Apr 2002 00:26:48 -0500
Date: Wed, 3 Apr 2002 07:28:42 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: -aa VM splitup
In-Reply-To: <20020402212517.C26986@dualathlon.random>
Message-ID: <Pine.LNX.4.10.10204030653220.649-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2002, Andrea Arcangeli wrote:

> As you can see the write/read raw performance is the same, dominated
> only by raw disk speed. I'm not sure how can you write or read to disk
> faster with 2.4.6. Also note that raw speed with total cache trashing is
> quite unrelated to the VM if balance_dirty()/bdflush works sanely.
> 
> One thing that cames to mind is the fact the old 2.4.6 balance_dirty()
> was passing over .ndirty buffers before breaking the loop, now we stop
> much earlier, so we may take less advantage of some cpu cache doing so,
> that may matter on slow cpu machines, for my box clearly doesn't matter.

Hmm.  Could it have something to do with the 1k blocksize?

> Are you sure the 15% of performance you're talking about isn't your disk
> that keeps writing when your workload finishes? I mean, see the sync
> time, it decreases because the latest kernels have lower bdflush sync
> percentages, that's normal and expected. You should take the sync time
> into account too of course. If you want the level of dirty buffers in
> the system to be larger you only need to tweak bdflush, the default has
> to be conservative to be fair with the users that are only reading.

The 15% delta was between 2.4.19-pre5 and 2.4.19-pre5aa1.  The move
a tree around test may not be a particularly wonderful test though.
(Bonnie, known to be less than wonderful test, shows no difference)

> The difference between 2.4.6 and the latest VM code should kick in when
> the VM really starts to matter.

My disk throughput loss has nothing to do with the VM change I think.
I thought your flush changes would give me more, just as my flush
changes to 2.4.6 did.  Alas, it didn't pan out.

> It is possible that your read/write mixed workload gets the elevator
> into the equation too. But the most important thing is that raw
> read/write speed with total cache trashing is fast, and that's the case,
> so whatever involvement with mixed read/write load it has to be only an
> elevator thing or a bdflush tuning parameter changable via sysctl.
> 
> Andrea

	-Mike

