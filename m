Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261979AbRESTgq>; Sat, 19 May 2001 15:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261983AbRESTgg>; Sat, 19 May 2001 15:36:36 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:62994 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261979AbRESTgW>; Sat, 19 May 2001 15:36:22 -0400
Date: Sat, 19 May 2001 12:35:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@suse.cz>
cc: James Simmons <jsimmons@transvirtual.com>,
        Alexander Viro <viro@math.psu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending Device
 Number Registrants]
In-Reply-To: <20010519211717.A7961@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.21.0105191231020.14472-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 19 May 2001, Pavel Machek wrote:
> 
> Well, if we did something like modify(int fd, char *how), you could do
> 
> modify(0, "nonblock,9600") 

What you're really proposing is to make ioctl's be ASCII strings.

Which is not necessarily a bad idea, and I think plan9 did something
similar (or rather, if I remember correctly, plan9 has control streams
that were ASCII. Or am I confused?).

> I thought about how to do networking without sockets, and it seems to
> me like this kind of modify syscall is needed, because network sockets
> connect to *two* different places (one local address and one
> remote). Sockets are really nasty :-(.

One of the horrors of ioctl's is indeed that they are not very
well-defined, and as such cannot be transported over a network without
knowing more about them. Structuring them some way would already be very
useful. the _IOC() macros do this partially, of course, but because it is
a voluntary thing it is not actually followed all that well in general,
and most ioctl names are just random numbers that don't tell the structure
of the arguments or return values.

And a "stream of bytes" is in a very real sense the simplest structure,
and is the unix way (and the plan9 way is to avoid binary streams, and use
ASCII text instead when possible, whihc probably also makes sense).

However, you can't really use a string. It would really have to be two
memory regions: incoming and outgoing, with an ASCII representation being
the _preferred_ method for stuff that isn't obviously structured or
performance-critical.

Let's not take this too far, though.

		Linus

