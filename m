Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262886AbSJBBMm>; Tue, 1 Oct 2002 21:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262891AbSJBBMm>; Tue, 1 Oct 2002 21:12:42 -0400
Received: from dp.samba.org ([66.70.73.150]:29669 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262886AbSJBBMl>;
	Tue, 1 Oct 2002 21:12:41 -0400
Date: Wed, 2 Oct 2002 11:18:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Morton <akpm@digeo.com>, David Miller <davem@redhat.com>,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH,RFC] Add gfp_mask to get_vm_area()
Message-ID: <20021002011809.GB1848@zax>
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>,
	Andrew Morton <akpm@digeo.com>, David Miller <davem@redhat.com>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc-embedded@lists.linuxppc.org
References: <20021001044226.GS10265@zax> <3D992DB0.9A8942D@digeo.com> <20021001053417.GW10265@zax> <20021001094202.C29814@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021001094202.C29814@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 09:42:02AM +0100, Russell King wrote:
> 
> On Tue, Oct 01, 2002 at 03:34:17PM +1000, David Gibson wrote:
> > I don't see an easy one: PPC 4xx has non-coherent cache, so we have to
> > mark consistent memory non-cacheable.  We want to make the normal
> > lowmem mapping use large page TLB entries, so we can't frob the
> > attribute bits on the pages in place.  That means we need to create a
> > new, non-cacheable mapping for the physical RAM we allocate, which in
> > turn means allocating a chunk of kernel virtual memory.
> 
> Same problem on ARM.  I just haven't got the motivation to rewrite the
> bits of the kernel that need to be rewritten to make it work.
> 
> Have you checked that your pte/pmd allocation functions can be called
> from IRQ context as well?
> 
> You basically need:
> 
>  - irq-safe get_vm_area
>  - irq-safe pmd_alloc_kernel
>  - irq-safe pte_alloc_kernel
> 
> Last time I looked, all the above were not irq-safe.

No, I realise they're not safe at the moment - I'm working on that
too.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
