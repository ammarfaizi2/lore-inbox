Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWJHWII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWJHWII (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 18:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWJHWII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 18:08:08 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:51416 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932076AbWJHWIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 18:08:04 -0400
Subject: Re: + clocksource-add-generic-sched_clock.patch added to -mm tree
From: Daniel Walker <dwalker@mvista.com>
To: tglx@linutronix.de
Cc: akpm@osdl.org, johnstul@us.ibm.com, mingo@elte.hu, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160343715.5686.118.camel@localhost.localdomain>
References: <200610070153.k971ruEZ020872@shell0.pdx.osdl.net>
	 <1160301340.22911.27.camel@localhost.localdomain>
	 <1160318750.3693.12.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160319112.5686.8.camel@localhost.localdomain>
	 <1160321570.3693.34.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160322376.5686.25.camel@localhost.localdomain>
	 <1160323597.3693.62.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160324354.5686.41.camel@localhost.localdomain>
	 <1160324846.3693.78.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160326451.5686.51.camel@localhost.localdomain>
	 <1160328400.3693.100.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160333127.5686.58.camel@localhost.localdomain>
	 <1160342108.3693.144.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160342483.5686.104.camel@localhost.localdomain>
	 <1160343221.3693.154.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160343715.5686.118.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 15:08:02 -0700
Message-Id: <1160345282.3693.175.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 23:41 +0200, Thomas Gleixner wrote:
> On Sun, 2006-10-08 at 14:33 -0700, Daniel Walker wrote:
> > On Sun, 2006-10-08 at 23:21 +0200, Thomas Gleixner wrote:
> > > On Sun, 2006-10-08 at 14:15 -0700, Daniel Walker wrote:
> > > > On Sun, 2006-10-08 at 20:45 +0200, Thomas Gleixner wrote:
> > > > 
> > > > > > I'm not moving the kernel/timer.c clocksource user back into
> > > > > > kernel/time/clocksource.c . That code completely belongs with the
> > > > > > generic time of day changes. The code is directly coupled, and in fact
> > > > > > it improves the timekeeping clock switching code to have it that way.
> > > > > 
> > > > > I don't see any reason, why it must be added to timer.c. You can achieve
> > > > > the same result with calling the code outside, except that the compiler
> > > > > might miss some inline optimization. The switch clock code is not a
> > > > > hotpath and so it does not matter whether it is called here or there.
> > > > 
> > > > It wouldn't be as clean to integrate the two. The hotpath is improved
> > > > (which is what I was referring too above.)
> > > 
> > > Sorry, where is which hotpath improved ?
> > 
> > The hotpath in update_wall_time() kernel/timer.c which involves clock
> > switching.
> 
> And why the heck does this require to move _clocksource_ related code
> including sysfs hackery into timer.c ? Your improvement works with
> extern code as well.

There are no clocksource internals added by me. There is a exposed
clocksource API which is all that is used.

The design of the original clocksource interface was specific for
timekeeping. What I did was modified it to be used by more than just
timekeeping.

If I add tons of externs there and cram all that into clocksource.c ,
that would just be a mess. Then we're tending back to the original
clocksource design when it's designed just for time keeping.

Daniel

