Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267686AbTBYFvm>; Tue, 25 Feb 2003 00:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267688AbTBYFvm>; Tue, 25 Feb 2003 00:51:42 -0500
Received: from holomorphy.com ([66.224.33.161]:43700 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267686AbTBYFvk>;
	Tue, 25 Feb 2003 00:51:40 -0500
Date: Mon, 24 Feb 2003 22:00:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Larry McVoy <lm@work.bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225060053.GC10396@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
References: <3610000.1045957443@[10.10.2.4]> <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]> <20030224065826.GA5665@work.bitmover.com> <20030224075142.GA10396@holomorphy.com> <20030224154725.GB5665@work.bitmover.com> <20030224233638.GS10411@holomorphy.com> <20030225002309.GA12146@work.bitmover.com> <20030225044236.GB10396@holomorphy.com> <20030225045404.GA26831@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225045404.GA26831@work.bitmover.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> This kind of measurement is actually relatively unusual. I'm definitely
>> interested in it, as there appear to be some deficits wrt. locality of
>> reference that show up as big profile spikes on NUMA boxen. With care
>> exercised good solutions should also trim down cache misses on UP also.
>> Cache and TLB miss profile driven development sounds very attractive.

On Mon, Feb 24, 2003 at 08:54:04PM -0800, Larry McVoy wrote:
> Again, I'm with you all the way on this.  If the scale up guys can adopt
> this as a mantra, I'm a lot less concerned that anything bad will happen.

I don't know about mantras, but we're getting to the point where lock
contention is a non-issue on midrange SMP and straight line efficiency
is beyond the range of "obviously it should be done some other way."
The time to chase cache pollution is certainly coming.


On Mon, Feb 24, 2003 at 08:54:04PM -0800, Larry McVoy wrote:
> Tim at OSDL and I have been talking about trying to work out some benchmarks
> to test for this.  I came up with the idea of adding a "-s XXX" which means
> "touch XXX bytes between each iteration" to each LMbench test.  One problem
> is the lack of page coloring will make the numbers bounce around too much.
> We talked that over with Linus and he suggested using the big TLB hack to
> get around that.  Assuming we can deal with the page coloring, do you think
> that there is any merit in taking microbenchmarks, adding an artificial
> working set, and running those?

Page coloring needs to get into the kernel at some point. Using large
TLB entries will artificially tie this to TLB effects and fragmentation,
in addition to pagetable space conservation (on x86 anyway). So I really
don't see any way to deal with reproducibility issues on this front but
just doing page coloring. Everything else that does it as a side effect
would unduly disturb the results, IMHO.


At some point in the past, I wrote:
>> Let me put it this way: IBM sells tiny boxen too, from 4x, to UP, to
>> whatever. And people are simultaneously actively trying to scale
>> downward to embedded bacteria or whatever. 

On Mon, Feb 24, 2003 at 08:54:04PM -0800, Larry McVoy wrote:
> That's really great, I know it's a lot less sexy but it's important.
> I'd love to see as much attention on making Linux work on tiny embedded
> platforms as there is on making it work on big iron.  Small is cool too.

There is, unfortunately the participation in the development cycle of
embedded vendors is not as visible as it is with large system vendors.
More direct, frequent, and vocal input from embedded kernel hackers
would be very valuable, as many "corner cases" with automatic kernel
scaling should occur on the small end, not just the large end.

I've had some brief attempts to explain to me the motives and methods
of embedded system vendors and the like, but I've failed to absorb
enough to get a "big picture" or much of any notion as to why embedded
kernel hackers aren't participating as much in the development cycle.

On the large system side, it's very clear that issues in the core VM
and other parts of the kernel must be addressed to achieve the goals,
and hence participation in the development cycle is outright mandatory.
It's not "working effectively". It's a requirement. And part of that
"requirement" bit is we have to work with constraints never enforced
before, including maintaining the scalability curve on the low end.

It's hard, and probably not impossible, but absolutely required.


-- wli
