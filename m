Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282818AbRLKT4v>; Tue, 11 Dec 2001 14:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282816AbRLKT4m>; Tue, 11 Dec 2001 14:56:42 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:50216 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S282792AbRLKT4a> convert rfc822-to-8bit; Tue, 11 Dec 2001 14:56:30 -0500
Date: Tue, 11 Dec 2001 18:01:07 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: "David S. Miller" <davem@redhat.com>
cc: <axboe@suse.de>, <gibbs@scsiguy.com>, <LB33JM16@yahoo.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
In-Reply-To: <20011210.221231.72737317.davem@redhat.com>
Message-ID: <20011211171832.R1848-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Dec 2001, David S. Miller wrote:

>    From: Gérard Roudier <groudier@free.fr>
>    Date: Mon, 10 Dec 2001 20:21:21 +0100 (CET)
>
>    Btw, a 16 MB boundary limitation would have no significant impact on
>    performance and would have the goodness of avoiding some hardware bugs not
>    only on a few Symbios devices in my opinion. As we know, numerous modern
>    cores still have rests of the ISA epoch in their guts. So, in my opinion,
>    the 16 MB boundary limitation should be the default on systems where
>    reliability is the primary goal.
>
> Complications arrive when IOMMU starts to remap things into a virtual
> 32-bit bus space as happens on several platforms now.
>
> Jen's block layer knows nothing about what we will do here, since
> he only really has access to physical addresses.
>
> Only after the pci_map_sg() call can you inspect DMA addresses and
> apply such workarounds.

Such workaround will add bloat on the already bloated for no relevant
reason 'generic scatter to physical' thing.

As you know, low-level drivers on Linux announce some maximum length for
the sg array. As you guess, in the worst case, each sg entry may have to
be cut into several real entry (hoped 2 maximum) due to boundary
limitations. At a first glance, low-level drivers should announce no more
than half their real sg length capability and also would have to rewalk
the entire sg list.

I used and was happy to do so when the scatter process was not generic.
If we want it to be generic, then we want it to do the needed work. If
generic means 'just bloated and clueless' then generic is a extreme bad
thing.

'virt_to_bus' + 'flat addressing model' was the 'just as complex as
needed' for DMA model and most (may-be > 99%) of existing physical
machines are just happy with such model. The DMA/BUS complexity all O/Ses
have invented nowadays is a useless misfeature when based on the reality,
in my opinion. So, I may just be dreaming, at the moment. :-)

If one really wants for some marketing reason to support these ugly and
stinky '32 bit machines that want to provide more than 4GB of memory by
shoe-horning complexity all over the place', one should use his brain,
when so-featured, prior to writing clueless code.

Speaking for the sym drivers, the sg list will NEVER be rewalked under any
O/S that want to provide a generic method to scatter the IO buffers. When
the normal semantic is supplied, as in the just complex as needed DMA
models, the drivers did and do things *right* regarding scatter/gather
without bloat.

  Gérard.

PS: If I want the sym driver to register as a PCI driver under Linux, then
some generic probing scheme seems to be unconditionnaly applied by the PCI
code. This just disallow the USER DEFINED boot order in the controller
NVRAMs to be applied by the driver. Did I miss something, or is it still
some clueless new generic method that bites me once again, here?

