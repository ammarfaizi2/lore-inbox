Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265843AbUATWuj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 17:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265842AbUATWuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 17:50:09 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:32494 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265809AbUATWsC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 17:48:02 -0500
Message-ID: <400DB009.5050304@mvista.com>
Date: Tue, 20 Jan 2004 14:47:37 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Robert Schwebel <robert@schwebel.de>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Juergen Beisert <jbeisert@eurodsn.de>, cliff white <cliffw@osdl.org>,
       piggin@cyberone.com.au, mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: [1/4] better i386 CPU selection
References: <20040106054859.GA18208@waste.org> <3FFA56D6.6040808@cyberone.com.au> <20040106064607.GB18208@waste.org> <3FFA5ED3.6040000@cyberone.com.au> <20040110004625.GB25089@fs.tum.de> <20040110005232.GD25089@fs.tum.de> <20040116111501.70200cf3.cliffw@osdl.org> <Pine.LNX.4.53.0401161425110.31018@chaos> <20040117021532.GH12027@fs.tum.de> <20040117091337.GZ5139@pengutronix.de> <20040120221025.GI12027@fs.tum.de>
In-Reply-To: <20040120221025.GI12027@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sat, Jan 17, 2004 at 10:13:37AM +0100, Robert Schwebel wrote:
> 
> 
>>Hi, 
> 
> 
> Hi Robert,
> 
> 
>>On Sat, Jan 17, 2004 at 03:15:32AM +0100, Adrian Bunk wrote:
>>
>>>Besides the AMD Elan cpufreq driver I see nothing where CONFIG_MELAN
>>>gave you any real difference (except your highest goal is to avoid a
>>>recompilation when switching from the Pentium 4 to the AMD Elan - but I
>>>doubt the really "prevents development").
>>>
>>>But I'm not religious about this issue. Let Robert decide, the Elan 
>>>support is his child.
>>>
>>>
>>>>>>- added optimizing CFLAGS for the AMD Elan
>>>>
>>>>There are no such different "optimizations" for ELAN.
>>>
>>>What's wrong wih the -march=i486 Robert suggested?
>>
>>I've not followed the 2.6 development regarding the arch selection that
>>closely; let's collect arguments: 
>>
>>- Is it still possible to run a -march=i486 built kernel on a pentium? 
>>  IMHO It would be good to optimize the code for i486, but I'm not that 
>>  familiar with how good gcc optimizes for 486 that I can comment this.
> 
> 
> yes, since a Pentium supports a superset of the 486 gcc can't optimize 
> for a 486 in a way that the code won't run on a Pentium.
> 
> 
>>- I personally work with lots of cross architectures like ARM, so cross
>>  compiling for an embedded system is no problem for me. But if people
>>  want to test stuff on their pentiums I also have no problem with that.
>>
>>Other arguments? 
> 
> 
> The only reason why I sent the patch to make the AMD Elan a separate 
> subarch was the CLOCK_TICK_RATE #ifdef in include/asm-i386/timex.h .
> 
> It should be possible to change it to a variable (as with 
> CONFIG_X86_PC9800) if both the Elan and a different cpu are supported if 
> this is really a required use.

This is a VERY bad idea.  If you would take a look at linux/time.h at the code 
to convert jiffies<->timeval/timespec you will see some very long expressions. 
This code is FAST but only because of constants which allow gcc to do most of 
the work at compile time.  If you change CLOCK_TICK_RATE this will NOT be true 
and a lot of work will be done at run time.  It might be instructive to compile 
one of these conversions and look at the cpp output.  Last time I looked it was 
about 1/2 page of wall to wall expression which reduces to one MPY and shift (or 
there about).
> 


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

