Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbWJXI3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbWJXI3f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbWJXI3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:29:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:39626 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965109AbWJXI3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:29:34 -0400
Subject: Re: pci_set_power_state() failure and breaking suspend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <453DCB17.6050304@s5r6.in-berlin.de>
References: <1161672898.10524.596.camel@localhost.localdomain>
	 <1161675611.10524.598.camel@localhost.localdomain>
	 <453DCB17.6050304@s5r6.in-berlin.de>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 18:29:17 +1000
Message-Id: <1161678557.10524.602.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Just out of curiosity: Are these HCs actual PCI hardware or are they
> glued onto an extra PCI interface? Does the startup message of ohci1394
> log OHCI 1.1 or 1.0 compliance for them? Probably the latter; OHCI 1.1
> was released in January 2000.

I don't have one at hand right now but I suspect it's 1.1. I'll ask
paulus tomorrow. They are cells inside an Apple ASIC but on a PCI bus
(on-chip PCI bus).

> OHCI 1.1 says "PCI based 1394 Open Host Controllers /should/ implement
> PCI Power Management, and implementations that support PCI Power
> Management /shall/ exhibit behavior consistent with this Annex."
> (Emphasis mine.) I.e. a compliant HC does either not support power
> management at all or supports it including the pci_set_power_state()
> triggered state transitions.

Well, the old Apple ones support power management but not the PCI PM
states. However, there are separate magic bits in the Apple ASIC that
can be used to toggle the clocks on/off (which is that the ppc specific
bits do basically, along as turning off power on the bus).

> OHCI 1.00 does not have a power management specification. It points to
> the PCI Local Bus Specification Revision 2.1 though (which I don't have).
> 
> We are still working on full power management support by ohci1394 and
> upper IEEE 1394 layers, so I am glad to get feedback and patches.

Well, the question is wether we want to make the whole machine suspend
fail because there is a 1394 chip that doesn't do PCI PM in or not...

I can send patches "fixing" it both ways (just ignoring the result from
pci_set_power_state in general, or just ignoring that result on Apple
cells).

Ben.


