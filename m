Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267035AbTBCUEd>; Mon, 3 Feb 2003 15:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbTBCUEL>; Mon, 3 Feb 2003 15:04:11 -0500
Received: from ns.suse.de ([213.95.15.193]:2053 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267035AbTBCUD1>;
	Mon, 3 Feb 2003 15:03:27 -0500
Date: Mon, 3 Feb 2003 21:12:55 +0100
From: Andi Kleen <ak@suse.de>
To: jt@hpl.hp.com
Cc: Mikael Pettersson <mikpe@csd.uu.se>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: two x86_64 fixes for 2.4.21-pre3
Message-ID: <20030203201255.GA32689@wotan.suse.de>
References: <15921.37163.139583.74988@harpo.it.uu.se> <20030124193721.GA24876@wotan.suse.de> <15926.60767.451098.218188@harpo.it.uu.se> <20030128212753.GA29191@wotan.suse.de> <15927.62893.336010.363817@harpo.it.uu.se> <20030129162824.GA4773@wotan.suse.de> <15934.49235.619101.789799@harpo.it.uu.se> <20030203194923.GA27997@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030203194923.GA27997@bougret.hpl.hp.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 11:49:23AM -0800, Jean Tourrilhes wrote:
> On Mon, Feb 03, 2003 at 08:17:39PM +0100, Mikael Pettersson wrote:
> > Andi Kleen writes:
> >  > > 1. One unknown ioctl is logged from RH8.0 init:
> >  > > 
> >  > > ioctl32(iwconfig:185): Unknown cmd fd(3) cmd(00008b01){00} arg(ffffda90) on socket:[389]
> >  > 
> >  > Probably harmless, but if you figure it out please send me a patch.
> > 
> > The ioctl is SIOCGIWNAME, which is used by iwconfig from the wireless-tools
> > package to check if a given net dev is a wireless thing or not (called from
> > ifup in RedHat as a type test on the net dev).
> > 
> > Unfortunately, include/linux/wireless.h has a big pile of ioctls and arg/res
> > types that would need to be checked, so I'll defer this to Jean Tourrilhes (cc:d).
> > 
> > /Mikael
> 
> 	Why don't you just recompile the Wireless Tools (iwconfig and
> friends) for 64 bits ?

We normally try to at least support all ioctls which are used in 
standard distributions as 32bit. This way users can easily switch
between 32bit and 64bit userland. The coverage is very good
(standing on the shoulders of sparc64 emulation gigants).

Of course 64bit tools exist, just the 64bit distributions are not commonly
available yet and it's still nice to switch at will.

Also some ports rely on emulation for all user land (sparc64, ppc64, mips64);
for these it would be eventually needed anyways.

> 	The source of Wireless Tools should be 64 bit clean (was
> working on Alpha), and I don't think it's worth adding a whole pile of
> cruft in the kernel when it's used by a few system utilities that you
> can simply recompile. Personally, I expect every distribution to ship
> the base system compiled natively.
> 	With regards to this specific problem, just return an
> error. The Wireless Tools should gracefully handle it and report to

That is currently done (-EINVAL), but the emulation layer logs an 
warning.

> 	Just food for thought... I you think the wireless ioctls are
> bad, there is worse. The linux-wlan-ng driver defines it's own driver
> specific ioctls, and it has 3 times the number of ioctls. Just for one
> driver. And the ioctl format sometimes changes with revision.

That's bad. Do they at least have unique numbers?

> 	So, clearly you can't expect to deal with every ioctl under
> the sun, that's just not practical.

So far it works.

-Andi
