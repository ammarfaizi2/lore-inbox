Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWIVU3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWIVU3v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 16:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWIVU3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 16:29:51 -0400
Received: from gw1a.telemetry-investments.com ([64.20.161.180]:9885 "EHLO
	sv2.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S964892AbWIVU3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 16:29:50 -0400
Date: Fri, 22 Sep 2006 16:29:40 -0400
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: hires timer patchset [was Re: 2.6.19 -mm merge plans]
Message-ID: <20060922202940.GF14984@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Ingo Molnar <mingo@elte.hu>, Pavel Machek <pavel@suse.cz>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <johnstul@us.ibm.com>,
	Arjan van de Ven <arjan@infradead.org>
References: <20060920135438.d7dd362b.akpm@osdl.org> <20060921131433.GA4182@elte.hu> <20060922130648.GD4055@ucw.cz> <20060922190106.GA32638@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922190106.GA32638@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 09:01:06PM +0200, Ingo Molnar wrote:
> 
> * Pavel Machek <pavel@suse.cz> wrote:
> 
> > > would be nice to merge the -hrt queue that goes right ontop this 
> > > queue. Even if HIGH_RES_TIMERS is "default n" in the beginning. That 
> > > gives us high-res timers and dynticks which are both very important 
> > > features to certain classes of users/devices.
> > 
> > dynticks give benefit of 0.3W, or 20minutes (IIRC) from 8hours on 
> > thinkpad x60... and they were around for way too long. (When baseline 
> > is hz=250, it is 0.5W from hz=1000 baseline). It would be cool to 
> > finally merge them.
> 
> note that this is a new implementation of dynticks though, not Con's 
> older stuff which you probably used, right? But it's fairly low-impact 
> (just a few lines ontop of hrtimers, here and there), ontop of the 
> long-existing -hrt queue.

Just a data point, FWIW; I've made no systematic effort to find regressions.

We've been running Thomas's (pre-dynticks) 2.6.16-hrt patchset (and
HZ=1000) without issue as part of my standard kernel build on x86 and
x86_64 UP/SMP production hosts -- workstations, PostgreSQL (and other)
servers, and routers --- since I experienced latency/ntp problems with
an unpatched kernel using sata_nv on Tyan 2895 Nvidia CK804-chipset mobo
back in March 2006.  I've also been running the (originally x86-only)
2.6.17-dynticks patch on a Tyan Athlon SMP workstation mobo, and occasionally
on my laptop, so far without issue.

I originally chose Thomas's -hrt variant of John Stultz's timekeeping
patchset because it had known-working x86_64 support ...

We're not doing anything exotic (such as audio, packet capture,
or serving thousands of connections) that might stress the timer or
clock system much, but the x86 routers have GigE traffic and the
x86_64 PostgreSQL servers are often heavily loaded.

Regards,

	Bill Rugolsky
