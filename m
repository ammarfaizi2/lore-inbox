Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVB0AnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVB0AnW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 19:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVB0AnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 19:43:22 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60933 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261315AbVB0AnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 19:43:16 -0500
Date: Sun, 27 Feb 2005 01:43:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] deprecate EXPORT_SYMBOL(do_settimeofday)
Message-ID: <20050227004313.GQ3311@stusta.de>
References: <20050224233742.GR8651@stusta.de> <20050224212448.367af4be.akpm@osdl.org> <20050226133337.GK3311@stusta.de> <20050226144635.B7151@flint.arm.linux.org.uk> <20050226162341.GN3311@stusta.de> <20050226164613.E7151@flint.arm.linux.org.uk> <20050226171325.GO3311@stusta.de> <20050226172922.B15124@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050226172922.B15124@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2005 at 05:29:22PM +0000, Russell King wrote:
> On Sat, Feb 26, 2005 at 06:13:25PM +0100, Adrian Bunk wrote:
> > You call it "breakage" because you have a relatively dogmatic view 
> > regarding the selection of user visible symbols.
> > Other people care more about the usability of the kernel config system, 
> > and therefore a select of one of the I2C* options is quite common from 
> > both outside and inside the i2c subsystem.
> 
> I think you have to realise that we're different in the ARM world.
> We tend to rely on the default configuration files to come out with
> something that works, rather than hard coding the "what works" into
> the kernel configuration subsystem.
> 
> If you want to see an example of this kind of "usability" approach,
> take a look at arch/arm/Kconfig LEDS options - lines of 250 or so
> characters of dependencies.  Not what I'd call particularly
> maintainable.
> 
> That is what your approach has in store for the other Kconfig files
> when it comes down to getting dependencies Correct(tm).

LEDS=n and LEDS_TIMER=y is a legal configuration if ARCH_EBSA110?

The LEDS_TIMER dependencies seem to be incorrect at least regarding 
ARCH_CDB89712.

Yes, it is ugly annd error-prone.

> (I do have a simplified LEDS configuration set, but it still keeps
> one huge LEDS dependency.)

The current LEDS configuration is ugly, but that's not an ARM specific 
problem. Compare e.g. the big #if in include/linux/parport.h 30 lines 
before the end of the file in Linus' tree and see how this is resolved 
in -mm in non-pc-parport-config-change.patch .

One solution for LEDS would be to add a helper option HAS_LEDS that gets 
selected by the ARCH_* options if the platform supports LEDS, and LEDS 
simply depends on HAS_LEDS.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

