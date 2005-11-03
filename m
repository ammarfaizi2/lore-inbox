Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbVKCDTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbVKCDTv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 22:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbVKCDTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 22:19:51 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:55987 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030307AbVKCDTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 22:19:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=R+MbiV65AjERR2kRfiDSRNd7Po4GYOLSQRiRENpOZxa9eqPkboq5klZoeI9xtw8S6hd0D0m1PPeGJhvd2Xtkwt3/ZRydDbs260xhEqMiFlWFLlu5wgV2PD+uWchdn8/1XRgw31h4U/UTs8chTPxUoehMF1Ag5DDAZdGQgn6F3GE=  ;
Message-ID: <4369824E.2020407@yahoo.com.au>
Date: Thu, 03 Nov 2005 14:21:50 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Mel Gorman <mel@csn.ul.ie>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <4366C559.5090504@yahoo.com.au>	 <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au>	 <Pine.LNX.4.58.0511011014060.14884@skynet> <20051101135651.GA8502@elte.hu>	 <1130854224.14475.60.camel@localhost> <20051101142959.GA9272@elte.hu>	 <1130856555.14475.77.camel@localhost> <20051101150142.GA10636@elte.hu>	 <1130858580.14475.98.camel@localhost> <20051102084946.GA3930@elte.hu>	 <436880B8.1050207@yahoo.com.au> <1130923969.15627.11.camel@localhost> <43688B74.20002@yahoo.com.au> <255360000.1130943722@[10.10.2.4]>
In-Reply-To: <255360000.1130943722@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

>>What can we do reasonably sanely? I think we can drive about 16GB of
>>highmem per 1GB of normal fairly well. So on your 1TB system, you
>>should be able to unplug 960GB RAM.
> 
> 
> I think you need to talk to some more users trying to run 16GB ia32
> systems. Feel the pain.
>  

OK, make it 8GB then.

And as a bonus we get all you IBM guys back on the case again
to finish the job that was started on highmem :)

And as another bonus, you actually *have* the capability to unplug
memory or use hugepages exactly the size you require, which is not the
case with the frag patches.

>>But if you can reclaim your ZONE_RECLAIMABLE, then you could reclaim
>>it all and expand your normal zones into it, bottom up.
> 
> 
> Can we quit coming up with specialist hacks for hotplug, and try to solve
> the generic problem please? hotplug is NOT the only issue here. Fragmentation
> in general is.
> 

Not really it isn't. There have been a few cases (e1000 being the main
one, and is fixed upstream) where fragmentation in general is a problem.
But mostly it is not.

Anyone who thinks they can start using higher order allocations willy
nilly after Mel's patch, I'm fairly sure they're wrong because they are
just going to be using up the contiguous regions.

Trust me, if the frag patches were a general solution that solved the
generic fragmentation problem I would be a lot less concerned about the
complexity they introduce. But even then it only seems to be a problem
that a very small number of users care about.

Anyway I keep saying the same things (sorry) so I'll stop now.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
