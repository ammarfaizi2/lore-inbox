Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282867AbRLLXTe>; Wed, 12 Dec 2001 18:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282874AbRLLXTY>; Wed, 12 Dec 2001 18:19:24 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:26159 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S282867AbRLLXTS> convert rfc822-to-8bit; Wed, 12 Dec 2001 18:19:18 -0500
Date: Wed, 12 Dec 2001 21:24:59 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Andrea Arcangeli <andrea@suse.de>
cc: Jens Axboe <axboe@suse.de>, "David S. Miller" <davem@redhat.com>,
        <gibbs@scsiguy.com>, <LB33JM16@yahoo.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
In-Reply-To: <20011212231936.Q4801@athlon.random>
Message-ID: <20011212210923.I642-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Dec 2001, Andrea Arcangeli wrote:

> On Wed, Dec 12, 2001 at 06:22:30PM +0100, Gérard Roudier wrote:
> >
> >
> > On Wed, 12 Dec 2001, Andrea Arcangeli wrote:
> >
> > > On Wed, Dec 12, 2001 at 10:36:54AM +0100, Jens Axboe wrote:
> >
> > > > > If one really wants for some marketing reason to support these ugly and
> > > > > stinky '32 bit machines that want to provide more than 4GB of memory by
> > > > > shoe-horning complexity all over the place', one should use his brain,
> > > > > when so-featured, prior to writing clueless code.
> > > >
> > > > First of all, virt_to_bus just cannot work on some archetectures that
> > > > are just slightly more advanced than x86. I'm quite sure Davem is ready
> > > > to lecture you on this.
> > >
> > > yes, the whole point of the iommu work (replacement for virt_to_bus) is
> > > for the 64bit machines, not for the 32bit machines. It's to allow the
> > > 64bit machines to do zerocopy dma (no bounce buffers) on memory above 4G
> > > with pci32 devices that doesn't support DAC.
> >
> > So, the PCI group should just have specified a 16 bit BUS and have told
> > that systems should implement some IOMMU in order to address the whole
> > memory. :-)
>
> 8)8)
>
> > PCI was intended to be implemented as a LOCAL BUS with all agents on the
> > LOCAL BUS being able to talk with any other agent using a flat addressing
> > scheme. Your PCI thing does not look like true PCI to me, but rather like
> > some bad mutant that has every chance not to survive a long time.
>
> It's not only a matter of the MSB of the "max bus address" supported,
> it's also a matter of "how much ram" can be under DMA at the same time.
> With pci32 we have a window of 4G of physical ram that can be
> simultaneously under I/O at the same time. The linux API (or better all
> the drivers) are unfortunately broken so that if the 4G is overflowed
> the kernel crashes (but this is a minor detail :).  16 bit would limit
> way too much the amount of simultaneous I/O, 4G is rasonable instead
> (incidentally this is why linux usually doesn't crash on the 64bit
> boxes).  For the few apps (like quadrics or myrinet) that needs SG
> windows larger than 4G we just require DAC support and we don't use the
> iommu 32bit (also to avoid triggering the device driver bugs :).
>
> But this is true PCI, you know the device has no clue it is writing over
> 4G, that's the iommu work to map a certain bus address into a certain
> physical address.
>
> You are completly right: what you mean is that if the PCI group
> specified 64bit/DAC (instead of 32... or 16 :) as only possible way to
> do DMA with PCI, we wouldn't need the iommu on the 64bit boxes. But
> those pci32 card exists and the iommu is better than the bounce
> buffers... and after all the iommu/pci_map API is clean enough, except
> when all the drivers do pci_map_single and think it cannot fail, because
> it _can_ fail! (but of course the conversion was painful because a fail
> path wasn't designed into the drivers and so now we can crash instead :)
>
> I guess passing through pci32 is been cheaper while on the x86. Not sure
> how much cheaper on the long run though, given we're paying for the
> iommu chips now.

Thanks for your explanations, Andrea.

My point is not that, given current hardware, supporting IOMMUs and other
weirdnesses is not the right thing to do. It is, very probably, ..., in
fact, I don't care. But, we should not be happy to have to support this.
After all, there are numerous situations in life where we have painful
things to do. Being happy with pain is called masochism. :)

A N% loss for the 99% case in order to support the 1% is close to N%
loss. So, each time we bloat or complexify the code with no relevance for
the average case, the overall difference cannot be a win.

  Gérard.

