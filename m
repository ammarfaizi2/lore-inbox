Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267208AbTAKNFV>; Sat, 11 Jan 2003 08:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267209AbTAKNFV>; Sat, 11 Jan 2003 08:05:21 -0500
Received: from colin.muc.de ([193.149.48.1]:22278 "HELO colin.muc.de")
	by vger.kernel.org with SMTP id <S267208AbTAKNFU>;
	Sat, 11 Jan 2003 08:05:20 -0500
Message-ID: <20030111141359.58669@colin.muc.de>
Date: Sat, 11 Jan 2003 14:13:59 +0100
From: Andi Kleen <ak@muc.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andi Kleen <ak@muc.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: any chance of 2.6.0-test*?
References: <20030110165441$1a8a@gated-at.bofh.it> <20030110165505$38d9@gated-at.bofh.it> <m3iswv27o3.fsf@averell.firstfloor.org> <20030111130151.A21505@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.88e
In-Reply-To: <20030111130151.A21505@flint.arm.linux.org.uk>; from Russell King on Sat, Jan 11, 2003 at 02:01:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 02:01:51PM +0100, Russell King wrote:
> > --- linux-2.5.56-work/drivers/char/tty_io.c-o	2003-01-02 05:13:12.000000000 +0100
> > +++ linux-2.5.56-work/drivers/char/tty_io.c	2003-01-11 13:23:15.000000000 +0100
> > @@ -1329,6 +1329,8 @@
> >  		int major, minor;
> >  		struct tty_driver *driver;
> >  
> > +		lock_kernel(); 
> > +
> 
> Deadlock.  chrdev_open() calls lock_kernel() and then the fops->open
> method, which is tty_open().

No problem, lock_kernel is recursive and dropped on schedule.

It is very very hard to get a BKL deadlock.

> This one needs deeper review.

I agree, but one has to start somewhere. Please submit any fixes,
perhaps we can take then close these issues for good.

Was looking at n_tty.c now, looks like it has some more race 
problems.


-Andi
