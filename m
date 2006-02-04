Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932577AbWBDVpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbWBDVpv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 16:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbWBDVpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 16:45:51 -0500
Received: from sccrmhc11.comcast.net ([204.127.200.81]:55019 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932577AbWBDVpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 16:45:50 -0500
Message-ID: <43E522E7.9010800@comcast.net>
Date: Sat, 04 Feb 2006 16:55:51 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: athlon 64 dual core tsc out of sync
References: <43E40D14.7070606@comcast.net> <1139079812.2791.45.camel@mindpipe> <200602041952.40945.s0348365@sms.ed.ac.uk>
In-Reply-To: <200602041952.40945.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:

>On Saturday 04 February 2006 19:03, Lee Revell wrote:
>  
>
>>On Fri, 2006-02-03 at 21:10 -0500, Ed Sweetman wrote:
>>    
>>
>>>I know this has been gone over before, and I am aware of the possible
>>>fix being the use of the pmtmr.
>>>
>>>My question is, if there is support builtin to the kernel for more than
>>>one timer, and we know that no timer but the pmtimer is reliable on a
>>>dual core system, why doesn't the startup of the kernel choose the
>>>pmtimer based on if it detects the system is a dual core proc with smp
>>>enabled?   And if the pmtimer doesn't fix this sync issue, is there a
>>>fix out there?   Currently with 2.6.16-rc1-mm5 the non-customized boot
>>>args to the kernel results in these messages.
>>>      
>>>
>>Excellent question.  What's the status of this bug?  It's a showstopper
>>for a ton of people on the JACK list...
>>    
>>
>
>As Andi has recounted many times already, pmtmr is now the default on x86-64 
>if it's built in. I'm sure you can confirm this from the sources.
>
>[alistair] 19:52 [~] uname -a
>Linux damocles 2.6.15.1 #5 SMP PREEMPT Wed Feb 1 09:43:23 GMT 2006 x86_64 
>x86_64 x86_64 GNU/Linux
>
>[alistair] 19:52 [~] dmesg | egrep -e time.c.*PM
>time.c: Using 3.579545 MHz PM timer.
>time.c: Using PM based timekeeping.
>
>  
>
this is the relevent (as far as i know) section of my .config i'm using now.

CONFIG_HPET_TIMER=y
CONFIG_X86_PM_TIMER=y
# CONFIG_HPET_EMULATE_RTC is not set
CONFIG_RTC=y
# CONFIG_HPET is not set


Now, there is no option in menuconfig for choosing pm timer, so i take 
it that the config option here compiles it in. Note, ACPI is also 
compiled in, without any apm code so acpi is enabled, as is apic.

This is my dmesg output.
Feb  3 16:22:49 psuedomode kernel: ACPI: PM-Timer IO Port: 0x4008
Feb  3 16:22:49 psuedomode kernel: time.c: Using 1.193182 MHz PIT timer.
Feb  3 16:22:49 psuedomode kernel: time.c: Using PIT/TSC based timekeeping.

So what happened to the pm timer.  I used to use the pm timer when i was 
using older kernels, 2.6.14.3'ish.


