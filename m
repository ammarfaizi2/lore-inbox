Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131306AbRAOU1N>; Mon, 15 Jan 2001 15:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131308AbRAOU1D>; Mon, 15 Jan 2001 15:27:03 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:43949 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S131306AbRAOU0v>;
	Mon, 15 Jan 2001 15:26:51 -0500
Date: Mon, 15 Jan 2001 21:26:45 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200101152026.VAA03317@harpo.it.uu.se>
To: mikpe@csd.uu.se, vandrove@vc.cvut.cz
Subject: Re: [PATCH] enable K7 nmi watchdog
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2001 04:00:29 +0100, Petr Vandrovec wrote:

>(1) You missed some zeros in MSR_K7_ definitions

Oops :-(

>(2) AMD's MSR are real 64bit (well, 47bit) values, so high
>    MSR dword must be set to -1, not to 0

Correct. That was a copy-paste error from the P6 code.
When writing to a perfctr MSR, Intel P6 sign-extends bit 31.
P5 and Pentium 4 [*], and AMD K7 don't sign-extend, so there one
has to pass -1 in the high word.

[*] P4? PIV? P15? NB? Oh why oh why couldn't they just have named
the core P7 ...

>(3) on my CPU performance register 0x76 counts who knows what...
>    This causes that when machine is idle, there is exactly one
>    NMI per second. When machine is loaded, NMI count/sec climbs
>    up to 100 NMIs per sec. I have no idea whether someone slows
>    clock down to 10MHz on hlt, or what happens. Maybe that they
>    removed this from documentation due to this. This also means
>    that on bootup check for NMI stuck probably passed only
>    due to pure luck - because of mdelay()/udelay() is implemented
>    as tight loop.

The varying speed of this counter is unfortunate, but at least
it doesn't stop completely. The NMI oopser should still trigger,
although perhaps after a much longer delay.

>Otherwise it works

Great. Thanks.

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
