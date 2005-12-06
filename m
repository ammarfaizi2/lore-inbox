Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbVLFU2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbVLFU2N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbVLFU2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:28:13 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:1013 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1030221AbVLFU2L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:28:11 -0500
Message-ID: <4395F3FC.6030301@mvista.com>
Date: Tue, 06 Dec 2005 12:26:36 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
CC: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/13] Time: Reduced NTP Rework (part 2)
References: <20051202032604.19357.59425.sendpatchset@cog.beaverton.ibm.com> <4394018D.19764.2440ED5D@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
In-Reply-To: <4394018D.19764.2440ED5D@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Windl wrote:
> On 2 Dec 2005 at 16:19, George Anzinger wrote:
> 
> 
>>john stultz wrote:
>>
>>>All,
>>>	Here is the second of two patches which try to minimize my ntp rework
>>>patches.
>>>	
>>>This patch further changes the interrupt time NTP code, breaking out the
>>>leapsecond processing and introduces an accessor to a shifted ppm
>>
>>In a discusson aroung the leapsecond and how to disable it (some folks 
>>don't want the time jump) it came to light that, for the most part, 
>>this is unused code.  It requires that time be kept in UST to be 
>>useful and, from what I can tell, most folks keep time in their local 
>>timezone, thus, effectively, disableing the usage of the leapsecond 
>>correction (ntp figures this out and just says "no").  Possibly it is 
>>time to ask if we should keep this in the kernel at all.
> 
> 
> I think this is not a question at all whether people like leap seconds or not: 
> Either they want to have the current official time, or they do not. If they do 
> not, they won't care about NTP; if they do they'd use it.
> 
> If they don't like leap seconds, they'd go into politics to forbid them by law.

I don't think that is what happens now.  Rather the leapsecond is not 
requested by ntp and either a) ntp sets the clock at the required time 
or b) it "creeps" it ahead or back by one second over a somewhat 
longer time.  It is behavior b) that I have found some folks want.  In 
no case do I see anyone wanting to drop the leapsecond, they just 
don't want the discontinuity it introduces and are willing to be a 
second (or if done properly, half a second) away from the correct time 
for a period of time around the official leapsecond.

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
