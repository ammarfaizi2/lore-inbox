Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267072AbTBCWhq>; Mon, 3 Feb 2003 17:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267049AbTBCWhl>; Mon, 3 Feb 2003 17:37:41 -0500
Received: from ns.suse.de ([213.95.15.193]:36614 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267048AbTBCWgr>;
	Mon, 3 Feb 2003 17:36:47 -0500
Date: Mon, 3 Feb 2003 23:46:19 +0100
From: Andi Kleen <ak@suse.de>
To: jt@hpl.hp.com
Cc: Andi Kleen <ak@suse.de>, Mikael Pettersson <mikpe@csd.uu.se>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: 32bit emulation of wireless ioctls
Message-ID: <20030203224619.GA6405@wotan.suse.de>
References: <15921.37163.139583.74988@harpo.it.uu.se> <20030124193721.GA24876@wotan.suse.de> <15926.60767.451098.218188@harpo.it.uu.se> <20030128212753.GA29191@wotan.suse.de> <15927.62893.336010.363817@harpo.it.uu.se> <20030129162824.GA4773@wotan.suse.de> <15934.49235.619101.789799@harpo.it.uu.se> <20030203194923.GA27997@bougret.hpl.hp.com> <20030203201255.GA32689@wotan.suse.de> <20030203214325.GA28330@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030203214325.GA28330@bougret.hpl.hp.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 01:43:25PM -0800, Jean Tourrilhes wrote:
> 	In this case, the degradation is quite graceful. The Wireless
> Tools just assume that the card doesn't support Wireless Extension, so
> you won't get extra stats and configuration, but you can still use the
> driver.

Ok that's good.

> 
> > Of course 64bit tools exist, just the 64bit distributions are not commonly
> > available yet and it's still nice to switch at will.
> 
> 	I believe that *BSD consider all system tools as part of the
> base OS, and is compiled alongside the kernel, so you don't have this
> issue, because kernel and tools are "in sync".

But this is not BSD...

> 	Anyway, I believe that 64 bit platforms will need to become
> mainstream before the issue of wireless on 64 bit is pressing, and by
> that time most distro will have made the jump.

Hmm, not so sure. I guess people will sooner than later plug wireless
cards into 64bit boxes, especially with x86-64 which will hopefully
be quite "mainstream".

> 
> > > 	With regards to this specific problem, just return an
> > > error. The Wireless Tools should gracefully handle it and report to
> > 
> > That is currently done (-EINVAL), but the emulation layer logs an 
> > warning.
> 
> 	It's just a shame that it's not more distinctive, because the
> error message wouldn't lead me to think "doh, I need a recompile".

Do you have a better suggestion?

> 
> > > 	Just food for thought... I you think the wireless ioctls are
> > > bad, there is worse. The linux-wlan-ng driver defines it's own driver
> > > specific ioctls, and it has 3 times the number of ioctls. Just for one
> > > driver. And the ioctl format sometimes changes with revision.
> > 
> > That's bad. Do they at least have unique numbers?
> 
> 	They use the device private ioctls and subclass them. They use
> one ioctl to query the driver for support of the API.

That's very bad, because the ioctl emulation needs unique numbers currently.

There was some hack added for PPP, but it may not extend to wireless.

> 	Also note that I made a first step in your direction. Since
> WE-13, most of the metadata describing the ioctls is in the kernel
> itself and the copy_to/from_user is centralised, which should make
> things easier once all drivers are converted...

Anyways: for me it is just slightly annoying to not have 32bit 
emulation for something, but for other ports like sparc64/ppc64/mips64 
it can be show stopper because they only have 32bit userland.

Expect trouble when DaveM wants to plug a wireless card into one of 
his sparc64 boxes ;-)

-Andi
