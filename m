Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281417AbRKEXNM>; Mon, 5 Nov 2001 18:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281418AbRKEXND>; Mon, 5 Nov 2001 18:13:03 -0500
Received: from modem-2114.lynx.dialup.pol.co.uk ([217.135.200.66]:17416 "EHLO
	Mail.MemAlpha.cx") by vger.kernel.org with ESMTP id <S281417AbRKEXMo>;
	Mon, 5 Nov 2001 18:12:44 -0500
Posted-Date: Mon, 5 Nov 2001 23:08:48 GMT
Date: Mon, 5 Nov 2001 23:08:47 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Pavel Machek <pavel@suse.cz>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
In-Reply-To: <20011102121602.A45@toy.ucw.cz>
Message-ID: <Pine.LNX.4.21.0111052300490.1693-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel.

>> PROBLEM: Linux updates RTC secretly when clock synchronizes.
>> 
>> Please CC replies etc to Ian Maclaine-cross <iml@debian.org>.
>> 
>> When /usr/sbin/ntpd synchronizes the Linux kernel (or system) clock
>> using the Network Time Protocol the kernel time is accurate to a few
>> milliseconds. Linux then sets the Real Time (or Hardware or CMOS)
>> Clock to this time at approximately 11 minute intervals. Typical
>> RTCs drift less than 10 s/day so rebooting causes only millisecond
>> errors.
>>
>> Linux currently does not record the 11 minute updates to a log file.
>> Clock programs (like hwclock) cannot correct RTC drift at boot time
>> without knowing when the RTC was last set. If NTP service is available
>> after a long shutdown, ntpd may step the time. Worse after a longer
>> shutdown ntpd may drop out or even synchronize to the wrong timezone.
>> The workarounds are clumsy.
>>
>> Please find following my small patch for
>> linux/arch/i386/kernel/time.c which adds a KERN_NOTICE of each 11
>> minute update to the RTC. This is just for i386 machines at present.
>> A script can search the logs for the last set time of the RTC and
>> update /etc/adjtime. Hwclock can then correct the RTC for drift and
>> set the kernel clock.

> That seems as very wrong solution.

> What about just making kernel only _read_ system clock, and never
> set it? That looks way cleaner to me.

It is cleaner. However, I feel that the RTC code should printk (at least
as KERN_DEBUG if not as KERN_NOTICE) whenever the RTC is written to.
It's too important a subsystem to be left hidden like it currently is.

Best wishes from Riley.

