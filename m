Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbVKCPvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbVKCPvs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbVKCPvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:51:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29123 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030354AbVKCPvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:51:47 -0500
Date: Thu, 3 Nov 2005 07:51:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Mel Gorman <mel@csn.ul.ie>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <1131032422.2839.8.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0511030747450.27915@g5.osdl.org>
References: <4366C559.5090504@yahoo.com.au>  <Pine.LNX.4.58.0511010137020.29390@skynet>
 <4366D469.2010202@yahoo.com.au>  <Pine.LNX.4.58.0511011014060.14884@skynet>
 <20051101135651.GA8502@elte.hu>  <1130854224.14475.60.camel@localhost>
 <20051101142959.GA9272@elte.hu>  <1130856555.14475.77.camel@localhost>
 <20051101150142.GA10636@elte.hu>  <1130858580.14475.98.camel@localhost>
 <20051102084946.GA3930@elte.hu>  <436880B8.1050207@yahoo.com.au>
 <1130923969.15627.11.camel@localhost>  <43688B74.20002@yahoo.com.au>
 <255360000.1130943722@[10.10.2.4]>  <4369824E.2020407@yahoo.com.au> 
 <306020000.1131032193@[10.10.2.4]> <1131032422.2839.8.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Nov 2005, Arjan van de Ven wrote:

> On Thu, 2005-11-03 at 07:36 -0800, Martin J. Bligh wrote:
> > >> Can we quit coming up with specialist hacks for hotplug, and try to solve
> > >> the generic problem please? hotplug is NOT the only issue here. Fragmentation
> > >> in general is.
> > >> 
> > > 
> > > Not really it isn't. There have been a few cases (e1000 being the main
> > > one, and is fixed upstream) where fragmentation in general is a problem.
> > > But mostly it is not.
> > 
> > Sigh. OK, tell me how you're going to fix kernel stacks > 4K please. 
> 
> with CONFIG_4KSTACKS :)

2-page allocations are _not_ a problem.

Especially not for fork()/clone(). If you don't even have 2-page 
contiguous areas, you are doing something _wrong_, or you're so low on 
memory that there's no point in forking any more. 

Don't confuse "fragmentation" with "perfectly spread out page 
allocations". 

Fragmentation means that it gets _exponentially_ more unlikely that you 
can allocate big contiguous areas. But contiguous areas of order 1 are 
very very likely indeed. It's only the _big_ areas that aren't going to 
happen.

This is why fragmentation avoidance has always been totally useless. It is
 - only useful for big areas
 - very hard for big areas

(Corollary: when it's easy and possible, it's not useful).

Don't do it. We've never done it, and we've been fine. Claiming that 
fork() is a reason to do fragmentation avoidance is invalid.

		Linus
