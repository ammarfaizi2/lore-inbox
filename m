Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUIDUxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUIDUxl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 16:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266127AbUIDUxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 16:53:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51467 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266096AbUIDUxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 16:53:38 -0400
Date: Sat, 4 Sep 2004 21:53:33 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: John Lenz <lenz@cs.wisc.edu>, Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       linux-kernel@vger.kernel.org, Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: [PATCH 2.6.8.1 0/2] leds: new class for led devices
Message-ID: <20040904215333.B29410@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>, John Lenz <lenz@cs.wisc.edu>,
	Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org,
	Kalin KOZHUHAROV <kalin@thinrope.net>
References: <1094157190l.4235l.2l@hydra> <ch8tdd$1uf$1@sea.gmane.org> <20040903120634.GK6985@lug-owl.de> <1094237243l.7429l.1l@hydra> <20040903232507.A8810@flint.arm.linux.org.uk> <20040904111202.GB28074@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040904111202.GB28074@atrey.karlin.mff.cuni.cz>; from pavel@ucw.cz on Sat, Sep 04, 2004 at 01:12:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 01:12:02PM +0200, Pavel Machek wrote:
> Hi!
> 
> > The kernel is NOT in sole control today on ARM platforms:
> > 
> > echo claim > /sys/devices/system/leds/leds0/event
> > echo red on > /sys/devices/system/leds/leds0/event
> > echo green on > /sys/devices/system/leds/leds0/event
> > echo red off > /sys/devices/system/leds/leds0/event
> > echo release > /sys/devices/system/leds/leds0/event
> > 
> > etc
> > 
> > Sure, we have a weird naming scheme (red, green, amber, blue) but
> > that came around because that's what people were dealing with.
> > There's nothing really stopping us from having any name for a LED
> > in the existing scheme.
> > 
> > I just don't buy the "we must have one sysfs node for every LED"
> > argument.
> 
> sysfs is one-file-one-value. We do not want to end up with /proc-like
> mess.

In which case I protest in the strongest terms that having one device
node plus attributes _PER_ _LED_ is just fscking stupid.  What if you
have an embedded machine with 32 LEDs?  Do you _really_ need all that
extra data just to support sysfs so that maybe you can control them
from userspace?

What next?  One sysfs node plus attributes per GPIO line?  How about
we do one sysfs node per virtual memory bit so people can control
anything in their system on a bit granularity without needing mmap
or any other interfaces?  When does this madness stop?

It comes down to this:
 - is a single LED in one package one device?
 - is a set of two LEDs in one package one device?
 - is a set of three LEDs in one package a device?
 - what about a bank of 8 LEDs grouped together?
 - what about 4 banks of 8 LEDs grouped together?
 - what about 7 segment numeric LED displays?
 - what about 14 segment alphanumeric LED displays?

All of these are LED devices.  Does one sysfs node per individual LED
element _really_ make sense for all these cases?  I think not.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
