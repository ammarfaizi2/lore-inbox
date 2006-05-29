Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWE2KYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWE2KYb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 06:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWE2KYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 06:24:31 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42973 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750830AbWE2KYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 06:24:30 -0400
Date: Mon, 29 May 2006 12:23:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Airlie <airlied@gmail.com>
Cc: "D. Hazelton" <dhazelton@enter.net>, Jon Smirl <jonsmirl@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060529102339.GA746@elf.ucw.cz>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605272245.22320.dhazelton@enter.net> <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com> <200605280112.01639.dhazelton@enter.net> <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> For a specific DRM chip there are currently four modules:
> >> fbdev-core
> >> fbdev-chip depends on fbdev-core
> >> drm-core
> >> drm-chip depends on drm-core
> >> RIght now drm and fbdev can be loaded independently.
> >>
> >> I would always keep fbdev-core and drm-core as separate modules.  But
> >> drm-core may become dependent on fbdev-core.
> 
> I've already pointed out to Jon the problems with this approach on
> numerous occasions and to be honest do not have the time to do so
> again,
> 
> I will not accept patches to make DRM drivers rely on fbdev drivers in
> the kernel for many many many reasons, two quick ones :
> 
> a) we don't always have a fully functional fbdev driver, see intel fb 
> drivers.

Well, we need to write those fbdev drivers, then.

> b) loading fbdev drivers breaks X in a lot of cases, we need to be a
> bit more careful.

Fix X and/or fbdev, then.

> c) Lots of distros don't use fbdev drivers, forcing this on them to
> use drm isn't an option.

Let the distros catch up with current state of technology....

I mean, it is crazy. We have complex subsystem (graphics), that is
made even more complex because of crazy design (independend fbdev and
DRM, X handling PCI from userspace).

Now, lets take common hardware like radeon. You want these
combinations to be supported:

vgacon 
vesafb ( + unaccelerated X )
radeonfb ( + unaccelerated X )

vgacon + accelerated X
vesafb + accelerated X
radeonfb + accelerated X

vgacon + DRM + accelerated X
vesafb + DRM + accelerated X
radeonfb + DRM + accelerated X

...that's crazy! You claim that for various reasons (mostly bugs) we
need to keep that complexity. That's not the way forward, with
manpower we have I'm afraid.

I believe we can trim supported combinations to half... for hardware
that works anyway. For special cases like intel when some driver is
unavailable /broken, well we may need to do different choices, or
better write missing parts / fix broken cards. I believe that these
combinations make sense:

vgacon 
vesafb ( + unaccelerated X )
radeonfb ( + unaccelerated X )
radeonfb + accelerated X
radeonfb + DRM + accelerated X

That's half of combinations to care about! Plus first two are really
generic across x86...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
