Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263929AbTCWVlA>; Sun, 23 Mar 2003 16:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263930AbTCWVlA>; Sun, 23 Mar 2003 16:41:00 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:19709 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S263929AbTCWVkz>; Sun, 23 Mar 2003 16:40:55 -0500
Message-ID: <3E7E2C69.5080401@quark.didntduck.org>
Date: Sun, 23 Mar 2003 16:51:37 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Brian Gerst <bgerst@didntduck.org>, Anton Blanchard <anton@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] slab.c cleanup
References: <3E7E204C.2040700@colorfullife.com> <3E7E2219.5090501@quark.didntduck.org> <3E7E252A.2030902@colorfullife.com>
In-Reply-To: <3E7E252A.2030902@colorfullife.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> Brian Gerst wrote:
> 
>>
>> Perhaps, but it currently is already allocating 128 bytes for smaller 
>> caches, because the cache is created with SLAB_HWCACHE_ALIGN.  So we 
>> ended up with redundantly sized caches.
>>
> 
> linux/mm/slab.c:
> 
>>     if (flags & SLAB_HWCACHE_ALIGN) {
>>         /* Need to adjust size so that objs are cache aligned. */
>>         /* Small obj size, can get at least two per cache line. */
>>         while (size < align/2)
>>             align /= 2;
>>         size = (size+align-1)&(~(align-1));
>>     }
>>  
>>
> HWALIGN is just a hint, the implementation ignores it if it results in 
> unreasonable wasting of memory.

I think I see what was causing be to believe it was always rounding up 
to the cache size.  The while test should be while (size <= align/2). 
On my machine (athlon, 64 byte cache), the size-32 cache was rounded up 
to 64 bytes because of this.

size-128            1416   1470    128   49   49    1 :  248  124
size-64              351    413     64    7    7    1 :  248  124
size-32              649    649     64   11   11    1 :  248  124
                                    ^^^^

--
				Brian Gerst


