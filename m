Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVEDUlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVEDUlR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 16:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVEDUhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 16:37:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:35830 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261623AbVEDUgb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 16:36:31 -0400
Message-ID: <4279323F.1000304@mvista.com>
Date: Wed, 04 May 2005 13:36:15 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortel.com>
CC: Nishanth Aravamudan <nacc@us.ibm.com>, john stultz <johnstul@us.ibm.com>,
       Liu Qi <liuqi@ict.ac.cn>,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       Darren Hart <dvhltc@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Help with the high res timers
References: <E1DSl7F-0002v2-Ck@sc8-sf-web4.sourceforge.net> <20050503024336.GA4023@ict.ac.cn> <4277EEF7.8010609@mvista.com> <1115158804.13738.56.camel@cog.beaverton.ibm.com> <427805F8.7000309@mvista.com> <20050504001307.GF3372@us.ibm.com> <42790207.30709@mvista.com> <42790A18.4000008@nortel.com> <20050504175151.GA2698@us.ibm.com> <42791160.7090905@nortel.com>
In-Reply-To: <42791160.7090905@nortel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> Nishanth Aravamudan wrote:
> 
>> If I understand your point correctly, I think this is achieved by
>> TIMERINTERVAL_BITS in my patch (not to claim my patch is function, but
>> conceptually). No matter what you actually request, the best you can do
>> is 2^TIMERINTERVAL_BITS nanoseconds, and usually worse because the
>> tick-rate and timerinterval length do not necessarily line up.
> 
> 
> My point is simply that the timer for the next interval should start at 
> the time the timer expires, not the time that userspace picks up the 
> prior expiration.  Throttling the timer rate should be done at the time 
> of timer request rather than timer expiry.
> 
> If I have usec-accuracy in the timer subsystem, I should be able to set 
> a timer with an interval of 9.999ms and have it remain accurate over 
> time (subject to scheduler jitter, of course).  N timer intervals later 
> my timer should expire at (original_time + N*9.999ms + jitter).  In this 
> case the error is roughly constant with time.
> 
> If the timer doesn't start counting the next interval until the user 
> detects expiry, I'm going to get some non-zero addition to *each* 
> interval such that my timers will not remain accurate over long periods 
> of time.  In this case N timer intervals later my timer will expire at 
> (original_time + N*(9.999ms + jitter)) which is a very different thing. 
>  Since jitter will always be positive, the error increases with time.

You can, and we do in the main line kernel, keep this accuracy even with missed 
timer expiries.  When a timer is restarted, the actual requested expire time is 
recalculated.  It is adjusted ONLY by the requested repeat time until it results 
in a time that has yet to come and the number of repeat times it takes is logged 
in the overrun count for user examination.
> 
> Chris
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
