Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154512AbQA3BwC>; Sat, 29 Jan 2000 20:52:02 -0500
Received: by vger.rutgers.edu id <S154479AbQA3Bvd>; Sat, 29 Jan 2000 20:51:33 -0500
Received: from sunsite.ms.mff.cuni.cz ([195.113.19.66]:2355 "EHLO sunsite.ms.mff.cuni.cz") by vger.rutgers.edu with ESMTP id <S154592AbQA3Btv>; Sat, 29 Jan 2000 20:49:51 -0500
Date: Sun, 30 Jan 2000 07:01:26 +0100
From: Jakub Jelinek <jakub@redhat.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.rutgers.edu
Subject: Re: DMA changes in 2.3.41 - how the f* do I get this working on ARM?
Message-ID: <20000130070126.C948@mff.cuni.cz>
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>, "David S. Miller" <davem@redhat.com>, linux-kernel@vger.rutgers.edu
References: <200001300006.AAA02084@raistlin.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <200001300006.AAA02084@raistlin.arm.linux.org.uk>; from Russell King on Sun, Jan 30, 2000 at 12:06:15AM +0000
Sender: owner-linux-kernel@vger.rutgers.edu

On Sun, Jan 30, 2000 at 12:06:15AM +0000, Russell King wrote:
> Hi,
> 
> I've been looking over the 2.3.41 patch, and have come across a major problem
> area for ARM.
> 
> On ARM, there is no such thing as "dma coherent" memory.  Unfortunately, the
> new PCI code (pci_alloc_consistent) appears to assume that there is a way
> of doing this.

Some SPARCs are not DMA coherent either and a similar interface works for
them for quite some years.
With the pci_map_single/pci_map_sg/pci_unmap_single/pci_unmap_sg
you can sync caches in those routines as required (plus there are
pci_dma_sync_single/pci_dma_sync_sg which should sync as well).
With pci_alloc_consistant, on DMA non-coherent systems the trick is to
allocate a non-cacheable memory (or make it uncacheable after allocating).

> 
> I have had ideas about ways to do this on the ARM, but it will not be trivial
> changes to the mm layer, and certainly has not been implemented yet.
> 
> This effectively means that I seem to have two options:
> 
> 1. either we loose any hope of IDE DMA for the rest of 2.3 and 2.4, or
> 2. the IDE DMA code gets the dma_cache_* macros added back in
> 
> I would have preferred to have heard about the extent of these changes (and
> that the dma_cache_* macros were going to be removed, along with my comments
> marking them with my initials) before it was submitted.

The interface was lined out e.g. during the
Alpha: virt_to_bus/GFP_DMA problem
thread on l-k in december.

Cheers,
    Jakub
___________________________________________________________________
Jakub Jelinek | jakub@redhat.com | http://sunsite.mff.cuni.cz/~jj
Linux version 2.3.41 on a sparc64 machine (1343.49 BogoMips)
___________________________________________________________________

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
