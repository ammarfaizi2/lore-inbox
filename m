Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292866AbSCWLqG>; Sat, 23 Mar 2002 06:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292857AbSCWLqA>; Sat, 23 Mar 2002 06:46:00 -0500
Received: from zeus.kernel.org ([204.152.189.113]:54725 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292852AbSCWLpu>;
	Sat, 23 Mar 2002 06:45:50 -0500
Date: Sat, 23 Mar 2002 12:41:56 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200203231141.MAA14841@harpo.it.uu.se>
To: egberts@yahoo.com
Subject: Re: 2.4.19-pre3: kernel bug: kswapd vmscan.c:358
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002 18:18:46 -0800 (PST), S W <egberts@yahoo.com> wrote:
>Bare 2.4.19-pre3 Kernel, running all VIA-chipsets mobo
>with "cachesize=0" boot option. (author of previous
>msg: (Cyrix II L2-cache redux?).
>
>Regularly getting kswapd vmscan.c:358 Kernel bug.

You're the one with a VIA C3 with broken L2 cache?
The "cachesize=0" option will not affect the L2 cache, only
the kernel's reporting of cache size. (Apparently due to some
Tualatins not being able to report correct cache size.)

That C3 is broken and should be replaced. If you really want
to use it, you'll need to hardware-disable the L2 cache. Your
BIOS should have an option for that; if not, try the patch below.

/Mikael

--- linux-2.4.19-pre4/arch/i386/kernel/setup.c.~1~	Sat Mar 23 12:26:01 2002
+++ linux-2.4.19-pre4/arch/i386/kernel/setup.c	Sat Mar 23 12:29:17 2002
@@ -1939,6 +1939,7 @@
 				case 6 ... 8:		/* Cyrix III family */
 					rdmsr (MSR_VIA_FCR, lo, hi);
 					lo |= (1<<1 | 1<<7);	/* Report CX8 & enable PGE */
+					lo |= (1<<8);
 					wrmsr (MSR_VIA_FCR, lo, hi);
 
 					set_bit(X86_FEATURE_CX8, &c->x86_capability);
