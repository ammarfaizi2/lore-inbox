Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWAEXNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWAEXNU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWAEXNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:13:20 -0500
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:30193 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751387AbWAEXNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:13:19 -0500
Message-ID: <43BDA80C.4020009@bigpond.net.au>
Date: Fri, 06 Jan 2006 10:13:16 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Helge Hafting <helgehaf@aitel.hist.no>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client   on	interactive
 response
References: <5.2.1.1.2.20060105070601.026b21f0@pop.gmx.net> <43BB2414.6060400@bigpond.net.au> <43A8EF87.1080108@bigpond.net.au> <1135145341.7910.17.camel@lade.trondhjem.org> <43A8F714.4020406@bigpond.net.au> <20060102110145.GA25624@aitel.hist.no> <43B9BD19.5050408@bigpond.net.au> <43BB2414.6060400@bigpond.net.au> <5.2.1.1.2.20060105070601.026b21f0@pop.gmx.net> <5.2.1.1.2.20060105143705.00be85c8@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20060105143705.00be85c8@pop.gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 5 Jan 2006 23:13:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> At 10:31 PM 1/5/2006 +1100, Peter Williams wrote:
> 
>> Mike Galbraith wrote:
>>
>>> At 08:51 AM 1/5/2006 +1100, Peter Williams wrote:
>>>
>>>> I think that some of the harder to understand parts of the scheduler 
>>>> code are actually attempts to overcome the undesirable effects (such 
>>>> as those I've described) of inappropriately identifying tasks as 
>>>> interactive.  I think that it would have been better to attempt to 
>>>> fix the inappropriate identifications rather than their effects and 
>>>> I think the prudent use of TASK_NONINTERACTIVE is an important tool 
>>>> for achieving this.
>>>
>>>
>>> IMHO, that's nothing but a cover for the weaknesses induced by using 
>>> exclusively sleep time as an information source for the priority 
>>> calculation.  While this heuristic does work pretty darn well, it's 
>>> easily fooled (intentionally or otherwise).  The challenge is to find 
>>> the right low cost informational component, and to stir it in at O(1).
>>
>>
>> TASK_NONINTERACTIVE helps in this regard, is no cost in the code where 
>> it's used and probably decreases the costs in the scheduler code by 
>> enabling some processing to be skipped.  If by its judicious use the 
>> heuristic is only fed interactive sleep data the heuristics accuracy 
>> in identifying interactive tasks should be improved.  It may also 
>> allow the heuristic to be simplified.
> 
> 
> I disagree.  You can nip and tuck all the bits of sleep time you want, 
> and it'll just shift the lumpy spots around (btdt).

Yes, but there's a lot of (understandable) reluctance to do any major 
rework of this part of the scheduler so we're stuck with nips and tucks 
for the time being.  This patch is a zero cost nip and tuck.

If the plugsched patches were included in -mm we could get wider testing 
of alternative scheduling mechanisms.  But I think it will take a lot of 
testing of the new schedulers to allay fears that they may introduce new 
problems of their own.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
