Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKPTbi>; Thu, 16 Nov 2000 14:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130074AbQKPTbS>; Thu, 16 Nov 2000 14:31:18 -0500
Received: from h00059aa0e40d.ne.mediaone.net ([24.91.9.69]:29426 "EHLO
	flowers.house.larsshack.org") by vger.kernel.org with ESMTP
	id <S129091AbQKPTbK>; Thu, 16 Nov 2000 14:31:10 -0500
Date: Thu, 16 Nov 2000 14:01:06 -0500 (EST)
From: Lars Kellogg-Stedman <lars@larsshack.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: BUG: 2.2.17 (sparc) fails in kmem_cache_alloc() w/ "large" initrd
Message-ID: <Pine.LNX.4.21.0011161356450.13357-100000@flowers>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

I have a couple of Sun sparcstation 2's (sun4c architectire) that reliably
fail in kmem_cache_alloc() whenever their kernel+initrd (net)boot image is
larger than about 2MB.

Each system has 48MB of RAM.  Here's some relevant boot output
(printk() isn't actually working at this point, so I've stuck
prom_printf() in a few critical spots):

  Memory: 32528k available (972k kernel code, 940k data, 136k init) [f0000000,f2ffe000]
  kmem_alloc: Bad slab magic (corrupt) (name=kmem_cache)

The "bad magic" error is being triggered because at this point in
__kmem_cache_alloc(), slabp->s_magic == 0.

Any thoughts on where to go from here?  I've traced it this far through
liberal application of prom_printf(), but I don't know anything about the
whole memory allocation system, so I'm not sure where to look next.

Cheers,

-- Lars

-- 
Lars Kellogg-Stedman <lars@larsshack.org> --> http://www.larsshack.org/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
