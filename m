Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbVKBEjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbVKBEjM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 23:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbVKBEjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 23:39:12 -0500
Received: from dvhart.com ([64.146.134.43]:18858 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1751492AbVKBEjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 23:39:11 -0500
Date: Tue, 01 Nov 2005 20:39:16 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Joel Schopp <jschopp@austin.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <217570000.1130906356@[10.10.2.4]>
In-Reply-To: <43682940.3020200@yahoo.com.au>
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie><20051031055725.GA3820@w-mikek2.ibm.com><4365BBC4.2090906@yahoo.com.au> <20051030235440.6938a0e9.akpm@osdl.org> <27700000.1130769270@[10.10.2.4]> <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au> <4367D71A.1030208@austin.ibm.com> <43681100.1000603@yahoo.com.au> <214340000.1130895665@[10.10.2.4]> <43681E89.8070905@yahoo.com.au> <216280000.1130898244@[10.10.2.4]> <43682940.3020200@yahoo.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm just pointing out that we ALL do it, so let us
>> not be too quick to judge when others propose adding something that does ;-)
> 
> What I'm getting worried about is the marked increase in the
> rate of features and complexity going in.
> 
> I am almost certainly never going to use memory hotplug or
> demand paging of hugepages. I am pretty likely going to have
> to wade through this code at some point in the future if it
> is merged.

Mmm. Though whether any one of us will personally use each feature
is perhaps not the most ideal criteria to judge things by ;-)

> It is also going to slow down my kernel by maybe 1% when
> doing kbuilds, but hey let's not worry about that until we've
> merged 10 more such slowdowns (ok that wasn't aimed at you or
> Mel, but my perception of the status quo).

If it's really 1%, yes, that's a huge problem. And yes, I agree with
you that there's a problem with the rate of change. Part of that is
a lack of performance measurement and testing, and the quality sometimes
scares me (though the last month has actually been significantly better,
the tree mostly builds and boots now!). I've tried to do something on 
the testing front, but I'm acutely aware it's not sufficient by any means.

>>> You can't what? What doesn't work? If you have no hard limits set,
>>> then the frag patches can't guarantee anything either.
>>> 
>>> You can't have it both ways. Either you have limits for things or
>>> you don't need any guarantees. Zones handle the former case nicely,
>>> and we currently do the latter case just fine (along with the frag
>>> patches).
>> 
>> I'll go look through Mel's current patchset again. I was under the
>> impression it didn't suffer from this problem, at least not as much
>> as zones did.
> 
> Over time, I don't think it can offer any stronger a guarantee
> than what we currently have. I'm not even sure that it would be
> any better at all for problematic workloads as time -> infinity.

Sounds worth discussing. We need *some* way of dealing with fragmentation
issues. To me that means both an avoidance strategy, and an ability
to actively defragment if we need it. Linux is evolved software, it
may not be perfect at first - that's the way we work, and it's served
us well up till now. To me, that's the biggest advantage we have over
the proprietary model.

>> Nothing is guaranteed. You can shag the whole machine and/or VM in
>> any number of ways ... if we can significantly improve the probability 
>> of existing higher order allocs working, and new functionality has
>> an excellent probability of success, that's as good as you're going to 
>> get. Have a free "perfect is the enemy of good" Linus quote, on me ;-)
> 
> I think it falls down if these higher order allocations actually
> get *used* for anything. You'll simply be going through the process
> of replacing your contiguous, easy-to-reclaim memory with pinned
> kernel memory.

It seems inevitable that we need both physically contiguous memory
sections, and virtually contiguous in kernel space (which equates to
the same thing, unless we totally break the 1-1 P-V mapping and
lose the large page mapping for kernel, which I'd hate to do.)
 
> However, for the purpose of memory hot unplug, a new zone *will*
> guarantee memory can be reclaimed and unplugged.

It's not just about memory hotplug. There are, as we have discussed
already, many usage for physically contiguous (and virtually contiguous)
memory segments. Focusing purely on any one of them will not solve the
issue at hand ...

M.
