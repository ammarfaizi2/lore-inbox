Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262700AbVDHG0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbVDHG0z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 02:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbVDHG0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 02:26:55 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:231 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262700AbVDHG0w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 02:26:52 -0400
Date: Thu, 7 Apr 2005 23:25:38 -0700
From: Tony Lindgren <tony@atomide.com>
To: Frank Sorenson <frank@tuxrocks.com>
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Dynamic Tick version 050406-1
Message-ID: <20050408062537.GB4477@atomide.com>
References: <20050406083000.GA8658@atomide.com> <425451A0.7020000@tuxrocks.com> <20050407082136.GF13475@atomide.com> <4255A7AF.8050802@tuxrocks.com> <4255B247.4080906@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4255B247.4080906@tuxrocks.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Frank Sorenson <frank@tuxrocks.com> [050407 15:21]:
> Frank Sorenson wrote:
> > Tony Lindgren wrote:
> > 
> >>Thanks for trying it out. What kind of hardware do you have? Does it
> >>have HPET? It looks like no suitable timer for dyn-tick is found...
> >>Maybe the following patch helps?
> >>
> >>Tony
> > 
> > 
> > Does 'different crash' qualify as "helping"?  :)
> 
> Update:
> The patch does seem to fix the crash.  This "different crash" I
> mentioned appears to be related to the netconsole I was using (serial
> console produces stairstepping text, netconsole seems to duplicate
> lines--go figure).  Without netconsole, dynamic tick appears to be
> working, so I'm not sure whether this is a netconsole bug or a dynamic
> tick bug.

This might be because time does not run correctly, see below.

> While dynamic tick no longer panics, with dynamic tick, my system slows
> to whatever is slower than a crawl.  It now takes 6 minutes 50 seconds
> to boot all the way up, compared to 1 minute 35 seconds with my 2.6.12
> kernel without the dynamic tick patch.  I'm not sure where this slowdown
> is occurring yet.

I think I have an idea on what's going on; Your system does not wake to
APIC interrupt, and the system timer updates time only on other interrupts.
I'm experiencing the same on a loaner ThinkPad T30.

I'll try to do another patch today. Meanwhile it now should work
without lapic in cmdline.

Tony

