Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWHPWCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWHPWCo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWHPWCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:02:44 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6319 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750805AbWHPWCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:02:44 -0400
Date: Thu, 17 Aug 2006 00:02:22 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] PM: Remove PM_TRACE from Kconfig
Message-ID: <20060816220222.GE16571@elf.ucw.cz>
References: <200608162259.00941.rjw@sisk.pl> <200608162305.34038.rjw@sisk.pl> <20060816145242.32faa669.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816145242.32faa669.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-08-16 14:52:42, Andrew Morton wrote:
> On Wed, 16 Aug 2006 23:05:33 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > Remove the CONFIG_PM_TRACE option, which is dangerous and should only be used
> > by people who know exactly what they are doing, from kernel/power/Kconfig .
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > ---
> >  kernel/power/Kconfig |   18 ------------------
> >  1 files changed, 18 deletions(-)
> > 
> > Index: linux-2.6.18-rc4-mm1/kernel/power/Kconfig
> > ===================================================================
> > --- linux-2.6.18-rc4-mm1.orig/kernel/power/Kconfig
> > +++ linux-2.6.18-rc4-mm1/kernel/power/Kconfig
> > @@ -47,24 +47,6 @@ config PM_DISABLE_CONSOLE_SUSPEND
> >  	suspend/resume routines, but may itself lead to problems, for example
> >  	if netconsole is used.
> >  
> > -config PM_TRACE
> > -	bool "Suspend/resume event tracing"
> > -	depends on PM && PM_DEBUG && X86_32 && EXPERIMENTAL
> > -	default n
> > -	---help---
> > -	This enables some cheesy code to save the last PM event point in the
> > -	RTC across reboots, so that you can debug a machine that just hangs
> > -	during suspend (or more commonly, during resume).
> > -
> > -	To use this debugging feature you should attempt to suspend the machine,
> > -	then reboot it, then run
> > -
> > -		dmesg -s 1000000 | grep 'hash matches'
> > -
> > -	CAUTION: this option will cause your machine's real-time clock to be
> > -	set to an invalid time after a resume.
> > -
> > -
> >  config SOFTWARE_SUSPEND
> >  	bool "Software Suspend"
> >  	depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP)) || ((FRV || PPC32) && !SMP)
> 
> So...  how are people supposed to turn it on again?  By patching the
> kernel?  That's a bit painful if they're using (say) fedora-of-the-day.
> 
> How about we add a kernel boot parameter to enable it at runtime?

You need to add hooks to the .c code to use this, anyway. Normal
fedora user is not expected to use this.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
