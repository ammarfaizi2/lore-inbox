Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWE1ALM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWE1ALM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 20:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWE1ALM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 20:11:12 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:57205 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751082AbWE1ALM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 20:11:12 -0400
Message-ID: <4478EA9D.4030201@bigpond.net.au>
Date: Sun, 28 May 2006 10:11:09 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RFC 2/5] sched: Add CPU rate soft caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	 <20060526042041.2886.69840.sendpatchset@heathwren.pw.nest> <661de9470605262331w2e2258a7r41e2aab10895955f@mail.gmail.com> <4477F9DC.8090107@bigpond.net.au>
In-Reply-To: <4477F9DC.8090107@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sun, 28 May 2006 00:11:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Balbir Singh wrote:
>> On 5/26/06, Peter Williams <pwil3058@bigpond.net.au> wrote:
>> <snip>
>>>
>>> Notes:
>>>
>>> 1. To minimize the overhead incurred when testing to skip caps 
>>> processing for
>>> uncapped tasks a new flag PF_HAS_CAP has been added to flags.
>>>
>>> 2. The implementation involves the addition of two priority slots to the
>>> run queue priority arrays and this means that MAX_PRIO no longer
>>> represents the scheduling priority of the idle process and can't be 
>>> used to
>>> test whether priority values are in the valid range.  To alleviate this
>>> problem a new function sched_idle_prio() has been provided.
>>
>> I am a little confused by this. Why link the bandwidth expired tasks a
>> cpu (its caps) to a priority slot? Is this a hack to conitnue using
>> the prio_array? why not move such tasks to the expired array?
> 
> Because it won't work as after the array switch they may get to run 
> before tasks who aren't exceeding their cap (or don't have a cap).

Another important reason for using these slots is that it allows waking 
tasks to preempt tasks that have exceeded their cap.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
