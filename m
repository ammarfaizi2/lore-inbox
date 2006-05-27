Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751742AbWE0AQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbWE0AQh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 20:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbWE0AQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 20:16:37 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:25744 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751741AbWE0AQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 20:16:36 -0400
Message-ID: <44779A61.7070002@bigpond.net.au>
Date: Sat, 27 May 2006 10:16:33 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	 <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>	 <200605262100.22071.kernel@kolivas.org>  <447709B3.80309@bigpond.net.au> <1148653398.8321.7.camel@homer>
In-Reply-To: <1148653398.8321.7.camel@homer>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 27 May 2006 00:16:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Fri, 2006-05-26 at 23:59 +1000, Peter Williams wrote:
>> Con Kolivas wrote:
>>> On Friday 26 May 2006 14:20, Peter Williams wrote:
>>>> This patch implements hard CPU rate caps per task as a proportion of a
>>>> single CPU's capacity expressed in parts per thousand.
>>> A hard cap of 1/1000 could lead to interesting starvation scenarios where a 
>>> mutex or semaphore was held by a task that hardly ever got cpu. Same goes to 
>>> a lesser extent to a 0 soft cap. 
>>>
>>> Here is how I handle idleprio tasks in current -ck:
>>>
>>> http://ck.kolivas.org/patches/2.6/pre-releases/2.6.17-rc5/2.6.17-rc5-ck1/patches/track_mutexes-1.patch
>>> tags tasks that are holding a mutex
>>>
>>> http://ck.kolivas.org/patches/2.6/pre-releases/2.6.17-rc5/2.6.17-rc5-ck1/patches/sched-idleprio-1.7.patch
>>> is the idleprio policy for staircase.
>>>
>>> What it does is runs idleprio tasks as normal tasks when they hold a mutex or 
>>> are waking up after calling down() (ie holding a semaphore).
>> I wasn't aware that you could detect those conditions.  They could be 
>> very useful.
> 
> Isn't this exactly what the PI code is there to handle?  Is something
> more than PI needed?
> 

AFAIK (but I may be wrong) PI is only used by RT tasks and would need to 
be extended.  It could be argued that extending PI so that it can be 
used by non RT tasks is a worthwhile endeavour in its own right.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
