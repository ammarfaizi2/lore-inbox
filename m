Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262962AbUCRVJT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 16:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbUCRVJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 16:09:18 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:6831 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262962AbUCRVG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 16:06:26 -0500
Subject: Re: [ACPI] X86_PM_TIMER: /proc/cpuinfo doesn't get updated
From: john stultz <johnstul@us.ibm.com>
To: Dominik Brodowski <linux@dominikbrodowski.de>
Cc: Nate Lawson <nate@root.org>, Dmitry Torokhov <dtor_core@ameritech.net>,
       Peter Chubb <peter@chubb.wattle.id.au>,
       Karol Kozimor <sziwan@hell.org.pl>, acpi-devel@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040318085133.GA15526@dominikbrodowski.de>
References: <16471.43776.178128.198317@wombat.chubb.wattle.id.au>
	 <200403162340.57546.dtor_core@ameritech.net>
	 <20040317095314.GB14983@dominikbrodowski.de>
	 <20040317145312.X3595@root.org>
	 <20040318085133.GA15526@dominikbrodowski.de>
Content-Type: text/plain
Message-Id: <1079643929.5408.71.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 18 Mar 2004 13:05:30 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 00:51, Dominik Brodowski wrote:
> On Wed, Mar 17, 2004 at 02:56:27PM -0800, Nate Lawson wrote:
> > Instead of all this gymnastics, how about:
> 
> It's not so much gymnastics -- implementing different handling for cpufreq
> drivers which do not affect the TSC is easy. It's just difficult to get to
> know what drivers/CPUs are affected... and the test run you did yesterday
> helped in evaluating this. Thanks for doing so.
>  
> > 1. If using Px states, state is unknown until first "set" event.
> 
> Normally, when using cpufreq drivers the original state is known -- only the
> ACPI spec has this severe flaw, but there are tries for a workaround [patch
> is submitted]
> 
> > 2. Implement priorities for time source selection and a generic timer API.
> > This gets around the need to get the clock rate correct to have system
> > timers work.  On FreeBSD, this is /sys/kern/kern_tc.c
> 
> IIRC, John Stultz intends to do a major upgrade of the timing code in 2.7.

Well, we already have time source selection in 2.6 for i386. Most other
arches have a single stable time source, so its not as critical for
them. As for 2.7, a couple of holes have been poked in my initial
design, so any major rewrite is somewhat on hold. Moving more arches to
the more generic time_interpolator interface that ia64 uses may be the
best solution, although its not as clean as I'd really like.

thanks
-john


