Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266093AbSKFUC4>; Wed, 6 Nov 2002 15:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266096AbSKFUC4>; Wed, 6 Nov 2002 15:02:56 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:52619 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266093AbSKFUCz>;
	Wed, 6 Nov 2002 15:02:55 -0500
Subject: Re: Voyager subarchitecture for 2.5.46
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211060729210.2393-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0211060729210.2393-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 06 Nov 2002 12:07:53 -0800
Message-Id: <1036613273.6099.164.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-06 at 07:45, Linus Torvalds wrote:
> The solution is to make all the TSC calibration and offsets be per-CPU.  
> That should be fairly trivial, since we _already_ do the calibration
> per-CPU anyway for bogomips (for no good reason except the whole process
> is obviously just a funny thing to do, which is the point of bogomips).

This was discussed earlier, but dismissed as being a can of worms. It
still is possible to do (and can be added as just another timer_opt
stucture), but uglies like the spread-spectrum feature on the x440,
which actually runs each node at slightly varying speeds, pop up and
make my head hurt. Regardless, the attempt would probably help clean
things up, as you mentioned below. We also would need to round-robin the
timer interrupt, as each cpu would need a last_tsc_low point to generate
an offset. So I'm not opposed to it, but I'm not exactly eager to
implement it. 

> Let's face it, we don't have that many tsc-related data structures. What, 
> we have:
> 
>  - loops_per_jiffy, which is already a per-CPU thing, used by udelay()
>  - fast_gettimeoffset_quotient - which is global right now and shouldn't 
>    be.

Good to see its on your hit-list. :) I mailed out a patch for this
earlier, I'll resend later today.

>  - delay_at_last_interrupt. See previous.

I'll get to this one too, as well as a few other spots where the
timer_opts abstraction isn't clean enough (cpu_khz needs to be pulled
out of the timer_tsc code, etc)

thanks for the feedback
-john


