Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292358AbSBUMn5>; Thu, 21 Feb 2002 07:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292357AbSBUMnq>; Thu, 21 Feb 2002 07:43:46 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:5833 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S292358AbSBUMni>; Thu, 21 Feb 2002 07:43:38 -0500
Date: Thu, 21 Feb 2002 14:32:29 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Christer Weinigel <wingel@acolyte.hack.org>, <roy@karlsbakk.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
In-Reply-To: <3C74E698.D3A0BFEB@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0202211425540.7649-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Jeff Garzik wrote:

> now, a policy question -- do you want to fail or simply put to sleep
> multiple openers?  if you want to fail, this should be ok I think.  if
> you want to sleep, you can look at sound/oss/* in 2.5.x or
> drivers/sound/* in 2.4.x for some examples of semaphore use on open(2).

i think the following would be ok here.

[...]
if (down_interruptible(&open_sem))
	return -ERESTARTSYS;
[...]

> Here's a big one, I still don't like this lack of probing in the
> driver.  Sure we have "probed elsewhere", but IMO each driver like this
> one needs to check -something- to ensure that SC1200 hardware is
> present.  Otherwise, a random user from a distro-that-builds-all-drivers
> might "modprobe sc1200_watchdog" and things go boom.

The actual SuperIO chip the SC1200 is based on is fully PnP so we can 
easily do a search without frobbing hardware. To support non PnP mode, we 
could find a register with a default value which isn't 0xFF or 0x00, i 
reckon that would work quite well.

Regards,
	Zwane Mwaikambo


