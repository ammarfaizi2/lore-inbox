Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbVINEPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbVINEPq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 00:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbVINEPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 00:15:46 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:37616 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932467AbVINEPq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 00:15:46 -0400
Message-ID: <4327A3CA.5000700@mvista.com>
Date: Tue, 13 Sep 2005 21:15:06 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: markh@compro.net, linux-kernel@vger.kernel.org
Subject: Re: HZ question
References: <4326CAB3.6020109@compro.net>	 <Pine.LNX.4.61.0509130919390.29445@chaos.analogic.com>	 <4326DB8A.7040109@compro.net>	 <Pine.LNX.4.53.0509131615160.13574@gockel.physik3.uni-rostock.de>	 <4326EAD7.50004@compro.net> <1126632856.3455.45.camel@cog.beaverton.ibm.com>
In-Reply-To: <1126632856.3455.45.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Tue, 2005-09-13 at 11:05 -0400, Mark Hounschell wrote:
> 
>>Tim Schmielau wrote:
>>
>>>On Tue, 13 Sep 2005, Mark Hounschell wrote:
>>>
>>>
>>>>Most if not all userland delay calls rely on HZ value in some way or
>>>>another. The minimum reliable delay you can get is one (kernel)HZ. A
>>>>program that needs an acurrate delay for a time shorter that one
>>>>(kernel)HZ may have an alternative if it knows that HZ is greater the
>>>>the requested delay.
>>>
>>>Just assume that kernel HZ are USER_HZ and see anything else as an
>>>additional bonus that you cannot rely on.
>>>
>>>What does 'acurrate delay' mean, anyways?
>>>
>>>Tim
>>>
>>
>>But they are not the same. Why can I get USER_HZ but not HZ?
> 
> 
> Because USER_HZ is there only because HZ changes on various systems and
> we don't want to break userland apps that assume its value.
> 
> 
> 
>>On a 100HZ kernel ANY requested delay via udelay or 
>>pthread_cond_timedwait of less than 10000usecs is unreliable and the the 
>>actual results are totally unacceptable.
>>
>>On a 1000HZ kernel the number is 1000 usecs.
>>
>>I'm not asking the kernel running at 1000hz to actually give me 500 usec 
>>delay if I ask. I do expect it to be at least 500 usec and within +- a 
>>single HZ however. Oviously a 1000HZ machine is going to give me better 
>>resulution in any requested delay. Why is it unreasonable for userland 
>>to know the probable resolution of userland delay requests.
> 
> 
> But you don't really want to know HZ, you want to know timer resolution.
> That's a reasonable request and I believe the posix-timers
> clock_getres() interface might provide what you need. Although I'd defer
> to George (CC'ed) since he's more of an expert on those interfaces.

Exactly.  clock_getres() on CLOCK_REALTIME will get the resolution of 
timers (itimers or posix timers on CLOCK_REALTIME.  You can also get the 
res using the old itimer interface by programing a repeating time of 1 
usec and then reading back the timer (get_timer ?).  Set a longish 
initial time so you can delete the timer prior to its expiring and look 
at the repeat time returned.  Do be aware that this will be rounded up, 
however, and will likely show, e.g. 1000 usec for 999849 ns (as returned 
by clock_getres()).  Either of these interfaces is in the 2.6 kernel 
these days.
> 
> You might also want to check out his HRT patches.

Thanks for the plug :)
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
