Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266303AbRGFIqg>; Fri, 6 Jul 2001 04:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266304AbRGFIq1>; Fri, 6 Jul 2001 04:46:27 -0400
Received: from yellow.jscc.ru ([195.208.40.129]:18186 "EHLO yellow.jscc.ru")
	by vger.kernel.org with ESMTP id <S266303AbRGFIqN>;
	Fri, 6 Jul 2001 04:46:13 -0400
Message-ID: <003701c105f8$06bb6fe0$4d28d0c3@jscc.ru>
From: "Oleg I. Vdovikin" <vdovikin@jscc.ru>
To: "Jeff Garzik" <jgarzik@mandrakesoft.com>
Cc: "Richard Henderson" <rth@twiddle.net>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>, <alan@redhat.com>,
        <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <022901c10095$f4fca650$4d28d0c3@jscc.ru> <20010629211931.A582@jurassic.park.msu.ru> <20010704114530.A1030@twiddle.net> <003e01c10522$1c9cf580$4d28d0c3@jscc.ru> <3B441618.638A3FC@mandrakesoft.com> <00a001c1052d$a3201320$4d28d0c3@jscc.ru> <3B4429AA.208BB183@mandrakesoft.com>
Subject: Re: [patch] Re: alpha - generic_init_pit - why using RTC for   calibration?
Date: Fri, 6 Jul 2001 12:45:35 +0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

    The things are pretty simple (HZ - in real should be "Hz", cause HZ are
fixed for Alpha, HZ = 1024 Hz) :
        Hz = cc / calibration_time

    cc == rpcc() at end - rpcc() at begin
    calibration_time = (CLOCK_TICK_RATE / CALIBRATE_LATCH).

    So there is nothing wrong - clock ticks with CLOCK_TICK_RATE and we've a
divisor equal to CALIBRATE_LATCH. So the time interval elapses after
(CLOCK_TICK_RATE / CALIBRATE_LATCH) seconds and the CPU performs 'cc'
cycles.

    That's all. And these really works. ;-))

    About x86 style code - don't forget what LATCH defined as follows in
linux/timex.h:

#define LATCH  ((CLOCK_TICK_RATE + HZ/2) / HZ) /* For divider */

Regards,
    Oleg.

> Oleg,
>
> How is this relative to HZ, when you remove all references to HZ?
>
> > -#define CALIBRATE_LATCH        (52 * LATCH)
> > -#define CALIBRATE_TIME (52 * 1000020 / HZ)
> > +#define CALIBRATE_LATCH        0xffff
> [...]
> > +       /* and the final result in HZ */
> > +       return ((unsigned long)cc * CLOCK_TICK_RATE) / CALIBRATE_LATCH;
>
> and in asm-alpha/timex.h,
> > #define CLOCK_TICK_RATE 1193180 /* Underlying HZ */
>
> --
> Jeff Garzik      | Thalidomide, eh?
> Building 1024    | So you're saying the eggplant has an accomplice?
> MandrakeSoft     |
>

