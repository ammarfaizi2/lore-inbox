Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271654AbRHQNXr>; Fri, 17 Aug 2001 09:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271653AbRHQNXh>; Fri, 17 Aug 2001 09:23:37 -0400
Received: from chaos.analogic.com ([204.178.40.224]:25733 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S271650AbRHQNXT>; Fri, 17 Aug 2001 09:23:19 -0400
Date: Fri, 17 Aug 2001 09:23:29 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Strange macros set HZ value for timer channel zero
Message-ID: <Pine.LNX.3.95.1010817091911.6570A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To whomever maintains the timer code, greetings.

When using Linux on the AMD SC520 chip, the system time will
not be correct because the PIT clock is 1.1882 MHz instead of
the usual 1.19318 MHz. Therefore, I put a conditional value
in ../linux/include/asm/timex.h .

#ifndef _ASMi386_TIMEX_H
#define _ASMi386_TIMEX_H

#include <linux/config.h>
#include <asm/msr.h>
#ifdef SC520
#define CLOCK_TICK_RATE	1188200 /* Underlying HZ */
#else
#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
#endif

Something is wrong! I now gain 3 hours in a 12 hour period. There
are some calculations performed somewhere that result in the
wrong divisor for the timer (PIT). I don't understand any of the
SHIFT stuff, nor FINE_TUNE stuff. It all seems bogus although
it might be the "new math" that's biting me.

The correct value for 100 Hz should be 1188200/100 = 11882 = 0x2e6a
for the divisor. If I hard-code the value as a divisor in
/usr/src/linux/arch/i386/kernel/i8259.c,  it works. If I use the
#defines and macros in the headers, it doesn't.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


