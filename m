Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261924AbRETNlm>; Sun, 20 May 2001 09:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261925AbRETNlc>; Sun, 20 May 2001 09:41:32 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:14456 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261924AbRETNl0>; Sun, 20 May 2001 09:41:26 -0400
Date: Sun, 20 May 2001 15:40:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010520154044.C18119@athlon.random>
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru> <20010519155502.A16482@athlon.random> <20010519231131.A2840@jurassic.park.msu.ru> <20010520044013.A18119@athlon.random> <20010520161234.B8223@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010520161234.B8223@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Sun, May 20, 2001 at 04:12:34PM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2001 at 04:12:34PM +0400, Ivan Kokshaysky wrote:
> On Sun, May 20, 2001 at 04:40:13AM +0200, Andrea Arcangeli wrote:
> > I was only talking about when you get the "pci_map_sg failed" because
> > you have not 3 but 300 scsi disks connected to your system and you are
> > writing to all them at the same time allocating zillons of pte, and one
> > of your drivers (possibly not even a storage driver) is actually not
> > checking the reval of the pci_map_* functions. You don't need a pte
> > memleak to trigger it, even regardless of the fact I grown the dynamic
> > window to 1G which makes it 8 times harder to trigger than in mainline.
> 
> I think you're too pessimistic. Don't mix "disks" and "controllers" --

I'm not pessimistic, I'm fairly relaxed also with a 512Mbyte dynamic window
(that's why I did the change in first place) and I agree that it should
take care of hiding all those bugs on 99% of hardware configurations,
but OTOH I don't want things to work by luck and I'd prefer if the real
bugs gets fixed as well eventually.

> SCSI adapter with 10 drives attached is a single DMA agent, not 10 agents.

you can do simultaneous I/O to all the disks, so you will keep those dma
entries for the SG for each disk in-use at the same time.

> If you're so concerned about Big Iron, go ahead and implement 64-bit PCI
> support, it would be right long-term solution. I'm pretty sure that
> high-end servers use mostly this kind of hardware.

Certainly 64bit pci is supported but that doesn't change the fact you
can as well have 32bit devices on those boxes. 

> Oh, well. This doesn't mean that I'm disagreed with what you said. :-)
> Driver writers must realize that pci mappings are limited resources.

Exactly.

Andrea
