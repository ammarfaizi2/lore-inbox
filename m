Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261230AbRESTBW>; Sat, 19 May 2001 15:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261956AbRESTBC>; Sat, 19 May 2001 15:01:02 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:36626 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261230AbRESTAu>; Sat, 19 May 2001 15:00:50 -0400
Date: Sat, 19 May 2001 12:00:41 -0700 (PDT)
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
In-Reply-To: <20010519122328.C31814@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.21.0105191152130.14472-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Attribution is gone, so I just deleted it.. ]

> > > > 	fd = open("/dev/tty00/nonblock,9600,n8", O_RDWR);
> > >
> > > Hmm, there might be problem with this. How do you change speed without
> > > reopening device? [Remember: your mice knows when you close device]

The naming scheme is not a replacement for these kinds of ioctl's - it's
just a way to make them less critical, and get people thinking in other
directions so that we don't get _more_ ioctl's.

Remember, the serial lines we already have legacy support for, that's not
going away. The termios-based stuff isn't Linux-only, and we'll
obviously maintain it for the forseeable future.

But if we can use naming to avoid ioctl's in the future, then THAT is
good. I'm in particular thinking about frame-buffer and similar things,
where we might be able to avoid making the situation worse.

And remember where this discussion started: not ioctl's, but device
numbers. The _biggest_ advantage of naming may be to get rid of the need
for extra major and minor numbers, and cleaning up /dev in the process-

		Linus

