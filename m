Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbWCHV44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbWCHV44 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbWCHV4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:56:55 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:22961 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S932580AbWCHV4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:56:54 -0500
Date: Wed, 8 Mar 2006 13:57:34 -0800
From: thockin@hockin.org
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Greg KH <greg@kroah.com>, Tejun Heo <htejun@gmail.com>,
       Jeff Garzik <jeff@garzik.org>, Kumar Gala <galak@kernel.crashing.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: proper way to assign fixed PCI resources to a "hotplug" device
Message-ID: <20060308215734.GA22826@hockin.org>
References: <Pine.LNX.4.44.0603031638050.30957-100000@gate.crashing.org> <4408CEC8.7040507@garzik.org> <20060308020028.GB26028@kroah.com> <440E4203.7040303@gmail.com> <20060308052723.GD29867@kroah.com> <20060308143952.B4851@jurassic.park.msu.ru> <20060308164041.GA31828@hockin.org> <20060309002153.A9651@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309002153.A9651@jurassic.park.msu.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 12:21:53AM +0300, Ivan Kokshaysky wrote:
> On Wed, Mar 08, 2006 at 08:40:42AM -0800, thockin@hockin.org wrote:
> > Assigned from what pool?  BIOS most likely sizes the hole to be a pretty
> > tight fit for all the resources it knows about.  If there is suddenly a
> > new resource, you're in trouble.
> 
> This can only be true when device in question is behind a pci-to-pci
> bridge (which is obviously not the case for ICH controllers you mentioned).
> Otherwise we have plenty of MMIO space.

Not true.  Plenty of root bridges have the same base/limit style
configuration registers, but they are non-standard.  Even worse - the MMIO
hole thatthe chipset carves out, is not guaranteed to be big enough for
some new random allocation.

> > We could teach linux about chipsets and let Linux re-do the whole
> > PCI-allocation process.   But that's not an easy task, and is probably a
> > contentious idea.
> 
> Linux knows how to do this for years. Actually, this is the way how alpha
> and some other platforms work. Since 2.6.13, this pretty much applies to
> x86 as well (we do respect BIOS PCI allocations, but we clean the things
> up after BIOS quite aggressively - see pci_assign_unassigned_resources() call).

Cleaning up and re-doing are not the same thing.  The plethora of x86
chipsets makes this unpleasant at best and more likely unworkable.
