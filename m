Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130702AbRCIVho>; Fri, 9 Mar 2001 16:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130705AbRCIVhe>; Fri, 9 Mar 2001 16:37:34 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:518 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130702AbRCIVh2>; Fri, 9 Mar 2001 16:37:28 -0500
Subject: Re: [linux-usb-devel] Re: SLAB vs. pci_alloc_xxx in usb-uhci patch [RFC: API]
To: linux-usb-devel@lists.sourceforge.net
Date: Fri, 9 Mar 2001 21:38:35 +0000 (GMT)
Cc: david-b@pacbell.net (David Brownell),
        manfred@colorfullife.com (Manfred Spraul),
        davem@redhat.com (David S. Miller),
        rmk@arm.linux.org.uk (Russell King), zaitcev@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010309141442.A18207@devserv.devel.redhat.com> from "Pete Zaitcev" at Mar 09, 2001 02:14:42 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14bUar-0005kI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder if it may be feasible to allocate a bunch of contiguous
> pages. Then, whenever the hardware returns a bus address, subtract
> the remembered bus address of the zone start, add the offset to
> the virtual and voila.

Even if not you can hash by page number not low bits so the hash is way 
smaller. You (in most cases) can also write the entry number in the relevant
tables onto the end of the object in spare space (or in front of it)

Something as trivial as

	struct usb_thingy
	{
		u32 thing_id;
		u32 flags;
		struct usb_thingy *next;
#ifndef __LP64__
		u32 pad
#endif
		struct usb_controller_goo goo;
	}

Alan

