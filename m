Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264743AbSLaVDK>; Tue, 31 Dec 2002 16:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbSLaVDK>; Tue, 31 Dec 2002 16:03:10 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:11480 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S264743AbSLaVDJ>; Tue, 31 Dec 2002 16:03:09 -0500
Date: Tue, 31 Dec 2002 13:17:47 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] generic device DMA (dma_pool update)
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3E12097B.9010202@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200212311950.gBVJos202971@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> david-b@pacbell.net said:
> 
>>You didn't make anything store or return the dma_addr_t ... that was
>>the issue I was referring to, it's got to be either (a) passed up from
>>the very lowest level, like the pci_*() calls assume, or else (b)
>>cheaply derived from the virtual address.  My patch added slab support
>>in common cases where (b) applies. 
> 
> 
> That's fairly simply done as part of the wrappers: The allocator stores the 
> vaddr, paddr and size in a hash table.  Thus, the paddr can be deduced when 
> kmem_cache_alloc is called by the allocation wrapper using the linearity 
> property.

However it'd be done, it'd be an essential part, and it was missing.  In fact,
your getpages() didn't have a way to return the dma_addr_t values, and your
freepages() didn't provide it as an input.  (But it did pass mem_flags in, as
I had at some point suggested should be done with dma_alloc_coherent.)


> I've got to say though that the most sensible course of action is still to 
> generalise pci_pool, which can be done easily and safely.  I think replacing 
> it with a slab based scheme is probably a 2.7 thing.

I think the patch I posted "easily and safely" does that, appropriate for 2.5,
even though some platforms can't yet collect that win.

I'd agree that morphing drivers/pci/pool.c into drivers/base/pool.c (or whatever)
would be appropriate, but I haven't heard any arguments to justify using that
allocator on systems where the the slab code can be used (more cheaply).

- Dave




