Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130698AbRCIVVf>; Fri, 9 Mar 2001 16:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130684AbRCIVVZ>; Fri, 9 Mar 2001 16:21:25 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:55436 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S130696AbRCIVVW>; Fri, 9 Mar 2001 16:21:22 -0500
Date: Fri, 09 Mar 2001 13:14:03 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: SLAB vs. pci_alloc_xxx in usb-uhci patch
 [RFC: API]
To: "David S. Miller" <davem@redhat.com>
Cc: Johannes Erdfelt <johannes@erdfelt.com>,
        linux-usb-devel@lists.sourceforge.net,
        Manfred Spraul <manfred@colorfullife.com>,
        Russell King <rmk@arm.linux.org.uk>, zaitcev@redhat.com,
        linux-kernel@vger.kernel.org
Message-id: <071c01c0a8dd$e0ac4940$6800000a@brownell.org>
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
 <15017.7950.106874.276894@pizda.ninka.net>
 <20010309133502.R31345@sventech.com>
 <06a701c0a8d1$199377e0$6800000a@brownell.org>
 <15017.14312.932929.194773@pizda.ninka.net>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > Given that some hardware must return the dma addresses, why
>  > should it be a good thing to have an API that doesn't expose
>  > the notion of a reverse mapping?  At this level -- not the lower
>  > level code touching hardware PTEs.
> 
> Because its' _very_ expensive on certain machines.  You have to do
> 1 or more I/O accesses to get at the PTEs.

Except, I said this was NOT at that level.  Those costs don't
need to be incurred, but you are reasoning as if they did.


> If you add this reverse notion to just one API (the dma pool one) then
> people will complain (rightly) that there is not orthogonality in the
> API since the other mapping functions do not provide it.

"Orthogonality" is the wrong word there.  In fact, this is a highly
orthogonal approach:  each layer deals with distinct problems.
(Which is why I'd ignore that complaint.)

There's a bunch of functionality drivers need to have, and which
the pci_*_consistent() layer APIs (rightly) don't provide.  Just
like a kmem_cache provides functionality that's not visible
through the generic page allocator code; except that this needs
to work with the pci-specific page allocator.

It feels to me like you're being inconsistent here, objecting
to a library API for some functionality (mapping) yet not for
any of the other functionality (alignment, small size, poisoning
and so on).  And yet when Pete Zaitcev described what that
mapping code actually involved, you didn't object.  So you've
succeeded in confusing me.  Care to unconfuse?

- Dave






