Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130600AbRCISfk>; Fri, 9 Mar 2001 13:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130603AbRCISfb>; Fri, 9 Mar 2001 13:35:31 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:8914 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S130600AbRCISfR>; Fri, 9 Mar 2001 13:35:17 -0500
Date: Fri, 09 Mar 2001 10:29:22 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: SLAB vs. pci_alloc_xxx in usb-uhci patch [RFC: API]
To: Manfred Spraul <manfred@colorfullife.com>
Cc: "David S. Miller" <davem@redhat.com>, Russell King <rmk@arm.linux.org.uk>,
        zaitcev@redhat.com, linux-usb-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Message-id: <060e01c0a8c6$ddbcc1e0$6800000a@brownell.org>
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
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > unlike the slab allocator bug(s) I pointed out.  (And which
> > Manfred seems to have gone silent on.)
> 
> which bugs?

See my previous email ...  its behavior contradicts its spec,
and I'd sent a patch.  You said you wanted kmalloc to have
an "automagic redzoning" feature, which would involve one
more change (to the flags used in kmalloc init when magic
redzoning is in effect).  I'd expected a response.


> >  * this can easily be optimized, but the best fix would be to
> >  * make this just a bus-specific front end to mm/slab.c logic.
>                ^^^^
> 
> Adding that new frond end was already on my todo list for 2.5, but it
> means modifying half of mm/slab.c.

Exactly why I think we need a usable solution changing that
half!  And why I asked for feedback about the API, not a
focus on this particular implementation.


> >  if (align < L1_CACHE_BYTES)
> >   align = L1_CACHE_BYTES;
> 
> Why?

To see who was awake, of course!  That shouldn't be there.


> > /* Convert a DMA mapping to its cpu address (as returned by pci_pool_alloc).
> >  * Don't assume this is cheap, although on some platforms it may be simple
> >  * macros adding a constant to the DMA handle.
> >  */
> > extern void *
> > pci_pool_dma_to_cpu (struct pci_pool *pool, dma_addr_t handle);
> 
> Do lots of drivers need the reverse mapping? It wasn't on my todo list
> yet.

Some hardware (like OHCI) talks to drivers using those dma handles.

- Dave


