Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318299AbSIOXV0>; Sun, 15 Sep 2002 19:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318300AbSIOXV0>; Sun, 15 Sep 2002 19:21:26 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31251 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318299AbSIOXVZ>; Sun, 15 Sep 2002 19:21:25 -0400
Date: Mon, 16 Sep 2002 00:26:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Albert Cranford <ac9410@attbi.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 9/9]Four new i2c drivers and __init/__exit cleanup to i2c
Message-ID: <20020916002619.D30390@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0209151845330.7637-200000@home1> <3D851556.7070203@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D851556.7070203@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sun, Sep 15, 2002 at 07:18:46PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2002 at 07:18:46PM -0400, Jeff Garzik wrote:
> Albert Cranford wrote:
> > --- linux/drivers/i2c/i2c-elektor.c.orig	2002-09-14 22:10:45.000000000 -0400
> > +++ linux-2.5.34/drivers/i2c/i2c-elektor.c	2002-09-15 01:18:55.000000000 -0400
> > @@ -125,12 +125,12 @@
> >  	int timeout = 2;
> >  
> >  	if (irq > 0) {
> > -		cli();
> > +		local_irq_disable();
> >  		if (pcf_pending == 0) {
> >  			interruptible_sleep_on_timeout(&pcf_wait, timeout*HZ );
> >  		} else
> >  			pcf_pending = 0;
> > -		sti();
> > +		local_irq_enable();
> >  	} else {
> >  		udelay(100);
> >  	}
> 
> 
> 
> this is _not_ the way to fix...   use a proper spinlock

You can't hold a spinlock and sleep though, was one of my points back
in August.  (Albert submitted a patch with all cli()/sti() converted
to spin_lock_irqsave()/spin_unlock_irqrestore().)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

