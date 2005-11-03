Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030361AbVKCP5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbVKCP5P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbVKCP5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:57:15 -0500
Received: from dvhart.com ([64.146.134.43]:62381 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1030361AbVKCP5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:57:14 -0500
Date: Thu, 03 Nov 2005 07:57:15 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Dave Hansen <haveblue@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>, Mel Gorman <mel@csn.ul.ie>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <307350000.1131033435@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.64.0511030747450.27915@g5.osdl.org>
References: <4366C559.5090504@yahoo.com.au>  <Pine.LNX.4.58.0511010137020.29390@skynet><4366D469.2010202@yahoo.com.au>  <Pine.LNX.4.58.0511011014060.14884@skynet><20051101135651.GA8502@elte.hu>  <1130854224.14475.60.camel@localhost><20051101142959.GA9272@elte.hu>  <1130856555.14475.77.camel@localhost><20051101150142.GA10636@elte.hu>  <1130858580.14475.98.camel@localhost><20051102084946.GA3930@elte.hu>  <436880B8.1050207@yahoo.com.au><1130923969.15627.11.camel@localhost>  <43688B74.20002@yahoo.com.au><255360000.1130943722@[10.10.2.4]>  <4369824E.2020407@yahoo.com.au> <306020000.1131032193@[10.10.2.4]> <1131032422.2839.8.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0511030747450.27915@g5.osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> with CONFIG_4KSTACKS :)
> 
> 2-page allocations are _not_ a problem.
> 
> Especially not for fork()/clone(). If you don't even have 2-page 
> contiguous areas, you are doing something _wrong_, or you're so low on 
> memory that there's no point in forking any more. 

64 bit platforms need kernel stacks > 8K, it seems.

> Don't confuse "fragmentation" with "perfectly spread out page 
> allocations". 
> 
> Fragmentation means that it gets _exponentially_ more unlikely that you 
> can allocate big contiguous areas. But contiguous areas of order 1 are 
> very very likely indeed. It's only the _big_ areas that aren't going to 
> happen.
> 
> This is why fragmentation avoidance has always been totally useless. It is
>  - only useful for big areas
>  - very hard for big areas
> 
> (Corollary: when it's easy and possible, it's not useful).
> 
> Don't do it. We've never done it, and we've been fine. Claiming that 
> fork() is a reason to do fragmentation avoidance is invalid.

With respect, we have not been fine. We see problems fairly regularly
with no large page/hotplug issues with higher order allocations. 
Drivers, CIFS, kernel stacks, etc, etc etc.

The larger memory gets, the worse the problem is, just because the 
statistics make it less likely to free up multiple contiguous pages.

M.

