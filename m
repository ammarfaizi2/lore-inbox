Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965166AbVI0Vp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbVI0Vp4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbVI0Vps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:45:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:25589 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S965166AbVI0Vpq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:45:46 -0400
Message-ID: <4339BD4E.3060401@mvista.com>
Date: Tue, 27 Sep 2005 14:44:46 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Darren Hart <dvhltc@us.ibm.com>,
       Geoff Levand <geoffrey.levand@am.sony.com>,
       "Theodore Ts'o" <tytso@mit.edu>,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       "lkml," <linux-kernel@vger.kernel.org>, dino@us.ibm.com,
       Paul McKenney <paulmck@us.ibm.com>,
       "Sarma, Dipankar" <dipankar@in.ibm.com>
Subject: Re: HRT on opteron / rt14 on opteron
References: <432F21D1.90209@us.ibm.com> <432F5A44.9010208@am.sony.com>	 <433489F6.9080203@us.ibm.com> <1127684460.15115.116.camel@tglx.tec.linutronix.de>
In-Reply-To: <1127684460.15115.116.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> On Fri, 2005-09-23 at 16:04 -0700, Darren Hart wrote:
> 
>>I am trying to run all the tests in the above tarball on a 2.6.13 kernel with 
>>ktimers+tod+hrt + a hrt compatibility patch which uses the normal clocks when a 
>>_HR clock is requested since ktimers treats them the same.  I remember there 
>>used to be a run_tests script or something when this was a kernel patch, but I 
> 
> 
> do_test
~
>># ./timerlimit
>>7168: timer id = 7167
>>timer_create: Resource temporarily unavailable
>>
>>Is that a reasonable number of successfully created clocks?
> 
> 
> Depends on the number of timers available on your system. But sounds
> reasonable.

Actually is limited by the maximum number of signal control block.  This 
is, I think, an RLIMIT and can be changed.  Currently it is set to 1024 
by default.
> 
> I have no idea about the plots. George ?

The plot code was done to get a handle on the performance of the timer 
list code.  The plot should be showing the list overhead as a function 
of the number of timers.  To get reasonable inteaction you may need to 
adjust the RLIMIT up so you can get 3000 to 6000 timers.

This code was done when we were using the hashed timer list and showed 
very good performance up to and above 3000 timers.  The hashed timer 
list did NOT have a cascade issue and I still think it may be a 
reasonable replacement for the cascade timer list.  It also had the nice 
ability to change the hash bucket size at configure time to improve 
performance as needed.
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
