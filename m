Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263154AbTCSR6F>; Wed, 19 Mar 2003 12:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263155AbTCSR6F>; Wed, 19 Mar 2003 12:58:05 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:58619 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S263154AbTCSR6C>;
	Wed, 19 Mar 2003 12:58:02 -0500
Message-ID: <3E78B226.6050908@mvista.com>
Date: Wed, 19 Mar 2003 10:08:38 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: tim@physik3.uni-rostock.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix nanosleep() granularity bumps
References: <Pine.LNX.4.33.0303190832430.32325-100000@gans.physik3.uni-rostock.de>	<3E78384A.6040406@mvista.com> <20030319014230.3412298e.akpm@digeo.com>
In-Reply-To: <20030319014230.3412298e.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> george anzinger <george@mvista.com> wrote:
> 
>>The attached patch is for 2.5.65.  As of this moment, the bk patch has 
>>not been posted to the snapshots directory.  I will wait for that to 
>>update.
> 
> 
> Don't use the snapshots directory.  Use
> 
> 	http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/

but then I need to pull each patch ... :)

-g
> 
> It is more up to date.
> 
> 
>>For what its worth, can someone explain how the add_timer call from 
>>run_timers was causing a problem.  The code looks right to me, unless 
>>the caller is so nasty as to continue to do the same thing (which 
>>would loop forever).
> 
> 
> That was the problem.
> 
> 
>>In this case, the simple fix is to bump the 
>>base->timer_jiffies at the beginning of the loop rather than the end. 
>>   This would cause the new timer to be put in the next jiffie instead 
>>of the current one AND it is free!
> 
> 
> Didn't think of that - I just ported up Andrea's fix.
> 
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

