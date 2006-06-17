Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWFQQeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWFQQeD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 12:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWFQQeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 12:34:03 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:44004 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750703AbWFQQeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 12:34:02 -0400
Date: Sat, 17 Jun 2006 09:33:52 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] slab: cpucache allocation cleanup
In-Reply-To: <1150355564.4633.6.camel@ubuntu>
Message-ID: <Pine.LNX.4.64.0606170929490.18882@schroedinger.engr.sgi.com>
References: <1150355564.4633.6.camel@ubuntu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2006, Pekka Enberg wrote:

> -static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
> +static __always_inline void *__cache_alloc_cpucache(struct kmem_cache *cachep,

The new name is confusing because __cache_alloc_cpucache suggests that we 
are only allocating from the cpucache and that this be something special. 
However, we always allocate from the cpucache for local allocations and we 
refill the cpucache in the __cpucache function from the shared cache and 
the per node lists. So we do much more there.

Maybe call this __cache_alloc_local ?

