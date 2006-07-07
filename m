Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbWGFXCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWGFXCX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 19:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWGFXCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 19:02:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:33047 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751008AbWGFXCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 19:02:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=iqGBnxes6vFqrmy9k96mZpJiIewDPTo7z9fCCT5+cuz/YHJrqEYIC1bt8RWi4c831FvWD5h33LSszE/MUzLd/Mypx0hKMfOkXQ8jDxsj2caNvSRxWkw9s/Vc7Za4BnmX0R9BOkMHHnudRdgolmJHD9mdWHzfP5FsltaQgWtsD0w=
Date: Fri, 7 Jul 2006 01:02:29 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Esben Nielsen <nielsen.esben@gogglemail.com>
cc: Ingo Molnar <mingo@elte.hu>, Esben Nielsen <nielsen.esben@googlemail.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: New PriorityInheritanceTest - bug in 2.6.17-rt7 confirmed
In-Reply-To: <Pine.LNX.4.64.0607061720410.30970@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0607070059170.7787@localhost.localdomain>
References: <Pine.LNX.4.64.0607061307260.10454@localhost.localdomain>
 <1152189293.24611.146.camel@localhost.localdomain>
 <Pine.LNX.4.64.0607061443050.30970@localhost.localdomain> <20060706133238.GA13800@elte.hu>
 <Pine.LNX.4.64.0607061720410.30970@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Jul 2006, Esben Nielsen wrote:

> On Thu, 6 Jul 2006, Ingo Molnar wrote:
>
>>
>>  * Esben Nielsen <nielsen.esben@googlemail.com> wrote:
>> 
>> >  It can run within try_to_wake_up(). But then it the whole lock chain
>> >  is traversed in an atomic section. That unpredictable overall system
>> >  latencies since the locks can be in userspace. So it has to run in
>> >  some task. That task has to be high priority enough to preempt the
>> >  boosted tasks, but it can't be so high priority that it bothers any
>> >  higher priority threads than those involved in this. So it can't be,
>> >  forinstance a general priority 99 task we just use for this. We thus
>> >  need something running at a slightly higher priority than the priority
>> >  to which the tasks are boosted, but not a full +1 priority. I.e. we
>> >  need to run it at priority "+0.5".
>>
>>  we could just queue the task in front of the other task in the runqueue,
>>  and mark that task for reschedule if it's running currently. (Doing this
>>  is not without precedent: we do something similar in wake_up_new_task()
>>  to implement child-runs-first logic.)
>> 
> I think that is more or less what my patch does...
>
I was a little bit in a hurry when I sent that comment:

What my patch does is to ensure rtmutex-boosters keep their priority and 
is scheduled to the head of the runqueue at their given priority.
What is ugly is that the scheduler core code knows about the rtmutex stuff 
directly. The previous mail was about how to generalise this so that other 
subsystems with similar needs can use it too.

Esben


> Esben
>
>>   Ingo
>> 
>
