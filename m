Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281020AbRKCTT1>; Sat, 3 Nov 2001 14:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281022AbRKCTTS>; Sat, 3 Nov 2001 14:19:18 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:24480 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S281020AbRKCTTL>;
	Sat, 3 Nov 2001 14:19:11 -0500
Date: Sat, 03 Nov 2001 19:19:07 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Riley Williams <rhw@MemAlpha.cx>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <534020141.1004815146@[195.224.237.69]>
In-Reply-To: <Pine.LNX.4.21.0111031813390.9415-100000@Consulate.UFP.CX>
In-Reply-To: <Pine.LNX.4.21.0111031813390.9415-100000@Consulate.UFP.CX>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riley,

> server	127.127.1.0		# local clock
> fudge	127.127.1.0 stratum 10	

'attempt to configure invalid address 127.127.1.0'; guess
ntpd (as opposed to xntpd) doesn't support it.

>> ... you are assuming that the RTC doesn't get adjusted first (to
>> match the system clock)!
>
> If it does, what adjusts it?

I got confused by the kernel /reading/ the CMOS clock,
and the symptoms the original reporter suggested (see
subject line). My symptoms came from non-APM driven
suspend (hence high time offset, no clock/hwclock
invocation) and writing back system clock to cmos clock
on shutdown, AND ntp not adjusting if the date difference
is greater than some small value AND ntpdate not being
able to get to any time server including the CMOS clock
when it was run; sigh...

>>>  3. AFAICT, if xntpd writes to the RTC, then it has achieved true
>>>     synchronisation to a reference clock other than the RTC.
>
>> I thought the original poster was claiming that the /kernel/
>> wrote to the RTC, which would explain the behaviour I'm seeing.
>
> The kernel itself never writes to the RTC, and that is one of Linus's
> decisions with which I am in 100% agreeance (and one thing I hate about
> Windows). In fact, the kernel itself also doesn't read from the RTC
> either, but leaves that to userspace.

The kernel does read from the rtc to support /dev/rtc, and in
the apm code. AIUI that's why the kernel needs to know
via config whether your RTC is in UTC (else that could
be done in userspace too). You are probably correct that
it doesn't write to it.

> please advise what you find.

Summary:

1. ntpd (as opposed to xntpd) doesn't seem to support the rtc,
   as a clock source, at least not in the same way.

2. suspending your laptop in a manner other than using apm
   doesn't do good things to the RTC when you later shut
   the machine down, with standard scripts.

3. Check your ntpdate on init is doing what you think it's
   doing.

--
Alex Bligh
