Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268410AbUIGSgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268410AbUIGSgq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268400AbUIGSdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:33:14 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:23032 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S268420AbUIGSbn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:31:43 -0400
Message-ID: <413DFCC2.7080405@mvista.com>
Date: Tue, 07 Sep 2004 11:24:02 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Andi Kleen <ak@suse.de>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       albert@users.sourceforge.net, Ulrich.Windl@rz.uni-regensburg.de,
       Len Brown <len.brown@intel.com>, linux@dominikbrodowski.de,
       David Mosberger <davidm@hpl.hp.com>, paulus@samba.org,
       schwidefsky@de.ibm.com, jimix@us.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC] New Time of day proposal (updated 9/2/04)
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com> <20040903151710.GB12956@wotan.suse.de> <1094242317.14662.556.camel@cog.beaverton.ibm.com> <20040904130022.GB21912@wotan.suse.de> <Pine.LNX.4.58.0409070908290.8484@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0409070908290.8484@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Sat, 4 Sep 2004, Andi Kleen wrote:
> 
> 
>>On Fri, Sep 03, 2004 at 01:11:58PM -0700, john stultz wrote:
>>
>>>The timeofday_hook (should be timeofday_interrupt_hook, my bad) is
>>>called by the semi-periodic-irregular-interval(also known as "timer")
>>>interrupt. Its what does the housekeeping for all the timeofday code so
>>>we don't run into a counter overflow.
>>>
>>>monotonic_clock() is an accessor that returns the amount of time that
>>>has been accumulated since boot in nanoseconds.
>>
>>Ok, but you need different low level drivers for those.  The TSC is not
>>stable enough as a long term time source, but it is best&fastest for
>>the offset calculation between timer interrupts.
> 
> 
> I thought the NTP daemon etc would even that out? ITC (TSC on IA64) is
> used by default on IA64 for all time keeping purposes. The CPU has on chip
> support for timer interrupt generation.

Yes, and it is designed (read the "rock" is carefully choosen) for time keeping. 
  On the x86 the "rock" drives the pm timer and the PIT, but a somewhat less 
stable "rock" drives the TSC.

Also, we don't "know" what rate the TSC is actully clocking so we must 
"discover" it at boot time.  This process either is inaccurate or slow (I think 
we use ~ 50 ms these days which gives an error of ~10 TSC cycles on a 800MHZ 
box).  FWIW the problem here is the sync up with the I/O backplane to find the 
start and ending of the measured time.

I suspect that the IA64 "tells" you what its clock rate is.  Right?
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

