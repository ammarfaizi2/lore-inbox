Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVCaQsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVCaQsg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 11:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVCaQsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 11:48:35 -0500
Received: from ida.rowland.org ([192.131.102.52]:14340 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261565AbVCaQsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 11:48:15 -0500
Date: Thu, 31 Mar 2005 11:48:11 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: kus Kusche Klaus <kus@keba.com>
cc: linux-usb-users@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.11, USB: High latency?
In-Reply-To: <AAD6DA242BC63C488511C611BD51F3673231CF@MAILIT.keba.co.at>
Message-ID: <Pine.LNX.4.44L0.0503311138260.1510-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2005, kus Kusche Klaus wrote:

> > The latencies are almost certainly caused by the USB host controller 
> > driver.  I'm planning improvements to uhci-hcd which should 
> > help reduce 
> > the latency, but it will still be on the large side.  And I 
> > won't have 
> > time to write the changes to the driver for several months.
> 
> Any numbers about the expected "large side"? 
> We would need <30 microseconds irq latency,
> and <<1 milliseconds rt application latency.

It's pretty hard to say, considering that: (1) None of the code has been 
written yet; (2) It's impossible to say how big a difference new code will 
make just by reading it -- you have to actually test it; and (3) I don't 
have any hardware suitable for testing latencies.

The biggest advantage would come from using a bottom-half handler to do 
most of the work.  Right now the uhci-hcd driver does everything in its 
interrupt handler.  This would certainly help IRQ latency; it might not 
affect application latency very much.

I'll try adding a bottom half in my next series of patches.  Maybe it will 
be ready in time to appear in the -mm kernels before 2.6.12-final is 
released.

> > The best solution is to stop using uhci-hcd.  Get a PCI card 
> > with an OHCI 
> > or EHCI (high-speed) controller.  They do much more work in hardware, 
> > reducing the amount of time the driver needs to spend with interrupts 
> > disabled.
> 
> The hardware is invariable. It is an embedded system with no PCI slots.
> 
> And it seems to be possible with UHCI, 
> because vxWorks allows USB stick transfers in operation without
> missing latency requirements.
> 
> I do not require rt on the USB, it may block its own irq as long as
> it likes, but it should not affect other irqs.

We'll see what happens with the upcoming changes.  Maybe you'll be able to 
test them for me?

Alan Stern

