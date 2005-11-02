Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVKBCvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVKBCvd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 21:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVKBCvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 21:51:32 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:39303 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932236AbVKBCvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 21:51:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=LjjeF5wmIGSixvRPeHNLlqmY5dYuhQPn97ZqKEv9AW7uVFXMskr2gKChd9sPQWL6KmgHtGtwOwnvp5EJPfTYsXUrNjR9H5qhQH8DD9Tq3565EzP8wCgHsDb3tBybfK/tKzuLldUbuTPkVLCd0xjZJI9FPGoOEwahDVg1TbqOcV8=  ;
Message-ID: <43682940.3020200@yahoo.com.au>
Date: Wed, 02 Nov 2005 13:49:36 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: Joel Schopp <jschopp@austin.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie><20051031055725.GA3820@w-mikek2.ibm.com><4365BBC4.2090906@yahoo.com.au> <20051030235440.6938a0e9.akpm@osdl.org> <27700000.1130769270@[10.10.2.4]> <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au> <4367D71A.1030208@austin.ibm.com> <43681100.1000603@yahoo.com.au> <214340000.1130895665@[10.10.2.4]> <43681E89.8070905@yahoo.com.au> <216280000.1130898244@[10.10.2.4]>
In-Reply-To: <216280000.1130898244@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

>>But let's move this to another thread if it is going to continue. I
>>would be happy to discuss scheduler problems.
> 
> 
> My point was that most things we do add complexity to the codebase,
> including the things you do yourself ... I'm not saying the we're worse
> off for the changes you've made, by any means - I think they've been
> mostly beneficial.

Heh - I like the "mostly" ;)

> I'm just pointing out that we ALL do it, so let us
> not be too quick to judge when others propose adding something that does ;-)
> 

What I'm getting worried about is the marked increase in the
rate of features and complexity going in.

I am almost certainly never going to use memory hotplug or
demand paging of hugepages. I am pretty likely going to have
to wade through this code at some point in the future if it
is merged.

It is also going to slow down my kernel by maybe 1% when
doing kbuilds, but hey let's not worry about that until we've
merged 10 more such slowdowns (ok that wasn't aimed at you or
Mel, but my perception of the status quo).

> 
>>You can't what? What doesn't work? If you have no hard limits set,
>>then the frag patches can't guarantee anything either.
>>
>>You can't have it both ways. Either you have limits for things or
>>you don't need any guarantees. Zones handle the former case nicely,
>>and we currently do the latter case just fine (along with the frag
>>patches).
> 
> 
> I'll go look through Mel's current patchset again. I was under the
> impression it didn't suffer from this problem, at least not as much
> as zones did.
> 

Over time, I don't think it can offer any stronger a guarantee
than what we currently have. I'm not even sure that it would be
any better at all for problematic workloads as time -> infinity.

> Nothing is guaranteed. You can shag the whole machine and/or VM in
> any number of ways ... if we can significantly improve the probability 
> of existing higher order allocs working, and new functionality has
> an excellent probability of success, that's as good as you're going to 
> get. Have a free "perfect is the enemy of good" Linus quote, on me ;-)
> 

I think it falls down if these higher order allocations actually
get *used* for anything. You'll simply be going through the process
of replacing your contiguous, easy-to-reclaim memory with pinned
kernel memory.

However, for the purpose of memory hot unplug, a new zone *will*
guarantee memory can be reclaimed and unplugged.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
