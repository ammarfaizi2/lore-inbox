Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265880AbRF2MVH>; Fri, 29 Jun 2001 08:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265874AbRF2MU6>; Fri, 29 Jun 2001 08:20:58 -0400
Received: from yellow.jscc.ru ([195.208.40.129]:25101 "EHLO yellow.jscc.ru")
	by vger.kernel.org with ESMTP id <S265873AbRF2MUv>;
	Fri, 29 Jun 2001 08:20:51 -0400
Message-ID: <022901c10095$f4fca650$4d28d0c3@jscc.ru>
From: "Oleg I. Vdovikin" <vdovikin@jscc.ru>
To: <linux-kernel@vger.kernel.org>
Subject: alpha - generic_init_pit - why using RTC for calibration?
Date: Fri, 29 Jun 2001 16:20:59 +0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

    we've a bunch of UP2000/UP2000+ boards (similar to DP264) with 666MHz
EV67 Alphas (we're building large Alpha cluster). And we're regulary see
"HWRPB cycle frequency bogus" and the measured value for the speed in the
range of 519 MHz - 666 MHz. And this value changes in this range from boot
to boot. So why this happens???

    Initialy we've an idea this boards has frequency stability problem. But
then I've decided to add simple recalculation for est_cycle_freq on every
1024 ticks which happens on boot processor (I've used rpcc for the
counting). I've added 10 lines to the timer_interrupt function. And I was
really wondered: the clock are rock solid - near 666 MHz and +- 1Khz
stability (I'm thinking it's some non constant overhead in the irq
handlers).

    So, I've looked deeper. And here is the question: why using RTC for
calibration and UIP bit? This bit guarantees nothing - the specs said when
it's raised to 1 if clock update occures in the ~244 ms! But it does not
said this happens regulary in the same time for this 244 ms!

    So, the final question: why we're not using the aproach which is used by
x86 time.c? I.e. why not to use CTC channel 2 for calibration?

    Please correct me, if there is something wrong.

Thanks,
    Oleg.

