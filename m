Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbVKBBEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVKBBEm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 20:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVKBBEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 20:04:42 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:4720 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932121AbVKBBEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 20:04:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=dXzkUUE/7wD/QO7IUbPU+7NmLJ92iP2eBbAfAt9X1Nzjm00uvKqc4uSOtE+WKmgNFlAQWWbESRa7xOtwrq9rTABj1brGrSEXHP0UkaJBvMK4+hS1p7YuEs6kVa+qUM8U3HX+mk8+V3ruX33WWmT4FecF7GxRtigi4+hU1+i8ZTo=  ;
Message-ID: <43681100.1000603@yahoo.com.au>
Date: Wed, 02 Nov 2005 12:06:08 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Joel Schopp <jschopp@austin.ibm.com>
CC: Mel Gorman <mel@csn.ul.ie>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie><20051031055725.GA3820@w-mikek2.ibm.com><4365BBC4.2090906@yahoo.com.au> <20051030235440.6938a0e9.akpm@osdl.org> <27700000.1130769270@[10.10.2.4]> <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au> <4367D71A.1030208@austin.ibm.com>
In-Reply-To: <4367D71A.1030208@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Schopp wrote:

> The patches do ad a reasonable amount of complexity to the page 
> allocator.  In my opinion that is the only downside of these patches, 
> even though it is a big one.  What we need to decide as a community is 
> if there is a less complex way to do this, and if there isn't a less 
> complex way then is the benefit worth the increased complexity.
> 
> As to the non-zero performance cost, I think hard numbers should carry 
> more weight than they have been given in this area.  Mel has posted hard 
> numbers that say the patches are a wash with respect to performance.  I 
> don't see any evidence to contradict those results.
> 

The numbers I have seen show that performance is decreased. People
like Ken Chen spend months trying to find a 0.05% improvement in
performance. Not long ago I just spent days getting our cached
kbuild performance back to where 2.4 is on my build system.

I can simply see they will cost more icache, more dcache, more branches,
etc. in what is the hottest part of the kernel in some workloads (kernel
compiles, for one).

I'm sorry if I sound like a wet blanket. I just don't look at a patch
and think "wow all those 3 guys with Linux on IBM mainframes and using
lpars are going to be so much happier now, this is something we need".

>>> The will need high order allocations if we want to provide HugeTLB pages
>>> to userspace on-demand rather than reserving at boot-time. This is a
>>> future problem, but it's one that is not worth tackling until the
>>> fragmentation problem is fixed first.
>>>
>>
>> Sure. In what form, we haven't agreed. I vote zones! :)
> 
> 
> I'd like to hear more details of how zones would be less complex while 
> still solving the problem.  I just don't get it.
> 

You have an extra zone. You size that zone at boot according to the
amount of memory you need to be able to free. Only easy-reclaim stuff
goes in that zone.

It is less complex because zones are a complexity we already have to
live with. 99% of the infrastructure is already there to do this.

If you want to hot unplug memory or guarantee hugepage allocation,
this is the way to do it. Nobody has told me why this *doesn't* work.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
