Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWGZKFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWGZKFq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 06:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWGZKFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 06:05:45 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:3002 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751186AbWGZKFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 06:05:45 -0400
Date: Wed, 26 Jul 2006 13:05:43 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 2/2] slab: always consider arch mandated alignment
In-Reply-To: <20060726085113.GD9592@osiris.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.58.0607261303270.17613@sbz-30.cs.Helsinki.FI>
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com>
 <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com>
 <20060722162607.GA10550@osiris.ibm.com> <Pine.LNX.4.64.0607221241130.14513@schroedinger.engr.sgi.com>
 <20060723073500.GA10556@osiris.ibm.com> <Pine.LNX.4.64.0607230558560.15651@schroedinger.engr.sgi.com>
 <20060723162427.GA10553@osiris.ibm.com> <20060726085113.GD9592@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006, Heiko Carstens wrote:
> Since ARCH_KMALLOC_MINALIGN didn't work on s390 I tried ARCH_SLAB_MINALIGN
> instead, just to find out that it didn't work too.
> In case of CONFIG_DEBUG_SLAB kmem_cache_create() creates caches with an
> alignment lesser than ARCH_SLAB_MINALIGN, which it shouldn't according to
> this comment in mm/slab.c :

[snip]

> Index: linux-2.6/mm/slab.c
> ===================================================================
> --- linux-2.6.orig/mm/slab.c	2006-07-26 09:55:54.000000000 +0200
> +++ linux-2.6/mm/slab.c	2006-07-26 09:57:07.000000000 +0200
> @@ -2103,6 +2103,9 @@
>  		if (ralign > BYTES_PER_WORD)
>  			flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
>  	}
> +	if (BYTES_PER_WORD < ARCH_SLAB_MINALIGN)
> +		flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
> +
>  	/* 3) caller mandated alignment: disables debug if necessary */
>  	if (ralign < align) {
>  		ralign = align;

This is similar to my patch and should be enough to fix the problem. The 
first patch seems bogus and I don't really understand why you would need 
it.

					Pekka
