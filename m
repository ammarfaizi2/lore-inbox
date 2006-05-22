Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWEVIef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWEVIef (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 04:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWEVIef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 04:34:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19078 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750709AbWEVIef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 04:34:35 -0400
Date: Mon, 22 May 2006 10:33:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16.16 Parameter-controlled mmap/stack randomization
Message-ID: <20060522083352.GA11923@elf.ucw.cz>
References: <446E6A3B.8060100@comcast.net> <1148132838.3041.3.camel@laptopd505.fenrus.org> <446F3483.40208@comcast.net> <20060522010606.GC25434@elf.ucw.cz> <44712605.4000001@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44712605.4000001@comcast.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>> On Fri, 2006-05-19 at 21:00 -0400, John Richard Moser wrote:
> >>>> Any comments on this one?
> >>>>
> >>>> I'm trying to control the stack and heap randomization via command-line
> >>>> parameters. 
> >>> why? this doesn't really sound like something that needs to be tunable
> >>> to that extend; either it's on or it's off (which is tunable already),
> >>> the exact amount should just be the right value. While I often disagree
> >>> with the gnome desktop guys, they have some point when they say that
> >>> if you can get it right you shouldn't provide a knob.
> >> This is a "One Size Fits All" argument.
> >>
> >> Oracle breaks with 256M stack/mmap() randomization, so does Linus' mail
> >> client.  That's why we have 8M stack and 1M mmap().
> >>
> >> On the other hand, some things[1][2][3] may give us the undesirable
> >> situation where-- even on an x86-64 with real NX-bit love-- there's an
> >> executable stack.  The stack randomization in this case can likely be
> >> weakened by, say, 8 bits by padding your shellcode with 1-byte NOPs
> >> (there's a zillion of these, like inc %eax) up to 4096 bytes.  This
> >> leaves 1 success case for every 2047 fail cases.
> > 
> > Maybe we can add more bits of randomness when there's enough address
> > space -- like in x86-64 case?
> 
> Yes but how many?  I set the max in my working copy (by the way, I
> patched it into Ubuntu Dapper kernel, built, tested, it works) at 1/12
> of TASK_SIZE; on x86-64, that's 128TiB / 12 -> 10.667TiB -> long_log2()
> - -> 43 bits -> 8TiB of VMA, which becomes 31 bits mmap() and 39 bits stack.
> 
> That's feasible, it's nice, it's fregging huge.  Can we justify it?  ...
> well we can't justify NOT doing it without the ad hominem "We Don't Need
> That Because It's Not Necessary", but that's not the hard part around here.

Well, making it configurable and pushing hard decision to the user is
not right approach, either. I believe we need different
per-architecture defaults, not "make user configure it".
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
