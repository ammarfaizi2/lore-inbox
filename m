Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbTCJWgo>; Mon, 10 Mar 2003 17:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261660AbTCJWgm>; Mon, 10 Mar 2003 17:36:42 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:24306 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261658AbTCJWgh>;
	Mon, 10 Mar 2003 17:36:37 -0500
Message-ID: <3E6D15DA.5020700@mvista.com>
Date: Mon, 10 Mar 2003 14:46:50 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: torvalds@transmeta.com, cobra@compuserve.com, linux-kernel@vger.kernel.org
Subject: Re: Runaway cron task on 2.5.63/4 bk?
References: <Pine.LNX.4.44.0303101147200.2542-100000@home.transmeta.com>	<3E6D0FD5.2090707@mvista.com> <20030310142944.2dff3422.akpm@digeo.com>
In-Reply-To: <20030310142944.2dff3422.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> george anzinger <george@mvista.com> wrote:
> 
>>Linus Torvalds wrote:
>>
>>>On Mon, 10 Mar 2003, george anzinger wrote:
>>>
>>>
>>>>Lets consider this one on its own merits.  What SHOULD sleep do when 
>>>>asked to sleep for MAX_INT number of jiffies or more, i.e. when 
>>>>jiffies overflows?  My notion, above, it that it is clearly an error. 
>>>
>>>
>>>My suggestion (in order of preference):
>>> - sleep the max amount, and then restart as if a signal had happened
>>
>>I think this will require a 64-bit expire in the timer_struct 
>>(actually it would not be treated as such, but the struct would still 
>>need the added bits).  Is this ok?
>>
>>I will look at the problem in detail and see if there might be another 
>>way without the need of the added bits.
> 
> 
> Is it not possible to just sit in a loop, sleeping for 0x7fffffff jiffies
> on each iteration?  (Until the final partial bit of course)

Seems reasonable.  I will have a look.

-g
> 
> 
>>Hm...  I changed it to what it is to make it easier to track down 
>>problems in the test code... and this was user code.  My thinking was 
>>that such large values are clear errors, and having the code "hang" in 
>>the sleep just hides the problem.  But then, I NEVER make a system 
>>call without checking for errors....  And, I was making a LOT of sleep 
>>calls and wanted to know which one(s) were wrong.
> 
> 
> If an app wants to sleep forever, calling
> 
> 	while (1)
> 		sleep(MAX_INT);
> 
> seems like a reasonable approach.  I'd expect quite a lot of applications
> would be doing that.
> 
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

