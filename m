Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129096AbRBBCgK>; Thu, 1 Feb 2001 21:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129215AbRBBCgA>; Thu, 1 Feb 2001 21:36:00 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:28365 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129096AbRBBCfq>;
	Thu, 1 Feb 2001 21:35:46 -0500
Date: Fri, 2 Feb 2001 03:35:37 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200102020235.DAA05959@harpo.it.uu.se>
To: mingo@elte.hu
Subject: Re: [PATCH] 2.4.1-ac1 UP-APIC/NMI watchdog fixes
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        macro@ds2.pg.gda.pl, vandrove@vc.cvut.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2001 01:37:28 +0100, Ingo Molnar wrote:

> On Thu, 1 Feb 2001, Mikael Pettersson wrote:
> 
> > This patch (against 2.4.1-ac1) contains the following fixes:
> > * UP-APIC linkage fix: nr_ioapics must be moved from io_apic.c to
> >   mpparse.c to permit linking the kernel in pure UP-APIC configs.
> > * NMI watchdog cleanups: mark setup_apic_nmi_watchdog() as __init,
> >   fix the K7 init code to not leave any perfctr MSR uninitialised,
> >   avoid having to check CPU type in NMI handler.
> >   (Yes, the merged wrmsr(,,-1) is safe for P6.)
> 
> thanks Mikael! Did you have a chance to test this on a K7? Does
> UP-APIC-NMI-watchdog code truly 'just work' now on the K7?

I wrote the initial patch using the info I gathered for my
performance-monitoring counters driver. Petr Vandrovec tested
and debugged it. (Alas, I don't yet have a K7 to play with.)

It seems K7 BIOSen keep the local APIC enabled as opposed to
what P6 BIOSen tend to do (at least, Petr's ASUS A7V did),
so in a sense, yes "it just works". The clock denoted by the
event selector is not perfect (it slows down by a factor of
100 when the CPU is idle), but the NMIs do keep coming in.

I might have been able to whip up something better, if AMD
hadn't required an NDA for the K7 BIOS writer's manual. My
regard for them is pretty low right now.

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
