Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130145AbRCGGVG>; Wed, 7 Mar 2001 01:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130240AbRCGGU5>; Wed, 7 Mar 2001 01:20:57 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:16827 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S130145AbRCGGUx>; Wed, 7 Mar 2001 01:20:53 -0500
Date: Mon, 05 Mar 2001 18:29:27 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: SLAB vs. pci_alloc_xxx in usb-uhci patch
To: linux-usb-devel@lists.sourceforge.net, Russell King <rmk@arm.linux.org.uk>
Cc: Manfred Spraul <manfred@colorfullife.com>, zaitcev@redhat.com,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <026b01c0a5e5$4513e740$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <E14a6uW-0008Gd-00@the-village.bc.nu>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > At the time, I didn't feel like creating a custom sub-allocator just
> > for USB, ...
> >
> > I'd be good to get it done "properly" at some point though.
> 
> Something like
> 
> struct pci_pool *pci_alloc_consistent_pool(int objectsize, int align)

    struct pci_pool *
    pci_create_consistent_pool (struct pci_dev *dev, int size, int align)

and similar for freeing the pool ... pci_alloc_consistent() needs the device,
presumably since some devices may need to dma into specific memory.
I'd probably want at least "flags" from kmem_cache_create().


> pci_alloc_pool_consistent(pool,..
> pci_free_pool_consistent(pool,..

These should have signatures just like pci_alloc_consistent() and
pci_free_consistent() except they take the pci_pool, not a pci_dev.
Oh, and likely GFP_ flags to control blocking.


> Where the pool allocator does page grabbing and chaining

Given an agreement on API, I suspect Johannes' patch could get
quickly generalized.  Then debugging support (like in slab.c) could
be added later.

- Dave


