Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbUCSAAm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 19:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263372AbUCRX6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:58:03 -0500
Received: from rrcs-central-24-123-144-118.biz.rr.com ([24.123.144.118]:32338
	"EHLO zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S263334AbUCRXz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:55:27 -0500
Subject: Re: CONFIG_PREEMPT and server workloads
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, mjy@geizhals.at,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040318153731.GG2246@dualathlon.random>
References: <40591EC1.1060204@geizhals.at>
	 <20040318060358.GC29530@dualathlon.random>
	 <20040318015004.227fddfb.akpm@osdl.org>
	 <1079623222.4167.52.camel@localhost.localdomain>
	 <20040318153731.GG2246@dualathlon.random>
Content-Type: text/plain
Message-Id: <1079654070.3758.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 18 Mar 2004 18:54:30 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 10:37, Andrea Arcangeli wrote:
> On Thu, Mar 18, 2004 at 10:20:23AM -0500, Tom Sightler wrote:
> > Well, I reported an issue on my laptop several weeks ago where network
> > activity via my aironet wireless adapter would use 60-70% of the CPU but
> > only when PREEMPT was enabled.  Looking back over the list I see other
> 
> sounds like a preempt bug triggering in a softirq, or maybe an SMP bug
> triggering in UP.
> 
> I certainly agree with Andrew that preempt cannot cause a 60/70%
> slowdown with a network card at least (if you do nothing but spinlocking
> in a loop then it's possible a 60/70% slowdown instead but the system
> time that a wifi card should take is nothing compared to the idle/user
> time).

Actually, I managed to get two bugs mixed together, my system had a
problem with PREEMPT and ACPI but this certainly seems to be fixed in
the current kernels, at least in 2.6.3-mm2 (my current everyday kernel)
and 2.6.5-rc1-mm2 (just a quick test tonight).  Somehow the combination
of PREEMPT and any little applet that used ACPI (battery monitor) would
use a lot of CPU, then using the aironet adapter caused the CPU to
spike.  Turning off either PREEMPT or ACPI would get rid of the
problem.  I forgot about the ACPI part being in the mix.

I still think the aironet driver acts strange, but I'm not really sure
how to describe it.  In 2.6.3-mm2 which I transfer a file top will show
60% of the cpu time in 'irq' whatever that means.  It seems vmstat still
calls this idle.  Perhaps I'm interpreting those numbers wrong.

When I enable preempt on the same system my network performance with the
aironet driver drops tremendously, probably by 75%, and the rest of the
systems seems to crawl.  Somehow without preempt this isn't a problem,
even though it shows 60% of the time in 'irq' the rest of the system
feels responsive.  What would be the proper way to track down this type
of problem?

I'm having more problems with 2.6.5-rc1-mm2 and the aironet card.  It
seems to preform poorly no matter if preempt is on or off.  I'm still
looking into that.  I don't think the drivers has changed significantly
between the two version so I'm hoping I just made a mistake.

Later,
Tom


