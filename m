Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264702AbUHABO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264702AbUHABO0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 21:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264763AbUHABO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 21:14:26 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:33028 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264702AbUHABOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 21:14:23 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2 PS2 keyboard gone south
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Shane Shrybman <shrybman@aei.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1091321213.20819.85.camel@mindpipe>
References: <1091196403.2401.10.camel@mars> <20040730152040.GA13030@elte.hu>
	 <1091209106.2356.3.camel@mars>
	 <1091229695.2410.1.camel@teapot.felipe-alfaro.com>
	 <1091232345.1677.20.camel@mindpipe>  <1091246064.2389.9.camel@mars>
	 <1091246621.1677.71.camel@mindpipe>
	 <1091267282.1768.8.camel@teapot.felipe-alfaro.com>
	 <1091296615.1677.283.camel@mindpipe>
	 <1091320571.2445.6.camel@teapot.felipe-alfaro.com>
	 <1091321213.20819.85.camel@mindpipe>
Content-Type: text/plain
Date: Sun, 01 Aug 2004 03:14:01 +0200
Message-Id: <1091322842.1860.8.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 (1.5.91-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-31 at 20:46 -0400, Lee Revell wrote:

> > OK, OK :-) I've been running 2.6.8-rc2-mm1-M5 with ACPI but without APIC
> > for more than ten minutes), compiling kernels, sending mails with
> > Evolution and it hasn't locked up yet. Crossfingers. Should we report
> > this to Ingo and Andrew?
> > 
> > Anyways, I'll keep on running this puppy to see if this behavior is
> > consistent.
> > 
> > # grep . /proc/irq/*/*/threaded
> > /proc/irq/11/eth0/threaded:1
> > /proc/irq/12/Intel 82801BA-ICH2/threaded:1
> > /proc/irq/14/ide0/threaded:1
> > /proc/irq/15/ide1/threaded:1
> > /proc/irq/1/i8042/threaded:1
> > /proc/irq/5/uhci_hcd/threaded:1
> > /proc/irq/8/rtc/threaded:1
> > /proc/irq/9/acpi/threaded:1
> > /proc/irq/9/uhci_hcd/threaded:!
> > 
> > # grep . /proc/sys/kernel/*_preemption
> > /proc/sys/kernel/voluntary_preemption:3
> > /proc/sys/kernel/preemption:1
> 
> The next thing I was going to suggest was the software RAID.  You appear
> to have a RAID 0 or 1 with one disk on irq14 and one on irq15.  I am not
> sure how interrupts are handled by Linux IDE RAID, but it seems like
> this would be tricky.  I bet the threading is screwing up the
> synchronization between the devices, and you end up with one waiting
> forever for the other - the possibilities for lockup are endless.

No, I'm not using any kind of RAID (eiher HW or SW) at all. Simply, two
identical, independent 120GB drives that only have one thing in common:
they are attached to the same IDE channel (the primary IDE channel). The
CD/RW and DVD are attached to the secondary IDE channel.

