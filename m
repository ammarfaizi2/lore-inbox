Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbVKDSrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVKDSrW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 13:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVKDSrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 13:47:21 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:15518 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750827AbVKDSrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 13:47:21 -0500
Date: Fri, 4 Nov 2005 13:47:19 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <gregkh@suse.de>
cc: "David S. Miller" <davem@davemloft.net>, <macro@linux-mips.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: post-2.6.14 USB change breaks sparc64 boot
In-Reply-To: <20051104174951.GA14957@suse.de>
Message-ID: <Pine.LNX.4.44L0.0511041343110.4480-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2005, Greg KH wrote:

> On Fri, Nov 04, 2005 at 09:40:53AM -0800, David S. Miller wrote:
> > From: "Maciej W. Rozycki" <macro@linux-mips.org>
> > Date: Thu, 3 Nov 2005 17:46:20 +0000 (GMT)
> > 
> > > On Thu, 3 Nov 2005, David S. Miller wrote:
> > > 
> > > > Perhaps pci_fixup_final would be a more appropriate time to run this
> > > > USB host controller fixup?  One downside to this is that such calls
> > > > would not be invoked for hot-plugged USB host controller devices.
> > > 
> > >  This might actually want to be split to disable legacy stuff as soon as
> > > possible to prevent a flood of interrupts, sending SMIs and what not else.  
> > > That just requires poking at the PCI config space.  Whatever's the rest
> > > could be done later.  I guess hot-plugged USB host controllers are not
> > > configured for legacy support, so the early bits should not matter for
> > > them.
> > 
> > Would anyone mind if I pushed to Linus the following fix, at
> > least for now?  Thanks.
> 
> No objection from me, if this fixes your machines.

It's okay with me -- I think.  The real requirement is that this code 
needs to run before any devices that share an IRQ with a USB controller 
can have their IRQ handler registered.  That may not always be possible, 
but we should come as close as we can.

Hot-plugged controllers don't matter, because this code only needs to 
handle hardware that the BIOS may have initialized.

Alan Stern

