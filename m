Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVBAHnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVBAHnJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 02:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVBAHmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 02:42:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:11421 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261716AbVBAHlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 02:41:40 -0500
Date: Mon, 31 Jan 2005 22:38:17 -0800
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Matthew Wilcox <matthew@wil.cx>, Jesse Barnes <jbarnes@sgi.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Patch to control VGA bus routing and active VGA device.
Message-ID: <20050201063817.GE15179@kroah.com>
References: <9e47339105011719436a9e5038@mail.gmail.com> <41ED3BD2.1090105@pobox.com> <9e473391050122083822a7f81c@mail.gmail.com> <200501240847.51208.jbarnes@sgi.com> <20050124175131.GM31455@parcelfarce.linux.theplanet.co.uk> <9e473391050124111767a9c6b7@mail.gmail.com> <41F54FC1.6080207@pobox.com> <20050124195523.B5541@flint.arm.linux.org.uk> <20050125042459.GA32697@kroah.com> <9e473391050127015970e1fedc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391050127015970e1fedc@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 04:59:45AM -0500, Jon Smirl wrote:
> On Mon, 24 Jan 2005 20:24:59 -0800, Greg KH <greg@kroah.com> wrote:
> > This can be done today in the bus specific match functions.  And because
> > of that, I would argue that this belongs in the bus specific code, and
> > not in the driver core, as it's up to the bus to know what the different
> > types of "matches" that can happen, and what the priority is.
> 
> Here's a version of the VGA control code that actually works. It helps
> if I pci_enable() the device before using it. There was nothing wrong
> with the routing code.
> 
> I can also control multiple cards on the same bus by turning on/off
> their response to IO space and then enabling VGA via the standard
> ports. I can use this to move my console from card to card.
> 
> I have this code in drivers/pci because it needs to know add/remove
> from hotplug. Is there a better way to structure it? Note that this is
> not a VGA device, it is just a mechanism for controlling which VGA
> device is active.
> 
> Another item I need to add is generating an initial hotplug event for
> each secondary card. This event has to happen even if there is a card
> specific driver loaded. The event will be used to run the reset
> program needed by secondary cards.

Ick, patch wasn't inline for me to comment on it :(

Anyway, get rid of the ifdefs in the kernel .c code to start with.

thanks,

greg k-h
