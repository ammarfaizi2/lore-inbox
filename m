Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVCLUZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVCLUZi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 15:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVCLUZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 15:25:38 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:14073 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261259AbVCLUZa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 15:25:30 -0500
Message-ID: <42335034.2080607@mvista.com>
Date: Sat, 12 Mar 2005 12:25:24 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: Andrew Morton <akpm@osdl.org>, "J. Bruce Fields" <bfields@fieldses.org>,
       Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: spin_lock error in arch/i386/kernel/time.c on APM resume
References: <20050312131143.GA31038@fieldses.org> <4233111A.5070807@mvista.com> <Pine.LNX.4.61.0503120918130.2166@montezuma.fsmlabs.com> <42332F18.5050004@mvista.com> <Pine.LNX.4.61.0503121248160.2903@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0503121248160.2903@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Sat, 12 Mar 2005, George Anzinger wrote:
> 
> 
>>I agree.  Still in all that follows, no one has addressed the apparent race
>>described above.  The reason the system reported the errors that started this
>>thread is that the APM restore code was trying to read the cmos clock (I
>>assume to set the xtime clock) WHILE the timer interrupt code what trying to
>>set the cmos clock from xtime.
> 
> 
> Doesn't my reply explain the actual problem? The code path being;

Sorry, I just didn't look at the apm code.  My bad.

-g
> 
> arch/i386/kernel/apm.c
> suspend()
> 	write_seqlock_irq(xtime_lock)
> 	...
> 	write_sequnlock_irq(xtime_lock)
> 	<interrupts enabled>
> 	device_power_up()
> 		timer_resume()
> 			get_cmos_time();

S
> So this covers the problem that the reporter reported, so yes it's setting 
> xtime but we shouldn't be taking interrupts in the first place, so i 
> posted the patch to cover that. APM was clearly violating PM resume 
> procedures.
> 
> Thanks,
> 	Zwane

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

