Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261695AbTCGSKg>; Fri, 7 Mar 2003 13:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261709AbTCGSKg>; Fri, 7 Mar 2003 13:10:36 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:35571 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261695AbTCGSKe>;
	Fri, 7 Mar 2003 13:10:34 -0500
Message-ID: <3E68E2E3.6030404@mvista.com>
Date: Fri, 07 Mar 2003 10:20:19 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Piel <Eric.Piel@Bull.Net>
CC: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, jim.houston@ccur.com
Subject: Re: POSIX timer syscalls
References: <200303062306.h26N6hrd008442@napali.hpl.hp.com>	<3E67DF8E.9080005@mvista.com>	<15975.62823.5398.712934@napali.hpl.hp.com>	<3E67F844.2090902@mvista.com> <15975.63734.837748.29150@napali.hpl.hp.com> <3E68573A.4020206@mvista.com> <3E688D29.F2E48939@Bull.Net>
In-Reply-To: <3E688D29.F2E48939@Bull.Net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Piel wrote:
> george anzinger wrote:
> 
>>By the way, I am seeing some reports from the clock_nanosleep test
>>about sleeping too long or too short.  The too long appears to be just
>>not being able to preempt what ever else is running.  The too short
>>(on the x86) is, I believe, due to the fact that more that 1/HZ is
>>clocked on the wall clock each jiffie.
>>
>>Try this:
>>
>>time sleep 60
>>
>>On the x86 it reports less than 60, NOT good.
>>
> 
> I've run the test programs and they pass everything well (with my
> patchs) excepted the nanosleeps which seems to be finnished a bit too
> early. My system test is a 2.5.64 patched on a 4xItaniumII.
> 
> My main question is to know if it's a problem even if the difference
> between the wakeup time and the requested time is smaller than the
> resolution of the clock, 976562ns ? I mean, at the resolution of the
> clock we could consider we woke up right at the good time, couldn't we?
> 
> In addition time sleep 60 always gave me time over 1 minute, I guess
> it's a good point. 
> 
> Here is a part of the log of 'do_test':
> 
> Testing behavor with clock seting...
> Retarding the clock
> Clock did not seem to move
>  was:           1046969027s 703359000ns
>  requested:     1046969023s 703359000ns
>  now:           1046969022s 467072000ns
>  diff is -1.236286998sec
> Cool clock_nanosleeptest.c,379:clock_nanosleep(clock, TIMER_ABSTIME,
> &ts, NULL)

Is it possible that a "clock_was_set()" call was missed?  I.e in the 
set_timeofday code?
> 
> Testing signal behavor...
> handler1 entered: signal 31
> expected clock_nanosleeptest.c,227:clock_nanosleep(clock, 0, &ts, &rs):
> Interrupted system call
> Time remaining is 0s 989257306ns
> clock_nanosleeptest.c,245:slept too short!
>  requested:     275s 207032000ns
>  now:           275s 207030632ns
>  diff is -0.000001368sec
> 
> Testing undelivered signal behavor...
> Cool clock_nanosleeptest.c,267:clock_nanosleep(clock, 0, &ts, &rs)
> clock_nanosleeptest.c,283:slept too short!
>  requested:     275s 223633000ns
>  now:           275s 223632698ns
>  diff is -0.000000302sec
> 
> 
>  --Eric
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

