Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264183AbUHAAqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbUHAAqw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 20:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbUHAAqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 20:46:51 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48309 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264183AbUHAAq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 20:46:26 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2 PS2 keyboard gone south
From: Lee Revell <rlrevell@joe-job.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Shane Shrybman <shrybman@aei.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1091320571.2445.6.camel@teapot.felipe-alfaro.com>
References: <1091196403.2401.10.camel@mars> <20040730152040.GA13030@elte.hu>
	 <1091209106.2356.3.camel@mars>
	 <1091229695.2410.1.camel@teapot.felipe-alfaro.com>
	 <1091232345.1677.20.camel@mindpipe>  <1091246064.2389.9.camel@mars>
	 <1091246621.1677.71.camel@mindpipe>
	 <1091267282.1768.8.camel@teapot.felipe-alfaro.com>
	 <1091296615.1677.283.camel@mindpipe>
	 <1091320571.2445.6.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Message-Id: <1091321213.20819.85.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 31 Jul 2004 20:46:53 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-31 at 20:36, Felipe Alfaro Solana wrote:
> On Sat, 2004-07-31 at 13:56 -0400, Lee Revell wrote:
> > On Sat, 2004-07-31 at 05:48, Felipe Alfaro Solana wrote:
> > > On Sat, 2004-07-31 at 00:03 -0400, Lee Revell wrote:
> > > > Shane & Felipe,
> > > > 
> > > > I am removing LKML and Ingo from the cc: list so we can compare
> > > > hardware, as I definitely am not seeing this problem.  Maybe we can
> > > > track it down to a difference there.  What hardware are you guys using?
> > 
> > > I'm running 2.6.8-rc2-bk9 plus a bunch of other patches, like Con's
> > > Staircase Scheduler and Ingo's voluntary-preempt (of course). Kernel is
> > > compiled with ACPI + APIC.
> > 
> > Hmm.  Maybe it's an ACPI/APIC problem?  I do not have these enabled.  It
> > could also be an interaction between some other patch you have.
> > 
> > Have you tried with 2.6.8-rc2-M5, without the other patches?  Booting
> > with acpi=off?
> 
> OK, OK :-) I've been running 2.6.8-rc2-mm1-M5 with ACPI but without APIC
> for more than ten minutes), compiling kernels, sending mails with
> Evolution and it hasn't locked up yet. Crossfingers. Should we report
> this to Ingo and Andrew?
> 
> Anyways, I'll keep on running this puppy to see if this behavior is
> consistent.
> 
> # grep . /proc/irq/*/*/threaded
> /proc/irq/11/eth0/threaded:1
> /proc/irq/12/Intel 82801BA-ICH2/threaded:1
> /proc/irq/14/ide0/threaded:1
> /proc/irq/15/ide1/threaded:1
> /proc/irq/1/i8042/threaded:1
> /proc/irq/5/uhci_hcd/threaded:1
> /proc/irq/8/rtc/threaded:1
> /proc/irq/9/acpi/threaded:1
> /proc/irq/9/uhci_hcd/threaded:!
> 
> # grep . /proc/sys/kernel/*_preemption
> /proc/sys/kernel/voluntary_preemption:3
> /proc/sys/kernel/preemption:1

The next thing I was going to suggest was the software RAID.  You appear
to have a RAID 0 or 1 with one disk on irq14 and one on irq15.  I am not
sure how interrupts are handled by Linux IDE RAID, but it seems like
this would be tricky.  I bet the threading is screwing up the
synchronization between the devices, and you end up with one waiting
forever for the other - the possibilities for lockup are endless.

However, I have no idea what you would do about this.  You could try
making those irqs non-threaded, but you'd have to do it one at a time,
and I would *definitely* expect weird stuff with one threaded and one
not.

I will have to defer to someone with more kernel expertise.

Lee

