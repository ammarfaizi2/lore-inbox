Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291164AbSBUMrH>; Thu, 21 Feb 2002 07:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291019AbSBUMq6>; Thu, 21 Feb 2002 07:46:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46345 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291463AbSBUMqo>;
	Thu, 21 Feb 2002 07:46:44 -0500
Message-ID: <3C74EC32.E01CA358@mandrakesoft.com>
Date: Thu, 21 Feb 2002 07:46:42 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: Christer Weinigel <wingel@acolyte.hack.org>, roy@karlsbakk.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
In-Reply-To: <Pine.LNX.4.44.0202211425540.7649-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> 
> On Thu, 21 Feb 2002, Jeff Garzik wrote:
> 
> > now, a policy question -- do you want to fail or simply put to sleep
> > multiple openers?  if you want to fail, this should be ok I think.  if
> > you want to sleep, you can look at sound/oss/* in 2.5.x or
> > drivers/sound/* in 2.4.x for some examples of semaphore use on open(2).
> 
> i think the following would be ok here.
> 
> [...]
> if (down_interruptible(&open_sem))
>         return -ERESTARTSYS;
> [...]

Read the OSS sound drivers, people have put a lot of time into coding
and debugging those open(2) routines :)


> > Here's a big one, I still don't like this lack of probing in the
> > driver.  Sure we have "probed elsewhere", but IMO each driver like this
> > one needs to check -something- to ensure that SC1200 hardware is
> > present.  Otherwise, a random user from a distro-that-builds-all-drivers
> > might "modprobe sc1200_watchdog" and things go boom.
> 
> The actual SuperIO chip the SC1200 is based on is fully PnP so we can
> easily do a search without frobbing hardware. To support non PnP mode, we
> could find a register with a default value which isn't 0xFF or 0x00, i
> reckon that would work quite well.

Well, if you already probe elsewhere, one could easily EXPORT_SYMBOL
such information from the main driver, so you would need to only check a
variable.

But I agree in principle with you about probing and PNP, just saying we
need to look at the big picture too, what other SC1200 modules are in
the system and what info/capabilities they provide.

	Jeff


-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
