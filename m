Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267734AbUHUUAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267734AbUHUUAK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 16:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267727AbUHUUAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 16:00:10 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:33959 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267734AbUHUUAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 16:00:03 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.6.8.1-mm3
Date: Sat, 21 Aug 2004 15:59:41 -0400
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040820031919.413d0a95.akpm@osdl.org> <20040820115541.3e68c5be.akpm@osdl.org> <20040820200248.GJ11200@holomorphy.com>
In-Reply-To: <20040820200248.GJ11200@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408211559.41655.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 20, 2004 4:02 pm, William Lee Irwin III wrote:
> Parallel compilation is an extremely poor benchmark in general, as the
> workload is incapable of being effectively scaled to system sizes, the
> linking phase is inherently unparallelizable and the compilation phase
> too parallelizable to actually stress anything. There is also precisely
> zero relevance the benchmark has to anything real users would do.

I disagree.  Although I wouldn't expect to try and optimize the system for a 
'make -j 2048', it's important that things not suck when several users do 
'make -j 16' since that *is* a very common operation on machines like this 
(though hopefully the runtime is dominated not by compiles but by actual 
application runs).

> It sounds like good news to me. The fact we boot at all instead
> of spinning in perpetuity on spinlocks in interrupt context is
> very good news to me, with a large added bonus of actually making
> forward progress on workloads hitting global locks we've taken
> steps to mitigate the locking overhead of.

Yep, I'm very excited about this.  It makes working with such systems to 
improve other things infinitely easier (i.e. possible).

> I suppose the unfortunate thing is that we didn't discover anything
> new at all, apart from quantifying certain things, e.g. how effective
> the RCU improvements have been. IIRC that question was unanswered after
> the last round, apart from (maybe) that things stopped livelocking.

Well, this isn't a very good benchmark for discovering things that we don't 
already know (e.g. dcache and RCU issues).  Now that things appear to be 
working however, we can start doing more realistic benchmarks.

> I suppose another way to answer the question of what's going on is to
> fiddle with ia64's implementation of profile_pc(). I suspect something
> like this may reveal the offending codepaths.

Looks interesting.  I'll see if it works next week.

Jesse
