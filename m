Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbVJEQNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbVJEQNh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbVJEQNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:13:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:59123 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1030206AbVJEQNg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:13:36 -0400
In-Reply-To: <1128528538.13057.145.camel@tglx.tec.linutronix.de>
References: <20051004084405.GA24296@elte.hu> <Pine.LNX.4.58.0510050928440.23350@localhost.localdomain> <Pine.LNX.4.58.0510051023460.23350@localhost.localdomain> <1128527319.13057.139.camel@tglx.tec.linutronix.de> <D0B94C2C-35B8-11DA-A5C0-000A959BB91E@mvista.com> <1128528538.13057.145.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FB0AEA1C-35BA-11DA-A5C0-000A959BB91E@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
From: david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rc3-rt2
Date: Wed, 5 Oct 2005 09:13:35 -0700
To: tglx@linutronix.de
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Oct 5, 2005, at 9:08 AM, Thomas Gleixner wrote:

> On Wed, 2005-10-05 at 08:58 -0700, david singleton wrote:
>>>
>>> Yes. Thats happening. I moved the priority of softirq-timer above
>>> hackbench priority and the problem goes away. I look into this 
>>> further.
>>
>> I had to set the threaded softirqs to real time priorities with the hi
>> thread at 24,
>> the timer thread at 23, net_rx at 22, etc.    I wanted their 
>> priorities
>>   just below the IRQ threads.
>>
>>   The problem was the timer thread.  Other real time threads got in 
>> its
>> way and held off timers.
>>
>> And I had to make a note if any higher priority apps depended on 
>> timers
>> that the timer
>> thread had to be boosted in priority to match that real time threads
>> priority.   It's like
>> the softirqd's timer thread needs priority inheritance.
>
> Well, we had implemented this in one of the previous -rt versions for
> the high resolution timers. It was a bit hacky and I did not come 
> around
> to reimplement it on top of ktimers. This is only a problem for itimers
> and posix interval timers at the moment. The nanosleep variants do not
> suffer from this problem as the wakeup happens directly from the hr
> timer interrupt. That way we have only one instead of two task 
> switches.

When I finally got the IRQ threads priorities straight and the softirqd 
priorities
matched to be right underneath the IRQ priorities the system would run
any benchmark I could throw at it with no problems,   modulo the strange
app that wanted to run at priority 99 and depended on itimers or 
sigarlm . . .

For that case I had to match the softirq timer thread to that of the 
app before
it would run with no problems.

David
>
> tglx
>
>
>
>

