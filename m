Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVBGU5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVBGU5w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 15:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVBGU5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 15:57:52 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:30458 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261268AbVBGU5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 15:57:48 -0500
Subject: Re: [PATCH] [SERIAL] add TP560 data/fax/modem support
From: Bjorn Helgaas <bjorn-helgaas@comcast.net>
Reply-To: bjorn.helgaas@hp.com
To: linux-os@analogic.com
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0502071508130.24378@chaos.analogic.com>
References: <1107805182.8074.35.camel@piglet>
	 <Pine.LNX.4.61.0502071508130.24378@chaos.analogic.com>
Content-Type: text/plain
Date: Mon, 07 Feb 2005 13:57:35 -0700
Message-Id: <1107809856.8074.50.camel@piglet>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-07 at 15:12 -0500, linux-os wrote:
> I thought somebody promised to add a pci_route_irq(dev) or some
> such so that the device didn't have to be enabled before
> the IRQ was correct.
>
> I first reported this bad IRQ problem back in December of 2004.
> Has the new function been added?

That's a completely different problem.  The point here is that
the serial driver currently doesn't do anything with the TP560
(no pci_enable_device(), no pci_route_irq(), no nothing).  Then
when setserial comes along and force-feeds the driver with the
IO and IRQ info, there's nothing at that point that does anything
to enable the device or route its interrupt either.

I did raise the idea of adding a pci_route_irq() interface, but
to be honest, I was never convinced of its general usefulness.
I haven't heard of any driver in the tree that requires it,
so it's not clear that it would be accepted even if I (or you)
wrote it.

I think you mentioned a specific PCI interface chip that was
susceptible to the problem; is there a public reference that
would help explicate the situation?

