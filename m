Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262703AbVAKBSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbVAKBSP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 20:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVAKBRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 20:17:46 -0500
Received: from oracle.bridgewayconsulting.com.au ([203.56.14.38]:62115 "EHLO
	oracle.bridgewayconsulting.com.au") by vger.kernel.org with ESMTP
	id S262689AbVAKBQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 20:16:12 -0500
Date: Tue, 11 Jan 2005 09:16:11 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: Shaw <shawv@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: Screwy clock after apm suspend
Message-ID: <20050111011611.GE4641@blackham.com.au>
References: <7bb8b8de05010710085ea81da9@mail.gmail.com> <20050109224711.GF1353@elf.ucw.cz> <200501092328.54092.shawv@comcast.net> <20050110074422.GA17710@mussel> <20050110105759.GM1353@elf.ucw.cz> <20050110174804.GC4641@blackham.com.au> <20050111001426.GF1444@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111001426.GF1444@elf.ucw.cz>
Organization: Dagobah Systems
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 01:14:26AM +0100, Pavel Machek wrote:
> > So would implementing the equivalent of hwclock --hctosys keep both
> > ACPI & APM happy, but not include time suspended in uptime?
> 
> I think that hwclock --hctosys is not quite straightforward operation
> -- it needs to know if your CMOS clock are in local timezone or GMT,
> or something like that, IIRC.
> 
> But this might work: compute difference between system and cmos time
> before suspend, and use that info to restore time after suspend.

Forgive my ignorance, but isn't this exactly what's done already?

Looking harder, in arch/i386/kernel/apm.c the system time is also
saved and restored in a very similar way to timer_suspend/resume.
Would this account for the time drift in APM mode? (sleep time being
accounted for twice?)

> > Hibernating shouldn't be noticeable to the system. For example, a
> > popup window that came up an instant prior to suspending which is
> > normally on the screen for several seconds would vanish instantly
> > upon resuming without the user ever seeing it.
> 
> I disagree here.
> 
> If I do cli(); sleep(5 hours); sti();, system should survive that. If
> you do cli(); sleep(5 hours); sti() but fail to compensate for lost
> ticks, all sorts of funny things might happen if you are comunicating
> with someone who did not sleep.

Then shouldn't it be fixed to compensate?

By including suspend time in jiffies, there becomes absolutely no
way for a kernel or userspace thread to measure actual usable system
time. At least if suspend time is not counted, they can use jiffies
or xtime depending on what they want to do. Making them one and the
same gives them no choice.

Bernard.
