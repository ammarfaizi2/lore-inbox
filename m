Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWACAzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWACAzp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 19:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWACAzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 19:55:45 -0500
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:27310 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751144AbWACAzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 19:55:45 -0500
Message-ID: <43B9CB8E.7050405@bigpond.net.au>
Date: Tue, 03 Jan 2006 11:55:42 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] CPU scheduler: Simplified interactive bonus mechanism
References: <43B22FBA.5040008@bigpond.net.au> <20051228080029.GA5641@elte.hu> <20051228083615.GA12180@elte.hu>
In-Reply-To: <20051228083615.GA12180@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 3 Jan 2006 00:55:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>* Peter Williams <pwil3058@bigpond.net.au> wrote:
>>
>>
>>>This patch implements a prototype version of a simplified interactive 
>>>bonus mechanism.  The mechanism does not attempt to identify 
>>>interactive tasks and give them a bonus (like the current mechanism 
>>>does) but instead attacks the problem that the bonuses are supposed to 
>>>fix, unacceptable interactive latency, directly.
>>
>>i think we could give this one a workout in -mm, to see the actual 
>>effects. Would you mind to merge this to -mm's scheduler queue, to right 
>>after sched-add-sched_batch-policy.patch?
> 
> 
> i have done this for latest -mm, see the patch below (i also merged your 
> patch to the SCHED_BATCH patch's effects), but the resulting kernel has 
> really bad interactivity: e.g. simply starting 4 CPU hogs on a 2-CPU 
> system slows down shell commands like 'ls' noticeably. So NACK for the 
> time being.

I've just realized a more serious reason why this scheduler modification 
needs to be postponed as unsuitable for general use.  It essentially 
relies on sched_clock() having at least microsecond resolution and it 
has been pointed out to me that on some systems this isn't true and, 
even though its units are always nanoseconds, the resolution of 
sched_clock() can be large as 1/HZ.  This scheduler would not work very 
well on these systems so its time has not yet come regardless of 
successful resolution of the other problems.

Nevertheless, I'll add a scheduler based on ingosched with this 
modification (and fixes) to PlugSched so that progress can be made on 
improving it for those systems where it is feasible.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
