Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262320AbREUBsG>; Sun, 20 May 2001 21:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262321AbREUBr5>; Sun, 20 May 2001 21:47:57 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31748 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262320AbREUBro>; Sun, 20 May 2001 21:47:44 -0400
Date: Mon, 21 May 2001 03:47:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010521034726.G30738@athlon.random>
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru> <20010519155502.A16482@athlon.random> <20010519231131.A2840@jurassic.park.msu.ru> <20010520044013.A18119@athlon.random> <3B07AF49.5A85205F@uow.edu.au> <20010520154958.E18119@athlon.random> <3B07CF20.2ABB5468@uow.edu.au> <20010520163323.G18119@athlon.random> <15112.26868.5999.368209@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15112.26868.5999.368209@pizda.ninka.net>; from davem@redhat.com on Sun, May 20, 2001 at 06:01:40PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2001 at 06:01:40PM -0700, David S. Miller wrote:
> 
> Andrea Arcangeli writes:
>  > > Well this is news to me.  No drivers understand this.
>  > 
>  > Yes, almost all drivers are buggy.
> 
> No, the interface says that the DMA routines may not return failure.

The alpha returns a faliure since day zero of iommu support, the sparc64
has too otherwise it's even more buggy than alpha when the machine runs
out of pci virtual address space.

> If you want to change the DMA api to act some other way, then fine
> please propose it, but do not act as if today they have to act this
> way because that is simply not true.

About the pci_map_single API I'd like if bus address 0 would not be the
indication of faluire, mainly on platforms without an iommu that's not
nice, x86 happens to get it right only because the physical page zero is
reserved for completly other reasons. so we either add a err parameter
to the pci_map_single, or we define a per-arch bus address to indicate
an error, either ways are ok from my part.

Andrea
