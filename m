Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155135AbQAaGDJ>; Mon, 31 Jan 2000 01:03:09 -0500
Received: by vger.rutgers.edu id <S155172AbQAaF42>; Mon, 31 Jan 2000 00:56:28 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:4956 "EHLO smtp1.cern.ch") by vger.rutgers.edu with ESMTP id <S155170AbQAaFxE>; Mon, 31 Jan 2000 00:53:04 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.rutgers.edu
Subject: Re: DMA changes in 2.3.41 - how the f* do I get this working on ARM?
References: <200001300006.AAA02084@raistlin.arm.linux.org.uk> <200001302211.OAA03036@pizda.ninka.net>
From: Jes Sorensen <Jes.Sorensen@cern.ch>
Date: 31 Jan 2000 11:02:28 +0100
In-Reply-To: "David S. Miller"'s message of "Sun, 30 Jan 2000 14:11:49 -0800"
Message-ID: <d3oga2r22z.fsf@lxplus011.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-kernel@vger.rutgers.edu

>>>>> "David" == David S Miller <davem@redhat.com> writes:

David>    From: Russell King <rmk@arm.linux.org.uk> Date: Sun, 30 Jan
David> 2000 00:06:15 +0000 (GMT)

>    I would have preferred to have heard about the extent of
> these changes (and that the dma_cache_* macros were going to be
> removed, along with my comments marking them with my initials)
> before it was submitted.

David> For the actual transfers, you can do the dma_cache_*() calls in
David> the pci_{un,}map_streaming() calls.

David> The only place you could possibly need it is for the IDE
David> scatter list tables, and that would only be if you have _no_
David> mechanism to disable the CPU cache in the MMU, which I severely
David> doubt.

Hmmm ok I just noticed this and I haven't read that DMA mapping
document yet. I'll have to look at it to see how it affects PCI
devices that are 64 bit address capable.

The one thing for the m68k is that we have very few machines with
PCI, though we still suffer a lot from the DMA coherency problem on
the busses we do have.

The place where this is a real problem is in drivers where data is
shared between the adapter and the host CPU, for instance the 53c7xx
driver. On the m68k we currently use a kernel_set_cachemode() function
to change the caching of the page allocated for the shared structures,
but thats a pretty non portable way of doing it. I would like to see
something a get_free_cachecoherent_page() interface instead, what do
you think of that?

Jes

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
