Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWJHQTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWJHQTR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 12:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWJHQTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 12:19:17 -0400
Received: from www.osadl.org ([213.239.205.134]:57019 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751254AbWJHQTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 12:19:16 -0400
Subject: Re: + clocksource-add-generic-sched_clock.patch added to -mm tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, johnstul@us.ibm.com, mingo@elte.hu, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160323597.3693.62.camel@c-67-180-230-165.hsd1.ca.comcast.net>
References: <200610070153.k971ruEZ020872@shell0.pdx.osdl.net>
	 <1160301340.22911.27.camel@localhost.localdomain>
	 <1160318750.3693.12.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160319112.5686.8.camel@localhost.localdomain>
	 <1160321570.3693.34.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160322376.5686.25.camel@localhost.localdomain>
	 <1160323597.3693.62.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 18:19:13 +0200
Message-Id: <1160324354.5686.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 09:06 -0700, Daniel Walker wrote:
> On Sun, 2006-10-08 at 17:46 +0200, Thomas Gleixner wrote:
> > On Sun, 2006-10-08 at 08:32 -0700, Daniel Walker wrote:
> > > > sched_clock is a user of the clocksource API and there is absolutely no
> > > > reason to put that into sched.c
> > > 
> > > We could do something like kernel/time/sched_clock.c ? I really don't
> > > like the idea of stuff sched_clock() , and timekeeping back into
> > > clocksource.
> > 
> > Do we really want 3 files which each has 50 lines of code ? Although
> > it's better than pushing that stuff into sched.c and timer.c. timer.c is
> > enough mess and we really do not want to add more.
> 
> I think John's plan, and my plan, is to move the generic time bits, plus
> the timekeeping specific clocksource stuff, into a different file.
> kernel/timer.c shouldn't have that stuff anyway. That's about 250 lines,
> the part of that which is due to the clocksource is about 100 lines.
> 
> Are you thinking that this interface is only likely to have one or two
> users?

Probably. Anyway, can we just keep the stuff in clocksource.c right
now ?

The sched stuff is really not worth a seperate file and the timekeeping
bits might move into kernel/time/timeofday.c once everone is happy to
move the timekeeping code out of timer.c

	tglx


