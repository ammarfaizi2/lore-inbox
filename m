Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWEJI3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWEJI3X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 04:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWEJI3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 04:29:23 -0400
Received: from mail.suse.de ([195.135.220.2]:31904 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964848AbWEJI3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 04:29:22 -0400
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Mike Kravetz <kravetz@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Dave Hansen <haveblue@us.ibm.com>, Andy Whitcroft <apw@shadowen.org>,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH] alloc_memory_early() routines
References: <20060509053512.GA20073@monkey.ibm.com>
	<20060508224952.0b43d0fd.akpm@osdl.org>
	<20060509210722.GD3168@w-mikek2.ibm.com>
	<84144f020605100009i74824233ie6feaf6fd2d9055f@mail.gmail.com>
	<Pine.LNX.4.64.0605100011090.3040@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0605101015190.12536@sbz-30.cs.Helsinki.FI>
From: Andi Kleen <ak@suse.de>
Date: 10 May 2006 10:29:14 +0200
In-Reply-To: <Pine.LNX.4.58.0605101015190.12536@sbz-30.cs.Helsinki.FI>
Message-ID: <p731wv28eqt.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.Helsinki.FI> writes:

> On Wed, 10 May 2006, Pekka Enberg wrote:
> > > > +void * __init alloc_memory_early_node(size_t size, gfp_t flags, int node)
> > > > +{
> > > > +       if (g_cpucache_up == FULL)
> > > > +               return kmalloc_node(size, flags, node);
> > > > +       else
> > > > +               return alloc_bootmem_node(NODE_DATA(node), size);
> > > > +}
> > > 
> > > I'd prefer you put this in mm/bootmem.c and added a
> > > 
> > > int slab_is_available(void)
> > > {
> > >       return g_cpucache_up == FULL;
> > > }
> > > 
> > > to mm/slab.c instead.
> 
> On Wed, 10 May 2006, Christoph Lameter wrote:
> > Does slab not available mean that bootmem can be used? 
> 
> Yes.


Actually it doesn't - in early boot up there is a phase where even bootmem
doesn't work yet.

-Andi
