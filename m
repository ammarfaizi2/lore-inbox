Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVAHPpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVAHPpE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 10:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVAHPpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 10:45:04 -0500
Received: from gprs214-39.eurotel.cz ([160.218.214.39]:31106 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261191AbVAHPo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 10:44:58 -0500
Date: Sat, 8 Jan 2005 16:44:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ncunningham@linuxmail.org
Subject: Re: 2.6.10-mm2: swsusp regression [update]
Message-ID: <20050108154439.GA24771@elf.ucw.cz>
References: <20050106002240.00ac4611.akpm@osdl.org> <200501081049.02862.rjw@sisk.pl> <20050108131909.GA7363@elf.ucw.cz> <200501081610.57625.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501081610.57625.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Thanks for pointing it out.  I have adapted this patch to -mm2, but 
> > > > unfortunately it does not fix the issue.  Still searching. ;-)
> > > 
> > > The regression is caused by the timer driver.  Obviously, turning 
> > > timer_resume() in arch/x86_64/kernel/time.c into a NOOP makes it go away.
> > > 
> > > It looks like a locking problem to me.  I'll try to find a fix, although 
> > > someone who knows more about these things would probably do it faster. :-)
> > 
> > (I do not have time right now, but...)
> > 
> > ..you might want to look at i386 time code, they have common
> > ancestor, and i386 one seems to work.
> 
> Well, I need the help of The Wise. :-)
> 
> If I comment out only the modification of jiffies in timer_resume() in 
> arch/x86_64/kernel/time.c (ie line 986), everything seems to work, but I get 
> "APIC error on CPU0: 00(00)" after device_power_up(), which seems strange to 
> me, because I boot with "noapic".  On the other hand, if it's not commented 
> out (ie jiffies _is_ modified in timer_resume()), the machine hangs solid 
> after executing device_power_up() in swsusp_suspend().

Perhaps calling handle_lost_ticks() like timer_interrupt does is right
thing to do?

> Right now I have no idea of what happens there, and it seems strange because 
> in 2.6.10-mm1 the code in time.c is the same.

Well, but in -mm1, the code is not actually called, right?

									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
