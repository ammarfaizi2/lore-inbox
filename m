Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWHQF2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWHQF2g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 01:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWHQF2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 01:28:35 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:17334 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750972AbWHQF2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 01:28:35 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/3] PM: Remove PM_TRACE from Kconfig
Date: Thu, 17 Aug 2006 07:32:39 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <200608162259.00941.rjw@sisk.pl> <200608162305.34038.rjw@sisk.pl> <20060816145242.32faa669.akpm@osdl.org>
In-Reply-To: <20060816145242.32faa669.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608170732.40048.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 August 2006 23:52, Andrew Morton wrote:
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

I'm considering a sysfs attribute in /sys/power .

If PM_TRACE is compiled in, an attribute, say "pm_trace", shows up in sysfs
which is initially set to 0 and the user has to explicitly set it to 1 to
enable the feature?  Pavel, what do you think?

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
