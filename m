Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261978AbRESTR4>; Sat, 19 May 2001 15:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261971AbRESTRq>; Sat, 19 May 2001 15:17:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34827 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261975AbRESTRl>; Sat, 19 May 2001 15:17:41 -0400
Date: Sat, 19 May 2001 21:17:17 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: James Simmons <jsimmons@transvirtual.com>,
        Alexander Viro <viro@math.psu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending Device Number Registrants]
Message-ID: <20010519211717.A7961@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010519122328.C31814@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.21.0105191152130.14472-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.21.0105191152130.14472-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, May 19, 2001 at 12:00:41PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > 	fd = open("/dev/tty00/nonblock,9600,n8", O_RDWR);
> > > >
> > > > Hmm, there might be problem with this. How do you change speed without
> > > > reopening device? [Remember: your mice knows when you close device]
> 
> The naming scheme is not a replacement for these kinds of ioctl's - it's
> just a way to make them less critical, and get people thinking in other
> directions so that we don't get _more_ ioctl's.
> 
> Remember, the serial lines we already have legacy support for, that's not
> going away. The termios-based stuff isn't Linux-only, and we'll
> obviously maintain it for the forseeable future.

Well, if we did something like modify(int fd, char *how), you could do

modify(0, "nonblock,9600") 

which looks slightly better than special ioctl. You could even hack
libc to emulate ioctl with modify.

I thought about how to do networking without sockets, and it seems to
me like this kind of modify syscall is needed, because network sockets
connect to *two* different places (one local address and one
remote). Sockets are really nasty :-(.

> But if we can use naming to avoid ioctl's in the future, then THAT is
> good. I'm in particular thinking about frame-buffer and similar things,
> where we might be able to avoid making the situation worse.

Yup. OTOH making "new" system so powerfull that it could lead to
ioctls emulated in libc would be very nice, too.
								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
