Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVAYEbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVAYEbG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 23:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVAYEbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 23:31:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:54448 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261810AbVAYEbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 23:31:02 -0500
Date: Mon, 24 Jan 2005 20:24:59 -0800
From: Greg KH <greg@kroah.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jon Smirl <jonsmirl@gmail.com>,
       Matthew Wilcox <matthew@wil.cx>, Jesse Barnes <jbarnes@sgi.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Patch to control VGA bus routing and active VGA device.
Message-ID: <20050125042459.GA32697@kroah.com>
References: <9e47339105011719436a9e5038@mail.gmail.com> <41ED3BD2.1090105@pobox.com> <9e473391050122083822a7f81c@mail.gmail.com> <200501240847.51208.jbarnes@sgi.com> <20050124175131.GM31455@parcelfarce.linux.theplanet.co.uk> <9e473391050124111767a9c6b7@mail.gmail.com> <41F54FC1.6080207@pobox.com> <20050124195523.B5541@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124195523.B5541@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 07:55:23PM +0000, Russell King wrote:
> On Mon, Jan 24, 2005 at 02:42:57PM -0500, Jeff Garzik wrote:
> > Jon Smirl wrote:
> > > Is this a justification for doing device drivers for bridge chips? It
> > > has been mentioned before but no one has done it.
> > 
> > 
> > Yeah, people are usually slack and work around the problem.
> > 
> > A bridge driver is really wanted for several situations in today's 
> > hardware...
> 
> There's a very good reason not to have a bridge driver at the moment -
> some PCI to PCI bridges need special drivers.  Currently, as the device
> model stands today, we can only have ONE PCI to PCI bridge driver for
> all P2P bridges, which is bad news if you need a specific driver for,
> eg, a mobility docking station P2P bridge.
> 
> As I said back in 2002, the device model needs a way to have driver
> priories - how well a driver matches the hardware.
> 
> My idea was for the bus match function to return the "goodness"
> factor of the match.  For PCI, matching on just the class IDs would
> be low goodness, but an exact match with both the vendor and device
> IDs would yeild a good match.

This can be done today in the bus specific match functions.  And because
of that, I would argue that this belongs in the bus specific code, and
not in the driver core, as it's up to the bus to know what the different
types of "matches" that can happen, and what the priority is.

And yes, I agree that this needs to be done, I've been talking with a
few other people who are interested in it.  I think the lock-rework code
needs to be finished before it can happen properly, so that we can do
the "unbind from one driver and give it to another one" type logic
properly.

thanks,

greg k-h
