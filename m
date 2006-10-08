Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWJHP6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWJHP6t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 11:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWJHP6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 11:58:49 -0400
Received: from www.osadl.org ([213.239.205.134]:40379 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751227AbWJHP6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 11:58:48 -0400
Subject: Re: + clocksource-increase-initcall-priority.patch added to -mm
	tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, johnstul@us.ibm.com, mingo@elte.hu, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160322317.3693.47.camel@c-67-180-230-165.hsd1.ca.comcast.net>
References: <200610070153.k971ren4020838@shell0.pdx.osdl.net>
	 <1160294812.22911.8.camel@localhost.localdomain>
	 <1160302797.22911.37.camel@localhost.localdomain>
	 <1160319033.3693.19.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160319234.5686.12.camel@localhost.localdomain>
	 <1160322317.3693.47.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 17:58:46 +0200
Message-Id: <1160323127.5686.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 08:45 -0700, Daniel Walker wrote:
> > I'd like to know, why we need to move that and you did not explain _why_
> > it is likely that it is used during bootup.
> 
> If the clocksources are registered at the same time as the clocksource
> users then you end up with users frequently switching clocks during boot
> up. The original clocksource code solved this by not allowing a real
> clocksource lookup until after the system fully booted.

No, that was not the reason. It does not hurt anything, when the
clocksource changes during bootup. You simply replace one read out
device by another one.

The reason was that we wanted to select clocksources as late as
possible, as we wanted to have late init clocksources ready and TSC
problems outruled.

> However, if you put all the clocksources into postcore initcall, with
> that being known in advance, and all the users are in lower priority
> initcalls then you don't need extra code to prevent churn during bootup.
> 
> The reason that I think this will get used during boot up is because
> some of the target users will be instrumentation, and (my prediction
> anyway) is that some will need to use the interface early. Still even
> postcore may not be early enough.

Early bootup Instrumentation is really not a good argument to make that
fragile time related stuff even more complex. There is no problem to
register reliable clocksources in early bootup, but do not make this
mandatory. Not every system is an ARM SoC, where you can and must rely
on the one source which is available usually right when the CPU comes
up.

Early bootup instrumentation can very well go with none or coarse
grained time information, if there is a need to have early boot
intstrumentation at all.

	tglx


