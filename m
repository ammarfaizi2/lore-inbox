Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264927AbUBDXZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbUBDXZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:25:57 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:32160 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264927AbUBDXZf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:25:35 -0500
Subject: Re: Active Memory Defragmentation: Our implementation & problems
From: Dave Hansen <haveblue@us.ibm.com>
To: Timothy Miller <miller@techsource.com>
Cc: Dave McCracken <dmccr@us.ibm.com>, root@chaos.analogic.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <40216B25.3020207@techsource.com>
References: <20040204185446.91810.qmail@web9705.mail.yahoo.com>
	 <Pine.LNX.4.53.0402041402310.2722@chaos> <361730000.1075923354@[10.1.1.5]>
	 <40216B25.3020207@techsource.com>
Content-Type: text/plain
Organization: 
Message-Id: <1075937097.27944.1361.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 Feb 2004 15:24:57 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-04 at 13:59, Timothy Miller wrote:
> Dave McCracken wrote:
> > Um, wrong answer.  When you ask for more than one page from the buddy
> > allocator  (order greater than 0) it always returns physically contiguous
> > pages.
> > 
> > Also, one of the near-term goals in VM is to be able to allocate and free
> > large pages from the main memory pools, which requires that something like
> > order 9 or 10 allocations (based on the architecture) succeed.
> 
> What's the x86 large page size?  4M?  16M?  For the sake of arguement, 
> let's call it 4M.  Doesn't matter.

2M with PAE on.  4MB with it off.

> Let's say this defragmenter allowed the kernel to detect when 1024 4k 
> pages were contiguous and aligned properly and could silently replace 
> the processor mapping tables so that all of these "pages" would be 
> mapped by one TLB entry.  (At such time that some pages need to get 
> freed, the VM would silently switch back to the 4k model.)
> 
> This would reduce TLB entries for a lot of programs above a certain 
> size, and therefore improve peformance.

This is something that would be interesting to pursue, but we already
have hugetlbfs which does this when you need it explicitly.  When you
know that TLB coverage is a problem, that's your fix for now. 

> The question is:  How much overhead really is caused by TLB misses?  The 
> TLB in the Athlon is like 512 entries.  That means it can know about 2 
> megabytes worth of 4k pages at any one time.

I'm not sure how the Athlon works, but the PIII has very few TLB entries
for large pages.  The P4 can put large or small entries anywhere.  

--dave

