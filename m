Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314578AbSEFQly>; Mon, 6 May 2002 12:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314571AbSEFQlx>; Mon, 6 May 2002 12:41:53 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:29756 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314562AbSEFQlv>; Mon, 6 May 2002 12:41:51 -0400
Date: Mon, 6 May 2002 18:42:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler gives big boost to tbench 192
Message-ID: <20020506184253.B31998@dualathlon.random>
In-Reply-To: <20020506042005.A18792@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2002 at 04:20:05AM -0400, rwhron@earthlink.net wrote:
> > BTW, Randy, I seen my tree runs slower with tiobench, that's probably
> > because I made the elevator anti-starvation logic more aggressive than
> > mainline and the other kernel trees (to help interactive usage), could
> > you try to run tiobench on -aa after elvtune -r 8192 -w 16384
> > /dev/hd[abcd] to verify? Thanks for the great benchmarking effort.
> 
> I will have results on the big machine in a couple days.  On the 
> small machine, elvtune increases tiobench sequential reads by
> 30-50%, and lowers worst case latency a little.

ok, everything is fine then, thanks for the further benchmarks. Not sure
if I should increase the elvtune defaults, the max latency with 8
reading threads literally doubles (from a mean of 500/600 to 1200). OTOH
with 128 threads max latency even decreases (most probably because of
higher mean throughput).

> > And for the reason fork is faster in -aa that's partly thanks to the
> > reschedule-child-first logic, that can be easily merged in mainline,
> > it's just in 2.5.
> 
> Is that part of parent_timeslice patch?  parent_timeslice helped 

Yep.

> fork a little when I tried to isolating patches to find what
> makes fork faster in -aa.  It is more than one patch as far as 
> I can tell.
> 
> On uniprocessor the unixbench execl test, all -aa kernel's going back 
> at least to 2.4.15aa1 are about 20% faster than other trees, even those 
> like jam and akpm's splitted vm.  Fork in -aa for more "real world" 
> test (autoconf build) is about 8-10% over other kernel trees.
> 
> On quad Xeon, with bigger L2 cache, autoconf (fork test) the difference
> between mainline and -aa is smaller.  The -aa based VMs in aa, jam, and
> mainline have about 15% edge over rmap VM in ac and rmap.  jam has a
> slight advantage for autoconf build, possibly because of O(1) effect
> which is more likely to show up since more processes execute
> on the 4 way box.
> 
> More quad Xeon at:
> http://home.earthlink.net/~rwhron/kernel/bigbox.html
> 
> 
> -- 
> Randy Hron


Andrea
