Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261746AbRESKYO>; Sat, 19 May 2001 06:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261751AbRESKYE>; Sat, 19 May 2001 06:24:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:25872 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261746AbRESKYA>; Sat, 19 May 2001 06:24:00 -0400
Date: Sat, 19 May 2001 12:23:28 +0200
From: Pavel Machek <pavel@suse.cz>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: no ioctls for serial ports? [was Re: LANANA: To Pending Device Number Registrants]
Message-ID: <20010519122328.C31814@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010517104226.B44@toy.ucw.cz> <Pine.LNX.4.10.10105181130510.12643-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.10.10105181130510.12643-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Fri, May 18, 2001 at 11:32:54AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > They might also be exactly the same channel, except with certain magic
> > > bits set. The example peter gave was fine: tty devices could very usefully
> > > be opened with something like
> > > 
> > > 	fd = open("/dev/tty00/nonblock,9600,n8", O_RDWR);
> > > 
> > > where we actually open up exactly the same channel as if we opened up
> > > /dev/cua00, we just set the speed etc at the same time. Which makes things
> > 
> > Hmm, there might be problem with this. How do you change speed without
> > reopening device? [Remember: your mice knows when you close device]
> 
> If you implement it as a filesystem you coould have a settings file in the
> tty filesystem. Something like this:
> 
> echo "115200" >  /dev/tty/settings

You can currently do 

stty 115200

or 

stty 19200

when your stdin is serial port. If it is filesystem, you'll have hard
time finding *which* of serial ports it is, followed by opening it.

What about this?

bash < /dev/ttyS0 &
rm -r /dev/ttyS0
how does bash change speed of serial line, then?
								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
