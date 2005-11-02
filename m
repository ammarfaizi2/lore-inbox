Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbVKBPCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbVKBPCL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 10:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbVKBPCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 10:02:11 -0500
Received: from dvhart.com ([64.146.134.43]:26795 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S965057AbVKBPCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 10:02:10 -0500
Date: Wed, 02 Nov 2005 07:02:03 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Dave Hansen <haveblue@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Mel Gorman <mel@csn.ul.ie>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <255360000.1130943722@[10.10.2.4]>
In-Reply-To: <43688B74.20002@yahoo.com.au>
References: <4366C559.5090504@yahoo.com.au>	 <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au>	 <Pine.LNX.4.58.0511011014060.14884@skynet> <20051101135651.GA8502@elte.hu>	 <1130854224.14475.60.camel@localhost> <20051101142959.GA9272@elte.hu>	 <1130856555.14475.77.camel@localhost> <20051101150142.GA10636@elte.hu>	 <1130858580.14475.98.camel@localhost> <20051102084946.GA3930@elte.hu>	 <436880B8.1050207@yahoo.com.au> <1130923969.15627.11.camel@localhost> <43688B74.20002@yahoo.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I agree enough on concept that I think we can go implement at least a
>> demonstration of how easy it is to perform.
>> 
>> There are a couple of implementation details that will require some
>> changes to the current zone model, however.  Perhaps you have some
>> suggestions on those.
>> 
>> In which zone do we place hot-added RAM?  I don't think answer can
>> simply be the HOTPLUGGABLE zone.  If you start with sufficiently small
>> of a machine, you'll degrade into the same horrible HIGHMEM behavior
>> that a 64GB ia32 machine has today, despite your architecture.  Think of
>> a machine that starts out with a size of 256MB and grows to 1TB.
>> 
> 
> What can we do reasonably sanely? I think we can drive about 16GB of
> highmem per 1GB of normal fairly well. So on your 1TB system, you
> should be able to unplug 960GB RAM.

I think you need to talk to some more users trying to run 16GB ia32
systems. Feel the pain.
 
> Lower the ratio to taste if you happen to be doing something
> particularly zone normal intensive - remember in that case the frag
> patches won't buy you anything more because a zone normal intensive
> workload is going to cause unreclaimable regions by definition.
> 
>> So, if you have to add to NORMAL/DMA on the fly, how do you handle a
>> case where the new NORMAL/DMA ram is physically above
>> HIGHMEM/HOTPLUGGABLE?  Is there any other course than to make a zone
>> required to be able to span other zones, and be noncontiguous?  Would
>> that represent too much of a change to the current model?
>> 
> 
> Perhaps. Perhaps it wouldn't be required to get a solution that is
> "good enough" though.
> 
> But if you can reclaim your ZONE_RECLAIMABLE, then you could reclaim
> it all and expand your normal zones into it, bottom up.

Can we quit coming up with specialist hacks for hotplug, and try to solve
the generic problem please? hotplug is NOT the only issue here. Fragmentation
in general is.


