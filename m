Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283436AbRK2Xmu>; Thu, 29 Nov 2001 18:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283435AbRK2Xmk>; Thu, 29 Nov 2001 18:42:40 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:23548 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S283455AbRK2XmW>; Thu, 29 Nov 2001 18:42:22 -0500
Message-ID: <3C06C7B3.A1DF4EAB@mvista.com>
Date: Thu, 29 Nov 2001 15:41:39 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Arras <mkarras110@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix for sys_nanosleep() in 2.4.16
In-Reply-To: <3C05DC1D.7071FC6B@yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Arras wrote:
> 
> Greetings,
> 
> For many of us, the kernel thread scheduling resolution is
> 10ms (see getitimer(2)).  By adding 1 jiffy to the time to
> sleep in sys_nanosleep(), threads are sleeping 10ms too long.
> timespec_to_jiffies() does a good job at returning the
> appropriate number of jiffies to sleep.  There is no need to
> add one for good measure.
>
Not really.  It depends on where the call is made with respect to the
next jiffies interrupt.  The standard says that the call MUST not return
early, thus, on the chance that the current time is not exactly on a
jiffies edge, the one must be added.  The average sleep should be 1/HZ+
1/(2*HZ) or 15ms, but never less than 10ms.  For higher resolution stay
tuned to the high-res-timers project (see signature line).


-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
