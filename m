Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbVLERDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbVLERDg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 12:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVLERDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 12:03:36 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:34466 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932458AbVLERDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 12:03:35 -0500
Date: Mon, 5 Dec 2005 09:03:13 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Alok Kataria <alokk@calsoftinc.com>, Petr Vandrovec <vandrove@vc.cvut.cz>,
       linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org
Subject: Re: [RFC] Use compound pages for higher order slab allocations.
In-Reply-To: <4391ED8D.1040104@colorfullife.com>
Message-ID: <Pine.LNX.4.62.0512050850310.11401@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0511301334450.20244@schroedinger.engr.sgi.com>
 <4391ED8D.1040104@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Dec 2005, Manfred Spraul wrote:

> Christoph Lameter wrote:
> 
> > +static inline struct page *virt_to_compound_page(const void *addr)
> > +{
> > +	struct page * page = virt_to_page(addr);
> > +
> > +	if (PageCompound(page))
> > +        	page = (struct page *)page_private(page);
> > +
> >  
> This would end up in every kmem_cache_free/kfree call. Is it really worth the
> effort, are the high order allocation a problem?

The use of compound pages allows the handling of the higher order 
allocated page as one unit in a generic slab independent way. Currently 
struct page elements have a slab specific meaning and must be 
inspected in a slab specific way to figure out where the 
higher order page starts. Having compound pages allows a generic handling
of higher order pages unifying f.e. hugepage handling with slab handling etc.

Not sure if this is worth it but it may make the handling of these pages 
easier for page migration, hotplug and bad memory relocation. Other 
endeavors that either scan struct page arrays or may start processing with 
any struct page also currently have to deal with the slab specific way of 
handling higher order pages.

> I'm against such a change without a clear proof that just using high order
> allocations is not possible.

We are doing it right now so its definitely possible.

