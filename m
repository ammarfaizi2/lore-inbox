Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262404AbREUJAr>; Mon, 21 May 2001 05:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262406AbREUJAh>; Mon, 21 May 2001 05:00:37 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:19550 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262404AbREUJA1>; Mon, 21 May 2001 05:00:27 -0400
Date: Mon, 21 May 2001 10:59:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010521105944.H30738@athlon.random>
In-Reply-To: <20010519155502.A16482@athlon.random> <20010519231131.A2840@jurassic.park.msu.ru> <20010520044013.A18119@athlon.random> <3B07AF49.5A85205F@uow.edu.au> <20010520154958.E18119@athlon.random> <3B07CF20.2ABB5468@uow.edu.au> <20010520163323.G18119@athlon.random> <15112.26868.5999.368209@pizda.ninka.net> <20010521034726.G30738@athlon.random> <15112.48708.639090.348990@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15112.48708.639090.348990@pizda.ninka.net>; from davem@redhat.com on Mon, May 21, 2001 at 12:05:40AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 12:05:40AM -0700, David S. Miller wrote:
> together.  And it was agreed upon that the routines will not allow
> failure in 2.4.x and we would work on resolving this in 2.5.x and no
> sooner.

I'm glad you at least just considered to fix all those bugs for 2.5 but
that won't change that if somebody runs out of entries now with sparc64
the only thing I can do in a short term is to use HIGHMEM, so that the
serialization to limit the amount of max simultaneous pci32 DMA will
happen in the code that allocates the bounce buffers. Tell me a best way
to get rid of those bugs all together if you can.

Furthmore some arch for the legacy pci32 cards may not provide an huge
amount of entries and so you could more easily trigger those bugs
without the need of uncommon hardware, those bugs renders the iommu
unusable for those archs in 2.4 because it would trigger the device
drivers bugs far too easily.

Please tell Andrew to worry about that, if somebody ever worried about
that we would have all network drivers correct just now and the needed
panics in the lowlevel scsi layer.

This without considering bttv and friends are not even trying to use the
pci_map_* yet, I hope you don't watch TV on your sparc64 if you have
enough ram.

I hate those kind of broken compromises between something that works
almost all the time and that breaks when you are not only using a few
harddisk and a few nic, and that is unfixable in the right way in a
short term after it triggers (bttv is fixable in a short term of course,
I'm only talking about when you run out of pci mappings).

Andrea
