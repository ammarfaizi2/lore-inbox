Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266243AbTBCWA7>; Mon, 3 Feb 2003 17:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266296AbTBCWA7>; Mon, 3 Feb 2003 17:00:59 -0500
Received: from phobos.hpl.hp.com ([192.6.19.124]:53234 "EHLO phobos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S266243AbTBCWAz>;
	Mon, 3 Feb 2003 17:00:55 -0500
Date: Mon, 3 Feb 2003 13:43:25 -0800
To: Andi Kleen <ak@suse.de>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: two x86_64 fixes for 2.4.21-pre3
Message-ID: <20030203214325.GA28330@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <15921.37163.139583.74988@harpo.it.uu.se> <20030124193721.GA24876@wotan.suse.de> <15926.60767.451098.218188@harpo.it.uu.se> <20030128212753.GA29191@wotan.suse.de> <15927.62893.336010.363817@harpo.it.uu.se> <20030129162824.GA4773@wotan.suse.de> <15934.49235.619101.789799@harpo.it.uu.se> <20030203194923.GA27997@bougret.hpl.hp.com> <20030203201255.GA32689@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030203201255.GA32689@wotan.suse.de>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 09:12:55PM +0100, Andi Kleen wrote:
> > 
> > 	Why don't you just recompile the Wireless Tools (iwconfig and
> > friends) for 64 bits ?
> 
> We normally try to at least support all ioctls which are used in 
> standard distributions as 32bit. This way users can easily switch
> between 32bit and 64bit userland. The coverage is very good
> (standing on the shoulders of sparc64 emulation gigants).

	In this case, the degradation is quite graceful. The Wireless
Tools just assume that the card doesn't support Wireless Extension, so
you won't get extra stats and configuration, but you can still use the
driver.

> Of course 64bit tools exist, just the 64bit distributions are not commonly
> available yet and it's still nice to switch at will.

	I believe that *BSD consider all system tools as part of the
base OS, and is compiled alongside the kernel, so you don't have this
issue, because kernel and tools are "in sync".
	Anyway, I believe that 64 bit platforms will need to become
mainstream before the issue of wireless on 64 bit is pressing, and by
that time most distro will have made the jump.

> > 	With regards to this specific problem, just return an
> > error. The Wireless Tools should gracefully handle it and report to
> 
> That is currently done (-EINVAL), but the emulation layer logs an 
> warning.

	It's just a shame that it's not more distinctive, because the
error message wouldn't lead me to think "doh, I need a recompile".

> > 	Just food for thought... I you think the wireless ioctls are
> > bad, there is worse. The linux-wlan-ng driver defines it's own driver
> > specific ioctls, and it has 3 times the number of ioctls. Just for one
> > driver. And the ioctl format sometimes changes with revision.
> 
> That's bad. Do they at least have unique numbers?

	They use the device private ioctls and subclass them. They use
one ioctl to query the driver for support of the API.

> > 	So, clearly you can't expect to deal with every ioctl under
> > the sun, that's just not practical.
> 
> So far it works.

	Of course, because you have dealt with the most common
subset. I want to remain pragmatic and try to define how far we need
to go. 100% coverage is unrealistic, and there is always the tradeof
between amount of work and number of users.
	I just believe that in thise case the number of users is not
there yet, and we can re-evaluate our options when we have those
users, because at that point we may have new options available.

	Also note that I made a first step in your direction. Since
WE-13, most of the metadata describing the ioctls is in the kernel
itself and the copy_to/from_user is centralised, which should make
things easier once all drivers are converted...

> -Andi

	Have fun...

	Jean
