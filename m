Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292363AbSBUNUo>; Thu, 21 Feb 2002 08:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292292AbSBUNUf>; Thu, 21 Feb 2002 08:20:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64524 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292363AbSBUNUW>;
	Thu, 21 Feb 2002 08:20:22 -0500
Message-ID: <3C74F410.B165E571@mandrakesoft.com>
Date: Thu, 21 Feb 2002 08:20:16 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christer Weinigel <wingel@acolyte.hack.org>
CC: zwane@linux.realnet.co.sz, roy@karlsbakk.net, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
In-Reply-To: <Pine.LNX.4.44.0202211134080.7649-100000@netfinity.realnet.co.sz> <3C74C8C7.25D7BCD@mandrakesoft.com> <20020221111910.57235F5B@acolyte.hack.org> <20020221115916.9FD5AF5B@acolyte.hack.org> <3C74E698.D3A0BFEB@mandrakesoft.com> <20020221125743.10F0BF5B@acolyte.hack.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christer Weinigel wrote:
> Jeff Garzik wrote:
> > > static void scx200_watchdog_update_margin(void)
> > > {
> > >         printk(KERN_INFO "%s: timer margin %d seconds\n", name, margin);
> > >         wdto_restart = 32768 / 1024 * margin;
> > >         scx200_watchdog_ping();
> > > }
> >
> > if you can turn multiplication and division of powers-of-2 into left and
> > right shifts, other simplications sometimes follow.  Certainly you want
> > to avoid division especially and multiplication also if possible.
> 
> Since this is only called on initialization I'm not overly concerned
> with performance here, I prefer code clarity.  This ought to be
> optimized by gcc anyways.

I mention it because we ran into a case with the ppc md where gcc did
not... I doubt this code would be used on PPC :) but I mention it mainly
as a matter of principle


> > now, a policy question -- do you want to fail or simply put to sleep
> > multiple openers?  if you want to fail, this should be ok I think.  if
> > you want to sleep, you can look at sound/oss/* in 2.5.x or
> > drivers/sound/* in 2.4.x for some examples of semaphore use on
> > open(2).
> 
> I'm not even sure if single-open sematics are neccesary at all, but I
> copied most of the interface from wdt285.c so I copied this too.  The
> watchdog API seems to be a rather ad hoc thing.  For example I just
> noticed that the WDIOC_SETTIMEOUT call probably takes a parameter
> which seems to be minutes, not seconds.  "Someone (tm)" ought to write
> a more formal API specification.

;-)   hey, if you took 30 minutes to jot down into a text file your
observations on the implementation of the API, I'm sure we could get
that into 2.4 and 2.5 ...


> > I wonder why 'name' is not simply a macro defining a string constant?
> > Oh yeah, it matters very little.  You might want to make 'name' const,
> > though.
> 
> Because "%s: " is less text than "scx200_watchdog" and I'm not sure if
> gcc is able to merge duplicate strings.  Not much of a difference.

Note that every place where you aren't sure, you are using string
catenation anyway with the KERN_xxx symbols:

	printk (KERN_ERR "...


> You're right, I just assumed that nobody would load this driver unless
> they are on a SCx200 system.  Done.  I'll update all the other drivers
> too.

Thanks!

	Jeff



-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
