Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVCOXs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVCOXs6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 18:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVCOXrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 18:47:03 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2990 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262127AbVCOXou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 18:44:50 -0500
Date: Wed, 16 Mar 2005 00:44:25 +0100
From: Pavel Machek <pavel@suse.cz>
To: john stultz <johnstul@us.ibm.com>
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
Subject: Re: [RFC][PATCH] new timeofday arch specific hooks  (v. A3)
Message-ID: <20050315234425.GH21292@elf.ucw.cz>
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com> <1110590710.30498.329.camel@cog.beaverton.ibm.com> <20050315225901.GB21143@elf.ucw.cz> <1110930129.30498.463.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1110930129.30498.463.camel@cog.beaverton.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 15-03-05 15:42:09, john stultz wrote:
> On Tue, 2005-03-15 at 23:59 +0100, Pavel Machek wrote:
> > > diff -Nru a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
> > > --- a/arch/i386/kernel/apm.c	2005-03-11 17:02:30 -08:00
> > > +++ b/arch/i386/kernel/apm.c	2005-03-11 17:02:30 -08:00
> > > @@ -224,6 +224,7 @@
> > >  #include <linux/smp_lock.h>
> > >  #include <linux/dmi.h>
> > >  #include <linux/suspend.h>
> > > +#include <linux/timeofday.h>
> > >  
> > >  #include <asm/system.h>
> > >  #include <asm/uaccess.h>
> > > @@ -1204,6 +1205,7 @@
> > >  	device_suspend(PMSG_SUSPEND);
> > >  	device_power_down(PMSG_SUSPEND);
> > >  
> > > +	timeofday_suspend_hook();
> > >  	/* serialize with the timer interrupt */
> > >  	write_seqlock_irq(&xtime_lock);
> > >  
> > 
> > Could you just register timeofday subsystem as a system device? Then
> > device_power_down will call you automagically..... And you'll not have
> > to modify apm, acpi, swsusp, ppc suspend, arm suspend, ...
> 
> That may very well be the right way to go. At the moment I'm just very
> hesitant of making any user-visible changes.
> 
> What is the impact if a new system device name is created and then I
> later change it? How stable is that interface supposed to be?

Changing its name is okay... your device probably will not have any
user-accessible controls, right?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
