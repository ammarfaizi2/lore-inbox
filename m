Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266597AbSKGV7x>; Thu, 7 Nov 2002 16:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266598AbSKGV7x>; Thu, 7 Nov 2002 16:59:53 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:11453 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S266597AbSKGV7v>; Thu, 7 Nov 2002 16:59:51 -0500
Date: Thu, 7 Nov 2002 15:06:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Templates and tweaks (for size performance and more)
Message-ID: <20021107220628.GA12151@opus.bloom.county>
References: <20021107190910.GC6164@opus.bloom.county> <20021107210304.C11437@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021107210304.C11437@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 09:03:04PM +0000, Russell King wrote:
> On Thu, Nov 07, 2002 at 12:09:10PM -0700, Tom Rini wrote:
> > The following is vs current 2.5 BK and has been lightly tested on PPC
> > (and compiled on i386).  This creates the default files for all current
> > arches, and adapts ARM and ia64 as well to show how to override a
> > generic param with an arch-specific one (and removes
> > CONFIG_FORCE_MAX_ZONEORDER).
> 
> This isn't a "tweak" on ARM as in a user-adjustable value.  It needs to
> specifically be reduced to prevent things from blowing up.

It is however, a "tweak" of the default value of 11.  I'll add a comment
about this for the next version.  And if it can be less than 9, it is
user-adjustable, it just has to be adjusted between 1 and 9.

> > +/* This is the number of free areas per zone to manage, but the max
> > + * number determines the maximum order of a page allocation request
> > + * as well. */
> > +/* Default: 11 */
> > +#if defined(ASSABET_NEPONSET0) || defined(SA1100_ADSBITSY) || 		\
> > +	defined(SA1100_BADGE4) || defined(SA1100_CONSUS) || 		\
> > +	defined(SA1100_GRAPHICSMASTER) || defined(SA1100_JORNADA720) ||	\
> > +	defined(ARCH_LUBBOCK) || defined(SA1100_PFS168) ||		\
> > +	defined(SA1100_PT_SYSTEM3) || defined(SA1100_XP860)
> > +#undef TWEAK_MAX_ORDER
> > +#define TWEAK_MAX_ORDER		9
> > +#endif
> 
> And the reason we have it in the configuration rather than the code is
> to get rid of crap like the above.

But having that as one line in arch/arm/Kconfig looks any better?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
