Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272414AbTHBJ0Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 05:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272457AbTHBJ0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 05:26:25 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:54516 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S272414AbTHBJ0X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 05:26:23 -0400
Message-ID: <3F2B83A0.7020205@mvista.com>
Date: Sat, 02 Aug 2003 02:25:52 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: Mark Mielke <mark@mark.mielke.cc>, Stephen Anthony <stephena@cs.mun.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: What's the timeslice size for kernel 2.6.0-test2, IA32?
References: <200308011404.46886.stephena@cs.mun.ca> <20030801183450.GC20001@mark.mielke.cc> <3F2ABF7E.4060006@candelatech.com>
In-Reply-To: <3F2ABF7E.4060006@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> 
> Mark Mielke wrote:
> 
>> On Fri, Aug 01, 2003 at 02:04:46PM -0230, Stephen Anthony wrote:
>>
>>> It would be great if sleeps were 1ms accurate instead of 10ms.  It 
>>> would make synchronization code a lot easier.
>>
>>
>>
>> Doesn't this depend on what HZ you define for the kernel?
>>
>> If you want 1ms sleep, just set HZ to 1000HZ+, and give your process a
>> high priority?

As it currently stands in the 2.6 kernel for the i386, HZ is defined 
as 1000.  Since the PIT interrupt source can not hit this, the actual 
timer interrupt period is 999848 nano seconds.  The minimum sleep 
interval nanosleep will take is 1 of these and since the time may 
start between ticks it adds another to give a min sleep time of 
999848+~1/2 of that depending on where the request falls in the time 
period.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

