Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131184AbRCGUhP>; Wed, 7 Mar 2001 15:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131193AbRCGUhG>; Wed, 7 Mar 2001 15:37:06 -0500
Received: from colorfullife.com ([216.156.138.34]:6412 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131184AbRCGUgt>;
	Wed, 7 Mar 2001 15:36:49 -0500
Message-ID: <003601c0a746$57ab5750$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Jes Sorensen" <jes@linuxcare.com>
Cc: "Mark Hemment" <markhe@veritas.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0103011800460.11260-100000@alloc> <3A9EA940.CB82665C@colorfullife.com> <d3lmqhny9w.fsf@lxplus015.cern.ch>
Subject: Re: Q: explicit alignment control for the slab allocator
Date: Wed, 7 Mar 2001 21:32:45 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jes Sorensen" <jes@linuxcare.com>
> >>>>> "Manfred" == Manfred Spraul <manfred@colorfullife.com> writes:
>
> Manfred> Mark Hemment wrote:
> >> As no one uses the feature it could well be broken, but is that a
> >> reason to change its meaning?
>
> Manfred> Some hardware drivers use HW_CACHEALIGN and assume certain
> Manfred> byte alignments, and arm needs 1024 byte aligned blocks.
>
> Isn't that just a reinvention of SMP_CACHE_BYTES? Or are there
> actually machines out there where the inbetween CPU cache line size
> differs from the between CPU and DMA controller cache line size?
>
No.

First of all HW_CACHEALIGN aligns to the L1 cache, not SMP_CACHE_BYTES.
Additionally you sometimes need a guaranteed alignment for other
problems, afaik ARM needs 1024 bytes for some structures due to cpu
restrictions, and several usb controllers need 16 byte alignment.

And some callers of kmem_cache_create() want SMP_CACHE_BYTES alignment,
other callers (and DaveM) expect L1_CACHE_BYTES alignment.

It's more a API clarification than a real change.

I think it can wait until 2.5:
drivers should use pci_alloc_consistent_pool(), not
kmalloc_aligned()+virt_to_bus(), arm can wait and the ability to choose
between SMP and L1 alignment is not that important.

--
    Manfred

