Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129581AbQK0SGq>; Mon, 27 Nov 2000 13:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129734AbQK0SGg>; Mon, 27 Nov 2000 13:06:36 -0500
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:41736 "EHLO
        munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
        id <S129581AbQK0SGS>; Mon, 27 Nov 2000 13:06:18 -0500
Date: Mon, 27 Nov 2000 12:36:55 -0500
From: Michael Meissner <meissner@spectacle-pond.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, Werner.Almesberger@epfl.ch,
        adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001127123655.A16930@munchkin.spectacle-pond.org>
In-Reply-To: <200011270556.VAA12506@baldur.yggdrasil.com> <20001127094139.H599@almesberger.net> <200011270839.AAA28672@pizda.ninka.net> <20001127182113.A15029@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001127182113.A15029@athlon.random>; from andrea@suse.de on Mon, Nov 27, 2000 at 06:21:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 06:21:13PM +0100, Andrea Arcangeli wrote:
> On Mon, Nov 27, 2000 at 12:39:55AM -0800, David S. Miller wrote:
> > Also I believe linkers are allowed to arbitrarily reorder members in
> > the data and bss sections.  I could be wrong on this one though.
> 
> I'm not sure either, but we certainly rely on that behaviour somewhere.
> Just to make an example fs/dquot.c:
> 
> 	int nr_dquots, nr_free_dquots;
> 
> kernel/sysctl.c:
> 
> 	{FS_NRDQUOT, "dquot-nr", &nr_dquots, 2*sizeof(int),
> 
> The above is ok also on mips in practice though.

That needs to be fixed ASAP to use an array (not a structure).  It is simply
wrong to depend on two variables winding up in at adjacent offsets.

-- 
Michael Meissner, Red Hat, Inc.
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
