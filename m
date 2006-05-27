Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWE0B2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWE0B2H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 21:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWE0B2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 21:28:07 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:45239 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964888AbWE0B2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 21:28:06 -0400
Message-ID: <4477AB24.1050109@bigpond.net.au>
Date: Sat, 27 May 2006 11:28:04 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Mike Galbraith <efault@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RFC 0/5] sched: Add CPU rate caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <200605262041.09221.kernel@kolivas.org>
In-Reply-To: <200605262041.09221.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 27 May 2006 01:28:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Friday 26 May 2006 14:20, Peter Williams wrote:
>> These patches implement CPU usage rate limits for tasks.
> 
> Nice :)

Thanks.

> 
>> Although the rlimit mechanism already has a CPU usage limit (RLIMIT_CPU)
>> it is a total usage limit and therefore (to my mind) not very useful.
>> These patches provide an alternative whereby the (recent) average CPU
>> usage rate of a task can be limited to a (per task) specified proportion
>> of a single CPU's capacity.  The limits are specified in parts per
>> thousand and come in two varieties -- hard and soft.
> 
> Why 1000?

Probably a hang over from a version where the units were proportion of a 
whole machine.  Percentage doesn't work very well if there are more than 
1 CPU in that case (especially if there are more than 100 CPUs :-)). 
But it's also useful to have the extra range if your trying to cap 
processes (or users) from outside the scheduler using these primitives.

> I doubt that degree of accuracy is possible in cpu accounting and 
> accuracy or even required. To me it would seem to make more sense to just be 
> a percentage.
> 

It's not meant to imply accuracy :-).  The main issue is avoiding 
overflow when doing the multiplications during the comparisons.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
