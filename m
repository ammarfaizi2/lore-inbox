Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbSKILx3>; Sat, 9 Nov 2002 06:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264698AbSKILx3>; Sat, 9 Nov 2002 06:53:29 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:16368 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S264697AbSKILx2>;
	Sat, 9 Nov 2002 06:53:28 -0500
Date: Sat, 9 Nov 2002 13:00:10 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200211091200.NAA19909@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org, zwane@holomorphy.com
Subject: Re: [PATCH][2.5] notsc option needs some attention/TLC
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo writes:
 > notsc doesn't work on a box with a TSC, when we need need the option the 
 > most...
 > 
 > Index: linux-2.5.46-bochs/arch/i386/kernel/cpu/common.c
 > ===================================================================
 > RCS file: /build/cvsroot/linux-2.5.46/arch/i386/kernel/cpu/common.c,v
 > retrieving revision 1.1.1.1
 > diff -u -r1.1.1.1 common.c
 > --- linux-2.5.46-bochs/arch/i386/kernel/cpu/common.c	5 Nov 2002 01:47:31 -0000	1.1.1.1
 > +++ linux-2.5.46-bochs/arch/i386/kernel/cpu/common.c	9 Nov 2002 03:10:45 -0000
 > @@ -12,6 +12,11 @@
 >  
 >  static int cachesize_override __initdata = -1;
 >  static int disable_x86_fxsr __initdata = 0;
 > +#ifdef CONFIG_X86_TSC
 > +static int tsc_disable __initdata = 0;
 > +#else
 > +#define tsc_disable	1
 > +#endif

CONFIG_X86_TSC means "I have a TSC, period" not "I may have a TSC".
It's an optimisation option, not a "try this" option.

If we configure for "I have a TSC, period" you add the option
to disable it, which nullifies any benefit of the config option
in the first place since we can't assume TSC presence any more.
If we don't configure for TSC, you force tsc_disable, which means
that a generic kernel _can't_ use the TSC.

People with broken TSCs need to run non-TSC-assuming kernels.

/Mikael
