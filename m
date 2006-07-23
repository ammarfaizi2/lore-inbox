Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWGWNDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWGWNDV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 09:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWGWNDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 09:03:21 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:51850 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751205AbWGWNDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 09:03:21 -0400
Date: Sun, 23 Jul 2006 06:03:09 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [patch] slab: always follow arch requested alignments
In-Reply-To: <20060723073500.GA10556@osiris.ibm.com>
Message-ID: <Pine.LNX.4.64.0607230558560.15651@schroedinger.engr.sgi.com>
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com>
 <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com>
 <20060722162607.GA10550@osiris.ibm.com> <Pine.LNX.4.64.0607221241130.14513@schroedinger.engr.sgi.com>
 <20060723073500.GA10556@osiris.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jul 2006, Heiko Carstens wrote:

> > 
> > See kmem_cache_create():
> >       /* 2) arch mandated alignment: disables debug if necessary */
> >         if (ralign < ARCH_SLAB_MINALIGN) {
> >                 ralign = ARCH_SLAB_MINALIGN;
> >                 if (ralign > BYTES_PER_WORD)
> >                         flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
> >         }
> 
> That is because if kmem_cache_create gets called with SLAB_HWCACHE_ALIGN set
> in flags then ralign will be greater or equal to ARCH_SLAB_MINALIGN:
> 
>         /* 1) arch recommendation: can be overridden for debug */ 
>         if (flags & SLAB_HWCACHE_ALIGN) { 
> 	        [...]
>                 ralign = cache_line_size(); 
> 	        [...]

Ok. Then you do not have a problem because ralign is greater than
ARCH_SLAB_MINALIGN.
 
> Therefore the test above will be passed and SLAB_RED_ZONE and SLAB_STORE_USER
> will stay in flags.
> cache_line_size() will return 256 on s390.

Looks as if you would have the correct alignment then. I still do not 
understand where the problem is since you want to align on an 8 byte 
boundary.


