Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275438AbTHNTp4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 15:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275459AbTHNTpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 15:45:55 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:27912 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S275438AbTHNTpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 15:45:44 -0400
Message-ID: <3F3BEA65.8080907@techsource.com>
Date: Thu, 14 Aug 2003 16:00:37 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Con Kolivas <kernel@kolivas.org>, rob@landley.net,
       Charlie Baylis <cb-lkml@fish.zetnet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O12.2int for interactivity
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <3F3A5D61.7080207@techsource.com> <20030814060959.GK32488@holomorphy.com> <200308141659.33447.kernel@kolivas.org> <20030814070119.GN32488@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:
> On Thu, 14 Aug 2003 16:09, William Lee Irwin III wrote:
> 
>>>"scale" on which scheduling events should happen, and as tasks become
>>>more cpu-bound, they have longer timeslices, so that two cpu-bound
>>>tasks of identical priority will RR very slowly and have reduced
>>>context switch overhead, but are near infinitely preemptible by more
>>>interactive or short-running tasks.
>>
> 
> On Thu, Aug 14, 2003 at 04:59:33PM +1000, Con Kolivas wrote:
> 
>>Actually the timeslice handed out is purely dependent on the static priority, 
>>not the priority it is elevated or demoted to by the interactivity estimator. 
>>However lower priority tasks (cpu bound ones if the estimator has worked 
>>correctly) will always be preempted by higher priority tasks (interactive 
>>ones) whenever they wake up.
> 
> 
> So it is; the above commentary was rather meant to suggest that the
> lengthening of timeslices in conventional arrangements did not penalize
> interactive tasks, not to imply that priority preemption was not done
> at all in the current scheduler.


If my guess from my previous email was correct (that is pri 5 gets 
shorter timeslide than pri 6), then that means that tasks of higher 
static priority have are penalized more than lower pri tasks for expiring.

Say a task has to run for 15ms.  If it's at a priority that gives it a 
10ms timeslice, then it'll expire and get demoted.  If it's at a 
priority that gives it a 20ms timeslice, then it'll not expire and 
therefore get promoted.

Is that fair?


