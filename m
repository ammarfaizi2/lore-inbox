Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272188AbRHWCWo>; Wed, 22 Aug 2001 22:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272187AbRHWCWf>; Wed, 22 Aug 2001 22:22:35 -0400
Received: from eamail1-out.unisys.com ([192.61.61.99]:2208 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S272186AbRHWCWV>; Wed, 22 Aug 2001 22:22:21 -0400
Message-ID: <245F259ABD41D511A07000D0B71C4CBA289F30@us-slc-exch-3.slc.unisys.com>
From: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
To: "'David S. Miller'" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: With Daniel Phillips Patch
Date: Wed, 22 Aug 2001 21:22:19 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    There had better not be any.  It is a violation of the PCI 
> specification
>    to generate a DAC if the address fits in 32 bits.
>    
> Then sym53c8xx with Gerard's current scripts code is in violation of
> the PCI specification when the chip is told to use DAC :-)

If you say so.  You make it sound like the driver can
compensate for the broken hardware by explicitly telling
it to use SAC for a transfer after checking if the
dma_addr < 4GB.  The HW is not in "violation" if it doesn't
generate a DAC < 4GB, and if it takes a driver check to
ensure that, it is the driver's problem: it is trivial to
check the high 32-bits of a 64-bit address for 0.

If the HW generates DAC for addresses < 4GB whenever enabling
support for 64-bit addresses, then that is very broken.

>    DAC is a LOT faster and more efficient than a copy (except 
> perhaps for the
>    very smallest of transfers, which are already very inefficient).
> 
> SAC with IOMMU is faster on some platforms.

Okay, so when the driver asks for the physical address, the arch-
specific code maps it with the iommu and returns a 32-bit address.
In that case, the dma_addr_t is 32 bits (unless it can return
64-bit addresses as well).

> There are several other reasons.  (Man, people check the archives, I
> feel like I've typed this in like 5 times in linux-kernel postings
> already)

If you send pointer to your previous message I will read it.  I am
interested in this subject (and have experience), so I threw in my
2 cents.  Please don't complain that I didn't spend hours searching
through the archives looking for a message from months? years? ago
that I didn't know existed.

> Let me list one of them, suppose you have a device for which
> some transfers can happily use DAC addresses, but some others strictly
> need to work with SAC addresses.

What does that have to do with anything?  That just means that the
DMA constraints have to be specified on a per-mapping/per-allocation
basis, not a per-device basis.  That doesn't mean you need separate
routines for 64-bit PCI addresses and 32-bit PCI addresses.  It just
means you need sane DMA constraints handling.

> I think for SAC-only devices, it is just dumb wasted space in the
> driver image.

Perhaps.  But the question is whether it is simpler/better to have
HIGHMEM x86 kernels (which by definition have memory to spare) waste
a few bytes to provide "sane" interfaces across all platforms.  And
whether the kernel bloat for all the additional functions compensates
for it ;-)

Reasonable people can have different opinions.

Kevin Van Maren
