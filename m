Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWCVGCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWCVGCr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWCVGCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:02:47 -0500
Received: from uproxy.gmail.com ([66.249.92.195]:53919 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750786AbWCVGCq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:02:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AQQPj1C8YY5BUfx2WxKR6CeeklvxtSLAQj+DN3QkZ1emBUMTjowxgO30GGuSYpfD+shfzfrP5mgCfVi8J2DF6GGF71uB10j2ZG3aXnFIQoOlix7/9HkK2rsb3zWVeO0PN1NuvTtRcadffEMxLAoTiWFOdZHcR+xKc0kPNKaJCZU=
Message-ID: <bc56f2f0603212202l5cb41f5h@mail.gmail.com>
Date: Wed, 22 Mar 2006 01:02:44 -0500
From: "Stone Wang" <pwstone@gmail.com>
To: "Dave Hansen" <haveblue@us.ibm.com>
Subject: Re: [PATCH][5/8] proc: export mlocked pages info through "/proc/meminfo: Wired"
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <1142977393.10906.204.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bc56f2f0603200537i7b2492a6p@mail.gmail.com>
	 <1142977393.10906.204.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/3/21, Dave Hansen <haveblue@us.ibm.com>:
> On Mon, 2006-03-20 at 08:37 -0500, Stone Wang wrote:
> > --- linux-2.6.15.orig/include/linux/mm.h        2006-01-02 22:21:10.000000000 -0500
> > +++ linux-2.6.15/include/linux/mm.h     2006-03-07 01:49:12.000000000 -0500
> > @@ -218,6 +221,10 @@
> >         unsigned long flags;            /* Atomic flags, some possibly
> >                                          * updated asynchronously */
> >         atomic_t _count;                /* Usage count, see below. */
> > +       unsigned short wired_count; /* Count of wirings of the page.
> > +                                        * If not zero,the page would be SetPageWired,
> > +                                        * and put on Wired list of the zone.
> > +                                        */
> >         atomic_t _mapcount;             /* Count of ptes mapped in mms,
> >                                          * to show when page is mapped
> >                                          * & limit reverse map searches.
>
> We're usually pretty picky about adding stuff to 'struct page'.  It
> _just_ fits inside a cacheline on most 32-bit architectures.
>
> Can this wired_count not be derived at runtime?  It seems like it would
> be possible to run through all VMAs mapping the page, and determining
> how many of them are VM_LOCKED.  Would that be too slow?

It can be derived, but perhaps would made code not that clear.

I will try accroding to your comments, and i think there could be
fast scanning of the vma list for this purpose.

> Also, does it matter how many times it is locked, or just that
> _somebody_ has it locked?

For now, it just matters somebody has it locked.
When munlock a page, it matters  somebody else has it locked.

>
> -- Dave
>
>
