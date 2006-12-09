Return-Path: <linux-kernel-owner+w=401wt.eu-S1761825AbWLITCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761825AbWLITCV (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 14:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761827AbWLITCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 14:02:20 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:37618 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761825AbWLITCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 14:02:18 -0500
Date: Sat, 9 Dec 2006 11:01:47 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org, mpm@selenic.com,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [RFC] Cleanup slab headers / API to allow easy addition of new
 slab allocators
In-Reply-To: <84144f020612090602w5c7f3f9ay8e771763ea8843cf@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0612091057390.24785@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0612081106320.16873@schroedinger.engr.sgi.com>
 <84144f020612090602w5c7f3f9ay8e771763ea8843cf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2006, Pekka Enberg wrote:

> Hi Christoph,
> 
> On 12/8/06, Christoph Lameter <clameter@sgi.com> wrote:
> > +#define        SLAB_POISON             0x00000800UL    /* DEBUG: Poison
> > objects */
> > +#define        SLAB_HWCACHE_ALIGN      0x00002000UL    /* Align objs on
> > cache lines */
> > +#define SLAB_CACHE_DMA         0x00004000UL    /* Use GFP_DMA memory */
> > +#define SLAB_MUST_HWCACHE_ALIGN        0x00008000UL    /* Force alignment
> > even if debuggin is active */
> 
> Please fix formatting while you're at it.

Yes I did that. Please look at it after you applied the diff.

> > + * its own optimized kmalloc definitions (like SLOB).
> > + */
> > +
> > +#if defined(CONFIG_NUMA) || defined(CONFIG_DEBUG_SLAB)
> > +#error "SLAB fallback definitions not usable for NUMA or Slab debug"
> 
> Do we need this? Shouldn't we just make sure no one can enable
> CONFIG_NUMA and CONFIG_DEBUG_SLAB for non-compatible allocators?

Ok. Dropped it.
> 
> > -static inline void *kmalloc(size_t size, gfp_t flags)
> > +void *kmalloc(size_t size, gfp_t flags)
> 
> static inline?
> 
> > +void *kzalloc(size_t size, gfp_t flags)
> > +{
> > +       return __kzalloc(size, flags);
> > +}
> 
> same here.
> 
Ok. Fixed that.

