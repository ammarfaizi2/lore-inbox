Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVASRk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVASRk1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 12:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVASRjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 12:39:15 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:64436 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261805AbVASRib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:38:31 -0500
Date: Wed, 19 Jan 2005 09:37:10 -0800
From: Tony Lindgren <tony@atomide.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Stephen Frost <sfrost@snowman.net>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       George Anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119173710.GD14545@atomide.com>
References: <20050119141115.GI10437@ns.snowman.net> <OFDC470564.D4624EB3-ON41256F8E.00512848-41256F8E.005428CC@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFDC470564.D4624EB3-ON41256F8E.00512848-41256F8E.005428CC@de.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Schwidefsky <schwidefsky@de.ibm.com> [050119 07:19]:
> 
> 
> 
> 
> Stephen Frost <sfrost@snowman.net> wrote on 19/01/2005 03:11:15 PM:
> 
> > > Hrm... reading more of the patch & Martin's previous work, I'm not sure
> > > I like the idea too much in the end... The main problem is that you are
> > > just "replaying" the ticks afterward, which I see as a problem for
> > > things like sched_clock() which returns the real current time, no ?
> > >
> > > I'll toy a bit with my own implementation directly using Martin's work
> > > and see what kind of improvement I really get on ppc laptops.
> >
> > I don't know if this is the same thing, or the same issue, but I've
> > noticed on my Windows machines that the longer my laptop sleeps the
> > longer it takes for it to wake back up- my guess is that it's doing
> > exactly this (replaying ticks).  It *really* sucks though because it can
> > take quite a while for it to come back if it's been asleep for a while.
> 
> That is the while loop that calls do_timer for each missed timer tick.
> In my very first try in regard to a tick less system it tried to avoid
> the loop with a new interface that allowed to account several ticks
> (the posting on lkml and the patch can still be found in the archives,
>  e.g. http://marc.theaimsgroup.com/?l=linux-kernel&m=98683292412129&w=2)
> We could try to revive the idea and add a #ticks parameter to do_timer(),
> update_process_times and friends. The main obstacle has been ntp with
> its time adjustments. There is another patch from John Stultz that
> introduces new time-of-day code, this would take care of the ntp problem
> (see http://marc.theaimsgroup.com/?l=linux-kernel&m=110247121329835&w=2).

Being able to skip multiple ticks would save some overhead with catching
up with the time after idle in this case.

Also John's patch for using nsecs looks very interesting. On ARM,
new sys_timer code should make the John's patch a bit easier to use.

Regards,

Tony
