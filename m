Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWGZKQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWGZKQF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 06:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWGZKQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 06:16:05 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:29770 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S932099AbWGZKQA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 06:16:00 -0400
Date: Wed, 26 Jul 2006 12:13:40 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 2/2] slab: always consider arch mandated alignment
Message-ID: <20060726101340.GE9592@osiris.boeblingen.de.ibm.com>
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com> <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com> <20060722162607.GA10550@osiris.ibm.com> <Pine.LNX.4.64.0607221241130.14513@schroedinger.engr.sgi.com> <20060723073500.GA10556@osiris.ibm.com> <Pine.LNX.4.64.0607230558560.15651@schroedinger.engr.sgi.com> <20060723162427.GA10553@osiris.ibm.com> <20060726085113.GD9592@osiris.boeblingen.de.ibm.com> <Pine.LNX.4.58.0607261303270.17613@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0607261303270.17613@sbz-30.cs.Helsinki.FI>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 01:05:43PM +0300, Pekka J Enberg wrote:
> On Wed, 26 Jul 2006, Heiko Carstens wrote:
> > Since ARCH_KMALLOC_MINALIGN didn't work on s390 I tried ARCH_SLAB_MINALIGN
> > instead, just to find out that it didn't work too.
> > In case of CONFIG_DEBUG_SLAB kmem_cache_create() creates caches with an
> > alignment lesser than ARCH_SLAB_MINALIGN, which it shouldn't according to
> > this comment in mm/slab.c :
> 
> [snip]
> 
> > Index: linux-2.6/mm/slab.c
> > ===================================================================
> > --- linux-2.6.orig/mm/slab.c	2006-07-26 09:55:54.000000000 +0200
> > +++ linux-2.6/mm/slab.c	2006-07-26 09:57:07.000000000 +0200
> > @@ -2103,6 +2103,9 @@
> >  		if (ralign > BYTES_PER_WORD)
> >  			flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
> >  	}
> > +	if (BYTES_PER_WORD < ARCH_SLAB_MINALIGN)
> > +		flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
> > +
> >  	/* 3) caller mandated alignment: disables debug if necessary */
> >  	if (ralign < align) {
> >  		ralign = align;
> 
> This is similar to my patch and should be enough to fix the problem. The 
> first patch seems bogus and I don't really understand why you would need 
> it.

It's enough to fix the ARCH_SLAB_MINALIGN problem. But it does _not_ fix the
ARCH_KMALLOC_MINALIGN problem. s390 currently only uses ARCH_KMALLOC_MINALIGN
since that should be good enough and it doesn't disable as much debugging
as ARCH_SLAB_MINALIGN does.
What exactly isn't clear from the description of the first patch? Or why do
you consider it bogus?
