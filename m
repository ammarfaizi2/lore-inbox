Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276048AbSIVDqr>; Sat, 21 Sep 2002 23:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276069AbSIVDqr>; Sat, 21 Sep 2002 23:46:47 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:1271 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S276048AbSIVDqq>;
	Sat, 21 Sep 2002 23:46:46 -0400
Message-ID: <3D8D3E4A.94C19E1@mvista.com>
Date: Sat, 21 Sep 2002 20:51:38 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jos Hulzink <josh@stack.nl>
CC: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: udelay and nanosleep questions
References: <20020921124235.I46546-100000@toad.stack.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jos Hulzink wrote:
> 
> Hi,
> 
> Talking about kernel driver programming:
> 
> 1) Can I rely on udelay(1) ? i.e. is the resolution high enough to wait at
> least 1 microsecond given it returns normally ? I know the actual
> implementation is platform / cpu dependant, so maybe I should ask: Should
> I be able to rely on udelay(1) ?
> 
> 2) With the highspeed CPUs these days, the implementation of sys_nanosleep
> (in kernel/timer.c) for realtime processes:
> 
> sys_nanosleep {udelay ((nsec+999)/1000}
> 
> is rather low-res. Time for something new ? sys_nanosleep seems not the
> call to make for in-kernel accurate delays, for it schedules a timeout
> instead of doing a busy wait. My driver needs 250 ns delays, is there a
> more accurate way than udelay(1) ? It is a pity to waste 4x more
> clockcycli than needed.
> 
> 3) Usleep and friends seem not to care about speedstepping technologies.
> Shouldn't we care, at least for in-kernel and realtime process waits ?
> True, you are an idiot when running realtime processes on a speedstep
> enabled CPU, but still...

You might want to check out the high-res-timers stuff.  We
will be sending this in soon for 2.5, for 2.4, see the link
below.

-g
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
