Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267818AbUG3Tqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267818AbUG3Tqj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 15:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267813AbUG3Tpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 15:45:50 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:6528 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S267807AbUG3Tpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 15:45:40 -0400
Date: Fri, 30 Jul 2004 21:47:04 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Matthew Wilcox <willy@debian.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Exposing ROM's though sysfs
Message-ID: <20040730194704.GA405@ucw.cz>
References: <20040730190456.GZ10025@parcelfarce.linux.theplanet.co.uk> <20040730193011.5239.qmail@web14929.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730193011.5239.qmail@web14929.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 12:30:11PM -0700, Jon Smirl wrote:
> --- Matthew Wilcox <willy@debian.org> wrote:
> 
> > My problem is with this is the following passage from PCI 2.2 and PCI
> > 2.3:
> > 
> >   In order to minimize the number of address decoders needed, a
> > device
> >   may share a decoder between the Expansion ROM Base Address register
> > and
> >   other Base Address registers.  When expansion ROM decode is
> > enabled, ...
> >
> > On Fri, Jul 30, 2004 at 11:59:21AM -0700, Jon Smirl wrote:
> > > Alan Cox knows more about this, but I believe there is only one PCI
> > > card in existence that does this.
> > 
> > Strange; he was the one who pointed out this requirement to me in the
> > first place and he hinted that many devices did this.
> 
> Alan, what's the answer here?
> 
> > Shutting off interrupts isn't nearly enough.  Any other CPU could
> > access the device, or indeed any device capable of DMA could
> 
> Another idea, it's ok to read the ROM when there is no device driver
> loaded. When the driver for one of these card loads it could trigger a
> copy of the ROM into RAM and cache it in a PCI structure.

I think this is a good idea.

It could either be done as a part of pci_enable_device(), or, which I
believe would be better, as a separate function, say
pci_copy_rom(char *dest), that the driver would call before
pci_enable_device().

Of course, in this case the ROM wouldn't be automatically exported
through sysfs, although the driver should be able to export it itself
rather easily.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
