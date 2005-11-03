Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030406AbVKCTIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbVKCTIa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 14:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030443AbVKCTIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 14:08:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:910 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030406AbVKCTIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 14:08:30 -0500
Date: Thu, 3 Nov 2005 11:08:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: Mel Gorman <mel@csn.ul.ie>, Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <314040000.1131043735@[10.10.2.4]>
Message-ID: <Pine.LNX.4.64.0511031102590.27915@g5.osdl.org>
References: <4366C559.5090504@yahoo.com.au>
 <Pine.LNX.4.58.0511010137020.29390@skynet><4366D469.2010202@yahoo.com.au>
 <Pine.LNX.4.58.0511011014060.14884@skynet><20051101135651.GA8502@elte.hu>
 <1130854224.14475.60.camel@localhost><20051101142959.GA9272@elte.hu>
 <1130856555.14475.77.camel@localhost><20051101150142.GA10636@elte.hu>
 <1130858580.14475.98.camel@localhost><20051102084946.GA3930@elte.hu>
 <436880B8.1050207@yahoo.com.au><1130923969.15627.11.camel@localhost>
 <43688B74.20002@yahoo.com.au><255360000.1130943722@[10.10.2.4]>
 <4369824E.2020407@yahoo.com.au>
 <306020000.1131032193@[10.10.2.4]><1131032422.2839.8.camel@laptopd505.fenrus.org><Pine.LNX.4.64.0511030747450.27915@g5.osdl.org><Pine.LNX.4.58.0511031613560.3571@skynet><Pine.LNX.4.64.0511030842050.27915@g5.osdl.org><309420000.1131036740@[10.10.2.4]>
 <Pine.LNX.4.64.0511030918110.27915@g5.osdl.org> <311050000.1131040276@[10.10.2.4]>
 <314040000.1131043735@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Nov 2005, Martin J. Bligh wrote:
> 
> Ha. Just because I don't think I made you puke hard enough already with
> foul approximations ... for order 2, I think it's

Your basic fault is in believing that the free watermark would stay 
constant.

That's insane.

Would you keep 8MB free on a 64MB system?

Would you keep 8MB free on a 8GB system?

The point being, that if you start with insane assumptions, you'll get 
insane answers.

The _correct_ assumption is that you aim to keep some fixed percentage of 
memory free. With that assumption and your math, finding higher-order 
pages is equally hard regardless of amount of memory. 

Now, your math then doesn't allow for the fact that buddy automatically 
coalesces for you, so in fact things get _easier_ with more memory, but 
hey, that needs more math than I can come up with (I never did it as math, 
only as simulations with allocation patterns - "smart people use math, 
plodding people just try to simulate an estimate" ;)

		Linus
