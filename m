Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280943AbRKCLlr>; Sat, 3 Nov 2001 06:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280946AbRKCLlh>; Sat, 3 Nov 2001 06:41:37 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:39583 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S280943AbRKCLlX>;
	Sat, 3 Nov 2001 06:41:23 -0500
Date: Sat, 03 Nov 2001 11:41:20 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Riley Williams <rhw@MemAlpha.cx>, Alex Bligh <linux-kernel@alex.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <506556532.1004787679@[195.224.237.69]>
In-Reply-To: <Pine.LNX.4.21.0111020026300.22697-100000@Consulate.UFP.CX>
In-Reply-To: <Pine.LNX.4.21.0111020026300.22697-100000@Consulate.UFP.CX>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riley,

> That sounds like a configuration error to me, and here's why.
>
>  1. One of the available reference clocks for xntpd is the local
>     RTC, type 1 in the list of reference clock types, and that
>     should ALWAYS be listed as one of the reference clocks to use,
>     but with a higher stratum than any other reference clock used.

Well, perhaps that's a difference between xntpd and ntpd - I am
using the latter, version 4.1.0, from Debian testing. Manpage
doesn't mention RTC, ntpdc doesn't seem to find it. I may
well be out of sync with ntpd (pun fully intended) as I haven't
looked at it for a while, but...

>  2. My experience with the xntpd driver suggests that if no better
>     reference is available and the RTC is one of the listed clocks,
>     then it ALWAYS adjusts the time to match the RTC, irrespective
>     of the time difference between them.

... you are assuming that the RTC doesn't get adjusted first (to
match the system clock)!

>  3. AFAICT, if xntpd writes to the RTC, then it has achieved true
>     synchronisation to a reference clock other than the RTC.

I thought the original poster was claiming that the /kernel/
wrote to the RTC, which would explain the behaviour I'm seeing.
An alternative explanation I suppose is simply that nothing
is writing to the RTC (not ntpd, not anything) except for
the final clock command as the machine shuts down. Very simply
the symptom is that both clocks are correct, I suspend the
machine (without APM in the kernel), I resume it, reboot
it, and now both clocks are wrong.

> If you have the RTC as one of your reference clocks, then this heuristic
> is not required as xntpd (at least) does the right thing for you.

OK I will go read the manpage even harder.

--
Alex Bligh
