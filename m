Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267645AbTBFUpb>; Thu, 6 Feb 2003 15:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267628AbTBFUpb>; Thu, 6 Feb 2003 15:45:31 -0500
Received: from [205.205.44.10] ([205.205.44.10]:48906 "EHLO
	sembo111.teknor.com") by vger.kernel.org with ESMTP
	id <S267645AbTBFUp2> convert rfc822-to-8bit; Thu, 6 Feb 2003 15:45:28 -0500
Message-ID: <5009AD9521A8D41198EE00805F85F18F219C32@sembo111.teknor.com>
From: "Isabelle, Francois" <Francois.Isabelle@ca.kontron.com>
To: "'george anzinger'" <george@mvista.com>
Cc: high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: RE: High-Res-Timers: Unexpected "lock" during "Calibrating delay 
	loop "
Date: Thu, 6 Feb 2003 15:55:02 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I might be able to use the "rtc" driver to meet the specific requirements of
this application, but considering the success of other OSes (in the embedded
field) on low cost/low speed x86 compatible devices, you may expect some
interest for your driver from linux enthousiasts for similar CPUs.

Anyway, you are doing some great job here and I'ld be (somehow) available
for validation of the fixes you might come with, if you get some time .

Thank you

Frank

> -----Original Message-----
> From: george anzinger [mailto:george@mvista.com]
> Sent: 5 février, 2003 15:39
> To: Isabelle, Francois
> Cc: high-res-timers-discourse@lists.sourceforge.net;
> linux-kernel@vger.kernel.org
> Subject: Re: High-Res-Timers: Unexpected "lock" during "Calibrating
> delay loop "
> 
> 
> Isabelle, Francois wrote:
> > Just wanted to add this: this seems to be reproducible on all 486 
> > 
> 
> I hope to get a chance to look at this today.  Thus far, I know that 
> the PIT version does not keep good time in the face of timers of 
> resolution > 1/HZ, i.e. the "_HR" clocks.
> 
> This has to do with the fact that we have only one interrupt source 
> and must change it to get the sub jiffies interrupts.  In the process 
> we loose track of where the jiffies interrupt should be.  There is an 
> attempt to use the second PIT timer to cover for this, but 
> assumptions 
> are made here that may not be right. (This timer is used for memory 
> refresh and is set up by the BIOS.  We can not change it and 
> we assume 
> that it has a given period.  I suppose we could attempt to 
> measure the 
> period, but thus far we have assumed that these sorts of machines 
> would not require high res timers and have not tried to run 
> down these 
> issues.
> 
> A side issue is that the timers seem to not follow the spec (at least 
> on my test machine) in the regard that a status bit is supposed to 
> indicate when the latch has been loaded after a program has been 
> output.  I can easily find cases where a wait for the bit to 
> change is 
> followed by a read of the latch which returns a stale value.  I 
> suppose some of this has to do with a large difference 
> between the cpu 
> clock and the timer clock.
> > 
> >>-----Original Message-----
> >>From: Isabelle, Francois [mailto:Francois.Isabelle@ca.kontron.com]
> >>Sent: 4 février, 2003 09:04
> >>To: high-res-timers-discourse@lists.sourceforge.net; 
> >>'george@mvista.com'
> >>Cc: linux-kernel@vger.kernel.org
> >>Subject: High-Res-Timers: Unexpected "lock" during 
> "Calibrating delay
> >>loop "
> >>
> >>
> >>Hi,
> >>	we are having an unexpected problem with the HR patch( 
> >>regardless of
> >>the patch you sent which compiled just fine ). The board uses 
> >>a 486DX cpu,
> >>so there is no support for TSC nor ACPI, the only thing we 
> >>have is the PIT. 
> >>
> >>Without highres, the kernel boots properly, with highres 
> >>enabled, the kernel
> >>passes "time_init()" put it hangs in "calibrate_loop() , ( I 
> >>though it hung
> >>for real, but it get passed the loop after a while) " 
> >>
> >>Seems like the tick is VERY SLOW..
> >>
> >>The PIT has been tested on this board, and without HR, the 
> >>kernel boots fine
> >>... if you have any hints, they would be welcome.
> >>
> >>The keyboard detection routine timeouts so the system is 
> >>quiet unuseable and
> >>I can't get the calibration results yet.
> >>
> >>
> >>Frank
> >>
> >>
> >>
> >>
> >>
> >>-------------------------------------------------------
> >>This SF.NET email is sponsored by:
> >>SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
> >>http://www.vasoftware.com
> >>to unsubscribe: 
> >>http://lists.sourceforge.net/lists/listinfo/high-res-timers-
discourse
>>High-res-timers-discourse mailing list
>>High-res-timers-discourse@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/high-res-timers-discourse
>>
> 
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
to unsubscribe:
http://lists.sourceforge.net/lists/listinfo/high-res-timers-discourse
High-res-timers-discourse mailing list
High-res-timers-discourse@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/high-res-timers-discourse
