Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWEJHQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWEJHQy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 03:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWEJHQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 03:16:54 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:42458 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751407AbWEJHQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 03:16:54 -0400
Date: Wed, 10 May 2006 10:16:48 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Christoph Lameter <clameter@sgi.com>
cc: Mike Kravetz <kravetz@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Dave Hansen <haveblue@us.ibm.com>, Andy Whitcroft <apw@shadowen.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alloc_memory_early() routines
In-Reply-To: <Pine.LNX.4.64.0605100011090.3040@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0605101015190.12536@sbz-30.cs.Helsinki.FI>
References: <20060509053512.GA20073@monkey.ibm.com>  <20060508224952.0b43d0fd.akpm@osdl.org>
  <20060509210722.GD3168@w-mikek2.ibm.com> <84144f020605100009i74824233ie6feaf6fd2d9055f@mail.gmail.com>
 <Pine.LNX.4.64.0605100011090.3040@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2006, Pekka Enberg wrote:
> > > +void * __init alloc_memory_early_node(size_t size, gfp_t flags, int node)
> > > +{
> > > +       if (g_cpucache_up == FULL)
> > > +               return kmalloc_node(size, flags, node);
> > > +       else
> > > +               return alloc_bootmem_node(NODE_DATA(node), size);
> > > +}
> > 
> > I'd prefer you put this in mm/bootmem.c and added a
> > 
> > int slab_is_available(void)
> > {
> >       return g_cpucache_up == FULL;
> > }
> > 
> > to mm/slab.c instead.

On Wed, 10 May 2006, Christoph Lameter wrote:
> Does slab not available mean that bootmem can be used? 

Yes.

					Pekka
