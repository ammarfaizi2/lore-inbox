Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266736AbTBYEda>; Mon, 24 Feb 2003 23:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266755AbTBYEda>; Mon, 24 Feb 2003 23:33:30 -0500
Received: from holomorphy.com ([66.224.33.161]:24244 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266736AbTBYEdY>;
	Mon, 24 Feb 2003 23:33:24 -0500
Date: Mon, 24 Feb 2003 20:42:36 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Larry McVoy <lm@work.bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225044236.GB10396@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
References: <2080000.1045947731@[10.10.2.4]> <20030222231552.GA31268@work.bitmover.com> <3610000.1045957443@[10.10.2.4]> <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]> <20030224065826.GA5665@work.bitmover.com> <20030224075142.GA10396@holomorphy.com> <20030224154725.GB5665@work.bitmover.com> <20030224233638.GS10411@holomorphy.com> <20030225002309.GA12146@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225002309.GA12146@work.bitmover.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> The changes are getting measured. By and large if it's slower on UP
>> it's rejected. 

On Mon, Feb 24, 2003 at 04:23:09PM -0800, Larry McVoy wrote:
> Suppose I have an application which has a working set which just exactly
> fits in the I+D caches, including the related OS stuff.
> Someone makes some change to the OS and the benchmark for that change is
> smaller than the I+D caches but the change increased the I+D cache space
> needed. 
> The benchmark will not show any slowdown, correct?
> My application no longer fits and will suffer, correct?

Well, it's often clear from the code whether it'll have a larger cache
footprint or not, so it's probably not that large a problem. OTOH it is
a real problem that little cache or TLB profiling is going on. I tried
once or twice and actually came up with a function or two that should
be inlined instead of uninlined in very short order. Much low-hanging
fruit could be gleaned from those kinds profiles.

It's also worthwhile noting increased cache footprints are actually
very often degradations on SMP and especially NUMA. The notion that
optimizing for SMP and/or NUMA involves increasing cache footprint
on anything doesn't really sound plausible, though I'll admit that
the mistake of trusting microbenchmarks too far on SMP has probably
already been committed at least once. Userspace owns the cache; using
cache for the kernel is "cache pollution", which should be minimized.
Going too far out on the space end of time/space tradeoff curves is
every bit as bad for SMP as UP, and really horrible for NUMA.


On Mon, Feb 24, 2003 at 04:23:09PM -0800, Larry McVoy wrote:
> The point is that if you are putting SMP changes into the system, you
> have to be held to a higher standard for measurement given the past
> track record of SMP changes increasing code length and cache footprints.
> So "measuring" doesn't mean "it's not slower on XYZ microbenchmark".
> It means "under the following work loads the cache misses went down or
> stayed the same for before and after tests".

This kind of measurement is actually relatively unusual. I'm definitely
interested in it, as there appear to be some deficits wrt. locality of
reference that show up as big profile spikes on NUMA boxen. With care
exercised good solutions should also trim down cache misses on UP also.
Cache and TLB miss profile driven development sounds very attractive.


On Mon, Feb 24, 2003 at 04:23:09PM -0800, Larry McVoy wrote:
> And if you said that all changes should be held to this standard, not
> just scaling changes, I'd agree with you.  But scaling changes are the
> "bad guy" in my mind, they are not to be trusted, so they should be held
> to this standard first.  If we can get everyone to step up to this bat,
> that's all to the good.

Let me put it this way: IBM sells tiny boxen too, from 4x, to UP, to
whatever. And people are simultaneously actively trying to scale
downward to embedded bacteria or whatever. So the small systems are
being neither ignored nor sacrificed for anything else.


-- wli
