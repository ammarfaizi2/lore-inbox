Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132600AbRC1Vuz>; Wed, 28 Mar 2001 16:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132592AbRC1Vrq>; Wed, 28 Mar 2001 16:47:46 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:43775 "EHLO math.psu.edu") by vger.kernel.org with ESMTP id <S132593AbRC1VrR>; Wed, 28 Mar 2001 16:47:17 -0500
Date: Wed, 28 Mar 2001 16:46:34 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Martin Dalecki <dalecki@evision-ventures.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
In-Reply-To: <3AC256A3.BABF7141@transmeta.com>
Message-ID: <Pine.GSO.4.21.0103281635580.26500-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Mar 2001, H. Peter Anvin wrote:

> Martin Dalecki wrote:
> > >
> > > devfs -- in the abstract -- really isn't that bad of an idea; after all,
> > 
> > Devfs is from a desing point of view the duplication for the bad /proc
> > design for devices. If you need a good design for general device
> > handling with names - network interfaces are the thing too look at.
> > mount() should be more like a select()... accept()!
> > 
> 
> And what on earth makes this better?  I have always thought the socket
> interface to be hideously ugly and full of ad-hockery.  Its abstractions
> for handle multiple address families by and large don't work, and it
> introduces new system calls left, right and center -- sometimes for good
> reasons, but please do tell me why I can't open() an AF_UNIX socket, but
> have to use a special system call called connect() instead.

Aye. The real problem with mount is that it always had been pretty
heavy-weight. Especially mount(8). I've done some (very rough) testing
on my tree - for ramfs-style filesystem latency of mount(2) is about
20% worse than latency of open(2). And it definitely can be improved -
right now I'm interested in getting the code cleaned.

mount(8) is a problem, but in nosuid namespace we can seriously cut
down on checks in the thing. And I'm very interested in designs that
would allow killing /etc/mtab - dropping it would allow very easy
mounting.

