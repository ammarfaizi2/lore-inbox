Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263795AbTCVUPG>; Sat, 22 Mar 2003 15:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263797AbTCVUPG>; Sat, 22 Mar 2003 15:15:06 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:12939 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263795AbTCVUPF>; Sat, 22 Mar 2003 15:15:05 -0500
Date: Sat, 22 Mar 2003 21:22:01 +0100
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Alan Cox <alan@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.65-ac2 (drivers/char/genrtc.c compile failure on i386)
Message-ID: <20030322202201.GA32386@localhost>
References: <200303211741.h2LHfPn00366@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200303211741.h2LHfPn00366@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday March 21st 2003 at 12:41 Alan Cox wrote:

> Linux 2.5.65-ac2
>       ...
> o	M68K rtc updates				(Geert Uytterhoeven)

The file drivers/char/genrtc.c was updated, but include/arch-generic/rtc.h
which is used on i386 wasn't (yet?), leading to compile failures on i386:
(the missing define is only the first symptom)

  gcc -Wp,-MD,drivers/char/.genrtc.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium3 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=genrtc -DKBUILD_MODNAME=genrtc -c -o drivers/char/genrtc.o drivers/char/genrtc.c
drivers/char/genrtc.c:100: warning: static declaration for `gen_rtc_interrupt' follows non-static
drivers/char/genrtc.c: In function `gen_rtc_timer':
drivers/char/genrtc.c:135: warning: comparison of distinct pointer types lacks a cast
drivers/char/genrtc.c: In function `gen_rtc_open':
drivers/char/genrtc.c:358: warning: `_MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:456)
drivers/char/genrtc.c: In function `gen_rtc_release':
drivers/char/genrtc.c:377: warning: `__MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:431)
drivers/char/genrtc.c: In function `gen_rtc_proc_output':
drivers/char/genrtc.c:453: void value not ignored as it ought to be
drivers/char/genrtc.c:498: `RTC_BATT_BAD' undeclared (first use in this function)
drivers/char/genrtc.c:498: (Each undeclared identifier is reported only once
drivers/char/genrtc.c:498: for each function it appears in.)
make[2]: *** [drivers/char/genrtc.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

Marco Roeland
