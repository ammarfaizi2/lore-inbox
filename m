Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280985AbRKGVKb>; Wed, 7 Nov 2001 16:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280983AbRKGVKW>; Wed, 7 Nov 2001 16:10:22 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:50695 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S280982AbRKGVKM>; Wed, 7 Nov 2001 16:10:12 -0500
Date: Tue, 6 Nov 2001 09:57:33 +0000
From: Pavel Machek <pavel@suse.cz>
To: Riley Williams <rhw@MemAlpha.cx>
Cc: Alex Bligh <linux-kernel@alex.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <20011106095733.A35@toy.ucw.cz>
In-Reply-To: <1301130987.1004623024@[10.132.113.67]> <Pine.LNX.4.21.0111020026300.22697-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0111020026300.22697-100000@Consulate.UFP.CX>; from rhw@MemAlpha.cx on Fri, Nov 02, 2001 at 09:50:23AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> The offset needs to be sufficient to handle the case of the RTC
> >> being set to local time and the boot and first ntp sync occurring on
> >> opposite sides of a Daylight Savings Time change. A couple of
> >> timezones use a DST offset of 90 minutes, so if it's less than that,
> >> there will be problems.
> 
> > There is a related problem, where if you are running something which
> > can suspend, like a laptop, but not using integrated apm to do it
> > (for instance a laptop which has a broken BIOS), then suspending
> > 'freezes' the system time, which is wrong on resume (as the power
> > management event appears to be invisible to Linux). Then this goes
> > and blats over the (correct) RTC time. If you then get a network
> > connection up, ntp won't adjust the time as it's too far out.
> 
> That sounds like a configuration error to me, and here's why.
> 
>  1. One of the available reference clocks for xntpd is the local
>     RTC, type 1 in the list of reference clock types, and that
>     should ALWAYS be listed as one of the reference clocks to use,
>     but with a higher stratum than any other reference clock used.
> 
>  2. My experience with the xntpd driver suggests that if no better
>     reference is available and the RTC is one of the listed clocks,
>     then it ALWAYS adjusts the time to match the RTC, irrespective
>     of the time difference between them.

This sounds racy. What if kernel is faster and destroys RTC just after 
resume and before xntpd ca run?
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

