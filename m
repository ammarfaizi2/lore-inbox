Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbVKAPd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbVKAPd0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 10:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbVKAPd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 10:33:26 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:17114 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750897AbVKAPdZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 10:33:25 -0500
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Mel Gorman <mel@csn.ul.ie>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <45430000.1130858744@[10.10.2.4]>
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie>
	 <20051031055725.GA3820@w-mikek2.ibm.com><4365BBC4.2090906@yahoo.com.au>
	 <20051030235440.6938a0e9.akpm@osdl.org> <27700000.1130769270@[10.10.2.4]>
	 <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet>
	 <4366C559.5090504@yahoo.com.au>  <45430000.1130858744@[10.10.2.4]>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 16:33:13 +0100
Message-Id: <1130859193.14475.104.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 07:25 -0800, Martin J. Bligh wrote:
> > I really don't think we *want* to say we support higher order allocations
> > absolutely robustly, nor do we want people using them if possible. Because
> > we don't. Even with your patches.
> > 
> > Ingo also brought up this point at Ottawa.
> 
> Some of the driver issues can be fixed by scatter-gather DMA *if* the 
> h/w supports it. But what exactly do you propose to do about kernel
> stacks, etc? By the time you've fixed all the individual usages of it,
> frankly, it would be easier to provide a generic mechanism to fix the 
> problem ...

That generic mechanism is the kernel virtual remapping.  However, it has
a runtime performance cost, which is increased TLB footprint inside the
kernel, and a more costly implementation of __pa() and __va().

I'll admit, I'm biased toward partial solutions without runtime cost
before we start incurring constant cost across the entire kernel,
especially when those partial solutions have other potential in-kernel
users.

-- Dave


