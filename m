Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263725AbTCWVNw>; Sun, 23 Mar 2003 16:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263843AbTCWVNw>; Sun, 23 Mar 2003 16:13:52 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:57537 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263725AbTCWVNv>; Sun, 23 Mar 2003 16:13:51 -0500
Message-Id: <200303232124.h2NLOqQJ020547@post.webmailer.de>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: [PATCH] slab.c cleanup
To: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org,
       Manfred Spraul <manfred@colorfullife.com>
Date: Sun, 23 Mar 2003 22:24:10 +0100
References: <20030323211010$1215@gated-at.bofh.it> <20030323211014$2f0c@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:

> Manfred Spraul wrote:
>>
>> No, the patch is a bad thing: It means that everyone who does 
>> kmalloc(32,) now allocates 128 bytes, i.e. 3/4 wasted. IMHO not acceptable.
> 
> Perhaps, but it currently is already allocating 128 bytes for smaller 
> caches, because the cache is created with SLAB_HWCACHE_ALIGN.  So we 
> ended up with redundantly sized caches.

Doesn't this code in kmem_cache_create() handle this already?

>        if (flags & SLAB_HWCACHE_ALIGN) {
>                /* Need to adjust size so that objs are cache aligned. */
>               /* Small obj size, can get at least two per cache line. */
>                while (size < align/2)
>                        align /= 2;
>                size = (size+align-1)&(~(align-1));
>        }

        Arnd <><
