Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965254AbWEaX2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965254AbWEaX2s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 19:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965258AbWEaX2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 19:28:48 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:709 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S965254AbWEaX2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 19:28:47 -0400
Message-ID: <447E26AC.7010102@bigpond.net.au>
Date: Thu, 01 Jun 2006 09:28:44 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	 <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest> <661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com> <44781167.6060700@bigpond.net.au> <447D95DE.1080903@sw.ru>
In-Reply-To: <447D95DE.1080903@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 31 May 2006 23:28:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
>>> Using a timer for releasing tasks from their sinbin sounds like a  bit
>>> of an overhead. Given that there could be 10s of thousands of tasks.
>>
>>
>> The more runnable tasks there are the less likely it is that any of 
>> them is exceeding its hard cap due to normal competition for the 
>> CPUs.  So I think that it's unlikely that there will ever be a very 
>> large number of tasks in the sinbin at the same time.
> for containers this can be untrue...

Why will this be untrue for containers?

> :( actually even for 1000 tasks (I 
> suppose this is the maximum in your case) it can slowdown significantly 
> as well.
> 
>>> Is it possible to use the scheduler_tick() function take a look at all
>>> deactivated tasks (as efficiently as possible) and activate them when
>>> its time to activate them or just fold the functionality by defining a
>>> time quantum after which everyone is worken up. This time quantum
>>> could be the same as the time over which limits are honoured.
> agree with it.

If there are a lot of RUNNABLE (i.e. on a run queue) tasks then normal 
competition will mean that their CPU usage rates are small and therefore 
unlikely to be greater than their cap.  The sinbin is only used for 
tasks that are EXCEEDING their cap.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
