Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUHDKMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUHDKMh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 06:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUHDKMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 06:12:37 -0400
Received: from mail023.syd.optusnet.com.au ([211.29.132.101]:43917 "EHLO
	mail023.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263626AbUHDKMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 06:12:34 -0400
References: <20040802015527.49088944.akpm@osdl.org> <410E3CAF.6080305@kolivas.org> <410F3423.3020409@yahoo.com.au> <cone.1091518501.973503.9648.502@pc.kolivas.org> <cone.1091519122.804104.9648.502@pc.kolivas.org> <41109FCC.4070906@yahoo.com.au>
Message-ID: <cone.1091614334.471559.9775.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2
Date: Wed, 04 Aug 2004 20:12:14 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin writes:

> Con Kolivas wrote:
>> Con Kolivas writes:
>> 
>>> Nick Piggin writes:
>>>
>>>> Con Kolivas wrote:
>>>>
>>>>> Andrew Morton wrote:
>>>>
>>>>
>>>>> Anyone with feedback on this please cc me. This was developed 
>>>>> separately from the -mm series which has heaps of other scheduler 
>>>>> patches which were not trivial to merge with so there may be 
>>>>> teething problems. Good reports dont hurt either ;)
>>>>>
>>>>
>>>> I can't get onto the OSDL site now, but I seem to remember staircase
>>>> having some performance problems on a few things. Hackbench and reaim
>>>> from memory... are these fixed? was I dreaming?
>>>
>>>
>>> Definitely dreaming I'm afraid :D
>>>
>>> The performance on both reaim and hackbench has always equalled or 
>>> exceeded mainline so thanks for bringing it up.
> 
> (OSDL's search thingy still isn't working quite right, but I'll get back
> to you about this when it does.)
> 
> 
> Otherwise, a couple of problems I noticed:
> 
> You removed things like this:
> -	/*
> -	 * The idle thread is not allowed to schedule!
> -	 * Remove this check after it has been exercised a bit.
> -	 */
> -	if (unlikely(current == rq->idle) && current->state != TASK_RUNNING) {
> -		printk(KERN_ERR "bad: scheduling from the idle thread!\n");
> -		dump_stack();
> -	}
> -
> And child-runs-first in wake_up_new_task. Please don't.

It does child runs first by design in staircase. You don't need any more.

> Also, basic interactivity in X is bad with the interactive sysctl set to 0

Well duh... disable interactivity and interactivity is bad. What's the 
problem? It's not meant to be used on a desktop in that way. 

> (is X supposed to be at nice 0?), however fairness is bad when interactive is 1.
> I'm not sure if this is an acceptable tradeoff - are you planning to fix it?

Why? A single user desktop is hardly needing extremely accurate cpu 
distribution... we see that already in 2.6. 

> It has interactivity problems with "thud". Also the mouse can freeze for .5 to 1
> second when moving between windows while there is disk IO going on in the background
> (this is with interactive = 1). The test-starve problem is back.

Hmm? a minor mouse freeze with a _test_ starvation program is not 
starvation; nor is it an interactivity problem. Yours is the first complaint 
about interactivity during i/o.

> Increasing priority (negative nice) doesn't have much impact. -20 CPU hog only gets
> about double the CPU of a 0 priority CPU hog and only about 120% the CPU time of a
> nice -10 hog.

-20 is 40 rr intervals. 0 is 20 rr intervals. +19 is 1 rr interval. 
Seems to me the cpu distribution is working our absolutely perfectly as 
designed.

Why is the only critic of this the person with a competing design? Does 
anyone else object to these things? I certainly dont feel objective enough 
to criticise yours.

Con

