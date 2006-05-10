Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWEJHMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWEJHMO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 03:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWEJHMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 03:12:14 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:22463 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751413AbWEJHMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 03:12:13 -0400
Date: Wed, 10 May 2006 00:11:59 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Mike Kravetz <kravetz@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Dave Hansen <haveblue@us.ibm.com>, Andy Whitcroft <apw@shadowen.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alloc_memory_early() routines
In-Reply-To: <84144f020605100009i74824233ie6feaf6fd2d9055f@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0605100011090.3040@schroedinger.engr.sgi.com>
References: <20060509053512.GA20073@monkey.ibm.com>  <20060508224952.0b43d0fd.akpm@osdl.org>
  <20060509210722.GD3168@w-mikek2.ibm.com> <84144f020605100009i74824233ie6feaf6fd2d9055f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2006, Pekka Enberg wrote:

> > +void * __init alloc_memory_early_node(size_t size, gfp_t flags, int node)
> > +{
> > +       if (g_cpucache_up == FULL)
> > +               return kmalloc_node(size, flags, node);
> > +       else
> > +               return alloc_bootmem_node(NODE_DATA(node), size);
> > +}
> 
> I'd prefer you put this in mm/bootmem.c and added a
> 
> int slab_is_available(void)
> {
>       return g_cpucache_up == FULL;
> }
> 
> to mm/slab.c instead.

Does slab not available mean that bootmem can be used? 

