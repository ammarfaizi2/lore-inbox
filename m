Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130745AbRCIXTZ>; Fri, 9 Mar 2001 18:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130753AbRCIXTP>; Fri, 9 Mar 2001 18:19:15 -0500
Received: from front7m.grolier.fr ([195.36.216.57]:27900 "EHLO
	front7m.grolier.fr") by vger.kernel.org with ESMTP
	id <S130745AbRCIXS7> convert rfc822-to-8bit; Fri, 9 Mar 2001 18:18:59 -0500
Date: Fri, 9 Mar 2001 22:07:24 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: David Brownell <david-b@pacbell.net>
cc: Pete Zaitcev <zaitcev@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        "David S. Miller" <davem@redhat.com>,
        Russell King <rmk@arm.linux.org.uk>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: SLAB vs. pci_alloc_xxx in usb-uhci patch [RFC: API]
In-Reply-To: <078101c0a8ea$44cd6920$6800000a@brownell.org>
Message-ID: <Pine.LNX.4.10.10103092150260.1818-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Mar 2001, David Brownell wrote:

> Gérard --
> 
> > Just for information to people that want to complexify the
> > pci_alloc_consistent() interface thats looks simple and elegant to me:
> 
> I certainly didn't propose that!  Just a layer on top of the
> pci_alloc_consistent code -- used as a page allocator, just
> like you used it.
> 
> 
> >   The object file of the allocator as seen in sym2 is as tiny as 3.4K
> >   unstripped and 2.5K stripped.
> 
> What I sent along just compiled to 2.3 KB ... stripped, and "-O".
> Maybe smaller with normal kernel flags.  The reverse mapping
> code hast to be less than 0.1KB.

If reverse mapping means bus_to_virt(), then I would suggest not to
provide it since it is a confusing interface. OTOH, only a few drivers
need or want to retrieve the virtual address that lead to some bus dma
address and they should check that this virtual address is still valid
prior to using it. As I wrote, some trivial hashed list can be used by
such drivers (as sym* do).

> I looked at your code, but it didn't seem straightforward to reuse.
> I think the allocation and deallocation costs can be pretty comparable
> in the two implementations.  Your implementation might even fit behind
> the API I sent.  They're both layers over pci_*_consistent (and both
> have address-to-address mappings, implemented much the same).

I wanted the code as short as possible since the driver code is already
very large. On the other hand there are bunches of #ifdef to deal with all
still alive kernel versions. As a result, the code may well not be general
nor clean enough to be moved to the kernel. Just what it actually does is 
fairly simple.

> > Now, if modern programmers are expecting Java-like interfaces for writing
> > kernel software, it is indeed another story. :-)
> 
> Only if when you wrote "Java-like" you really meant "reusable"!  :)

Hmmm... 'reusable' implies 'usable'...
Does 'usable' apply to Java applications ? :-)

  Gérard.

