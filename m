Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272096AbRHWBb3>; Wed, 22 Aug 2001 21:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272107AbRHWBbJ>; Wed, 22 Aug 2001 21:31:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49282 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272106AbRHWBbA>;
	Wed, 22 Aug 2001 21:31:00 -0400
Date: Wed, 22 Aug 2001 18:31:09 -0700 (PDT)
Message-Id: <20010822.183109.34763266.davem@redhat.com>
To: kevin.vanmaren@unisys.com
Cc: gibbs@scsiguy.com, linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <245F259ABD41D511A07000D0B71C4CBA289F2E@us-slc-exch-3.slc.unisys.com>
In-Reply-To: <245F259ABD41D511A07000D0B71C4CBA289F2E@us-slc-exch-3.slc.unisys.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
   Date: Wed, 22 Aug 2001 20:06:21 -0500

   There had better not be any.  It is a violation of the PCI specification
   to generate a DAC if the address fits in 32 bits.
   
Then sym53c8xx with Gerard's current scripts code is in violation of
the PCI specification when the chip is told to use DAC :-)

   DAC is a LOT faster and more efficient than a copy (except perhaps for the
   very smallest of transfers, which are already very inefficient).

SAC with IOMMU is faster on some platforms.
   
   Separate 32-bit and 64-bit DMA routines adds unnecessary complication.
   As far as I can tell, the only reason to have separate APIs is so
   that 32bit machines with 64 bit DMA  addresses (PAE on ia32) can
   avoid copying around an "extra" 32bits of address for the drivers
   that don't support 64-bit DMA.

Welcome to the complicated real world.

There are several other reasons.  (Man, people check the archives, I
feel like I've typed this in like 5 times in linux-kernel postings
already)  Let me list one of them, suppose you have a device for which
some transfers can happily use DAC addresses, but some others strictly
need to work with SAC addresses.

pci64_*() would mean "DAC address would be OK".

   I think it makes more sense to just make the dma_addr_t 64 bits on
   ia32 if using PAE and deal with the insignificant "waste" -- you
   have > 4GB RAM :-)

I think for SAC-only devices, it is just dumb wasted space in the
driver image.

I do not want to even go into the abuse I took in my email when I
added the original APIs because people had to keep track of the
damn mappings at all!  These people would strangle me if they learnt
that in HIGHMEM kernels twice as much space was needed to do this
DMA address tracking.

I at least comfort myself that those who maintain drivers on several
platforms, and have an open mind, such as Gerard, for the most part
support the API I have designed.

Later,
David S. Miller
davem@redhat.com
