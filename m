Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbWCULDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbWCULDg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbWCULDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:03:36 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:36833 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S965026AbWCULDg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:03:36 -0500
Date: Tue, 21 Mar 2006 13:03:25 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH] slab: introduce kmem_cache_zalloc allocator
In-Reply-To: <20060321023654.389dc572.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0603211250530.22577@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0603201506140.19005@sbz-30.cs.Helsinki.FI>
 <20060321023654.389dc572.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, 21 Mar 2006, Andrew Morton wrote:
> The way this is supposed to work in slab is that the owner of the cache
> provides a constructor which zeroes out newly-allocated storage and the
> owner of the cache is supposed to free objects in a constructed (ie:
> zeroed) state.

Constructors work well for things like lock and and list initialization 
where the object state is naturally in 'initial' state when free'd. They 
don't work well for unconditional zeroing for the exact reasons you 
outline below.

On Tue, 21 Mar 2006, Andrew Morton wrote:
> I've always felt that this was an odd design.  Because
> 
> a) All that cache-warmth which we get from the constructor's zeroing can
>    be lost by the time we get around to using an individual object and
> 
> b) The object may be cache-cold by the time we free it, and we'll take
>    cache misses just putting it back into a constructed state for
>    kmem_cache_free().  And we'll lose that cache warmth by the time we use
>    this object again.
> 
> So from that POV I think (in my simple way) that this is a good patch.  But
> IIRC, Manfred has reasons why it might not be?

I assume the design comes from Bonwick's paper which states that the 
purpose of object constructor is to support one-time initialization of 
objects which we're _not_ doing in this case.

				Pekka 
