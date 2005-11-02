Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbVKBBme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbVKBBme (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 20:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVKBBme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 20:42:34 -0500
Received: from dvhart.com ([64.146.134.43]:7082 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932144AbVKBBmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 20:42:33 -0500
Date: Tue, 01 Nov 2005 17:41:41 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>,
       Joel Schopp <jschopp@austin.ibm.com>
Cc: Mel Gorman <mel@csn.ul.ie>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <214340000.1130895665@[10.10.2.4]>
In-Reply-To: <43681100.1000603@yahoo.com.au>
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie><20051031055725.GA3820@w-mikek2.ibm.com><4365BBC4.2090906@yahoo.com.au> <20051030235440.6938a0e9.akpm@osdl.org> <27700000.1130769270@[10.10.2.4]> <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au> <4367D71A.1030208@austin.ibm.com> <43681100.1000603@yahoo.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The numbers I have seen show that performance is decreased. People
> like Ken Chen spend months trying to find a 0.05% improvement in
> performance. Not long ago I just spent days getting our cached
> kbuild performance back to where 2.4 is on my build system.

Ironically, we're currently trying to chase down a 'database benchmark'
regression that seems to have been cause by the last round of "let's
rewrite the scheduler again" (more details later). Nick, you've added an 
awful lot of complexity to some of these code paths yourself ... seems 
ironic that you're the one complaining about it ;-)

>>> Sure. In what form, we haven't agreed. I vote zones! :)
>> 
>> 
>> I'd like to hear more details of how zones would be less complex while 
>> still solving the problem.  I just don't get it.
>> 
> 
> You have an extra zone. You size that zone at boot according to the
> amount of memory you need to be able to free. Only easy-reclaim stuff
> goes in that zone.
> 
> It is less complex because zones are a complexity we already have to
> live with. 99% of the infrastructure is already there to do this.
> 
> If you want to hot unplug memory or guarantee hugepage allocation,
> this is the way to do it. Nobody has told me why this *doesn't* work.

Because the zone is statically sized, and you're back to the same crap
we had with 32bit systems of splitting ZONE_NORMAL and ZONE_HIGHMEM,
effectively. Define how much you need for system ram, and how much
for easily reclaimable memory at boot time. You can't - it doesn't work.

M.

