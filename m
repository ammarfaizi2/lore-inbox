Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbVKBCYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVKBCYB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 21:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVKBCYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 21:24:01 -0500
Received: from dvhart.com ([64.146.134.43]:9642 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932217AbVKBCYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 21:24:00 -0500
Date: Tue, 01 Nov 2005 18:24:04 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Joel Schopp <jschopp@austin.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <216280000.1130898244@[10.10.2.4]>
In-Reply-To: <43681E89.8070905@yahoo.com.au>
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie><20051031055725.GA3820@w-mikek2.ibm.com><4365BBC4.2090906@yahoo.com.au> <20051030235440.6938a0e9.akpm@osdl.org> <27700000.1130769270@[10.10.2.4]> <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au> <4367D71A.1030208@austin.ibm.com> <43681100.1000603@yahoo.com.au> <214340000.1130895665@[10.10.2.4]> <43681E89.8070905@yahoo.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> The numbers I have seen show that performance is decreased. People
>>> like Ken Chen spend months trying to find a 0.05% improvement in
>>> performance. Not long ago I just spent days getting our cached
>>> kbuild performance back to where 2.4 is on my build system.
>> 
>> Ironically, we're currently trying to chase down a 'database benchmark'
>> regression that seems to have been cause by the last round of "let's
>> rewrite the scheduler again" (more details later). Nick, you've added an 
>> awful lot of complexity to some of these code paths yourself ... seems 
>> ironic that you're the one complaining about it ;-)
> 
> Yeah that's unfortunate, but I think a large portion of the problem
> (if they are anything the same) has been narrowed down to some over
> eager wakeup balancing for which there are a number of proposed
> patches.
> 
> But in this case I was more worried about getting the groundwork done
> for handling the multicore multicore systems that everyone will soon
> be using rather than several % performance regression on TPC-C (not
> to say that I don't care about that at all)... I don't see the irony.
> 
> But let's move this to another thread if it is going to continue. I
> would be happy to discuss scheduler problems.

My point was that most things we do add complexity to the codebase,
including the things you do yourself ... I'm not saying the we're worse
off for the changes you've made, by any means - I think they've been
mostly beneficial. I'm just pointing out that we ALL do it, so let us
not be too quick to judge when others propose adding something that does ;-)

>> Because the zone is statically sized, and you're back to the same crap
>> we had with 32bit systems of splitting ZONE_NORMAL and ZONE_HIGHMEM,
>> effectively. Define how much you need for system ram, and how much
>> for easily reclaimable memory at boot time. You can't - it doesn't work.
> 
> You can't what? What doesn't work? If you have no hard limits set,
> then the frag patches can't guarantee anything either.
> 
> You can't have it both ways. Either you have limits for things or
> you don't need any guarantees. Zones handle the former case nicely,
> and we currently do the latter case just fine (along with the frag
> patches).

I'll go look through Mel's current patchset again. I was under the
impression it didn't suffer from this problem, at least not as much
as zones did.

Nothing is guaranteed. You can shag the whole machine and/or VM in
any number of ways ... if we can significantly improve the probability 
of existing higher order allocs working, and new functionality has
an excellent probability of success, that's as good as you're going to 
get. Have a free "perfect is the enemy of good" Linus quote, on me ;-)

M.
