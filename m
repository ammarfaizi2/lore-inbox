Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281841AbRLLTdt>; Wed, 12 Dec 2001 14:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281843AbRLLTdk>; Wed, 12 Dec 2001 14:33:40 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:57385 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S281841AbRLLTdf> convert rfc822-to-8bit; Wed, 12 Dec 2001 14:33:35 -0500
Date: Wed, 12 Dec 2001 17:39:20 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Jens Axboe <axboe@suse.de>
cc: "David S. Miller" <davem@redhat.com>, <gibbs@scsiguy.com>,
        <LB33JM16@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
In-Reply-To: <20011212093654.GA13498@suse.de>
Message-ID: <20011212170821.K1853-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Dec 2001, Jens Axboe wrote:

> On Tue, Dec 11 2001, Gérard Roudier wrote:

[...]

> > As you know, low-level drivers on Linux announce some maximum length for
> > the sg array. As you guess, in the worst case, each sg entry may have to
> > be cut into several real entry (hoped 2 maximum) due to boundary
> > limitations. At a first glance, low-level drivers should announce no more
> > than half their real sg length capability and also would have to rewalk
> > the entire sg list.
>
> That's why these boundary limitations need to be known by the layer
> build the requests for you.

How can I tell the layer about boundaries ?
Will check if I missed some important change.

> > I used and was happy to do so when the scatter process was not generic.
> > If we want it to be generic, then we want it to do the needed work. If
> > generic means 'just bloated and clueless' then generic is a extreme bad
> > thing.
> >
> > 'virt_to_bus' + 'flat addressing model' was the 'just as complex as
> > needed' for DMA model and most (may-be > 99%) of existing physical
> > machines are just happy with such model. The DMA/BUS complexity all O/Ses
> > have invented nowadays is a useless misfeature when based on the reality,
> > in my opinion. So, I may just be dreaming, at the moment. :-)
> >
> > If one really wants for some marketing reason to support these ugly and
> > stinky '32 bit machines that want to provide more than 4GB of memory by
> > shoe-horning complexity all over the place', one should use his brain,
> > when so-featured, prior to writing clueless code.
>
> First of all, virt_to_bus just cannot work on some archetectures that
> are just slightly more advanced than x86. I'm quite sure Davem is ready
> to lecture you on this.
>
> Second, you are misunderstanding the need of a page/offset instead of
> virtua_address model. It's _not_ for > 4GB machines, it's for machines
> with highmem. You'll need this on the standard kernel to I/O above
> 860MB, that that is definitely a much bigger part of the market. Heck,
> lots of home users have 1GB or more with the RAM prices these days.

I didn't misunderstand anything here, but have probably been unclear. The
3GB user + 1 GB kernel - some room for vremap/vmalloc looks a Linuxish
issue to me and I wanted to be more general here. By the way, speaking for
meyself, I donnot use bloaty applications and hence, at least in theory,
it will be possible for me to use at least 2GB of physical memory without
need of any kind of higmem crap. My guess is that 2GB of physical memory
still encompasses 99% of physically machines in use.

About what I call '32 bit machine', the sparc64 with its s****d IOMMU does
falls in this category. The CPU can do 64 bit operations and addressing,
but as seen from IO, the silicium is some 32 bit out-of-age thing hacked
for 64 bit memory addressing capability and some proprietary BUS streaming
protocol.

FYI, my personnal machine uses a ServerWorks LE chipset. The thing is 32
bit, but it is clean design regarding buses. It is possible for example
for a device on one PCI BUS to master another device on the other PCI BUS.
And the PCI BUses bandwidth seems quite good.

For your memory refresh, virtual memory has been invented for programs to
be allowed to be larger than the physical memory. OTOH, all archs based on
memory segmentations have been replaced by a flat model since this led to
unbearable complexity. The current 32 bit to 64 bit transition resembles
the 8/16 bit and 16 bit/32 bit transition, adding same kind of useless
complexity in software. This stinks a lot. Let me not encourage this a
single second.

  Gérard.

