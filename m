Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267676AbRHAXPf>; Wed, 1 Aug 2001 19:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267713AbRHAXPZ>; Wed, 1 Aug 2001 19:15:25 -0400
Received: from [63.209.4.196] ([63.209.4.196]:1286 "EHLO neon-gw.transmeta.com")
	by vger.kernel.org with ESMTP id <S267676AbRHAXPL>;
	Wed, 1 Aug 2001 19:15:11 -0400
Date: Wed, 1 Aug 2001 16:14:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <bristuccia@starentnetworks.com>, <linux-kernel@vger.kernel.org>
Subject: Re: repeated failed open()'s results in lots of used memory [Was:
 [Fwd: memory consumption]]
In-Reply-To: <Pine.GSO.4.21.0108011901170.27494-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0108011610520.15902-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 1 Aug 2001, Alexander Viro wrote:
>
>
> On Wed, 1 Aug 2001, Linus Torvalds wrote:
>
> >  - make all the things that shrink dentries (notably the
> >    shrink_dcache_memory() function) call the above function first.
> >
> > Does that fix the behaviour for you?
>
> That will kill _all_ negative dentries whenever we get any amount of
> memory pressure. For stuff a-la $PATH it will get very ugly - currently
> we have a lot of negative dentries in /usr/local/bin that prevent tons
> of bogus lookups there,

I agree. I'm a big fan of negative dentries myself.

However, I'd like to see what the patch does for the bad case first, and
then we can see whether there are less drastic methods (like only killing
half of the negative dentries or something).

The current behaviour obviously has some problems, and negative dentries
_are_ different from positive ones. Trond (or somebody - maybe it was
Neil) also mentioned that negative dentries tend to hurt some NFS
benchmarks by virtue of filling up memory a bit too much.

Btw, my fix description wasn't perfect - you need to get things like the
unused dentry counts right too, etc. The basic approach stands, though.

		Linus

