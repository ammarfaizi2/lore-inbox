Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbRCBNWN>; Fri, 2 Mar 2001 08:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129137AbRCBNWE>; Fri, 2 Mar 2001 08:22:04 -0500
Received: from colorfullife.com ([216.156.138.34]:28421 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129136AbRCBNVs>;
	Fri, 2 Mar 2001 08:21:48 -0500
Message-ID: <3A9F9E7E.37661415@colorfullife.com>
Date: Fri, 02 Mar 2001 14:22:06 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hemment <markhe@veritas.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Q: explicit alignment control for the slab allocator
In-Reply-To: <Pine.LNX.4.21.0103021218080.11260-100000@alloc>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hemment wrote:
> 
> > >   Hmm, no that note, seen the L1 line size defined for a Pentium IIII?
> > > 128 bytes!! (CONFIG_X86_L1_CACHE_SHIFT of 7).  That is probably going to
> > > waste a lot of space for small objects.
> > >
> > No, it doesn't:
> > HWCACHE_ALIGN means "do not cross a cache line boundary".
> 
>   Ah, I broke my code!!!!! :(
> 
>   In my original slab, the code to do "packing" of objects into a single
> cache line was #if-def'ed out for SMP to avoid the possibility of
> false-sharing between objects.  Not a large possibility, but it exists.
>
But then you need SMP_CACHE_BYTES, not L1_CACHE_BYTES.
And 128 byte aligning the 32-byte kmalloc cache wastes too much memory
;-)

If the caller of kmem_cache_create really wants do avoid false sharing
he could set align to SMP_CACHE_BYTES. (e.g. for some per-cpu data
structures)

> > Even if the hot zone is larger than the default offset, is there any advantage
> > of increasing the colour offset beyond the alignment?
> >
> > I don't see an advantage.
> 
>   I do, but like you, I don't have any data to prove my point.
>   Time to get profiling?
>

How? You've already noticed that noone in the linux kernel uses offset.

--	
	Manfred
