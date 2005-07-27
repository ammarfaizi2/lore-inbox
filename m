Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbVG0Rnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbVG0Rnx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 13:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVG0Rnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 13:43:46 -0400
Received: from relay01.pair.com ([209.68.5.15]:46097 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S262213AbVG0RmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 13:42:17 -0400
X-pair-Authenticated: 209.68.2.107
Message-ID: <42E7C777.7010400@cybsft.com>
Date: Wed, 27 Jul 2005 12:42:15 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Esben Nielsen <simlo@phys.au.dk>
CC: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
References: <Pine.OSF.4.05.10507271852030.3210-100000@da410.phys.au.dk>
In-Reply-To: <Pine.OSF.4.05.10507271852030.3210-100000@da410.phys.au.dk>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Esben Nielsen wrote:
> On Wed, 27 Jul 2005, K.R. Foley wrote:
> 
> 
>>Esben Nielsen wrote:
>>
>>>On Wed, 27 Jul 2005, Ingo Molnar wrote:
>>>
>>>
>>>
>>>>* Steven Rostedt <rostedt@goodmis.org> wrote:
>>>>
>>>>
>>>>
>>>>>Perfectly understood.  I've had two customers ask me to increase the 
>>>>>priorities for them, but those where custom kernels, and a config 
>>>>>option wasn't necessary. But since I've had customers asking, I 
>>>>>thought that this might be something that others want.  But I deal 
>>>>>with a niche market, and what my customers want might not be what 
>>>>>everyone wants. (hence the RFC in the subject).
>>>>>
>>>>>So if there are others out there that would prefer to change their 
>>>>>priority ranges, speak now otherwise this patch will go by the waste 
>>>>>side.
>>>>
>>>>i'm not excluding that this will become necessary in the future. We 
>>>>should also add the safety check to sched.h - all i'm suggesting is to 
>>>>not make it a .config option just now, because that tends to be fiddled 
>>>>with.
>>>>
>>>
>>>Isn't there a way to mark it "warning! warning! dangerous!" ?
>>>
>>>Anyway: I think 100 RT priorities is way overkill - and slowing things
>>>down by making the scheduler checking more empty slots in the runqueue.
>>>Default ought to be 10. In practise it will be very hard to have
>>>a task at the lower RT priority behaving real-time with 99 higher
>>>priority tasks around. I find it hard to believe that somebody has an RT
>>>app needing more than 10 priorities and can't do with RR or FIFO
>>>scheduling within a fewer number of prorities.
>>>
>>>Esben
>>>
>>
>>Actually, is it really that slow to search a bitmap for a slot that 
>>needs processing? 
> 
> No, it is ultra fast - but done very often.
> 

:-) I'm not going to argue this. You could definitely save a few 
instructions if you had fewer priorities and it probably wouldn't be 
very hard to create a patch to do this.

> 
>>I work on real-time test stands which are less of an 
>>embedded system and more of a real Unix system that require determinism. 
>>It is very nice in some cases to have more than 10 RT priorities to work 
>>with.
> 
> 
> What for? Why can't you use FIFO at the same priorities for some of your
> tasks? I pretty much quess you have a very few tasks which have some high
> requirements. The rest of you "RT" task could easily share the lowest RT
> priority. FIFO would also be more effective as you will have context
> switches.
> 
> This about multiple priorities probably comes from an ordering of tasks:
> You have a lot of task. You have a feeling about which one ought to be
> more important than the other. Thus you end of with an ordered list of
> tasks. BUT when you boil it down to what RT is all about, namely
> meeting your deadlines, it doesn't matter after the 5-10 priorities
> because the 5-10 priorities have introduced a lot of jitter to the rest
> of the tasks anyway. You can just as well just put them at the same
> priority.
> 
> Esben

All of the RT priorities that we have are not absolutely necessary. As I 
think Steven pointed out in another email, it is nice though to be able 
to priortize tasks using large jumps in priorities and then being able 
to fill in tasks that are dependent on other tasks in between. Even if 
you think of nothing but the IRQ handlers, the 5-10 priorities quickly 
get crowded without any user tasks.


-- 
    kr
