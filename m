Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267030AbTBHQiD>; Sat, 8 Feb 2003 11:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267035AbTBHQiD>; Sat, 8 Feb 2003 11:38:03 -0500
Received: from [195.39.17.254] ([195.39.17.254]:10500 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267030AbTBHQiC>;
	Sat, 8 Feb 2003 11:38:02 -0500
Date: Fri, 7 Feb 2003 17:33:01 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Kevin Lawton <kevinlawton2001@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Possible bug in arch/i386/kernel/process.c for reloading of debug registers (DRx)?
Message-ID: <20030207163301.GH345@elf.ucw.cz>
References: <20030203235140.10443.qmail@web80304.mail.yahoo.com.suse.lists.linux.kernel> <p7365s0ri9c.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p7365s0ri9c.fsf@oldwotan.suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I was scanning through the source and noticed the lines below.
> > Should the code below, be reloading at least the local bits of
> > DR7 if the current DR7 value != 0?  From a quick glance, it
> > looks like only if the next task's DR7 value is non-zero,
> > that DR7 is reloaded.  I'm wondering if this would leave
> > a new task to receive "local" debug events for the previous
> > task if prev->DR7!=0 && next->DR7==0.
> 
> The do_debug trap handler handles that. It checks that
> the debug event is set in the current process before doing anything
> and if they weren't they are clared.
> 
> So yes they leak, but only once and the user should never notice.

What if DRx contains sensitive data? ...Its probably pretty
unlikely. Still it allows for example easy communication between tasks
that should not be able to communicate.

								Pavel

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
