Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129830AbRCATbB>; Thu, 1 Mar 2001 14:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129833AbRCATaw>; Thu, 1 Mar 2001 14:30:52 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:64970 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S129830AbRCATab>; Thu, 1 Mar 2001 14:30:31 -0500
Date: Thu, 1 Mar 2001 18:09:07 +0000 (GMT)
From: Mark Hemment <markhe@veritas.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Q: explicit alignment control for the slab allocator
In-Reply-To: <3A9E8628.7CCD1162@colorfullife.com>
Message-ID: <Pine.LNX.4.21.0103011800460.11260-100000@alloc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Manfred Spraul wrote:

> Alan added a CONFIG options for FORCED_DEBUG slab debugging, but there
> is one minor problem with FORCED_DEBUG: FORCED_DEBUG disables
> HW_CACHEALIGN, and several drivers assume that HW_CACHEALIGN implies a
> certain alignment (iirc usb/uhci.c assumes 16-byte alignment)
> 
> I've attached a patch that fixes the explicit alignment control in
> kmem_cache_create().
> 
> The parameter 'offset' [the minimum offset to be used for cache
> coloring] actually is the guaranteed alignment, except that the
> implementation was broken. I've fixed the implementation and renamed
> 'offset' to 'align'.

  As the original author of the slab allocator, I can assure you there is
nothing guaranteed about "offset".  Neither is it to do with any minimum.

  The original idea behind offset was for objects with a "hot" area
greater than a single L1 cache line.  By using offset correctly (and to my
knowledge it has never been used anywhere in the Linux kernel), a SLAB
cache creator (caller of kmem_cache_create()) could ask the SLAB for more
than one colour (space/L1 cache lines) offset between objects.

  As no one uses the feature it could well be broken, but is that a reason
to change its meaning?

Mark

