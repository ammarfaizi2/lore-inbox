Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266676AbSKHAW3>; Thu, 7 Nov 2002 19:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266677AbSKHAW3>; Thu, 7 Nov 2002 19:22:29 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43269 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266676AbSKHAW3>; Thu, 7 Nov 2002 19:22:29 -0500
Date: Fri, 8 Nov 2002 00:29:05 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Templates and tweaks (for size performance and more)
Message-ID: <20021108002905.F11437@flint.arm.linux.org.uk>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	linux-kernel@vger.kernel.org
References: <20021107190910.GC6164@opus.bloom.county> <20021107210304.C11437@flint.arm.linux.org.uk> <20021107220628.GA12151@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021107220628.GA12151@opus.bloom.county>; from trini@kernel.crashing.org on Thu, Nov 07, 2002 at 03:06:29PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 03:06:29PM -0700, Tom Rini wrote:
> But having that as one line in arch/arm/Kconfig looks any better?

Actually its supposed to depend on CONFIG_SA1111, not that random
collection of other symbols.  The following just happened to be a nice
way to specify it under CML1:

if [ "$CONFIG_ASSABET_NEPONSET" = "y" -o \
     "$CONFIG_SA1100_ACCELENT" = "y" -o \
     "$CONFIG_SA1100_ADSBITSY" = "y" -o \
     "$CONFIG_SA1100_BADGE4" = "y" -o \
     "$CONFIG_SA1100_CONSUS" = "y" -o \
     "$CONFIG_SA1100_GRAPHICSMASTER" = "y" -o \
     "$CONFIG_SA1100_JORNADA720" = "y" -o \
     "$CONFIG_SA1100_PFS168" = "y" -o \
     "$CONFIG_SA1100_PT_SYSTEM3" = "y" -o \
     "$CONFIG_SA1100_XP860" = "y" ]; then
   define_bool CONFIG_SA1111 y
   define_int CONFIG_FORCE_MAX_ZONEORDER 9
fi

The conversion should've been:

config FORCE_MAX_ZONEORDER
        int
        depends on SA1111
        default "9"

Even so, my original point remains about the dependency between config
symbols concentrating in one "tweaks" header file leading to the situation
where you change one symbol and everything rebuilds.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

