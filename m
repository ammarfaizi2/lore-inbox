Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVASSWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVASSWb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 13:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVASSWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 13:22:31 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:9927 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261821AbVASSWF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 13:22:05 -0500
Date: Wed, 19 Jan 2005 10:19:47 -0800
From: Tony Lindgren <tony@atomide.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119181947.GF14545@atomide.com>
References: <20050119000556.GB14749@atomide.com> <20050119094342.GB25623@elf.ucw.cz> <20050119171323.GB14545@atomide.com> <20050119174858.GB12647@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119174858.GB12647@dualathlon.random>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrea Arcangeli <andrea@suse.de> [050119 09:49]:
> On Wed, Jan 19, 2005 at 09:13:23AM -0800, Tony Lindgren wrote:
> > HZ=100 does not allow improving the idle loop much further
> > from what we have. We should be able to take advantage of the
> > longer idle/sleep periods inbetween the skipped ticks.
> 
> OTOH servers aren't just doing idle power saving, if you're computing
> wasting 1% of your cpu isn't always desiderable.

That's true, this is more for battery operated systems. In the
current patch there's not that much extra calculation going on when
the system is busy, but there is some overhead.

> You'd need to trap into add_timer to make it a truly dynamic timer, only
> then it would obsolete the HZ=100. So if there's no timer you run at
> HZ=100, while if there's some timer pending in the next 10 timer queues
> you run at HZ=1000.

OK, that makes sense.

> The main problem I can see with your patch is the accuracy issue with
> the system time. I couldn't fix the algorithm you're depending on to get
> accurate system time, and I can guarantee such algorithm never worked
> accurately here and worst of all it doesn't printk anything (which is
> why it doesn't printk for your patch), so you only see system time go in
> the future at an excessive rate (minutes per hour IIRC).

Sounds like for some reason it does not work on your computer then.
I've tried it only on four different machines here, with one SMP
box, and it works fine here. And the debug printk works too, and
time is accurate.

If you have a chance, can you please provide me with some more info
on your system, see my recent reply to Pavel in this thread for the
tests I've been using. Sounds like your system won't boot well enough
to carry out the tests though...

> Pavel posted the cli/sti script, that should allow to reproduce the
> inaccuracy of the algorithm. I had to set HZ=100 by hand to workaround
> the usb modem irq latency that is about 3/4 msec.

Great, I'd like to try it out here.

> Once in a while such algorithm overstates the number of ticks that have
> been missed, and so the system time goes 1msec in the future when that
> happens. I still suspect there might be a bug in such code though.
> There's an unfixable window between the latch read and the tsc
> read where an error can happen, but as long as the window is below
> 0.5msec, it should always be possible to regenerate the accurate timing
> with the current algo, but in practice it fails to be accurate...

Sure there's a lot of room for improvment, but it works quite
accurately here.

Tony
