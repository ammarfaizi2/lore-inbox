Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVBHMap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVBHMap (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 07:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVBHM3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 07:29:34 -0500
Received: from alog0076.analogic.com ([208.224.220.91]:48256 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261526AbVBHM1w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 07:27:52 -0500
Date: Tue, 8 Feb 2005 07:25:50 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: bjorn.helgaas@hp.com
cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [SERIAL] add TP560 data/fax/modem support
In-Reply-To: <1107809856.8074.50.camel@piglet>
Message-ID: <Pine.LNX.4.61.0502080710230.27765@chaos.analogic.com>
References: <1107805182.8074.35.camel@piglet>  <Pine.LNX.4.61.0502071508130.24378@chaos.analogic.com>
 <1107809856.8074.50.camel@piglet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2005, Bjorn Helgaas wrote:

> On Mon, 2005-02-07 at 15:12 -0500, linux-os wrote:
>> I thought somebody promised to add a pci_route_irq(dev) or some
>> such so that the device didn't have to be enabled before
>> the IRQ was correct.
>>
>> I first reported this bad IRQ problem back in December of 2004.
>> Has the new function been added?
>
> That's a completely different problem.  The point here is that
> the serial driver currently doesn't do anything with the TP560
> (no pci_enable_device(), no pci_route_irq(), no nothing).  Then
> when setserial comes along and force-feeds the driver with the
> IO and IRQ info, there's nothing at that point that does anything
> to enable the device or route its interrupt either.
>
> I did raise the idea of adding a pci_route_irq() interface, but
> to be honest, I was never convinced of its general usefulness.

There  have been two PCI drivers in the past three days where
users have reported that the IRQ was wrong. One patch was
provided to enable the device before requesting the IRQ, this
being inherently dangerous. So, if you are the one who
re-wrote the PCI stuff so that the IRQ is wrong when the
device is claimed, then I think you have a duty to fix the
code that you have broken.

The correct way to fix the broken code is to make sure that
the IRQ, reported in the structure, is correct. Alternate
methods might be a pci_route_irq() function.

The existing PCI code is broken. The fact that an invalid
IRQ is reported in the structure is PROOF that it is broken
and requires no further discussion. Many of us have to
use this stuff in a professional environment, we can't
enable devices without an interrupt handler in place
because it is not allowed in code that is subject to
peer review. We also can't use code when such problems
as invalid values in returned data are discovered.

Two months ago I discovered this problem and reported it, hoping
that the person who broke existing code would fix it. It has
not been fixed.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
