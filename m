Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWDHB3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWDHB3U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 21:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWDHB3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 21:29:20 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:31877 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751391AbWDHB3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 21:29:19 -0400
Message-ID: <443711EC.7070003@bigpond.net.au>
Date: Sat, 08 Apr 2006 11:29:16 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
References: <200604031459.51542.a1426z@gawab.com> <200604051116.05270.a1426z@gawab.com> <44344A59.9070007@bigpond.net.au> <200604080032.28911.a1426z@gawab.com>
In-Reply-To: <200604080032.28911.a1426z@gawab.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 8 Apr 2006 01:29:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Peter Williams wrote:
>> Al Boldi wrote:
>>> Peter Williams wrote:
>>>> Al Boldi wrote:
>>>>> Peter Williams wrote:
>>>>>> Al Boldi wrote:
>>>>>>>>>> Control parameters for the scheduler can be read/set via files
>>>>>>>>>> in:
>>>>>>>>>>
>>>>>>>>>> /sys/cpusched/<scheduler>/
>>>>>>> The default values for spa make it really easy to lock up the
>>>>>>> system.
>>>>>> Which one of the SPA schedulers and under what conditions?  I've been
>>>>>> mucking around with these and may have broken something.  If so I'd
>>>>>> like to fix it.
>>>>> spa_no_frills, with a malloc-hog less than timeslice.  Setting
>>>>> promotion_floor to max unlocks the console.
>>>> OK, you could also try increasing the promotion interval.
>>> Seems that this will only delay the lock in spa_svr but not inhibit it.
>> OK. But turning the promotion mechanism off completely (which is what
>> setting the floor to the maximum) runs the risk of a runaway high
>> priority task locking the whole system up.  IMHO the only SPA scheduler
>> where it's safe for the promotion floor to be greater than MAX_RT_PRIO
>> is spa_ebs.  So a better solution is highly desirable.
> 
> Yes.
> 
>> I'd like to fix this problem but don't fully understand what it is.
>> What do you mean by a malloc-hog?  Would it possible for you to give me
>> an example of how to reproduce the problem?
> 
> Can you try the attached mem-eater passing it the number of kb to be eaten.
> 
> 	i.e. '# while :; do ./eatm 9999 ; done' 
> 
> This will print the number of bytes eaten and the timing in ms.
> 
> Adjust the number of kb to be eaten such that the timing will be less than 
> timeslice (120ms by default for spa).  Switch to another vt and start 
> pressing enter.  A console lockup should follow within seconds for all spas 
> except ebs.

This doesn't seem to present a problem (other than the eatme loop being 
hard to kill with control-C) on my system using spa_ws with standard 
settings.  I tried both UP and SMP.  I may be doing something wrong or 
perhaps don't understand what you mean by a console lock up.  When you 
say "less than the timeslice" how much smaller do you mean?

Peter
PS I even managed to do a kernel build with the eatme loop running on a 
single processor system.
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
