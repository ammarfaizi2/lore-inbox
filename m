Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbVL2Dve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbVL2Dve (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 22:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbVL2Dve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 22:51:34 -0500
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:39825 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S965002AbVL2Dve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 22:51:34 -0500
Message-ID: <43B35D43.40902@bigpond.net.au>
Date: Thu, 29 Dec 2005 14:51:31 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC] CPU scheduler: Simplified interactive bonus mechanism
References: <43B22FBA.5040008@bigpond.net.au> <200512281735.00992.kernel@kolivas.org> <43B242F4.3050004@yahoo.com.au>
In-Reply-To: <43B242F4.3050004@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 29 Dec 2005 03:51:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Con Kolivas wrote:
> 
>> On Wed, 28 Dec 2005 05:24 pm, Peter Williams wrote:
>>
>>> This patch implements a prototype version of a simplified interactive
>>> bonus mechanism.  The mechanism does not attempt to identify interactive
>>
>>
>>
>>> ---
>>>
>>> Your comments on this proposal are requested.
>>>
>>> ---
>>
>>
>>
>> If we're going to redo the interactivity estimator I happen to have a 
>> whole cpu scheduler design that is interactive by design without being 
>> a state machine that I've been hacking / maintining / debugging for 2 
>> years that many people are already using in production...
>>
> 
> What do you mean interactive by design (presumably as opposed
> to the current scheduler which is not interactive by design)?
> 
> And what do you mean by not being a state machine?
> 
> Back on topic: I don't think that this patch isn't clearly

I assume that the double negative here is accidental and you mean that 
this scheduler isn't clearly better than the current one.

> better than what currently exists, nor would require less
> testing than any other large scale changes to the scheduler
> behaviour.
> 
> So, as Con seems to imply, it is JASW (just another scheduler
> rewrite).

Not a rewrite just some major surgery to one small part (at least when 
compared to nicksched, staircase and the SPA schedulers).  This doesn't 
effect the run queue structure or the load balancing mechanisms.  Or, 
for that matter, even the bonus mechanism itself other than the 
calculation of the bonus as the way the bonus is applied once calculated 
is unchanged.

> Not that there's anything wrong with that... except
> it is not really a good fix for a problem with the current
> scheduler.

Probably not in its present form but with a little refinement I think 
that it may provide a solution.  As I see it the current strategy of 
trying to identify interactive tasks and then giving them bonuses is the 
cause of most of the remaining problems because it's hard to do and if 
you get it wrong and identify non interactive tasks as interactive tasks 
it can have long lasting bad effects on the scheduling quality.  So I 
think a strategy that makes bonuses more ephemeral has some chance of 
success.  Only time and testing will tell.

I think that the big advantage of the patch (at the moment) is that it's 
easy to understand.  Which in turn makes it easier to tweak.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
