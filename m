Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVAJK6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVAJK6U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 05:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVAJK6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 05:58:20 -0500
Received: from gprs215-6.eurotel.cz ([160.218.215.6]:12674 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262204AbVAJK6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 05:58:12 -0500
Date: Mon, 10 Jan 2005 11:57:59 +0100
From: Pavel Machek <pavel@suse.cz>
To: bernard@blackham.com.au
Cc: Shaw <shawv@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: Screwy clock after apm suspend
Message-ID: <20050110105759.GM1353@elf.ucw.cz>
References: <7bb8b8de05010710085ea81da9@mail.gmail.com> <20050109224711.GF1353@elf.ucw.cz> <200501092328.54092.shawv@comcast.net> <20050110074422.GA17710@mussel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110074422.GA17710@mussel>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Probably code to compensate clock after ACPI suspend breaks apm case
> > >
> > > arch/i386/kernel/time.c, can you comment out
> > > jiffies += sleep_length * HZ;
> > >
> > > in timer_resume to see if it goes away?
> > 
> > Worked like a charm.  I'm not seeing any time drift after your suggested 
> > change.
> 
> AIUI, this also means that a machine's uptime does not include time
> whilst suspended. This was the behaviour prior to 2.6.10 and seems to be
> more desirable as it counts the time the machine is actually running,
> not just time since boot. Is there a good reason why we can't go back to
> this?

I think it means very wrong system clock in ACPI state. Plus think
something wanting timeout of five minutes, then suspend one minute
after, machine sleeps for a hour.

With this approach, timeout should happen just after resume, with your
approach, it would wait 4 more minutes.

[Perhaps it needs to call lost_ticks or something like that.]

									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
