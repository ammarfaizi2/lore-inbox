Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWEQEph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWEQEph (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 00:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWEQEpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 00:45:36 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:51872 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750911AbWEQEpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 00:45:36 -0400
Message-ID: <446AAA6D.9080401@bigpond.net.au>
Date: Wed, 17 May 2006 14:45:33 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: tim.c.chen@linux.intel.com, Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
References: <4t16i2$12rqnu@orsmga001.jf.intel.com>	 <200605160945.13157.kernel@kolivas.org>	 <1147822331.4859.37.camel@localhost.localdomain> <1147839913.8335.35.camel@homer>
In-Reply-To: <1147839913.8335.35.camel@homer>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 17 May 2006 04:45:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Tue, 2006-05-16 at 16:32 -0700, Tim Chen wrote:
>> On Tue, 2006-05-16 at 09:45 +1000, Con Kolivas wrote:
>>
>>> Yes it's only designed to detect something that has been asleep for an 
>>> arbitrary long time and "categorised as idle"; it is not supposed to be a 
>>> priority stepping stone for everything, in this case at MAX_BONUS-1. Mike 
>>> proposed doing this instead, but it was never my intent. 
>> It seems like just one sleep longer than INTERACTIVE_SLEEP is needed
>> kick the priority of a process all the way to MAX_BONUS-1 and boost the
>> sleep_avg, regardless of what the prior sleep_avg was.
>>
>> So if there is a cpu hog that has long sleeps occasionally, once it woke
>> up, its priority will get boosted close to maximum, likely starving out
>> other processes for a while till its sleep_avg gets reduced.  This
>> behavior seems like something to avoid according to the original code
>> comment.  Are we boosting the priority too quickly?  
> 
> The answer to that is, sometimes yes, and when it bites, it bites hard.
> Happily, most hogs don't sleep much, and we don't generally have lots of
> bursty sleepers.
> 

But it's easy for a malicious user to exploit.  Yes?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
