Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbVATIG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVATIG3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 03:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbVATIG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 03:06:28 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:3495 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262071AbVATIGX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 03:06:23 -0500
Date: Thu, 20 Jan 2005 00:04:41 -0800
From: Tony Lindgren <tony@atomide.com>
To: George Anzinger <george@mvista.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Pavel Machek <pavel@suse.cz>,
       john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050120080441.GF9975@atomide.com>
References: <20050119000556.GB14749@atomide.com> <20050119094342.GB25623@elf.ucw.cz> <20050119171323.GB14545@atomide.com> <20050119174858.GB12647@dualathlon.random> <41EEE648.2010309@mvista.com> <20050119231702.GJ14545@atomide.com> <41EEFA4A.4070605@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EEFA4A.4070605@mvista.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* George Anzinger <george@mvista.com> [050119 16:25]:
> Tony Lindgren wrote:
> >* George Anzinger <george@mvista.com> [050119 15:00]:
> >
> >>I don't think you will ever get good time if you EVER reprogramm the PIT. 
> >>That is why the VST patch on sourceforge does NOT touch the PIT, it only 
> >>turns off the interrupt by interrupting the interrupt path (not changing 
> >>the PIT).  This allows the PIT to be the "gold standard" in time that it 
> >>is designed to be.  The wake up interrupt, then needs to come from an 
> >>independent timer.  My patch requires a local APIC for this.  Patch is 
> >>available at http://sourceforge.net/projects/high-res-timers/
> >
> >
> >Well on my test systems I have pretty good accurate time. But I agree,
> >PIT is not the best option for interrupt. It should be possible to use
> >other interrupt sources as well.
> >
> >It should not matter where the timer interrupt comes from, as long as 
> >it comes when programmed. Updating time should be separate from timer
> >interrupts. Currently we have a problem where time is tied to the
> >timer interrupt.
> 
> In the HRT code time is most correctly stated as wall_time + 
> get_arch_cycles_since(wall_jiffies) (plus conversion or two:)).  This is 
> some what removed from the tick interrupt, but is resynced to that 
> interrupt more or less each interrupt.

That sounds very accurate :)

> A second issue is trying to get the jiffies update as close to the run of 
> the timer list as possible.  Without this we have no hope of high res 
> timers.

OK. But if the timer interrupt is separated from updating the time,
the next timer interrupt should be programmable to happen exactly
when a HRT timer needs it, right?

Hmm, how about using a pool of programmable timers available on the 
system for the timer interrupts and HRT? Or is one interrupt source
always enough?

Tony
