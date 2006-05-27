Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751740AbWE0AQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbWE0AQU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 20:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbWE0AQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 20:16:20 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:7332 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751736AbWE0AQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 20:16:19 -0400
Message-ID: <44779A51.5010206@bigpond.net.au>
Date: Sat, 27 May 2006 10:16:17 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RFC 0/5] sched: Add CPU rate caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <1148630661.7589.65.camel@homer>
In-Reply-To: <1148630661.7589.65.camel@homer>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 27 May 2006 00:16:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Fri, 2006-05-26 at 14:20 +1000, Peter Williams wrote:
>> These patches implement CPU usage rate limits for tasks.
>>
>> Although the rlimit mechanism already has a CPU usage limit (RLIMIT_CPU)
>> it is a total usage limit and therefore (to my mind) not very useful.
>> These patches provide an alternative whereby the (recent) average CPU
>> usage rate of a task can be limited to a (per task) specified proportion
>> of a single CPU's capacity.
> 
> The killer problem I see with this approach is that it doesn't address
> the divide and conquer problem.  If a task is capped, and forks off
> workers, each worker inherits the total cap, effectively extending same.
> 
> IMHO, per task resource management is too severely limited in it's
> usefulness, because jobs are what need managing, and they're seldom
> single threaded.  In order to use per task limits to manage any given
> job, you have to both know the number of components, and manually
> distribute resources to each component of the job.  If a job has a
> dynamic number of components, it becomes impossible to manage.

Doing caps at a process level inside the scheduler is doable but would 
involve an extra level of complexity including locking at the process 
level to calculate process usage rates.  Also the calculation of usage 
rates would be more complex than just doing it for tasks and the fact 
that there are not separate structures for processes and threads also 
complicates the code compared to what is required otherwise (e.g. for 
Solaris).

I'm not sure that this extra complexity is warranted when it is possible 
to implement caps at the process level from outside the scheduler using 
the task level caps provided by this patch.  However, to allow the costs 
to be properly evaluated, I'll put some effort into a process level 
capping mechanism over the next few weeks.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
