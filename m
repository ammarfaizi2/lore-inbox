Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVDCHKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVDCHKh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 03:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVDCHKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 03:10:36 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:36804 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261572AbVDCHKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 03:10:30 -0400
Message-ID: <424F96DD.2070307@colorfullife.com>
Date: Sun, 03 Apr 2005 09:10:21 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel stack size
References: <424EFD2A.6060305@colorfullife.com> <1112480132.27149.55.camel@localhost.localdomain>
In-Reply-To: <1112480132.27149.55.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:

>>Have you benchmarked your own memory manager?
>>kmalloc(1024, GFP_KERNEL) is something like 17 instructions on i386 
>>uniprocessor.
>>    
>>
>
>Where did you get that? I'm looking at the assembly of it right now and
>it's much larger than 17 instructions. Not to mention that it calls the
>slab functions which might have to invoke the buddy system.
>
>  
>
Have you looked at kmem_cache_alloc? kmalloc(1024, GFP_KERNEL) is 
compile-time replaced with the appropriate kmem_cache_alloc call. And 
the fast path within kmem_cache_alloc is 17 instructions long. Best 
case: uniprocessor, no regparams. Unfortunately with cli and popfd, thus 
something like 35 cpu cycles on an Athlon 64.

> I haven't clocked the speed of sem compared to kmalloc.
>But I would think that the sem functions are still quicker.
>
>  
>
Yes - sem or spin locks are quicker as long as no cache line transfers 
are necessary. If the semaphore is accessed by multiple cpus, then 
kmalloc would be faster: slab tries hard to avoid taking global locks. 
I'm not speaking about contention, just the cache line ping pong for 
acquiring a free semaphore.

--
    Manfred
