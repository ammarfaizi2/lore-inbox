Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVEZTZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVEZTZW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 15:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVEZTZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 15:25:21 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:3829 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261707AbVEZTZL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 15:25:11 -0400
Message-ID: <42962272.9060506@mvista.com>
Date: Thu, 26 May 2005 12:24:34 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: linux-os@analogic.com, Olivier Croquette <ocroquette@free.fr>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11 timeval_to_jiffies() wrong for ms resolution timers
References: <21FFE0795C0F654FAD783094A9AE1DFC07AFE7C1@cof110avexu4.global.avaya.com>	 <4294D9C6.3060501@mvista.com> <4296019B.8070006@free.fr>	 <Pine.LNX.4.61.0505261350480.7195@chaos.analogic.com> <1117131568.5477.12.camel@mindpipe>
In-Reply-To: <1117131568.5477.12.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Thu, 2005-05-26 at 14:10 -0400, Richard B. Johnson wrote:
> 
>>The time for a sleeping (waiting) task to get the CPU is much
>>greater than the jitter. Once in the ISR, some wake-up call
>>is "scheduled" and the interrupt returns. A CPU hog may have
>>been using the CPU when the interrupt occurred. It will continue
>>to use the CPU until its time-slot (quantum) has expired. This
>>could be a whole millisecond if HZ is 1000, 10 milliseconds if
>>100. It's only then that your sleeping task gets awakened
>>by the interrupting event.
>>
>>So, accurate waking up is not guaranteed on any multi-user,
>>multitasking system because you don't know what a user has
>>been doing with the CPU. On a dedicated machine, one can
>>have tasks that are most always sleeping or waiting for
>>I/O so, the latency can come way down. However, signaling
>>a task, based upon some time will never be very accurate
>>anywhere.
> 
> 
> Not quite, if your sleeping task has higher priority than the CPU hog it
> will preempt the CPU hog immediately on return from the interrupt.
> Unless you've disabled preemption of course, which would be stupid in
> this case.

And even then the task would need to be in the kernel and would be preempted 
when it exits the kernel.


-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
