Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280759AbRKBSQg>; Fri, 2 Nov 2001 13:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280761AbRKBSQ1>; Fri, 2 Nov 2001 13:16:27 -0500
Received: from modem-3583.leopard.dialup.pol.co.uk ([217.135.157.255]:58130
	"EHLO Mail.MemAlpha.cx") by vger.kernel.org with ESMTP
	id <S280759AbRKBSQS>; Fri, 2 Nov 2001 13:16:18 -0500
Posted-Date: Fri, 2 Nov 2001 09:50:23 GMT
Date: Fri, 2 Nov 2001 09:50:23 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Alex Bligh <linux-kernel@alex.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
In-Reply-To: <1301130987.1004623024@[10.132.113.67]>
Message-ID: <Pine.LNX.4.21.0111020026300.22697-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex.

>> The offset needs to be sufficient to handle the case of the RTC
>> being set to local time and the boot and first ntp sync occurring on
>> opposite sides of a Daylight Savings Time change. A couple of
>> timezones use a DST offset of 90 minutes, so if it's less than that,
>> there will be problems.

> There is a related problem, where if you are running something which
> can suspend, like a laptop, but not using integrated apm to do it
> (for instance a laptop which has a broken BIOS), then suspending
> 'freezes' the system time, which is wrong on resume (as the power
> management event appears to be invisible to Linux). Then this goes
> and blats over the (correct) RTC time. If you then get a network
> connection up, ntp won't adjust the time as it's too far out.

That sounds like a configuration error to me, and here's why.

 1. One of the available reference clocks for xntpd is the local
    RTC, type 1 in the list of reference clock types, and that
    should ALWAYS be listed as one of the reference clocks to use,
    but with a higher stratum than any other reference clock used.

 2. My experience with the xntpd driver suggests that if no better
    reference is available and the RTC is one of the listed clocks,
    then it ALWAYS adjusts the time to match the RTC, irrespective
    of the time difference between them.

 3. AFAICT, if xntpd writes to the RTC, then it has achieved true
    synchronisation to a reference clock other than the RTC.

It's for these reasons that I'm rather puzzled by the comments in this
thread so far.

> What I wanted was an option which did the copy the other way on a
> large offset - i.e. keep the RTC in sync for smallish offsets, but
> if the offset is wrong by more than 5 minutes (and RTC is in
> advance), copy RTC to system time as the laptop probably suspended.

If you have the RTC as one of your reference clocks, then this heuristic
is not required as xntpd (at least) does the right thing for you.

> There might of course be a better heuristic to detect this (perhaps
> every time it does the check see if it got out of sync by > the
> interval between checks).

Probably the 'heuristic' of ensuring that the RTC is one of the
reference clocks is sufficient.

> Short of this, it would be useful to be able to turn /off/ futzing
> with the RTC.

True.

Best wishes from Riley.

