Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285114AbRLLJha>; Wed, 12 Dec 2001 04:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285125AbRLLJhU>; Wed, 12 Dec 2001 04:37:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:36111 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285114AbRLLJhL>;
	Wed, 12 Dec 2001 04:37:11 -0500
Date: Wed, 12 Dec 2001 10:36:54 +0100
From: Jens Axboe <axboe@suse.de>
To: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>
Cc: "David S. Miller" <davem@redhat.com>, gibbs@scsiguy.com,
        LB33JM16@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
Message-ID: <20011212093654.GA13498@suse.de>
In-Reply-To: <20011210.221231.72737317.davem@redhat.com> <20011211171832.R1848-100000@gerard>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011211171832.R1848-100000@gerard>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11 2001, Gérard Roudier wrote:
> On Mon, 10 Dec 2001, David S. Miller wrote:
> 
> >    From: Gérard Roudier <groudier@free.fr>
> >    Date: Mon, 10 Dec 2001 20:21:21 +0100 (CET)
> >
> >    Btw, a 16 MB boundary limitation would have no significant impact on
> >    performance and would have the goodness of avoiding some hardware bugs not
> >    only on a few Symbios devices in my opinion. As we know, numerous modern
> >    cores still have rests of the ISA epoch in their guts. So, in my opinion,
> >    the 16 MB boundary limitation should be the default on systems where
> >    reliability is the primary goal.
> >
> > Complications arrive when IOMMU starts to remap things into a virtual
> > 32-bit bus space as happens on several platforms now.
> >
> > Jen's block layer knows nothing about what we will do here, since
> > he only really has access to physical addresses.
> >
> > Only after the pci_map_sg() call can you inspect DMA addresses and
> > apply such workarounds.
> 
> Such workaround will add bloat on the already bloated for no relevant
> reason 'generic scatter to physical' thing.
> 
> As you know, low-level drivers on Linux announce some maximum length for
> the sg array. As you guess, in the worst case, each sg entry may have to
> be cut into several real entry (hoped 2 maximum) due to boundary
> limitations. At a first glance, low-level drivers should announce no more
> than half their real sg length capability and also would have to rewalk
> the entire sg list.

That's why these boundary limitations need to be known by the layer
build the requests for you.

> I used and was happy to do so when the scatter process was not generic.
> If we want it to be generic, then we want it to do the needed work. If
> generic means 'just bloated and clueless' then generic is a extreme bad
> thing.
> 
> 'virt_to_bus' + 'flat addressing model' was the 'just as complex as
> needed' for DMA model and most (may-be > 99%) of existing physical
> machines are just happy with such model. The DMA/BUS complexity all O/Ses
> have invented nowadays is a useless misfeature when based on the reality,
> in my opinion. So, I may just be dreaming, at the moment. :-)
> 
> If one really wants for some marketing reason to support these ugly and
> stinky '32 bit machines that want to provide more than 4GB of memory by
> shoe-horning complexity all over the place', one should use his brain,
> when so-featured, prior to writing clueless code.

First of all, virt_to_bus just cannot work on some archetectures that
are just slightly more advanced than x86. I'm quite sure Davem is ready
to lecture you on this.

Second, you are misunderstanding the need of a page/offset instead of
virtua_address model. It's _not_ for > 4GB machines, it's for machines
with highmem. You'll need this on the standard kernel to I/O above
860MB, that that is definitely a much bigger part of the market. Heck,
lots of home users have 1GB or more with the RAM prices these days.

-- 
Jens Axboe

