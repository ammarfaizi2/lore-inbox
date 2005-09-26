Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbVIZRiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbVIZRiX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 13:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbVIZRiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 13:38:23 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:37072 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932433AbVIZRiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 13:38:22 -0400
Date: Mon, 26 Sep 2005 10:38:01 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: nickpiggin@yahoo.com.au, davem@davemloft.net, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: Make kzalloc a macro
In-Reply-To: <20050923153702.6194e53f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0509261018150.3650@schroedinger.engr.sgi.com>
References: <4333A109.2000908@yahoo.com.au> <200509230909.54046.ioe-lkml@rameria.de>
 <4333B588.9060503@yahoo.com.au> <20050923.010939.11256142.davem@davemloft.net>
 <4333C4F4.9030402@yahoo.com.au> <2cd57c9005092302174e0f657e@mail.gmail.com>
 <Pine.LNX.4.62.0509230857190.22086@schroedinger.engr.sgi.com>
 <Pine.LNX.4.62.0509231048530.22423@schroedinger.engr.sgi.com>
 <20050923153702.6194e53f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2005, Andrew Morton wrote:

> I'd question the usefulness of this.  It adds more code to a fastpath
> (kmem_cache_alloc) so as to speed up a slowpath (kzalloc()) which is
> already slow due to its memset.

It tries to unify both and make usage consistent over the allocator 
functions in slab.c. kzalloc essentially vanishes.
 
> It makes my kernel a bit fatter too - 150-odd bytes of text for some
> reason.

Yes the inline function doubles the code generated for obj_checkout 
because it occurs in __cache_alloc and __cache_alloc_node. 
__cache_alloc is also an inline and is expanded three times.

Removing the inline from __cache_alloc could reduced code size.
