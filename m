Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbVCLRM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbVCLRM0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 12:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVCLRMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 12:12:23 -0500
Received: from 70-56-134-246.albq.qwest.net ([70.56.134.246]:41609 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261983AbVCLRKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 12:10:02 -0500
Date: Sat, 12 Mar 2005 10:11:18 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
cc: Peter Chubb <peterc@gelato.unsw.edu.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
In-Reply-To: <9e473391050312075548fb0f29@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0503121009130.2166@montezuma.fsmlabs.com>
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
 <9e473391050312075548fb0f29@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Mar 2005, Jon Smirl wrote:

> On Fri, 11 Mar 2005 14:36:10 +1100, Peter Chubb
> <peterc@gelato.unsw.edu.au> wrote:
> > 
> > As many of you will be aware, we've been working on infrastructure for
> > user-mode PCI and other drivers.  The first step is to be able to
> > handle interrupts from user space. Subsequent patches add
> > infrastructure for setting up DMA for PCI devices.
> 
> I've tried implementing this before and could not get around the
> interrupt problem. Most interrupts on the x86 architecture are shared.
> Disabling the IRQ at the PIC blocks all of the shared IRQs. This works
> (hope your userspace handler is last on the shared handler list) until
> you have a problem in userspace.
> 
> Once you have a problem in userspace there is no way to acknowledge
> the interrupt anymore. I tried to address that by maintaining a timer
> and suspending the hardware through the D0 state to reset it. That had
> some success. Not acknowledging the interrupt results in an interrupt
> loop and reboot.
> 
> The problem can be mitigated by choosing what slot your hardware to
> put your hardware in. This can reduce the number of shared interrupts.
> If you can get exclusive use of the interrupt this method will work.
> 
> If I were designing a new bus I would make interrupt acknowledge part
> of PCI config space in order to allow a single piece of code to
> acknowledge them. Since we can't change the bus the only safe way to
> do this is to build a hardware specific driver for each device to
> acknowledge the interrupt.
> 
> Bottom line is that I could find no reliable solution for handing 
> interrupts.

Alan's proposal sounds very plausible and additionally if we find that 
we have an irq line screaming we could use the same supplied information 
to disable userspace interrupt handled devices first.

	Zwane

