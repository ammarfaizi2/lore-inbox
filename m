Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130603AbRCITlW>; Fri, 9 Mar 2001 14:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130636AbRCITlM>; Fri, 9 Mar 2001 14:41:12 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:7344 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S130603AbRCITk4>; Fri, 9 Mar 2001 14:40:56 -0500
Date: Fri, 09 Mar 2001 11:37:27 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: SLAB vs. pci_alloc_xxx in usb-uhci patch [RFC: API]
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        "David S. Miller" <davem@redhat.com>,
        Russell King <rmk@arm.linux.org.uk>, zaitcev@redhat.com,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <069601c0a8d0$6091b680$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <001f01c0a5c0$e942d8f0$5517fea9@local>
 <00d401c0a5c6$f289d200$6800000a@brownell.org>
 <20010305232053.A16634@flint.arm.linux.org.uk>
 <15012.27969.175306.527274@pizda.ninka.net>
 <055e01c0a8b4$8d91dbe0$6800000a@brownell.org>
 <3AA91B2C.BEB85D8C@colorfullife.com>
 <060e01c0a8c6$ddbcc1e0$6800000a@brownell.org>
 <20010309141442.A18207@devserv.devel.redhat.com>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > extern void *
> > > > pci_pool_dma_to_cpu (struct pci_pool *pool, dma_addr_t handle);
> > > 
> > > Do lots of drivers need the reverse mapping? It wasn't on my todo list
> > > yet.
> > 
> > Some hardware (like OHCI) talks to drivers using those dma handles.
> 
> I wonder if it may be feasible to allocate a bunch of contiguous
> pages. Then, whenever the hardware returns a bus address, subtract
> the remembered bus address of the zone start, add the offset to
> the virtual and voila.

That's effectively what the implementation I posted is doing.

Simple math ... as soon as you get the right "logical page",
and that page size could become a per-pool tunable.  Currently
one logical page is PAGE_SIZE; there are some issues to
deal with in terms of not crossing page boundaries.

There can be multiple such pages, known to the pool allocator
and hidden from the device drivers.  I'd expect most USB host
controllers wouldn't allocate more than one or two pages, so
the cost of this function would typically be small.

- Dave


