Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbSL2SD1>; Sun, 29 Dec 2002 13:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261205AbSL2SD1>; Sun, 29 Dec 2002 13:03:27 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6149 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261173AbSL2SD0>; Sun, 29 Dec 2002 13:03:26 -0500
Date: Sun, 29 Dec 2002 19:11:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: acpi_os_queue_for_execution()
Message-ID: <20021229181146.GC16995@atrey.karlin.mff.cuni.cz>
References: <20021223181747.GA10363@elf.ucw.cz> <20021228202716.GA28570@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021228202716.GA28570@gtf.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Acpi seems to create short-lived kernel threads, and I don't quite
> > understand why. 
> > 
> > In thermal.c
> > 
> > 
> >                         tz->timer.data = (unsigned long) tz;
> >                         tz->timer.function = acpi_thermal_run;
> >                         tz->timer.expires = jiffies + (HZ * sleep_time) / 1000;
> >                         add_timer(&(tz->timer));
> > 
> > and acpi_thermal_run creates kernel therad that runs
> > acpi_thermal_check. Why is not acpi_thermal_check called directly? I
> > don't like idea of thread being created every time thermal zone needs
> > to be polled...
> 
> This is the standard way to get process context [i.e. somewhere where
> you can sleep].  The new delayed-work workqueue code in 2.5.x does
> something almost exactly like that under the covers.

Is it really true that fork() can not sleep?

> That said, it sounds like you found something to fix in ACPI:
> 
> In 2.4.x ACPI, it should be using schedule_task(), and in 2.5.x it should
> be using schedule_work(), if this is truly the intention of the ACPI
> subsystem.

Agreed.
								Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
