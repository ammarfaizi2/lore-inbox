Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbVJEP6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbVJEP6I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 11:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbVJEP6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 11:58:08 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:20982 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1030192AbVJEP6H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 11:58:07 -0400
In-Reply-To: <1128527319.13057.139.camel@tglx.tec.linutronix.de>
References: <20051004084405.GA24296@elte.hu> <Pine.LNX.4.58.0510050928440.23350@localhost.localdomain> <Pine.LNX.4.58.0510051023460.23350@localhost.localdomain> <1128527319.13057.139.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D0B94C2C-35B8-11DA-A5C0-000A959BB91E@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
From: david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rc3-rt2
Date: Wed, 5 Oct 2005 08:58:05 -0700
To: tglx@linutronix.de
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Oct 5, 2005, at 8:48 AM, Thomas Gleixner wrote:

> On Wed, 2005-10-05 at 10:29 -0400, Steven Rostedt wrote:
>> Hmm, Ingo,
>>
>> Do you know why time goes backwards when I run hackbench as a realtime
>> process?  I added the output of start and stop and it does seem to go
>> backwards.
>>
>> Thomas?
>
> Yes. Thats happening. I moved the priority of softirq-timer above
> hackbench priority and the problem goes away. I look into this further.

I had to set the threaded softirqs to real time priorities with the hi 
thread at 24,
the timer thread at 23, net_rx at 22, etc.    I wanted their priorities 
  just below the IRQ threads.

  The problem was the timer thread.  Other real time threads got in its 
way and held off timers.

And I had to make a note if any higher priority apps depended on timers 
that the timer
thread had to be boosted in priority to match that real time threads 
priority.   It's like
the softirqd's timer thread needs priority inheritance.

David
>
> tglx
>
>

