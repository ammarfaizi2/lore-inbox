Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbVIOXLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVIOXLI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 19:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVIOXLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 19:11:08 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:8689 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1750821AbVIOXLH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 19:11:07 -0400
Message-ID: <4329FF58.5010709@mvista.com>
Date: Thu, 15 Sep 2005 16:10:16 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: john stultz <johnstul@us.ibm.com>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>
Subject: Re: 2.6.13-rt6, ktimer subsystem
References: <20050913100040.GA13103@elte.hu>  <43287C52.7050002@mvista.com>	 <1126751140.6509.474.camel@tglx.tec.linutronix.de>	 <4329F733.2090604@mvista.com> <1126824819.6509.540.camel@tglx.tec.linutronix.de>
In-Reply-To: <1126824819.6509.540.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
~
>>>- The posix timer tests run all successful, except the broken 2timertest
>>>which fails on any other HRT kernel too and the sleep to long for real
>>>timers when the clock is set backwards, which is easily solvable
>>>(working on that).
>>
>>Your mileage seems to differ from mine.  Here is what I get from ./do_test:
>>The following tests failed:
>>clock_nanosleeptest
>>abs_timer_test
>>4-1
>>clock_settimetest
>>clock_gettimetest2
>>2timer_test 
> 
> 
> Hmm. Except for the 2timer_test, where my source seems to be broken it
> works here. 

The latest support source is in the CVS tree on the HRT site.  It is no 
longer a patch...
> 
> 
>>Then, on the second run, it crashed in an attempt to get the monotonic 
>>clock (a divide error).  System is a dual PIII, 800Mhz.  This from the 
>>rt11 patch.
> 
> 
> Hmm, divide error. I had one of those in the early phase due to some
> strange 64/32 truncation problem, which was caused by nested
> inline/macros. After unmingling the problem went away.

I suspect that the 64/32 div resulted in a >32 bit result which is a 
fault.  This was deep in monotonic_clock.  I would rather change to 
clock_monotonic (i.e. xtime+offset+walltomonotonic) and work that code 
patch.  monotonic_clock is just the wrong thing for this work.
> 
> tglx
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
