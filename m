Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267089AbSLDVMb>; Wed, 4 Dec 2002 16:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267090AbSLDVMb>; Wed, 4 Dec 2002 16:12:31 -0500
Received: from smtp02.fields.gol.com ([203.216.5.132]:54970 "EHLO
	smtp02.fields.gol.com") by vger.kernel.org with ESMTP
	id <S267089AbSLDVMa>; Wed, 4 Dec 2002 16:12:30 -0500
To: James@tc-1-100.kawasaki.gol.ne.jp,
       Bottomley@tc-1-100.kawasaki.gol.ne.jp (James.Bottomley@SteelEye.com)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
In-Reply-To: <200212041747.gB4HlEF03005@localhost.localdomain>
References: <200212041747.gB4HlEF03005@localhost.localdomain>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
From: Miles Bader <miles@gnu.org>
Date: 05 Dec 2002 06:19:57 +0900
Message-ID: <87vg29iirm.fsf@tc-1-100.kawasaki.gol.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Abuse-Complaints: abuse@gol.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley writes:
> Currently our only DMA API is highly PCI specific (making any non-pci
> bus with a DMA controller create fake PCI devices to help it
> function).
>
> Now that we have the generic device model, it should be equally
> possible to rephrase the entire API for generic devices instead of
> pci_devs.

Keep in mind that sometimes the actual _implementation_ is also highly
PCI-specific -- that is, what works for PCI devices may not work for
other devices and vice-versa.

So perhaps instead of just replacing `pci_...' with `dma_...', it would
be better to add new function pointers to `struct bus_type' for all this
stuff (or something like that).

> The PCI api has pci_alloc_consistent which allocates only consistent memory
> and fails the allocation if none is available thus leading to driver writers
> who might need to function with inconsistent memory to detect this and employ
> a fallback strategy.
> ...
> The idea is that the memory type can be coded into dma_addr_t which the
> subsequent memory sync operations can use to determine whether
> wback/invalidate should be a nop or not.

How is the driver supposed to tell whether a given dma_addr_t value
represents consistent memory or not?  It seems like an (arch-specific)
`dma_addr_is_consistent' function is necessary, but I couldn't see one
in your patch.

Thanks,

-Miles
-- 
We are all lying in the gutter, but some of us are looking at the stars.
-Oscar Wilde
