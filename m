Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbUCPXhw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 18:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbUCPXhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 18:37:51 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:46068 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261847AbUCPXhe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 18:37:34 -0500
Subject: Re: [ACPI] X86_PM_TIMER: /proc/cpuinfo doesn't get updated
From: john stultz <johnstul@us.ibm.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: acpi-devel@lists.sourceforge.net, Karol Kozimor <sziwan@hell.org.pl>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200403161819.55351.dtor_core@ameritech.net>
References: <20040316182257.GA2734@dreamland.darkstar.lan>
	 <20040316194805.GC20014@picchio.gall.it>
	 <20040316214239.GA28289@hell.org.pl>
	 <200403161819.55351.dtor_core@ameritech.net>
Content-Type: text/plain
Message-Id: <1079479950.5408.53.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 16 Mar 2004 15:32:30 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-16 at 15:19, Dmitry Torokhov wrote:
> On Tuesday 16 March 2004 04:42 pm, Karol Kozimor wrote:
> > Thus wrote Daniele Venzano:
> > > > I have a notebook with an Athlon-M CPU. I tried linux 2.6.4 with
> > > > CONFIG_X86_PM_TIMER=y and I noticed that /proc/cpuinfo doesn't get
> > > > updated when I switch frequency (via sysfs, using powernow-k7). The is
> > > > issue seems cosmetic only, CPU frequency changes (watching
> > > > temperature/battery life).
> > > I can confirm, I'm seeing the same behavior. Please note that the
> > > bogomips count gets updated, it's only the frequency that doesn't
> > > change.
> > 
> > Same here with a P4-M, follow-up to John and Dmitry.
> > Best regards,
> > 
> 
> PM timer does not install CPUFREQ handler which would scale cpu_khz to
> give proper display. I might cook up something later tonight.

Actually, the cpufreq handler is installed by an initcall regardless of
which time-source is used. However as the handler changes a few TSC
specific variables, it exits in timer_tsc.c.

I think the fix I just mailed should do the trick. Let me know if it
doesn't.

thanks
-john



