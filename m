Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266397AbSKGU43>; Thu, 7 Nov 2002 15:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266563AbSKGU43>; Thu, 7 Nov 2002 15:56:29 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62482 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266397AbSKGU41>; Thu, 7 Nov 2002 15:56:27 -0500
Date: Thu, 7 Nov 2002 21:03:04 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Templates and tweaks (for size performance and more)
Message-ID: <20021107210304.C11437@flint.arm.linux.org.uk>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	linux-kernel@vger.kernel.org
References: <20021107190910.GC6164@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021107190910.GC6164@opus.bloom.county>; from trini@kernel.crashing.org on Thu, Nov 07, 2002 at 12:09:10PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 12:09:10PM -0700, Tom Rini wrote:
> The following is vs current 2.5 BK and has been lightly tested on PPC
> (and compiled on i386).  This creates the default files for all current
> arches, and adapts ARM and ia64 as well to show how to override a
> generic param with an arch-specific one (and removes
> CONFIG_FORCE_MAX_ZONEORDER).

This isn't a "tweak" on ARM as in a user-adjustable value.  It needs to
specifically be reduced to prevent things from blowing up.

So, when SA1111-type machines are selected, the max zone order _must_
(no ifs or buts) be set to 9 or below.

> +/* This is the number of free areas per zone to manage, but the max
> + * number determines the maximum order of a page allocation request
> + * as well. */
> +/* Default: 11 */
> +#if defined(ASSABET_NEPONSET0) || defined(SA1100_ADSBITSY) || 		\
> +	defined(SA1100_BADGE4) || defined(SA1100_CONSUS) || 		\
> +	defined(SA1100_GRAPHICSMASTER) || defined(SA1100_JORNADA720) ||	\
> +	defined(ARCH_LUBBOCK) || defined(SA1100_PFS168) ||		\
> +	defined(SA1100_PT_SYSTEM3) || defined(SA1100_XP860)
> +#undef TWEAK_MAX_ORDER
> +#define TWEAK_MAX_ORDER		9
> +#endif

And the reason we have it in the configuration rather than the code is
to get rid of crap like the above.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

