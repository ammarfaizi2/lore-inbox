Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266464AbRGFMAv>; Fri, 6 Jul 2001 08:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266457AbRGFMAl>; Fri, 6 Jul 2001 08:00:41 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:60423 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S266454AbRGFMAd>; Fri, 6 Jul 2001 08:00:33 -0400
Date: Fri, 6 Jul 2001 16:00:24 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "Oleg I. Vdovikin" <vdovikin@jscc.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: alpha - generic_init_pit - why using RTC for calibration?
Message-ID: <20010706160024.A2620@jurassic.park.msu.ru>
In-Reply-To: <022901c10095$f4fca650$4d28d0c3@jscc.ru> <20010629211931.A582@jurassic.park.msu.ru> <20010704114530.A1030@twiddle.net> <003e01c10522$1c9cf580$4d28d0c3@jscc.ru> <20010705134306.A2071@jurassic.park.msu.ru> <005601c105fa$8be41cb0$4d28d0c3@jscc.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <005601c105fa$8be41cb0$4d28d0c3@jscc.ru>; from vdovikin@jscc.ru on Fri, Jul 06, 2001 at 01:03:38PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2001 at 01:03:38PM +0400, Oleg I. Vdovikin wrote:
> return ((long)cc * 1000000) / CALIBRATE_TIME;
> 
>     truncates the result to the MHZ because of the '* 1000000' statement (cc
> is an int value, so you just loose the precision).

No, this is ok. 'cc' is long here, and CALIBRATE_TIME is in microseconds,
hence '* 1000000'.

> This works ok for x86,
> because x86 uses this value with an accuracy to MHz, but this is not enough
> for Alphas (see gettimeofday - we're relies rpcc for calculation). Try to
> pass 'cycle=666000000' to your kernel and when run ntp - you're out of luck
> for clock sync.

Hmm, this should be ok. I heard of people who had problems with ntp starting
from 0.5% or more difference between real and estimated clock rates.

>     But the most innacuracy comes from
> 
> #define CALIBRATE_TIME (5 * 1000020/HZ)

With that I agree. All these integer divisions leads to about
%0.02 error.

>     (long)(int)0x80000000 != (long)(unsigned int)0x80000000, and
> (long)(int)0x80000000 < 0 and you will get negative frequency value (yes we
> current boxes we're not overflowing, but let's look for the future).

Oh, I see. So you're arguing for 72 vs. 36 GHz limit. ;-)

> Funny?
> ;-))

Not at all. The future of Alpha is dark... [thanks, Compaq!]

> P.S. Ivan, you can reach me by dialing 938-6412 in Moscow.

Ok. And I can be reached at 930-8952.

Ivan.
