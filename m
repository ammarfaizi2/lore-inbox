Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWEIS0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWEIS0x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 14:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWEIS0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 14:26:53 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:63876 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1750717AbWEIS0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 14:26:52 -0400
Message-ID: <4460DEAD.9040900@colorfullife.com>
Date: Tue, 09 May 2006 20:25:49 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20060212 Fedora/1.7.12-5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
CC: Christoph Lameter <clameter@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       Daniel Hokka Zakrisson <daniel@hozac.com>, linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       greg@kroah.com, matthew@wil.cx, akpm@osdl.org
Subject: Re: [PATCH] fs: fcntl_setlease defies lease_init assumptions
References: <445E80DD.9090507@hozac.com>  <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org>  <84144f020605080131r58ce2a93w6c7ba784a266bbeb@mail.gmail.com>  <84144f020605080134q7e16f37fl385359c634ece8ca@mail.gmail.com>  <Pine.LNX.4.64.0605080807430.3718@g5.osdl.org>  <1147104412.22096.8.camel@localhost>  <Pine.LNX.4.64.0605080913240.3718@g5.osdl.org> <1147116991.11282.3.camel@localhost> <Pine.LNX.4.64.0605082031580.23431@schroedinger.engr.sgi.com> <44603543.8070205@colorfullife.com> <Pine.LNX.4.58.0605091316010.27821@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0605091316010.27821@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:

>I think you mean
>
>static inline struct kmem_cache *slab_get_cache(const void *obj)
>{
>        struct kmem_cache **p = (void *)((unsigned long) obj & ~(PAGE_SIZE-1));
>        return *p;
>}
>
>  
>
Of course.

>On Tue, 9 May 2006, Manfred Spraul wrote:
>  
>
>>The result would be a few small restrictions: all objects must start in the
>>first page of a slab (there are no exceptions on my 2.6.16 system), and
>>PAGE_SIZE'd caches are very expensive. Replacing the names_cache with
>>get_free_page is trivial. That leaves the pgd cache.
>>    
>>
>
>Your plan makes sense for slabs that have slab management structures 
>embedded within.
>
No - it would only make sense if it could be used for all slabs. 
Otherwise: How should kfree figure out if it's called for a slab with 
embedded pointers or not?

> We already have enough free space there for one pointer 
>due to 
>
>    colour_off += cachep->slab_size;
>
>in the alloc_slabmgmt() function, I think. Are you planning to kill 
>external slab management allocation completely by switching to 
>get_free_pages() for those cases? I'd much rather make the switch to page 
>allocator under the hood so kmalloc(PAGE_SIZE*n) would still work because 
>it's much nicer API.
>  
>
How many kmalloc(PAGE_SIZE*n) users are there?

--
    Manfred
