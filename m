Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130666AbRCITrM>; Fri, 9 Mar 2001 14:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130662AbRCITrE>; Fri, 9 Mar 2001 14:47:04 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:36536 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S130663AbRCITqw>; Fri, 9 Mar 2001 14:46:52 -0500
Date: Fri, 09 Mar 2001 11:42:38 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: SLAB vs. pci_alloc_xxx in usb-uhci patch
 [RFC: API]
To: Johannes Erdfelt <johannes@erdfelt.com>,
        linux-usb-devel@lists.sourceforge.net
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Russell King <rmk@arm.linux.org.uk>, zaitcev@redhat.com,
        linux-kernel@vger.kernel.org
Message-id: <06a701c0a8d1$199377e0$6800000a@brownell.org>
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
 <15017.7950.106874.276894@pizda.ninka.net> <20010309133502.R31345@sventech.com>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  > Do lots of drivers need the reverse mapping? It wasn't on my todo list
> >  > yet.
> > 
> > I am against any API which provides this.  It can be extremely
> > expensive to do this on some architectures, 

The implementation I posted needed no architecture-specific
knowledge.  If cost is the issue, fine -- this makes it finite,
(not infinite), and some drivers can eliminate that cost.


> >        and since the rest
> > of the PCI dma API does not provide such an interface neither
> > should the pool routines.
> 
> The API I hacked together for uhci.c didn't have this.

But it didn't handle the OHCI done-list processing, and we've heard
a lot more about pci_*_consistent being needed with OHCI than
with UHCI; it's more common on non-Intel architectures.

Given that some hardware must return the dma addresses, why
should it be a good thing to have an API that doesn't expose
the notion of a reverse mapping?  At this level -- not the lower
level code touching hardware PTEs.

- Dave


