Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267333AbUHECJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267333AbUHECJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 22:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUHECJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 22:09:56 -0400
Received: from gizmo01ps.bigpond.com ([144.140.71.11]:59365 "HELO
	gizmo01ps.bigpond.com") by vger.kernel.org with SMTP
	id S267333AbUHECJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 22:09:53 -0400
Message-ID: <411196EE.9050408@bigpond.net.au>
Date: Thu, 05 Aug 2004 12:09:50 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       kernel@kolivas.org, Andrew Morton OSDL <akpm@osdl.org>
Subject: Re: SCHED_BATCH and SCHED_BATCH numbering
References: <1091638227.1232.1750.camel@cube> <41118AAE.7090107@bigpond.net.au> <41118D0C.9090103@yahoo.com.au>
In-Reply-To: <41118D0C.9090103@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Peter Williams wrote:
> 
>> Albert Cahalan wrote:
>>
>>> Are these going to be numbered consecutively, or might
>>> they better be done like the task state? SCHED_FIFO is
>>> in fact already treated this way in one place. One might
>>> want to test values this way:
>>>
>>> if(foo & (SCHED_ISO|SCHED_RR|SCHED_FIFO))  ...
>>>
>>> (leaving aside SCHED_OTHER==0, or just translate
>>> that single value for the ABI)
>>>
>>> I'd like to see these get permenant allocations
>>> soon, even if the code doesn't go into the kernel.
>>> This is because user-space needs to know the values.
>>
>>
>>
>> Excellent idea.  The definition of rt_task() could become:
>>
>> #define rt_task(p) ((p)->policy & (SCHED_RR|SCHED_FIFO))
>>
>> instead of the highly dodgy:

I probably should have said "slightly" instead of "highly" here but I 
got carried away. :-)

>>
>> #define rt_task(p) ((p)->prio < MAX_RT_PRIO)
>>
> 
> Nothing wrong with that, is there?

It's sloppy logic in that "prio" being less than MAX_RT_PRIO is a 
consequence of the task being real time not the definition of it.  At 
the moment it is a sufficient condition for identifying a task as real 
time but that may not always be the case.  But, the real issue is, 
what's the point of having a field, "policy", that IS the definitive 
indicator of the task's scheduling policy if you don't use it?  An 
rt_task() function/macro defined in terms of the policy field with this 
suggested numbering scheme should always be correct.

At the moment rt_task(p) could be defined as ((p)->policy != 
SCHED_OTHER) but the addition of SCHED_ISO and SCHED_BATCH would break 
that.  Another option would be (((p)->policy == SCHED_FIFO) || 
((p)->policy == SCHED_RR)) but that's a little long winded and (avoiding 
it) is probably the reason for the current definition.  So I stand by my 
comment that Albert's numbering scheme is an excellent idea.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

