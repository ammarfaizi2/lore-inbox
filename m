Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277024AbRKAAxO>; Wed, 31 Oct 2001 19:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277176AbRKAAxH>; Wed, 31 Oct 2001 19:53:07 -0500
Received: from modem-1321.leopard.dialup.pol.co.uk ([217.135.149.41]:33797
	"EHLO Mail.MemAlpha.cx") by vger.kernel.org with ESMTP
	id <S277024AbRKAAxC>; Wed, 31 Oct 2001 19:53:02 -0500
Posted-Date: Thu, 1 Nov 2001 00:52:19 GMT
Date: Thu, 1 Nov 2001 00:52:19 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Kurt Roeckx <Q@ping.be>
cc: Ian Maclaine-cross <iml@ilm.mech.unsw.edu.au>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Ian Maclaine-cross <iml@debian.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
In-Reply-To: <20011031125204.A1126@ping.be>
Message-ID: <Pine.LNX.4.21.0111010045050.28028-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kurt.

>>>> PROBLEM: Linux updates RTC secretly when clock synchronizes.
>>>>
>>>> When /usr/sbin/ntpd synchronizes the Linux kernel (or system) clock
>>>> using the Network Time Protocol the kernel time is accurate to a
>>>> few milliseconds. Linux then sets the Real Time (or Hardware or
>>>> CMOS) Clock to this time at approximately 11 minute intervals.
>>>> Typical RTCs drift less than 10 s/day so rebooting causes only
>>>> millisecond errors.

>> When the machine reboots from a power interruption Internet
>> connection may be unavailable (usual here). Ntpd can start
>> synchronized to an RTC but time is inaccurate because hwclock has
>> not adjusted it. When Internet connection reestablishes ntpd notices
>> the time conflict and terminates. Human intervention or cron lines
>> can run ntpdate and then restart ntpd. This results in time of low
>> quality.

> I'm not really sure about this, but I think you need a *high*
> offset, like in the order of an hour, before ntpd refused to adjust.
> I know it happely does 5 minutes.

The offset needs to be sufficient to handle the case of the RTC being
set to local time and the boot and first ntp sync occurring on opposite
sides of a Daylight Savings Time change. A couple of timezones use a DST
offset of 90 minutes, so if it's less than that, there will be problems.

>> There are lots of high quality and cost hardware solutions. The
>> solution in my first post was a very small kernel patch to add an 11
>> minute update log so hwclock etc could adjust the time. Any comments
>> on my patch?

> Note that hwclock does not adjust the clock if the error is smaller
> than 1 second, or it already wrote to the RTC is the past 23 hours.

I knew about the "not less than 1 second" restriction, but not the "only
once a day" restriction. Can you confirm that the latter restriction is
indeed the case please?

Best wishes from Riley.

