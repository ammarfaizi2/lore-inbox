Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263884AbTCUTJt>; Fri, 21 Mar 2003 14:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263873AbTCUTIy>; Fri, 21 Mar 2003 14:08:54 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:42747 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S263867AbTCUTIZ>;
	Fri, 21 Mar 2003 14:08:25 -0500
Message-ID: <3E7B659F.9020407@mvista.com>
Date: Fri, 21 Mar 2003 11:18:55 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Waitz <tali@admingilde.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Clock monotonic  a suggestion
References: <3E7A59CD.8040700@mvista.com> <20030321131744.GL27366@admingilde.org>
In-Reply-To: <20030321131744.GL27366@admingilde.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Waitz wrote:
> On Thu, Mar 20, 2003 at 04:16:13PM -0800, george anzinger wrote:
> 
>>Define CLOCK_MONOTONIC to be the same as
>>(gettimeofday() + wall_to_monotonic).
> 
> 
> why don't you simply use asm("rdtsc") ?
> (ok, you should make sure that you always ask the same processor and
> stuff, but using the built in TSC seems to do everything you want...)
> 
> 
I don't really understand how :(

I want a tick on CLOCK_MONOTONIC to be the same size as a tick on 
gettimeofday() over the life of the system.  I.e. lock step.  The only 
difference is that CLOCK_MONOTONIC can not be set, so, if we use the 
above, wall_to_monotonic must be adjusted when the gettimeofday() 
clock is set (but not when it is "adjusted" by NTP).

asm("rdtsc") is, first of all, only useful on x86 platforms, 
CLOCK_MONOTONIC is in the POSIX clocks and timers code and in all 
platforms.  Second, each platform has an equivalent, best guess, way 
of filling in the time information below the 1/HZ level (and yes, some 
x86 platforms use TSC) already in the gettimeofday() code.  Except 
that the system settime code is platform dependent, this solution is 
platform independent.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

