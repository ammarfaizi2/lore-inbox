Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVFRIOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVFRIOh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 04:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVFRIOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 04:14:37 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:43441 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S261413AbVFRIOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 04:14:23 -0400
Message-ID: <42B3D7E2.2070600@bredband.net>
Date: Sat, 18 Jun 2005 10:14:26 +0200
From: =?ISO-8859-1?Q?Patrik_H=E4gglund?= <patrik.hagglund@bredband.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: linux-kernel@vger.kernel.org, Chris Friesen <cfriesen@nortel.com>
Subject: Re: SCHED_RR/SCHED_FIFO and kernel threads?
References: <42B199FF.5010705@bredband.net> <42B19F65.6000102@nortel.com>	 <42B26FF8.6090505@bredband.net> <1119011872.4846.12.camel@localhost.localdomain>
In-Reply-To: <1119011872.4846.12.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:

>On Fri, 2005-06-17 at 08:38 +0200, Patrik Hägglund wrote:
>  
>
>>Don't you get the problem with priority inversion? I.e., if you have two 
>>processes, P1 and P2, scheduled with SCHED_FIFO, where P1 has higer 
>>priority than P2. Now, if P1 gets blocked and needs some kernel thread 
>>to execute to get unblocked, then P2 is scheduled before the kernel 
>>thread, and can execute without any time limit.
>>    
>>
>
>Yep, that could happen.
>
>  
>
>>That is, you should be much better off if the kernel threads has a 
>>_high_ priority. Then the execution progress can only be blocked by 
>>kernel threads, not by user space threads and processes. Or have I 
>>missed something?
>>    
>>
>
>Still have that problem with priority inversion. Kernel threads share
>date structures with user processes (when they are in kernel mode) and
>that kernel thread that is needed may get blocked on a process that is
>lower in priority than the two mentioned above.
>
>  
>
>>(Besides that, as I see it, SCHED_RR/SCHED_FIFO are scheduling 
>>abstractions on their own, not necessarily  connected to  "low latency " 
>>or "realtime".)
>>    
>>
>
>Only in the vanilla kernel. See Ingo's RT work. It handles priority
>inversion and SCHED_RR/SCHED_FIFO are actually connected to "low
>latency" and "realtime".
>
>http://people.redhat.com/mingo/realtime-preempt/
>
>-- Steve
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Thanks for the pointer to Ingo's work. I will have a look.

Regarding my last comment: What I was trying to say was that I thought 
there are _basic_ aspects to consider (i.e. my original problem with 
kernel starvation) when implementing SCHED_RR/SCHED_FIFO _before_ you 
consider how to implement them in a "low latency" or "realtime" context.

/Patrik Hägglund
