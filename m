Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266691AbSKHAat>; Thu, 7 Nov 2002 19:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266690AbSKHAas>; Thu, 7 Nov 2002 19:30:48 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:44221 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S266689AbSKHAao>; Thu, 7 Nov 2002 19:30:44 -0500
Date: Thu, 7 Nov 2002 17:37:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Templates and tweaks (for size performance and more)
Message-ID: <20021108003721.GH6164@opus.bloom.county>
References: <20021107190910.GC6164@opus.bloom.county> <20021107210304.C11437@flint.arm.linux.org.uk> <20021107220628.GA12151@opus.bloom.county> <20021108002905.F11437@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021108002905.F11437@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 12:29:05AM +0000, Russell King wrote:
> On Thu, Nov 07, 2002 at 03:06:29PM -0700, Tom Rini wrote:
> > But having that as one line in arch/arm/Kconfig looks any better?
> 
> Actually its supposed to depend on CONFIG_SA1111, not that random
> collection of other symbols.  The following just happened to be a nice
> way to specify it under CML1:
> 
> if [ "$CONFIG_ASSABET_NEPONSET" = "y" -o \
>      "$CONFIG_SA1100_ACCELENT" = "y" -o \
>      "$CONFIG_SA1100_ADSBITSY" = "y" -o \
>      "$CONFIG_SA1100_BADGE4" = "y" -o \
>      "$CONFIG_SA1100_CONSUS" = "y" -o \
>      "$CONFIG_SA1100_GRAPHICSMASTER" = "y" -o \
>      "$CONFIG_SA1100_JORNADA720" = "y" -o \
>      "$CONFIG_SA1100_PFS168" = "y" -o \
>      "$CONFIG_SA1100_PT_SYSTEM3" = "y" -o \
>      "$CONFIG_SA1100_XP860" = "y" ]; then
>    define_bool CONFIG_SA1111 y
>    define_int CONFIG_FORCE_MAX_ZONEORDER 9
> fi
> 
> The conversion should've been:
> 
> config FORCE_MAX_ZONEORDER
>         int
>         depends on SA1111
>         default "9"

Ah.  I should have guessed :)  I've seen a few similar ones on PPC.
I'll update the patch.

> Even so, my original point remains about the dependency between config
> symbols concentrating in one "tweaks" header file leading to the situation
> where you change one symbol and everything rebuilds.

Yes, this is an annoyance.  I'm trying to figure out how to adapt
split-include to work with the tweak headers, and I don't think it will
be too painful.  It'll just require something in the middle to take
<asm/tweaks.h> and spit out something akin to <linux/autoconf.h>.

So aside from that, any other comments about the idea or implementation?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
