Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261765AbRETOeS>; Sun, 20 May 2001 10:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261743AbRETOd6>; Sun, 20 May 2001 10:33:58 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:24836 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261644AbRETOdr>; Sun, 20 May 2001 10:33:47 -0400
Date: Sun, 20 May 2001 16:33:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010520163323.G18119@athlon.random>
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru> <20010519155502.A16482@athlon.random> <20010519231131.A2840@jurassic.park.msu.ru>, <20010519231131.A2840@jurassic.park.msu.ru>; <20010520044013.A18119@athlon.random> <3B07AF49.5A85205F@uow.edu.au>, <3B07AF49.5A85205F@uow.edu.au>; <20010520154958.E18119@athlon.random> <3B07CF20.2ABB5468@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B07CF20.2ABB5468@uow.edu.au>; from andrewm@uow.edu.au on Mon, May 21, 2001 at 12:05:20AM +1000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 12:05:20AM +1000, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > [ cc'ed to l-k ]
> > 
> > > DMA-mapping.txt assumes that it cannot fail.
> > 
> > DMA-mapping.txt is wrong. Both pci_map_sg and pci_map_single failed if
> > they returned zero. You either have to drop the skb or to try again later
> > if they returns zero.
> > 
> 
> Well this is news to me.  No drivers understand this.

Yes, almost all drivers are buggy.

> How long has this been the case?  What platforms?

Always and all platforms.

Just think about this, you have 2^32 of bus address space, and you
theoritically can start I/O for more than 2^32 of phys memory, see?
Whatever platform it is it will never be able to guarantee all mappings
to succeed.

> For netdevices at least, the pci_map_single() call is always close
> to the site of the skb allocation.  So what we can do is to roll
> them together and use the existing oom-handling associated with alloc_skb(),
> assuming the driver has it...

Fine.

Andrea
