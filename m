Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbVKAPBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbVKAPBc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 10:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbVKAPBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 10:01:32 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:34754 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750837AbVKAPBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 10:01:31 -0500
Date: Tue, 1 Nov 2005 16:01:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Mel Gorman <mel@csn.ul.ie>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <20051101150142.GA10636@elte.hu>
References: <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au> <Pine.LNX.4.58.0511011014060.14884@skynet> <20051101135651.GA8502@elte.hu> <1130854224.14475.60.camel@localhost> <20051101142959.GA9272@elte.hu> <1130856555.14475.77.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130856555.14475.77.camel@localhost>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dave Hansen <haveblue@us.ibm.com> wrote:

> > then we need to see that 100% solution first - at least in terms of 
> > conceptual steps.
> 
> I don't think saying "truly 100%" really even makes sense.  There will 
> always be restrictions of some kind.  For instance, with a 10MB kernel 
> image, should you be able to shrink the memory in the system below 
> 10MB? ;)

think of it in terms of filesystem shrinking: yes, obviously you cannot 
shrink to below the allocated size, but no user expects to be able to do 
it. But users would not accept filesystem shrinking failing for certain 
file layouts. In that case we are better off with no ability to shrink: 
it makes it clear that we have not solved the problem, yet.

so it's all about expectations: _could_ you reasonably remove a piece of 
RAM? Customer will say: "I have stopped all nonessential services, and 
free RAM is at 90%, still I cannot remove that piece of faulty RAM, fix 
the kernel!". No reasonable customer will say: "True, I have all RAM 
used up in mlock()ed sections, but i want to remove some RAM 
nevertheless".

> There is also no precedent in existing UNIXes for a 100% solution.

does this have any relevance to the point, other than to prove that it's 
a hard problem that we should not pretend to be able to solve, without 
seeing a clear path towards a solution?

	Ingo
