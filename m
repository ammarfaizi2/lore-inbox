Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131382AbRDSQeN>; Thu, 19 Apr 2001 12:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131323AbRDSQeG>; Thu, 19 Apr 2001 12:34:06 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:15569 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131344AbRDSQeA>;
	Thu, 19 Apr 2001 12:34:00 -0400
Date: Thu, 19 Apr 2001 12:33:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Abramo Bagnara <abramo@alsa-project.org>, Alon Ziv <alonz@nolaviz.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mkravetz@sequent.com>,
        Ulrich Drepper <drepper@cygnus.com>
Subject: Re: light weight user level semaphores
In-Reply-To: <Pine.LNX.4.31.0104190903560.3842-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0104191223070.16930-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Apr 2001, Linus Torvalds wrote:

> 
> 
> On Thu, 19 Apr 2001, Abramo Bagnara wrote:
> >
> > > [ Using file descriptors ]
> >
> > This would also permit:
> > - to have poll()
> > - to use mmap() to obtain the userspace area
> >
> > It would become something very near to sacred Unix dogmas ;-)
> 
> No, this is NOT what the UNIX dogmas are all about.
> 
> When UNIX says "everything is a file", it really means that "everything is
> a stream of bytes". Things like magic operations on file desciptors are
> _anathema_ to UNIX. ioctl() is the worst wart of UNIX. Having magic
> semantics of file descriptors is NOT Unix dogma at all, it is a horrible
> corruption of the original UNIX cleanlyness.

<applause>

The only reason for using file descriptors is that we can (AFAICS)
avoid any magic operations or new kinds of files. Honest-to-$DEITY
read() and write() on real pipes seems to be enough to implement
contention case for simple semaphores.

I see your point re sequential allocation of descriptors, but I'm not
sure that it's that serious - we need that stuff only for multi-threaded
programs and in that case we can't rely on sequentially allocated
descriptors anyway - stuff from different threads gets mixed together.

I certainly agree that introducing ioctl() in _any_ API is a shootable
offense. However, I wonder whether we really need any kernel changes
at all.
								Al

