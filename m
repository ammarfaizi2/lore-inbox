Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbRESX5d>; Sat, 19 May 2001 19:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262004AbRESX5X>; Sat, 19 May 2001 19:57:23 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:61112 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261996AbRESX5J>;
	Sat, 19 May 2001 19:57:09 -0400
Date: Sat, 19 May 2001 19:57:07 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Pavel Machek <pavel@suse.cz>, James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending Device
 Number Registrants]
In-Reply-To: <Pine.LNX.4.21.0105191231020.14472-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0105191943300.7162-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 May 2001, Linus Torvalds wrote:

> 
> On Sat, 19 May 2001, Pavel Machek wrote:
> > 
> > Well, if we did something like modify(int fd, char *how), you could do
> > 
> > modify(0, "nonblock,9600") 
> 
> What you're really proposing is to make ioctl's be ASCII strings.
> 
> Which is not necessarily a bad idea, and I think plan9 did something
> similar (or rather, if I remember correctly, plan9 has control streams
> that were ASCII. Or am I confused?).

You are not. Control streams in question look like normal files. Normally
driver exports a tree with several data files (e.g. fd0, fd1, fd2, fd3)
and several control files (e.g. fd0ctl, fd1ctl, fd2ctl, fd3ctl). write()
to the latter passes commands. No extra syscalls needed.

Notice that sometimes it's not ASCII - depends on the nature of stuff you
are passing. Things like setting font, etc. need to pass bitmaps, so some
parts of the stuff you write end up as binary. Which is perfectly sane.

> And a "stream of bytes" is in a very real sense the simplest structure,
> and is the unix way (and the plan9 way is to avoid binary streams, and use
> ASCII text instead when possible, whihc probably also makes sense).

s/possible/makes sense/. For commands ASCII is OK, but for cases when you
pass binary data as a part of command (not just "something large", but
something that really happens to be a bitmap, etc.) you write it as binary
data.

