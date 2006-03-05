Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWCEWaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWCEWaA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 17:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWCEWaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 17:30:00 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:65361 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750765AbWCEW37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 17:29:59 -0500
Message-ID: <440B6664.5070100@bigpond.net.au>
Date: Mon, 06 Mar 2006 09:29:56 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Mike Galbraith <efault@gmx.de>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org, mingo@elte.hu, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, akpm@osdl.org
Subject: Re: [patch 2.6.16-rc5-mm2]  sched_cleanup-V17 - task throttling patch
 1 of 2
References: <1140183903.14128.77.camel@homer> <200603041654.59480.kernel@kolivas.org> <1141455048.9482.13.camel@homer> <200603041750.21484.kernel@kolivas.org>
In-Reply-To: <200603041750.21484.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sun, 5 Mar 2006 22:29:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Saturday 04 March 2006 17:50, Mike Galbraith wrote:
> 
>>On Sat, 2006-03-04 at 16:54 +1100, Con Kolivas wrote:
>>
>>>On Saturday 04 March 2006 16:40, Randy.Dunlap wrote:
>>>
>>>>On Sat, 04 Mar 2006 06:29:47 +0100 Mike Galbraith wrote:
>>>>
>>>>>On Sat, 2006-03-04 at 16:24 +1100, Con Kolivas wrote:
>>>>>
>>>>>>On Saturday 04 March 2006 16:20, Mike Galbraith wrote:
>>>>>>
>>>>>>>On Sat, 2006-03-04 at 13:33 +1100, Peter Williams wrote:
>>>>>>>
>>>>>>>>> include/linux/sched.h |    3 -
>>>>>>>>> kernel/sched.c        |  136
>>>>>>>>>+++++++++++++++++++++++++++++--------------------- 2 files
>>>>>>>>>changed, 82 insertions(+), 57 deletions(-)
>>>>>>>>>
>>>>>>>>>--- linux-2.6.16-rc5-mm2/include/linux/sched.h.org	2006-03-01
>>>>>>>>>15:06:22.000000000 +0100 +++
>>>>>>>>>linux-2.6.16-rc5-mm2/include/linux/sched.h	2006-03-02
>>>>>>>>>08:33:12.000000000 +0100 @@ -720,7 +720,8 @@
>>>>>>>>>
>>>>>>>>> 	unsigned long policy;
>>>>>>>>> 	cpumask_t cpus_allowed;
>>>>>>>>>-	unsigned int time_slice, first_time_slice;
>>>>>>>>>+	int time_slice;
>>>>>>>>
>>>>>>>>Can you guarantee that int is big enough to hold a time slice
>>>>>>>>in nanoseconds on all systems?  I think that you'll need more
>>>>>>>>than 16 bits.
>>>>>>>
>>>>>>>Nope, that's a big fat bug.
>>>>>>
>>>>>>Most ints are 32bit anyway, but even a 32 bit unsigned int
>>>>>>overflows with nanoseconds at 4.2 seconds. A signed one at about
>>>>>>half that. Our timeslices are never that large, but then int isn't
>>>>>>always 32bit either.
>>>>>
>>>>>Yup.  I just didn't realize that there were 16 bit integers out
>>>>>there.
>>>>
>>>>LDD 3rd ed. doesn't know about them either.  Same for me.
>>>
>>>Alright I made that up, but it might not be one day :P
>>
>>Well Fudgecicles.  Now you guys have gotten me aaaaall confused.  Are
>>there cpus out there (in generic linux land) that have 16 bit integers
>>or not?  16 bit integers existing in a 32 bit cpu OS seems like an alien
>>concept to me, but I'm not a twisted cpu designer... I'll just go with
>>the flow ;-)
> 
> 
> All supported architectures on linux currently use 32bits for int. That should 
> give you 2.1 seconds in nanoseconds. Sorry my legacy of remembering when ints 
> were 8 bits coloured me.
> 
> Cheers,
> Con

The size of int isn't just a function of the architecture it's also a 
function of the C compiler used.  C requires that longs be at least 32 
bits but only requires that ints be at least 16 bits.  If the 
architecture supports 16 bit integer operations there's nothing to stop 
a VALID compiler from make ints only 16 bits.  Since everyone uses gcc 
(at the moment) it's probably not an (urgent) issue but it seems to me 
that the safe option is to use longs when you want to ensure that you 
get at least 32 bits.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
