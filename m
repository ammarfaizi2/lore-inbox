Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266552AbTAFLD3>; Mon, 6 Jan 2003 06:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266560AbTAFLD3>; Mon, 6 Jan 2003 06:03:29 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:64516 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S266552AbTAFLD2>; Mon, 6 Jan 2003 06:03:28 -0500
Date: Mon, 6 Jan 2003 12:12:04 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] acpi_os_queue_for_execution()
Message-ID: <20030106111204.GD27239@atrey.karlin.mff.cuni.cz>
References: <F760B14C9561B941B89469F59BA3A84725A107@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A107@orsmsx401.jf.intel.com>
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
> >                         tz->timer.expires = jiffies + (HZ * 
> > sleep_time) / 1000;
> >                         add_timer(&(tz->timer));
> > 
> > and acpi_thermal_run creates kernel therad that runs
> > acpi_thermal_check. Why is not acpi_thermal_check called directly? I
> > don't like idea of thread being created every time thermal zone needs
> > to be polled...
> 
> Are we allowed to block in a timer callback? One of the things
> thermal_check does is call a control method, which in turn can be very
> slow, sleep, etc., so I'd guess that's why the code tries to execute
> things in its own thread.

But... Creating a kernel thread can block, too? [Correct me if I'm
wrong, but creating a kernel thread  looks like a *lot* of semaphores
taken to me].

				Pavel  
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
