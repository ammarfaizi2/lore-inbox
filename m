Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262242AbSI0Pyk>; Fri, 27 Sep 2002 11:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262513AbSI0Pyk>; Fri, 27 Sep 2002 11:54:40 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:50840 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S262242AbSI0Pyj>;
	Fri, 27 Sep 2002 11:54:39 -0400
Message-ID: <3D948074.5030800@colorfullife.com>
Date: Fri, 27 Sep 2002 17:59:48 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/4] slab reclaim balancing
References: <3D931608.3040702@colorfullife.com> <3D9345C4.74CD73B8@digeo.com> <3D935655.1030606@colorfullife.com> <3D9364BA.A2CA02C5@digeo.com> <3D9372D3.3000908@colorfullife.com> <3D937E87.D387F358@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>>
>>Is that actually the right approach? For large objects, it would be
>>possible to cripple the freeable slabs list, and to perform the cache
>>hit optimization (i.e. per-cpu LIFO) in page_alloc.c, but that doesn't
>>work with small objects.
> 
> 
> Well with a, what? 100:1 speed ratio, we'll generally get best results
> from optimising for locality/recency of reference.
> 
You misunderstood me:

AFAICS slab.c has 2 weaks spots:
* cache hit rates are ignored on UP, and for objects > PAGE_SIZE on both 
SMP and UP.
* freeable pages are not returned efficiently to page_alloc.c, neither 
on SMP nor on UP. On SMP, this is a big problems, because the 
cache_chain_semaphore is overloaded.

I just wanted to say that a hotlist in page_alloc.c is not able to 
replace a hotlist in slab.c, because many objects are smaller than page 
size. Both lists are needed.

--
	Manfred


