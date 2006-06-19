Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWFSUX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWFSUX7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWFSUX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:23:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45021 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750856AbWFSUX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:23:58 -0400
Date: Mon, 19 Jun 2006 16:23:54 -0400
From: Dave Jones <davej@redhat.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
Message-ID: <20060619202354.GD26759@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
	linux-kernel@vger.kernel.org
References: <20060619191543.GA17187@rhlx01.fht-esslingen.de> <Pine.LNX.4.61.0606191542050.4926@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0606191542050.4926@chaos.analogic.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 04:00:06PM -0400, linux-os (Dick Johnson) wrote:

 > > arch/i386/kernel/doublefault.c/doublefault_fn():
 > >
 > >        for (;;) /* nothing */;
 > > }
 > >
 > > Let's assume that we have a less than moderate fan failure that causes
 > > the CPU to heat up beyond the critical limit...
 > > That might result in - you guessed it - crashes or doublefaults.
 > > In which case we enter the corresponding handler and do... what?
 > 
 > The double-fault is just a place-holder. The CPU will actually
 > reset without even executing this (try it).

Wrong.

Why do you think we go to the bother of installing a double fault handler if
we're going to reset? Why would we go to the bother of printk'ing
information about the double fault if we're about to reset faster than
it would get to a serial console ?

The box intentionally locks up, so we have a chance to know wtf happened.

 > A CPU without a fan will go into
 > a cold, cold, shutdown, requiring a hardware reset to get it out of
 > that latched, no internal clock running, mode.

Wrong.

 > Try it. I have had
 > broken plastic heat-sink hold-downs let the entire heat-sink fall off
 > the CPU. The machine just stops.

Your single datapoint is just that, a single datapoint.
There are a number of reported cases of CPUs frying themselves.
Here's one: http://www.tomshardware.com/2001/09/17/hot_spot/page4.html
Google no doubt has more.

Another anecdote: Upon fan failure, I once had an athlon MP *completely shatter*
(as in broke in two pieces) under extreme heat.

This _does_ happen.

 > Also, the CPU was only warm to the touch, having been completely shut down for the
 > several minutes it took to locate tools to remove the cover, even
 > though I deliberately left the power ON.

So you got lucky. I've blistered a thumb on hot CPUs before now
after fan failure.

 > In the first place, when the Intel and AMD CPUs overheat, they
 > shut down. 

Reality disagrees with you.

 > For sure, it might be nicer to have some call-and-never-return
 > function for waiting with the rep-nop code, but it isn't necessary
 > for CPU protection.

cpu_relax() and friends aren't going to save a box in light of
a fan failure in my experience.  
However for a box which has locked up (intentionally)
running instructions that do save power in a loop has obvious advantages.

		Dave

-- 
http://www.codemonkey.org.uk
