Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155015AbQAaATR>; Sun, 30 Jan 2000 19:19:17 -0500
Received: by vger.rutgers.edu id <S154999AbQAaASu>; Sun, 30 Jan 2000 19:18:50 -0500
Received: from fw.suse.com ([216.88.157.2]:61441 "HELO suse.com") by vger.rutgers.edu with SMTP id <S155032AbQAaASX>; Sun, 30 Jan 2000 19:18:23 -0500
Date: Sun, 30 Jan 2000 20:27:18 -0800 (PST)
From: Andre Hedrick <andre@suse.com>
To: "David S. Miller" <davem@redhat.com>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.rutgers.edu
Subject: Re: DMA changes in 2.3.41 - how the f* do I get this working on ARM?
In-Reply-To: <200001302211.OAA03036@pizda.ninka.net>
Message-ID: <Pine.LNX.4.10.10001302024210.18120-100000@home.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


David,

It is important that we all work togather, but there has been at least one
other occassion that this code has been nuke by accident.  And yes, pissed
off never worked again since the begin of the hand off of IDE between
2.1.112 and 2.1.122..  Russell, I am in your corner to help fix this.


On Sun, 30 Jan 2000, David S. Miller wrote:

>    From: Russell King <rmk@arm.linux.org.uk>
>    Date:   Sun, 30 Jan 2000 00:06:15 +0000 (GMT)
> 
>    On ARM, there is no such thing as "dma coherent" memory.  Unfortunately, the
>    new PCI code (pci_alloc_consistent) appears to assume that there is a way
>    of doing this.
> 
> You have no mechanism whatsoever to disable the cache on a per-page
> basis with MMU mappings?  This would very much surprise me.
> 
>    I would have preferred to have heard about the extent of these changes (and
>    that the dma_cache_* macros were going to be removed, along with my comments
>    marking them with my initials) before it was submitted.
> 
> For the actual transfers, you can do the dma_cache_*() calls in the
> pci_{un,}map_streaming() calls.
> 
> The only place you could possibly need it is for the IDE scatter list
> tables, and that would only be if you have _no_ mechanism to disable
> the CPU cache in the MMU, which I severely doubt.
> 
>    For now, I'm adding the dma_cache_* macros back in, and if I don't hear anything,
>    I will be re-submitting that code back to Linus.
> 
>    (very pissed)
> 
> Actually, don't be pissed, and instead work with us to get your
> port working again.  The changes were designed so that all of
> the cache flushing hacks could just dissapear and be hidden
> within the new interfaces on ports which needed.
> 
> I was completely convinced that if all dma mappings were handled
> explicitly in the manner they are now, none of that crap would be
> needed anymore.
> 
> Later,
> David S. Miller
> davem@redhat.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.rutgers.edu
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
The Linux ATA/IDE guy

THE USE OF EMAIL FOR THE TRANSMISSION OF UNSOLICITED COMMERCIAL
MATERIAL IS PROHIBITED UNDER FEDERAL LAW (47 USC 227). Violations may
result in civil penalties and claims of $500.00 PER OCCURRENCE
(47 USC 227[c]).  Commercial spam WILL be forwarded to postmasters.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
