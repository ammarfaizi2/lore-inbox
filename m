Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTJPAUr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 20:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbTJPAUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 20:20:47 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:56312 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262041AbTJPAUn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 20:20:43 -0400
Message-ID: <3F8DE452.2070901@mvista.com>
Date: Wed, 15 Oct 2003 17:20:34 -0700
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Marshall <tmarshall@real.com>
CC: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Fw: missed itimer signals in 2.6
References: <20031013163411.37423e4e.akpm@osdl.org> <3F8C8692.5010108@mvista.com> <20031014235213.GC860@real.com> <3F8D63AA.9000509@mvista.com> <20031015165016.GA2167@real.com> <3F8DCF73.3000707@mvista.com> <20031015232553.GB4034@real.com>
In-Reply-To: <20031015232553.GB4034@real.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Marshall wrote:
>>>I expect there are at least a few applications that will misbehave because
>>>the developers did not expect a timer to behave this way (regardless of
>>>whether it's proper according to the spec).
>>>
>>>Is it possible to choose a timer resolution that errs on the high side of
>>>1ms instead of the low side? [*]  It seems to me that would result in the
>>>application getting very close to the expected number of alarm signals.  I
>>>am not at all familiar with the kernel design so I don't know if this would
>>>be feasible or not.
>>>
>>>[*] If this is the 8254 timer, using 1192 as a divisor should result in a
>>>resolution of ~1,000,686 nanoseconds.
>>
>>Well here is the rub.  Your high side give an error of 686 PPM while the 
>>low side has an error of only 152 PPM.  This assumes, of course, that you 
>>are trying to hit exactly 1,000,000 nano seconds per tick.
>>
>>On the other hand, since we do correct for this error, I suspect one could 
>>use the high side number.
> 
> 
> It doesn't really matter to me, as an application developer, what the actual
> numbers are.  What matters is that when I ask for a timer in the 1..50ms
> range, I get a reasonably close number of SIGALRMs to what I requested. 
> Having to adjust the resolution by 9% at 10ms when I know the system clock
> is ticking at 10x that rate seems to be a bit broken from that perspective
> (not technically, but perceptually).
> 
> 
>>Still, if an application depends on the count rather than just reading the 
>>clock, I suspect that some would consider it broken.  Timer signals can be 
>>delayed and may, in fact overrun with out notice (unlike POSIX timers which 
>>tell you when they overrun).
> 
> 
> Our code does not depend solely on the delivery of SIGALRM.  It resyncs
> periodically using gettimeofday().
> 
> 
>>What you really need is a higher resolution timer.  Funny, there seems to 
>>be a reference to such a thing in my signature :)
> 
> 
> I have rewritten our timer code to take the information learned in this
> thread into account.  It turns out that at least one other *nix platform has
> problems with the magical 10ms number and, unlike the 2.6 kernel, does not
> seem to fill in the actual interval for getitimer().

That is the standard.  They must be broken :(
> 
> Thanks again for taking the time to explain the timer system to me.
> 
You are very welcome.
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

