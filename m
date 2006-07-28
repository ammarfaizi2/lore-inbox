Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751842AbWG1GW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbWG1GW5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 02:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbWG1GW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 02:22:57 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:48734 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751842AbWG1GW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 02:22:56 -0400
Date: Fri, 28 Jul 2006 08:20:28 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, akpm@osdl.org,
       manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: respect architecture and caller mandated alignment
Message-ID: <20060728062028.GA9559@osiris.boeblingen.de.ibm.com>
References: <Pine.LNX.4.58.0607271514310.2172@sbz-30.cs.Helsinki.FI> <Pine.LNX.4.64.0607271909580.15840@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607271909580.15840@schroedinger.engr.sgi.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 07:25:56PM -0700, Christoph Lameter wrote:
> On Thu, 27 Jul 2006, Pekka J Enberg wrote:
> 
> > As explained by Heiko, on s390 (32-bit) ARCH_KMALLOC_MINALIGN is set to eight
> > because their common I/O layer allocates data structures that need to have an
> > eight byte alignment. This does not work when CONFIG_SLAB_DEBUG is enabled
> > because kmem_cache_create will override alignment to BYTES_PER_WORD which is
> > four.
> > 
> > So change kmem_cache_create to ensure cache alignment is always at minimum
> > what the architecture or caller mandates even if slab debugging is enabled.
> 
> Note that this will disable SLAB_RED_ZONE and SLAB_STORE_USER 
> for the following SLAB_DEBUG cases:
> 
> 1. For all slabs if an arch sets ARCH_SLAB_MINALIGN > BYTES_PER_WORD
> [...]
> 2. For all general (kmalloc) slabs if an arch sets
>    ARCH_KMALLOC_MINALIGN > BYTES_PER_WORD
> [...]
> F.e. S/390 will not be able to use slab debug for the general slabs.
> 
> You may want to document that change somewhere.

It is already documented (see top of slab.c). The only thing that was wrong was
that ARCH_SLAB_MINALIGN and ARCH_KMALLOC_MINALIGN didn't have the effect like
one would expect from the documentation.
