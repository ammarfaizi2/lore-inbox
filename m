Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262119AbRETRjX>; Sun, 20 May 2001 13:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262122AbRETRjD>; Sun, 20 May 2001 13:39:03 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:21532 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262119AbRETRiv>; Sun, 20 May 2001 13:38:51 -0400
Date: Sun, 20 May 2001 19:37:55 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010520193755.C30738@athlon.random>
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru> <20010519155502.A16482@athlon.random> <20010519231131.A2840@jurassic.park.msu.ru>, <20010519231131.A2840@jurassic.park.msu.ru>; <20010520044013.A18119@athlon.random> <3B07AF49.5A85205F@uow.edu.au> <20010520154958.E18119@athlon.random> <20010520181803.I18119@athlon.random> <3B07FBE9.1176D9DC@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B07FBE9.1176D9DC@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sun, May 20, 2001 at 01:16:25PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2001 at 01:16:25PM -0400, Jeff Garzik wrote:
> Andrea Arcangeli wrote:
> > 
> > On Sun, May 20, 2001 at 03:49:58PM +0200, Andrea Arcangeli wrote:
> > > they returned zero. You either have to drop the skb or to try again later
> > > if they returns zero.
> > 
> > BTW, pci_map_single is not a nice interface, it cannot return bus
> > address 0, 
> 
> who says?
> 
> A value of zero for the mapping is certainly an acceptable value, and it
> should be handled by drivers.

this is exactly why I'm saying pci_map_single currently is ugly in
declaring a retval of 0 as an error, because as you also explicitly said
above bus address 0 is perfectly valid bus adress, so my whole point is
that I'd prefer to change the API of pci_map_single to notify of faliure
not returning 0 like it does right now in 2.4.5pre3 and all previous 2.4
kernels but via a parameter, so bus address zero returns a valid bus
address as it should be just now (but it isn't right now).

> In fact its an open bug in a couple net drivers that they check the
> mapping to see if it is non-zero...

if a driver is catching the faluire of pci_map_single by checking if the
bus address returned is zero such driver is one of the few (or the only
one) correct driver out there.

As it stands right now a bus address of 0 means pci_map_single failed.

For pci_map_sg if it returns zero it means it failed too.

Andrea
