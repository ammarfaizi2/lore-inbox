Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758244AbWK0ObY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758244AbWK0ObY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 09:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758245AbWK0ObY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 09:31:24 -0500
Received: from SMT02002.global-sp.net ([193.168.50.254]:25751 "EHLO
	SMT02002.global-sp.net") by vger.kernel.org with ESMTP
	id S1758244AbWK0ObX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 09:31:23 -0500
Message-ID: <456AF6F5.7050201@privacy.net>
Date: Mon, 27 Nov 2006 15:32:21 +0100
From: John <me@privacy.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050905
X-Accept-Language: en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: tglx@timesys.com, mingo@elte.hu, johnstul@us.ibm.com
Subject: Re: Incorrect behavior of timer_settime() for absolute dates in the
 past
References: <455D7CDD.9000202@privacy.net>
In-Reply-To: <455D7CDD.9000202@privacy.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 27 Nov 2006 14:34:02.0159 (UTC) FILETIME=[15312BF0:01C71231]
X-global-asp-net-MailScanner: Found to be clean
X-global-asp-net-MailScanner-SpamCheck: 
X-MailScanner-From: me@privacy.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John wrote:

> I'm playing with the POSIX timers API. My platform is x86 running Linux 
> 2.6.18.1 patched with the high-resolution timer subsystem.
> 
> http://www.tglx.de/hrtimers.html
> 
> I'm seeing unexpected behavior from timer_settime().
> 
> int timer_settime(timer_t timerid, int flags,
>   const struct itimerspec *value, struct itimerspec *ovalue);
> 
> timer_settime() is used to arm a timer. If the TIMER_ABSTIME flag is 
> set, then the timer should fire when the appropriate clock reaches the 
> date specified by value. If that date is in the past, the timer should 
> fire immediately.
> 
> The Open Group Base Specifications Issue 6 states:
> http://www.opengroup.org/onlinepubs/009695399/functions/timer_getoverrun.html 
> 
> 
> "If the flag TIMER_ABSTIME is set in the argument flags, timer_settime() 
> shall behave as if the time until next expiration is set to be equal to 
> the difference between the absolute time specified by the it_value 
> member of value and the current value of the clock associated with 
> timerid. That is, the timer shall expire when the clock reaches the 
> value specified by the it_value member of value. If the specified time 
> has already passed, the function shall succeed and the expiration 
> notification shall be made."
> 
> In my tests, when timer_settime() is called with an expiration date in 
> the past, the timer still takes some time to fire.
> 
> Here's a run-down of the code provided as an attachment:
> 
> I switch to a SCHED_RR scheduling policy. In other words, whenever my 
> process wants the CPU, it gets it. (No other SCHED_RR or SCHED_FIFO 
> processes on the system.) I mask the signal that will be delivered on 
> timer expiration. I then arm a timer with an expiration date in the 
> past, check whether the signal is pending, and block waiting for the 
> signal. I then print how long I've had to wait.
> 
> # ./a.out
> RESOLUTION=1 ns
> NOW=969.735545919
> SLEEPING 1 SECOND...
> NOW=970.735581398
> NOW=970.735613525
> NOW=970.735749017
> nsdiff=135492 ns i.e. 135.5 µs
> 
> Any ideas?

Is there a better forum to discuss this matter?

Regards.

