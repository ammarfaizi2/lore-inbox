Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSGMUyx>; Sat, 13 Jul 2002 16:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315440AbSGMUyw>; Sat, 13 Jul 2002 16:54:52 -0400
Received: from t1o53p61.telia.com ([62.20.228.61]:38273 "EHLO best.localdomain")
	by vger.kernel.org with ESMTP id <S313628AbSGMUyw>;
	Sat, 13 Jul 2002 16:54:52 -0400
To: Russell King <rmk@arm.linux.org.uk>
Cc: Peter Osterlund <petero2@telia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-rc1-ac3
References: <Pine.LNX.4.44.0207131435570.3808-100000@linux-box.realnet.co.sz>
	<m2n0svr42e.fsf@best.localdomain>
	<1026584861.13886.27.camel@irongate.swansea.linux.org.uk>
	<m265zj9zxn.fsf@best.localdomain>
	<20020713205422.E25995@flint.arm.linux.org.uk>
From: Peter Osterlund <petero2@telia.com>
Date: 13 Jul 2002 22:56:07 +0200
In-Reply-To: <20020713205422.E25995@flint.arm.linux.org.uk>
Message-ID: <m2n0sv2vq0.fsf@best.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:

> On Sat, Jul 13, 2002 at 09:43:16PM +0200, Peter Osterlund wrote:
> > So, is any of the above true for x86 processors? Or are there other
> > reasons to expect frequency scaling to increase battery run-time.
> 
> You're right if your CPU usage is 100% - lowering the CPU clock rate
> means you take longer to complete the task, and with the static
> element of the CPU power consumption, you'd probably end up using
> more energy to perform the same task in a longer time.
> 
> However, if, like most desktops, your CPU is sitting around 90% idle,
> if you lower the CPU clock rate, the idle time will drop.  Since the
> power drops, the rate at which the CPU uses energy also drops.
> However, overall your task completes in the same amount of time.

Hmm, assume my activity at the computer requires 10% CPU time when the
CPU is at full speed. My power consumption will then be

        P_fullspeed = P_static + 0.9 * P_idle_hi + 0.1 * P_busy_hi

If I halve the clock frequency, the computer will require 20% CPU time
to perform the work, and the power consumption becomes

        P_halfspeed = P_static + 0.8 * P_idle_lo + 0.2 * P_busy_lo

If the voltage doesn't change, 0.1 * P_busy_hi == 0.2 * P_busy_lo, so
the power savings will be

        P_fullspeed - P_halfspeed = 0.9 * P_idle_hi - 0.8 * P_idle_lo

or
        deltaP = 0.1 * P_idle_hi + 0.8 * (P_idle_hi - P_idle_lo)

The first term will be smaller the more idle my CPU is. (When reading
mail, I think 99% idle time is closer to the truth than 90%). The
second term in this formula is the reason I wondered if the power
consumption in apm idle mode is lower at lower clock frequencies.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
