Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266888AbUIOR7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266888AbUIOR7j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267254AbUIOR7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:59:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:65523 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266888AbUIOR6l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:58:41 -0400
Message-ID: <414881C2.4090909@mvista.com>
Date: Wed, 15 Sep 2004 10:54:10 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dominik Brodowski <linux@dominikbrodowski.de>
CC: Christoph Lameter <clameter@sgi.com>, john stultz <johnstul@us.ibm.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com, jimix@us.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
References: <1094700768.29408.124.camel@cog.beaverton.ibm.com> <413FDC9F.1030409@mvista.com> <1094756870.29408.157.camel@cog.beaverton.ibm.com> <4140C1ED.4040505@mvista.com> <Pine.LNX.4.58.0409131420500.490@schroedinger.engr.sgi.com> <1095114307.29408.285.camel@cog.beaverton.ibm.com> <Pine.LNX.4.58.0409141045370.6963@schroedinger.engr.sgi.com> <41479369.6020506@mvista.com> <Pine.LNX.4.58.0409142024270.10739@schroedinger.engr.sgi.com> <4147F774.6000800@mvista.com> <20040915085450.GA5242@dominikbrodowski.de>
In-Reply-To: <20040915085450.GA5242@dominikbrodowski.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:
> On Wed, Sep 15, 2004 at 01:04:04AM -0700, George Anzinger wrote:
> 
>>>One could do this but we want to have a tickless system. The tick is only
>>>necessary if the time needs to be adjusted.
>>
>>I really think a tickless system, for other than UML systems, is a loosing 
>>thing.  The accounting overhead on context switch (which increases as the 
>>number of switchs per second) will cause more overhead than a periodic 
>>accounting tick once a respectable load appears.
> 
> 			 ^^^^^^^^^^^^^^^^
> 
> On a largely idle system (like notebooks on battery power in typical use)
> the accounting overhead will be less a problem. However, the CPU being 
> woken up each millisecond will cause an increased battery usage. So if 
> the load is less than a certain threshold, tickless systems do make much 
> sense.

At MontaVista I have been working on a thing we call VST which looks ahead in 
the timer list and, finding nothing for N ticks, turns off the ticker until that 
time.  It is not tickless, unless the system is idle, but then it can go 
tickless for as long as the max value that can be programmed on the wakeup 
timer.  Interrupts prior to that time will, of course, also wake the system.

Seems like the best of both worlds to me.

An early version of this is on the HRT sourceforge site.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

