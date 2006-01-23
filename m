Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWAWUKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWAWUKt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWAWUKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:10:49 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:2008 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964917AbWAWUKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:10:48 -0500
Subject: Re: [PATCHSET] Time: Generic Timeofday Subsystem (v B17)
From: john stultz <johnstul@us.ibm.com>
To: Paul Mundt <lethal@linux-sh.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Roman Zippel <zippel@linux-m68k.org>,
       George Anzinger <george@mvista.com>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060122233938.GA31392@linux-sh.org>
References: <1137801626.27699.279.camel@cog.beaverton.ibm.com>
	 <20060122233938.GA31392@linux-sh.org>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 12:10:36 -0800
Message-Id: <1138047036.15682.10.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-23 at 01:39 +0200, Paul Mundt wrote:
> On Fri, Jan 20, 2006 at 04:00:26PM -0800, john stultz wrote:
> > The patchset applies against the current 2.6.16-rc1-git.
> > 
> > The complete patchset can be found here:
> > 	http://sr71.net/~jstultz/tod/
> > 
> > As always, feedback, suggestions and bug-reports are always appreciated.
> > 
> Patches weren't explicitly mentioned, but I'm assuming they're also
> welcome ;-)
> 
> At first glance the register/unregister interface is a bit
> unconventional, but I have a few trivial patches to get those fixed up,
> which I'll send to you separately.

Very Cool!

> It looks like struct clocksource will also need suspend/resume ops,
> since it's defining its own sysclass (so there's no overlap with the
> timer sysclass that several other architectures setup to deal with this).
> I haven't done that yet, but if there's interest, I'll hack something up.

Hmmm. While we do have suspend and resume functions for the timekeeping
core, I'm not sure if suspend and resume are necessary for each struct
clocksource since state changes are only allowed inside the callback
hook.  That probably should be better documented. :)

Some specific hardware that might provide a clocksource interface may
need suspend/resume hooks (like the PIT, for example), but in my mind
that would be done independently from the clocksource code.

But maybe I'm not quite grasping what you're suggesting, so feel free to
clarify with maybe an example of its use and I'll re-think it.

Thanks for the code review and patches! I really appreciate it!
-john

