Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281324AbRKEUlW>; Mon, 5 Nov 2001 15:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281319AbRKEUlM>; Mon, 5 Nov 2001 15:41:12 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:16656 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S281318AbRKEUlG>; Mon, 5 Nov 2001 15:41:06 -0500
Date: Fri, 2 Nov 2001 12:16:03 +0000
From: Pavel Machek <pavel@suse.cz>
To: Ian Maclaine-cross <iml@ilm.mech.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Ian Maclaine-cross <iml@debian.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <20011102121602.A45@toy.ucw.cz>
In-Reply-To: <20011031113312.A8738@ilm.mech.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011031113312.A8738@ilm.mech.unsw.edu.au>; from iml@ilm.mech.unsw.edu.au on Wed, Oct 31, 2001 at 11:33:12AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> PROBLEM: Linux updates RTC secretly when clock synchronizes.
> 
> Please CC replies etc to Ian Maclaine-cross <iml@debian.org>.
> 
> When /usr/sbin/ntpd synchronizes the Linux kernel (or system) clock
> using the Network Time Protocol the kernel time is accurate to a few
> milliseconds. Linux then sets the Real Time (or Hardware or CMOS)
> Clock to this time at approximately 11 minute intervals. Typical RTCs
> drift less than 10 s/day so rebooting causes only millisecond errors.
> 
> Linux currently does not record the 11 minute updates to a log file.
> Clock programs (like hwclock) cannot correct RTC drift at boot without
> knowing when the RTC was last set. If NTP service is available after a
> long shutdown, ntpd may step the time.  Worse after a longer shutdown
> ntpd may drop out or even synchronize to the wrong time zone.  The
> workarounds are clumsy.
> 
> Please find following my small patch for linux/arch/i386/kernel/time.c
> which adds a KERN_NOTICE of each 11 minute update to the RTC. This is
> just for i386 machines at present. A script can search the logs for
> the last set time of the RTC and update /etc/adjtime.  Hwclock can
> then correct the RTC for drift and set the kernel clock.

That seems as very wrong solution.

What about just making kernel only _read_ system clock, and never set it? 
That looks way cleaner to me.

								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

