Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263220AbTCUAFl>; Thu, 20 Mar 2003 19:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263195AbTCUAFk>; Thu, 20 Mar 2003 19:05:40 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:34289 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S263182AbTCUAFk>;
	Thu, 20 Mar 2003 19:05:40 -0500
Message-ID: <3E7A59CD.8040700@mvista.com>
Date: Thu, 20 Mar 2003 16:16:13 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Clock monotonic  a suggestion
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In an effort to get better resolution and to get CLOCK_MONOTONIC to 
better track CLOCK_REALTIME, I would like to do the following:

Define CLOCK_MONOTONIC to be the same as
(gettimeofday() + wall_to_monotonic).

Wall_to_monotonic would be defined at boot time as -(gettimeofday()) 
at that time and would be updated each time the wall clock is set. 
Currently this happens in only three places in the kernel, two in the 
wall clock update routine (a leap second can be added or subtracted) 
and in settimeofday().  The update of wall_to_monotonic must be done 
under the xtime lock, as should the add to convert gettimeofday() to 
CLOCK_MONOTONIC.

What this gets us is:

Both clocks will tick at the same rate, even under NTP corrections.
The conversion is a simple (well almost simple) add.
Both clocks will have the same resolution.

Comments?

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

