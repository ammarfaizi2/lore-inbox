Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbVAKDYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbVAKDYs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 22:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbVAKDVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 22:21:46 -0500
Received: from gprs215-170.eurotel.cz ([160.218.215.170]:2177 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262412AbVAKDTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 22:19:47 -0500
Date: Tue, 11 Jan 2005 04:19:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: bernard@blackham.com.au, shawv@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: Screwy clock after apm suspend
Message-ID: <20050111031931.GC4092@elf.ucw.cz>
References: <7bb8b8de05010710085ea81da9@mail.gmail.com> <20050109224711.GF1353@elf.ucw.cz> <200501092328.54092.shawv@comcast.net> <20050110074422.GA17710@mussel> <20050110105759.GM1353@elf.ucw.cz> <20050110174804.GC4641@blackham.com.au> <20050111001426.GF1444@elf.ucw.cz> <20050111141332.68e5e05b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111141332.68e5e05b.sfr@canb.auug.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I think that hwclock --hctosys is not quite straightforward operation
> > -- it needs to know if your CMOS clock are in local timezone or GMT,
> > or something like that, IIRC.
> > 
> > But this might work: compute difference between system and cmos time
> > before suspend, and use that info to restore time after suspend.
> 
> Which is, of course, what APM has done all along ...

Heh, but we need to find a way to do it without config options...

#ifdef CONFIG_APM_RTC_IS_GMT
#       define  clock_cmos_diff 0
#       define  got_clock_diff  1
#else
 
...no, it is actually okay, CONFIG_APM_RTC_IS_GMT is only
optimalization.

Hmm...

...and arch/i386/kernel/time.c contains copy of that code. That means
that we should kill apm.c copy and see why time.c copy sometimes does
the wrong thing.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
