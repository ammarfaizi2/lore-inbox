Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267626AbUBTHA1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 02:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267410AbUBTHA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 02:00:27 -0500
Received: from mail.kroah.org ([65.200.24.183]:49328 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267626AbUBTHAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 02:00:21 -0500
Date: Thu, 19 Feb 2004 23:00:14 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] USB update for 2.6.3
Message-ID: <20040220070012.GA8121@kroah.com>
References: <20040220012802.GA16523@kroah.com> <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org> <1077256996.20789.1091.camel@gaston> <Pine.LNX.4.58.0402192221560.2244@ppc970.osdl.org> <1077258504.20781.1121.camel@gaston> <Pine.LNX.4.58.0402192243170.14296@ppc970.osdl.org> <1077259375.20787.1141.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077259375.20787.1141.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 05:42:56PM +1100, Benjamin Herrenschmidt wrote:
> 
> > Well, we do. The pcibios_xxx routines get called for all PCI devices 
> > during discovery, and that's when you'd fill them in.
> 
> But what about USB or FireWire devices ? In theory, I'd like to see
> the driver for those not have to bother about beeing hosted by a PCI
> device or whatever else (there are typically non-PCI OHCI USBs on
> embedded platform, faking a pci_dev is becoming painful).

This is the main reason this patch was done.  The arm people were
getting tired or having to do this for their USB controller drivers.
This round of patches (and the previous ones with the dmapool stuff)
removed that dependency.

As for how ARM deals with their devices on non-pci busses, I really do
not know, I never looked into that.

But for PPC64 this should not be a problem, as all of the code should
just work the same as it did before because you only have PCI based USB
controllers, right?  Odds are your header files just don't include the
same files so Linus's patch should be all that is needed.

As for the bigger "generic" dma mapping discussions for devices, hasn't
this been hashed out a bunch already?  For some reason I thought
everyone was happy for now with the way things work, and for 2.7 it was
going to be expanded a bit to help support non-pci based busses (much
like the ARM people just did.)

Hm, I wonder if I can convince anyone that I have to have a PPC64 box
now to make sure I don't break the build anytime in the future :)

thanks,

greg k-h
