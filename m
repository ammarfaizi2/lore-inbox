Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284460AbRLJRAr>; Mon, 10 Dec 2001 12:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286308AbRLJRAi>; Mon, 10 Dec 2001 12:00:38 -0500
Received: from colorfullife.com ([216.156.138.34]:52751 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S284460AbRLJRA1>;
	Mon, 10 Dec 2001 12:00:27 -0500
Message-ID: <3C14EA26.5060306@colorfullife.com>
Date: Mon, 10 Dec 2001 18:00:22 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jack Steiner <steiner@sgi.com>
CC: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
In-Reply-To: <200112101633.KAA45958@fsgi055.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack Steiner wrote:

>
>BTW, I think Tony Luck (at Intel) is currently changing the slab allocator 
>to be numa-aware. Are coordinating your work with his???
>

Thanks, I wasn't aware that he's working on it.
I haven't started coding, I'm still collecting what's needed.

* force certain alignments. e.g. ARM needs 1024 byte aligned objects for 
the page tables.
* NUMA support.
* Add a "priority" to kmem_cache_shrink, to avoid that every 
dcache/icache shrink causes an IPI to all cpus.
* If possible: replace the division in kmem_cache_free_one with the 
multiplication by the reciprocal. (I have a patch, but it's too ugly for 
inclusion). Important for uniprocessor versions.
* add reservation support - e.g. there must be a minimum amount of bio 
structures available, otherwise the kernel could oom-deadlock. They must 
be available, not hidden in the per-cpu caches of the other cpus.

--
    Manfred


