Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270476AbUJUBLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270476AbUJUBLM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 21:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270528AbUJUBLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 21:11:10 -0400
Received: from 2-227.coreds.net ([207.55.227.2]:55281 "EHLO data.mvista.com")
	by vger.kernel.org with ESMTP id S270614AbUJUBEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 21:04:46 -0400
Message-ID: <41770B1F.5020203@mvista.com>
Date: Wed, 20 Oct 2004 18:04:31 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Jerome Borsboom <j.borsboom@erasmusmc.nl>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: process start time set wrongly at boot for kernel 2.6.9
References: <Pine.LNX.4.61.0410192015420.6471@knorkaan.xs4all.nl>	 <1098216701.20778.78.camel@cog.beaverton.ibm.com>	 <Pine.LNX.4.53.0410200233280.9510@gockel.physik3.uni-rostock.de>	 <1098233967.20778.93.camel@cog.beaverton.ibm.com>	 <41767B60.4050409@mvista.com>	 <1098294178.20778.117.camel@cog.beaverton.ibm.com>	 <4176FA29.2030208@mvista.com> <1098318323.20778.199.camel@cog.beaverton.ibm.com>
In-Reply-To: <1098318323.20778.199.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
~

> 
>>>So rather then every tick incrementing jiffies, instead jiffies is set
>>>equal to (monotonic_clock()*HZ)/NSEC_PER_SEC. 
>>
>>As mention by me (a long time ago), this assumes you have a better source for 
>>the clock than the interrupt.  I would argue that on the x86 (which I admit is 
>>really deficient) the best long term clock is, in fact, the PIT interrupt.  The 
>>_best_ clock on the x86, IMHO, is one that used the PIT interrupt as the gold 
>>standard.  Then one smooths this to eliminate interrupt latency issues and lost 
>>ticks using the TSC.   The pm_timer is as good as the PIT but suffers from 
>>access time issues.
> 
> 
> Well, assuming the PIT is programmed to a value it can actually run at
> accurately, you might be right. 
> 
> The only problem is I've started to arrive at the notion of
> interpolation between multiple problematic timesources is just a rats
> nest. When you can't trust timer interrupts to arrive and you can't
> trust the TSC to run at the right frequency, there's no way to figure
> out who's right.  We already have the lost-tick compensation code, but
> we still get time inconsistencies. Now maybe I'm just too dim witted to
> make it work, but the more I look at it, the more corner cases appear
> and the uglier the code gets. 
> 
> I say pick a timesource you can trust on your machine and stick to it.
> NTP is there to correct for drift, so just use it.
> 
Lets try to remember that the x86 WRT time is a real pile of used hay.  Even the 
"fixes" the hardware folks are spinning out reflect a real lack of 
understanding.  A pm_timer that you can not trust is doubly bad, but then they 
thought it was part of the powerdown code so...  The new timer which we may see 
on real machines some day, is still in I/O space (read REALLY SLOW TO ACCESS) 
for starters.

Back in my days at HP we (HP) talked with intel and, to some extent, caused a 
change in the IA64.  That machine, and a lot of other platforms, have decent 
time keeping hardware.  All we have to do is wait for the x86 to die :).
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

