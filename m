Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154749AbQA3SGn>; Sun, 30 Jan 2000 13:06:43 -0500
Received: by vger.rutgers.edu id <S154311AbQA3SGf>; Sun, 30 Jan 2000 13:06:35 -0500
Received: from [216.101.162.242] ([216.101.162.242]:32821 "EHLO pizda.ninka.net") by vger.rutgers.edu with ESMTP id <S154735AbQA3SGV>; Sun, 30 Jan 2000 13:06:21 -0500
Date: Sun, 30 Jan 2000 14:11:49 -0800
Message-Id: <200001302211.OAA03036@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.rutgers.edu
In-reply-to: <200001300006.AAA02084@raistlin.arm.linux.org.uk> (message from Russell King on Sun, 30 Jan 2000 00:06:15 +0000 (GMT))
Subject: Re: DMA changes in 2.3.41 - how the f* do I get this working on ARM?
References: <200001300006.AAA02084@raistlin.arm.linux.org.uk>
Sender: owner-linux-kernel@vger.rutgers.edu

   From: Russell King <rmk@arm.linux.org.uk>
   Date:   Sun, 30 Jan 2000 00:06:15 +0000 (GMT)

   On ARM, there is no such thing as "dma coherent" memory.  Unfortunately, the
   new PCI code (pci_alloc_consistent) appears to assume that there is a way
   of doing this.

You have no mechanism whatsoever to disable the cache on a per-page
basis with MMU mappings?  This would very much surprise me.

   I would have preferred to have heard about the extent of these changes (and
   that the dma_cache_* macros were going to be removed, along with my comments
   marking them with my initials) before it was submitted.

For the actual transfers, you can do the dma_cache_*() calls in the
pci_{un,}map_streaming() calls.

The only place you could possibly need it is for the IDE scatter list
tables, and that would only be if you have _no_ mechanism to disable
the CPU cache in the MMU, which I severely doubt.

   For now, I'm adding the dma_cache_* macros back in, and if I don't hear anything,
   I will be re-submitting that code back to Linus.

   (very pissed)

Actually, don't be pissed, and instead work with us to get your
port working again.  The changes were designed so that all of
the cache flushing hacks could just dissapear and be hidden
within the new interfaces on ports which needed.

I was completely convinced that if all dma mappings were handled
explicitly in the manner they are now, none of that crap would be
needed anymore.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
