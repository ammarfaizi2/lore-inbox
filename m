Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265570AbTFRWQN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 18:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265566AbTFRWQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 18:16:13 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:54258 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265570AbTFRWPb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 18:15:31 -0400
Message-ID: <3EF0E7AC.60007@mvista.com>
Date: Wed, 18 Jun 2003 15:29:00 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: joe.korty@ccur.com
CC: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: O(1) scheduler seems to lock up on sched_FIFO and sched_RR tasks
References: <3EF0979C.8060603@mvista.com> <20030618193053.GA15576@tsunami.ccur.com>
In-Reply-To: <20030618193053.GA15576@tsunami.ccur.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty wrote:
> On Wed, Jun 18, 2003 at 09:47:24AM -0700, george anzinger wrote:
> 
>>It seems that once a SCHED_FIFO or SCHED_RR tasks gets control it does 
>>not yield to other tasks of higher priority.
>>
>>Attached is a test program (busyloop) that just loops doing 
>>gettimeofday() for the requested time and a little utility (rt) to run 
>>programs at real time priorities.
>>
>>Here is an annotated example of the problem:
>>
>>First, become root then:
>>
>>>rt 90 bash        <-- run bash at priority 90 SCHED_RR
>>>rt -f 30 busyloop 10 &  <-- busyloop 10 at priority 30 SCHED_FIFO
>>
>>At this point the bash at priority 90 should be available, but is not. 
>> When the 10 second busyloop completes, bash returns.
> 
> 
> 
> Hi George,
>  When I boost the priority of each of the per-cpu 'events/%d' daemon to
> 96, the problem goes away.

Seems like your saying that the events workqueues are involved in the 
scheduler in some ugly way.  Certainly not what your average rt 
programmer would expect :(  What is going on here?

> 
> Joe
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

