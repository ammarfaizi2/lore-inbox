Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVAMMEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVAMMEx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 07:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVAMMEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 07:04:53 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:35716 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S261602AbVAMMEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 07:04:51 -0500
Subject: Re: PCI lost interrupts and PLX chips
From: Dimitris Lampridis <soth@softhome.net>
To: linux-os@analogic.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0501130647420.10398@chaos.analogic.com>
References: <1105573129.3218.11.camel@localhost>
	 <Pine.LNX.4.61.0501130647420.10398@chaos.analogic.com>
Message-Id: <1105617881.3203.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 13 Jan 2005 14:04:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-13 at 13:49, linux-os wrote:
> On Thu, 13 Jan 2005, Dimitris Lampridis wrote:
> 
> > Hi everybody,
> > I noticed a conversation some days ago that also mentioned something
> > about PLX chips and a certain problem resulting in loss of interrupt
> > signals.
> >
> > I'm writing a driver for a PCI-based device (an embedded USB Host
> > Controller) and it uses a PLX bridge (device ID 5406). Although I've set
> > up the device correctly and a logical analyzer shows the interrupts
> > being generated on the USB HC chip, nothing comes past the bridge, thus
> > nothing reaches the system. I use a typical pci_enable_device() followed
> > but some request_region() and of course request_irq() on a kernel
> > 2.6.10-rc3 (i386 system, VIA KT133, no APIC...)
> > Does this have something to do with the discussion about PLX chips
> > mentioned above? If it does, can anybody make clear what I have to do to
> > see those interrupts coming?
> >
> > You can find the mail in question at:
> > http://seclists.org/lists/linux-kernel/2005/Jan/0792.html
> >
> > Thanks,
> > Dimitris
> 
> Make sure you execute pci_enable_device() __before__ you believe
> the IRQ number in the structure.

I was doing that all the time. I'm calling pci_enable_device(pdev), then
reading pdev->irq, then calling request_irq(pdev->irq,...). But I don't
get interrupts. Is it possible for the compiler to rearrange the order
of execution? 
I was talking about that strange phenonomenon you were saying with PLX
and interrupts going mad when initializing the device, ie the trick with
enable->disable->do whatever(this is where I need help if it applies to
me)->reenable. 

Thanks,
Dimitris

