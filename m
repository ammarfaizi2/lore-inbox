Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbVCOXpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVCOXpg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 18:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVCOXpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 18:45:31 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:31616 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262148AbVCOXmR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 18:42:17 -0500
Subject: Re: [RFC][PATCH] new timeofday arch specific hooks  (v. A3)
From: john stultz <johnstul@us.ibm.com>
To: Pavel Machek <pavel@suse.cz>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com
In-Reply-To: <20050315225901.GB21143@elf.ucw.cz>
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com>
	 <1110590710.30498.329.camel@cog.beaverton.ibm.com>
	 <20050315225901.GB21143@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 15:42:09 -0800
Message-Id: <1110930129.30498.463.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-15 at 23:59 +0100, Pavel Machek wrote:
> > diff -Nru a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
> > --- a/arch/i386/kernel/apm.c	2005-03-11 17:02:30 -08:00
> > +++ b/arch/i386/kernel/apm.c	2005-03-11 17:02:30 -08:00
> > @@ -224,6 +224,7 @@
> >  #include <linux/smp_lock.h>
> >  #include <linux/dmi.h>
> >  #include <linux/suspend.h>
> > +#include <linux/timeofday.h>
> >  
> >  #include <asm/system.h>
> >  #include <asm/uaccess.h>
> > @@ -1204,6 +1205,7 @@
> >  	device_suspend(PMSG_SUSPEND);
> >  	device_power_down(PMSG_SUSPEND);
> >  
> > +	timeofday_suspend_hook();
> >  	/* serialize with the timer interrupt */
> >  	write_seqlock_irq(&xtime_lock);
> >  
> 
> Could you just register timeofday subsystem as a system device? Then
> device_power_down will call you automagically..... And you'll not have
> to modify apm, acpi, swsusp, ppc suspend, arm suspend, ...

That may very well be the right way to go. At the moment I'm just very
hesitant of making any user-visible changes.

What is the impact if a new system device name is created and then I
later change it? How stable is that interface supposed to be?

thanks
-john

