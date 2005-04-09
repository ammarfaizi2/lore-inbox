Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVDIIKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVDIIKT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 04:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVDIIKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 04:10:19 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:52131 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261310AbVDIIKM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 04:10:12 -0400
Date: Sat, 9 Apr 2005 01:09:19 -0700
To: Frank Sorenson <frank@tuxrocks.com>
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Updated: Dynamic Tick version 050408-1
Message-ID: <20050409080919.GA29867@atomide.com>
References: <20050406083000.GA8658@atomide.com> <425451A0.7020000@tuxrocks.com> <20050407082136.GF13475@atomide.com> <4255A7AF.8050802@tuxrocks.com> <4255B247.4080906@tuxrocks.com> <20050408062537.GB4477@atomide.com> <20050408075001.GC4477@atomide.com> <42564584.4080606@tuxrocks.com> <20050408091757.GD4477@atomide.com> <4256FAE3.30500@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4256FAE3.30500@tuxrocks.com>
User-Agent: Mutt/1.5.6+20040907i
From: Tony Lindgren <tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 03:42:59PM -0600, Frank Sorenson wrote:
> Tony Lindgren wrote:
> > 
> > Then you might as well run timetest from same location too to make
> > sure your clock keeps correct time.
> 
> Seems to be going up when under load, and down when idle, so I suppose
> it's working :)  The clock is only a little jittery, but not more than
> I'd expect across the network, so it looks like it's keeping time okay.

Good.

> Would it be possible to determine whether the system will wake to the
> APIC interrupt at system boot, rather than hardcoded in the config?
> After you explained the problem, I noticed that creating my own
> interrupts (holding down a key on the keyboard for example) kept the
> system moving and not slow.  For example, something like this (sorry, I
> don't know the code well enough yet to attempt to code it myself):
> 
> set the APIC timer to fire in X
> set another timer/interrupt to fire in 2X
> wait for the interrupt
> if (time_elapsed >= 2X) disable the APIC timer
> else APIC timer should work
> 
> Or, determine which timer woke us up, etc.

Yeah, I was thinking that too. But maybe there's some way of stopping
PIT interrupts while keeping APIC timer interrupts running on all chips.
It seems to work OK on my P3 boxes, but seems to fail on newer machines.

BTW, stopping PIT interrupts (like the HRT VST patch does) seems to
kill APIC timer interrupts too, the same way as reprogamming PIT does.
Or maybe there's something else that needs to be done to get APIC
interrupts going after PIT interrupts are disabled.

Tony
