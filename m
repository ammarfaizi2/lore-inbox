Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135958AbRAUIhN>; Sun, 21 Jan 2001 03:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136017AbRAUIhE>; Sun, 21 Jan 2001 03:37:04 -0500
Received: from colorfullife.com ([216.156.138.34]:5902 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S135958AbRAUIgu>;
	Sun, 21 Jan 2001 03:36:50 -0500
Message-ID: <3A6A9F9A.3CDE1B05@colorfullife.com>
Date: Sun, 21 Jan 2001 09:36:42 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Johannes Erdfelt <johannes@erdfelt.com>, linux-kernel@vger.kernel.org
Subject: Re: Inefficient PCI DMA usage (was: [experimental patch] UHCI updates)
In-Reply-To: <200101202315.f0KNFTV01790@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> Johannes Erdfelt writes:
> > They need to be visible via DMA. They need to be 16 byte aligned. We
> > also have QH's which have similar requirements, but we don't use as many
> > of them.
> 
> Can we get away from the "16 byte aligned" and make it "n byte aligned"?
> I believe that slab already has support for this?
>

Not yet, but that would be a 2 line patch (currently it's hardcoded to
BYTES_PER_WORD align or L1_CACHE_BYTES, depending on the HWCACHE_ALIGN
flag).

But there are 2 other problems:
* kmem_cache_alloc returns one pointer, pci_alloc_consistent 2 pointers:
one dma address, one virtual address.
* The code relies on the virt_to_page() macro.

The second problem is the difficult one, I don't see how I could remove
that dependency without a major overhaul.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
