Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbWJHWfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWJHWfM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 18:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWJHWfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 18:35:12 -0400
Received: from www.osadl.org ([213.239.205.134]:39616 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751512AbWJHWfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 18:35:09 -0400
Subject: Re: + clocksource-add-generic-sched_clock.patch added to -mm tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, johnstul@us.ibm.com, mingo@elte.hu, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160345282.3693.175.camel@c-67-180-230-165.hsd1.ca.comcast.net>
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
	 <1160345282.3693.175.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 00:35:08 +0200
Message-Id: <1160346908.5686.143.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 15:08 -0700, Daniel Walker wrote:
> > And why the heck does this require to move _clocksource_ related code
> > including sysfs hackery into timer.c ? Your improvement works with
> > extern code as well.
> 
> There are no clocksource internals added by me. There is a exposed
> clocksource API which is all that is used.

You move tons of code into timer.c, which does not belong there.
clocksource is a different thing than timekeeping. timekeeping makes use
of clocksources, and your extra layer of timekeeping_clocksource API
does not change that at all. What you call abstraction is just an
artificial extra layer, as it is intrinsically tied to the clocksource
core.

> The design of the original clocksource interface was specific for
> timekeeping. What I did was modified it to be used by more than just
> timekeeping.
> 
> If I add tons of externs there and cram all that into clocksource.c ,
> that would just be a mess. Then we're tending back to the original
> clocksource design when it's designed just for time keeping.

Tons of externs for the optimization of the clock source switch? Sorry,
I'm not following. 

The clock source switch happens once or twice during bootup and the
replacement of a call with an atomic check does not in any way
legitimate the move of code into timer.c. The number of cylces saved is
not impressing. Moving the clock source switch out of that path at all
would be progress and save real cylces. 
.
The maintainability of code has to weighed carefully against some
obscure cylce savings.

	tglx


