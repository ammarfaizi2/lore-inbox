Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129213AbRCBMca>; Fri, 2 Mar 2001 07:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129137AbRCBMcO>; Fri, 2 Mar 2001 07:32:14 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:37862 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S129155AbRCBMcE>; Fri, 2 Mar 2001 07:32:04 -0500
Date: Fri, 2 Mar 2001 12:39:11 +0000 (GMT)
From: Mark Hemment <markhe@veritas.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Q: explicit alignment control for the slab allocator
In-Reply-To: <983533909.3a9f89554db32@colorfullife.com>
Message-ID: <Pine.LNX.4.21.0103021218080.11260-100000@alloc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2001, Manfred Spraul wrote:
> Zitiere Mark Hemment <markhe@veritas.com>:
> >   Could be a win on archs with small L1 cache line sizes (16bytes on a
> > 486) - but most modern processors have larger lines.
> 
> IIRC cache colouring was introduced for some sun hardware with 2 memory busses:
> one handes (addr%256<128), the other one (addr%256>=128)
> 
> If everything is perfectly aligned, the load one one bus was far higher than the
> load on the other bus.

  Yes.
  High-end Intel PCs have also had interleaved buses for a few years
now.  So it is not just for Sun h/w.

 
> >   Hmm, no that note, seen the L1 line size defined for a Pentium IIII?
> > 128 bytes!! (CONFIG_X86_L1_CACHE_SHIFT of 7).  That is probably going to
> > waste a lot of space for small objects.
> >
> No, it doesn't:
> HWCACHE_ALIGN means "do not cross a cache line boundary".

  Ah, I broke my code!!!!! :(

  In my original slab, the code to do "packing" of objects into a single
cache line was #if-def'ed out for SMP to avoid the possibility of
false-sharing between objects.  Not a large possibility, but it exists.
 
> The question is who should decide about the cache colour offset?
> 
> a) the slab allocator always chooses the smallest sensible offset (i.e. the
> alignment)
> b) the caller can specify the offset, e.g. if the caller knows that the hot zone
> is large he would use a larger colour offset.

  Only the caller knows about the attributes and usage of an object, so
they should be able to request (not demand) the offset/alignment of the
allocator. (OK, they can demand the alignment.)

> Even if the hot zone is larger than the default offset, is there any advantage
> of increasing the colour offset beyond the alignment?
> 
> I don't see an advantage.

  I do, but like you, I don't have any data to prove my point.
  Time to get profiling?

Mark


