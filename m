Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275464AbTHSFe1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 01:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275486AbTHSFe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 01:34:27 -0400
Received: from anumail2.anu.edu.au ([150.203.2.42]:48039 "EHLO anu.edu.au")
	by vger.kernel.org with ESMTP id S275464AbTHSFeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 01:34:23 -0400
Message-ID: <3F41B6CE.1000407@cyberone.com.au>
Date: Tue, 19 Aug 2003 15:34:06 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.2.1) Gecko/20021217
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] new scheduler policy
References: <3F4182FD.3040900@cyberone.com.au> <20030819023536.GZ32488@holomorphy.com> <3F418F7A.7090007@cyberone.com.au> <3F4192AD.1020305@cyberone.com.au> <20030819051533.GL16387@waste.org>
In-Reply-To: <20030819051533.GL16387@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Domain: cyberone.com.au
X-Spam-Score: (-2.9)
X-Spam-Tests: EMAIL_ATTRIBUTION,IN_REP_TO,REFERENCES,SPAM_PHRASE_03_05,USER_AGENT,USER_AGENT_MOZILLA_UA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:

>On Tue, Aug 19, 2003 at 12:59:57PM +1000, Nick Piggin wrote:
>
>>
>>Nick Piggin wrote:
>>
>>
>>>
>>>William Lee Irwin III wrote:
>>>
>>>
>>>>On Tue, Aug 19, 2003 at 11:53:01AM +1000, Nick Piggin wrote:
>>>>
>>>>
>>>>>As per the latest trend these days, I've done some tinkering with
>>>>>the cpu scheduler. I have gone in the opposite direction of most
>>>>>of the recent stuff and come out with something that can be nearly
>>>>>as good interactivity wise (for me).
>>>>>I haven't run many tests on it - my mind blanked when I tried to
>>>>>remember the scores of scheduler "exploits" thrown around. So if
>>>>>anyone would like to suggest some, or better still, run some,
>>>>>please do so. And be nice, this isn't my type of scheduler :P
>>>>>It still does have a few things that need fixing but I thought
>>>>>I'd get my first hack a bit of exercise.
>>>>>Its against 2.6.0-test3-mm1
>>>>>
>>>>>
>>>>Say, any chance you could spray out a brief explanation of your new
>>>>heuristics?
>>>>
>>>>
>>>Oh alright. BTW, this one's not for your big boxes yet! It does funny
>>>things with timeslices. But they will be (pending free time) made much
>>>more dynamic, so it should _hopefully_ context switch even less than
>>>the normal scheduler in a compute intensive load.
>>>
>>>OK. timeslices: they are now dynamic. Full priority tasks will get
>>>100ms, minimum priority tasks 10ms (this is what needs fixing, but
>>>should be OK to test "interactiveness")
>>>
>>>interactivity estimator is gone: grep -i interactiv sched.c | wc -l
>>>gives 0.
>>>
>>>priorities are much the same, although processes are supposed to be
>>>able to change priority much more quickly.
>>>
>>>backboost is back. that is what (hopefully) prevents X from starving
>>>due to the quickly changing priorities thing.
>>>
>> And lack of interactivity estimator.
>>
>
>You forgot to mention fork() splitting its timeslice 2/3 to 1/3 parent
>to child.
>
>

Hmm... did I do that? I don't actually have the code in front of me, but I
think the timeslice split is still 50/50 (see fork.c). Its the priority
points that go 2/3 to 1/3. Actually its a bit more complex than that even
and probably not exactly right...


