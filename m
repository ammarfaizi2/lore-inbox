Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWCHXxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWCHXxO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 18:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbWCHXxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 18:53:14 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:43205 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S932293AbWCHXxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 18:53:14 -0500
Date: Wed, 8 Mar 2006 15:54:04 -0800
From: thockin@hockin.org
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Greg KH <greg@kroah.com>, Tejun Heo <htejun@gmail.com>,
       Jeff Garzik <jeff@garzik.org>, Kumar Gala <galak@kernel.crashing.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: proper way to assign fixed PCI resources to a "hotplug" device
Message-ID: <20060308235404.GA31070@hockin.org>
References: <Pine.LNX.4.44.0603031638050.30957-100000@gate.crashing.org> <4408CEC8.7040507@garzik.org> <20060308020028.GB26028@kroah.com> <440E4203.7040303@gmail.com> <20060308052723.GD29867@kroah.com> <20060308143952.B4851@jurassic.park.msu.ru> <20060308164041.GA31828@hockin.org> <20060309002153.A9651@jurassic.park.msu.ru> <20060308215734.GA22826@hockin.org> <20060309011147.C9651@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309011147.C9651@jurassic.park.msu.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 01:11:47AM +0300, Ivan Kokshaysky wrote:
> On Wed, Mar 08, 2006 at 01:57:34PM -0800, thockin@hockin.org wrote:
> > > Otherwise we have plenty of MMIO space.
> > 
> > Not true.  Plenty of root bridges have the same base/limit style
> > configuration registers, but they are non-standard.  Even worse - the MMIO
> > hole thatthe chipset carves out, is not guaranteed to be big enough for
> > some new random allocation.
> 
> I'm intrigued. Care to give us an example of such system (where the
> root bridge window is too small), please? lspci -vxxx?

I have systems where the BIOS sets up the IO hole to be the size of the
BARs it finds at PCI enum time.  If I have a device that has a hidden BAR,
the hole won't cover it.  Period.

> > Cleaning up and re-doing are not the same thing.  The plethora of x86
> > chipsets makes this unpleasant at best and more likely unworkable.
> 
> Yes, re-doing is a LOT simpler. ;-)
> If needed, we could introduce 'pci=totallyingnorefsckingbiossettings'
> boot option - it would be 10 or less lines of code.

Except for that whole chipset code thing.  Have you dealt with the
fugliness that is the chipset?  You're really glossing over it.
