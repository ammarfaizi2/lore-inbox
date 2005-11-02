Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVKBCCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVKBCCQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 21:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbVKBCCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 21:02:16 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:11651 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932174AbVKBCCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 21:02:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=rh+17lkVVHPrCztnCTgfRRosT6aQo80ADtdkuzIo+XrtQqo2I1M7Ctc6HAg+O31uj/FcWg0JSFb+4JzJagGwqU0MH0ONPXW2CXMrDaUirWmloXJRTVjtvUGqOaQaRrOU1b/OlgplXS/Y3re0AsXR7PY3bXgoSZq/xPl9nu8+4p8=  ;
Message-ID: <43681E89.8070905@yahoo.com.au>
Date: Wed, 02 Nov 2005 13:03:53 +1100
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
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie><20051031055725.GA3820@w-mikek2.ibm.com><4365BBC4.2090906@yahoo.com.au> <20051030235440.6938a0e9.akpm@osdl.org> <27700000.1130769270@[10.10.2.4]> <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au> <4367D71A.1030208@austin.ibm.com> <43681100.1000603@yahoo.com.au> <214340000.1130895665@[10.10.2.4]>
In-Reply-To: <214340000.1130895665@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>The numbers I have seen show that performance is decreased. People
>>like Ken Chen spend months trying to find a 0.05% improvement in
>>performance. Not long ago I just spent days getting our cached
>>kbuild performance back to where 2.4 is on my build system.
> 
> 
> Ironically, we're currently trying to chase down a 'database benchmark'
> regression that seems to have been cause by the last round of "let's
> rewrite the scheduler again" (more details later). Nick, you've added an 
> awful lot of complexity to some of these code paths yourself ... seems 
> ironic that you're the one complaining about it ;-)
> 

Yeah that's unfortunate, but I think a large portion of the problem
(if they are anything the same) has been narrowed down to some over
eager wakeup balancing for which there are a number of proposed
patches.

But in this case I was more worried about getting the groundwork done
for handling the multicore multicore systems that everyone will soon
be using rather than several % performance regression on TPC-C (not
to say that I don't care about that at all)... I don't see the irony.

But let's move this to another thread if it is going to continue. I
would be happy to discuss scheduler problems.

>>You have an extra zone. You size that zone at boot according to the
>>amount of memory you need to be able to free. Only easy-reclaim stuff
>>goes in that zone.
>>
>>It is less complex because zones are a complexity we already have to
>>live with. 99% of the infrastructure is already there to do this.
>>
>>If you want to hot unplug memory or guarantee hugepage allocation,
>>this is the way to do it. Nobody has told me why this *doesn't* work.
> 
> 
> Because the zone is statically sized, and you're back to the same crap
> we had with 32bit systems of splitting ZONE_NORMAL and ZONE_HIGHMEM,
> effectively. Define how much you need for system ram, and how much
> for easily reclaimable memory at boot time. You can't - it doesn't work.
> 

You can't what? What doesn't work? If you have no hard limits set,
then the frag patches can't guarantee anything either.

You can't have it both ways. Either you have limits for things or
you don't need any guarantees. Zones handle the former case nicely,
and we currently do the latter case just fine (along with the frag
patches).

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
