Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbUBDVyD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 16:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266573AbUBDVyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 16:54:03 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:44561 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266555AbUBDVx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 16:53:57 -0500
Message-ID: <40216B25.3020207@techsource.com>
Date: Wed, 04 Feb 2004 16:59:01 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Dave McCracken <dmccr@us.ibm.com>
CC: root@chaos.analogic.com, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: Active Memory Defragmentation: Our implementation & problems
References: <20040204185446.91810.qmail@web9705.mail.yahoo.com> <Pine.LNX.4.53.0402041402310.2722@chaos> <361730000.1075923354@[10.1.1.5]>
In-Reply-To: <361730000.1075923354@[10.1.1.5]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dave McCracken wrote:

> 
> Um, wrong answer.  When you ask for more than one page from the buddy
> allocator  (order greater than 0) it always returns physically contiguous
> pages.
> 
> Also, one of the near-term goals in VM is to be able to allocate and free
> large pages from the main memory pools, which requires that something like
> order 9 or 10 allocations (based on the architecture) succeed.
> 

What's the x86 large page size?  4M?  16M?  For the sake of arguement, 
let's call it 4M.  Doesn't matter.

Let's say this defragmenter allowed the kernel to detect when 1024 4k 
pages were contiguous and aligned properly and could silently replace 
the processor mapping tables so that all of these "pages" would be 
mapped by one TLB entry.  (At such time that some pages need to get 
freed, the VM would silently switch back to the 4k model.)

This would reduce TLB entries for a lot of programs above a certain 
size, and therefore improve peformance.

The question is:  How much overhead really is caused by TLB misses?  The 
TLB in the Athlon is like 512 entries.  That means it can know about 2 
megabytes worth of 4k pages at any one time.

