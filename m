Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267766AbUHUUZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267766AbUHUUZD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 16:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267787AbUHUUZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 16:25:02 -0400
Received: from holomorphy.com ([207.189.100.168]:21376 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267766AbUHUUYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 16:24:39 -0400
Date: Sat, 21 Aug 2004 13:24:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm3
Message-ID: <20040821202435.GA1510@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040820031919.413d0a95.akpm@osdl.org> <20040820115541.3e68c5be.akpm@osdl.org> <20040820200248.GJ11200@holomorphy.com> <200408211559.41655.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408211559.41655.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 20, 2004 4:02 pm, William Lee Irwin III wrote:
>> Parallel compilation is an extremely poor benchmark in general, as the
>> workload is incapable of being effectively scaled to system sizes, the
>> linking phase is inherently unparallelizable and the compilation phase
>> too parallelizable to actually stress anything. There is also precisely
>> zero relevance the benchmark has to anything real users would do.

On Sat, Aug 21, 2004 at 03:59:41PM -0400, Jesse Barnes wrote:
> I disagree.  Although I wouldn't expect to try and optimize the system for a 
> 'make -j 2048', it's important that things not suck when several users do 
> 'make -j 16' since that *is* a very common operation on machines like this 
> (though hopefully the runtime is dominated not by compiles but by actual 
> application runs).

Yet this criterion involves no performance metric; if it were a
benchmark it would quantify performance in a meaningful, reproducible,
and cross-system comparable way. AFAICT it's just being used as a
stress test for the dcache RCU issue.


On Friday, August 20, 2004 4:02 pm, William Lee Irwin III wrote:
>> It sounds like good news to me. The fact we boot at all instead
>> of spinning in perpetuity on spinlocks in interrupt context is
>> very good news to me, with a large added bonus of actually making
>> forward progress on workloads hitting global locks we've taken
>> steps to mitigate the locking overhead of.

On Sat, Aug 21, 2004 at 03:59:41PM -0400, Jesse Barnes wrote:
> Yep, I'm very excited about this.  It makes working with such systems to 
> improve other things infinitely easier (i.e. possible).

Stress test again...


On Friday, August 20, 2004 4:02 pm, William Lee Irwin III wrote:
>> I suppose the unfortunate thing is that we didn't discover anything
>> new at all, apart from quantifying certain things, e.g. how effective
>> the RCU improvements have been. IIRC that question was unanswered after
>> the last round, apart from (maybe) that things stopped livelocking.

On Sat, Aug 21, 2004 at 03:59:41PM -0400, Jesse Barnes wrote:
> Well, this isn't a very good benchmark for discovering things that we don't 
> already know (e.g. dcache and RCU issues).  Now that things appear to be 
> working however, we can start doing more realistic benchmarks.

I'll be happy to see those happen instead of kernel compiles. =)


On Friday, August 20, 2004 4:02 pm, William Lee Irwin III wrote:
>> I suppose another way to answer the question of what's going on is to
>> fiddle with ia64's implementation of profile_pc(). I suspect something
>> like this may reveal the offending codepaths.

On Sat, Aug 21, 2004 at 03:59:41PM -0400, Jesse Barnes wrote:
> Looks interesting.  I'll see if it works next week.

I can take it for a spin here to make sure it does the right thing.


-- wli
