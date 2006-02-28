Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWB1TfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWB1TfV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWB1TfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:35:21 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:64899 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S932473AbWB1TfS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:35:18 -0500
X-ORBL: [67.117.73.34]
Date: Tue, 28 Feb 2006 11:34:51 -0800
From: Tony Lindgren <tony@atomide.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: akpm@osdl.org, heiko.carstens@de.ibm.com, johnstul@us.ibm.com,
       rmk@arm.linux.org.uk, schwidefsky@de.ibm.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: + fix-next_timer_interrupt-for-hrtimer.patch added to -mm tree
Message-ID: <20060228193450.GD6140@atomide.com>
References: <200602250219.k1P2JLqY018864@shell0.pdx.osdl.net> <1140884243.5237.104.camel@localhost.localdomain> <20060225185731.GA4294@atomide.com> <20060228032900.GE4486@atomide.com> <1141117500.5237.112.camel@localhost.localdomain> <20060228095100.GA31105@atomide.com> <1141121191.5237.130.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141121191.5237.130.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Gleixner <tglx@linutronix.de> [060228 02:05]:
> Tony,
> 
> On Tue, 2006-02-28 at 01:51 -0800, Tony Lindgren wrote:
> > Cool, after a quick test seems to work OK here. Any ideas how to fix the
> > locking problem above?
> > 
> > Maybe one option would be to just reprogram the hardware timer when a
> > new hrtimer is added. That would then allow subjiffie timers too.

Actually to me it looks like the read lock should do just fine on ARM,
as timer_dyn_reprogram() is called from idle loop with interrupts
disabled.
 
> You might have a look into the high resolution timer patches on top of
> hrtimers at http://www.tglx.de/projects/hrtimers

I'll take a look at those once I have some more time...
 
> The clockevents abstraction layer is a quick attempt to generalize the
> problem around event generation. I'm stuck in some other work right now,
> but I'm going to rework this layer soon. IMO John Stultz GTOD patches
> and the generalization of clock events will be a sane base for high
> resolution timers and dynamic ticks.

Yeah. And then we also need to change next_timer_interrupt() return
nanoseconds.

Regards,

Tony
