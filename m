Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVAXTzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVAXTzq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 14:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVAXTzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 14:55:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15374 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261601AbVAXTze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 14:55:34 -0500
Date: Mon, 24 Jan 2005 19:55:23 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, Matthew Wilcox <matthew@wil.cx>,
       Jesse Barnes <jbarnes@sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Patch to control VGA bus routing and active VGA device.
Message-ID: <20050124195523.B5541@flint.arm.linux.org.uk>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Jon Smirl <jonsmirl@gmail.com>, Matthew Wilcox <matthew@wil.cx>,
	Jesse Barnes <jbarnes@sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
	lkml <linux-kernel@vger.kernel.org>
References: <9e47339105011719436a9e5038@mail.gmail.com> <41ED3BD2.1090105@pobox.com> <9e473391050122083822a7f81c@mail.gmail.com> <200501240847.51208.jbarnes@sgi.com> <20050124175131.GM31455@parcelfarce.linux.theplanet.co.uk> <9e473391050124111767a9c6b7@mail.gmail.com> <41F54FC1.6080207@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41F54FC1.6080207@pobox.com>; from jgarzik@pobox.com on Mon, Jan 24, 2005 at 02:42:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 02:42:57PM -0500, Jeff Garzik wrote:
> Jon Smirl wrote:
> > Is this a justification for doing device drivers for bridge chips? It
> > has been mentioned before but no one has done it.
> 
> 
> Yeah, people are usually slack and work around the problem.
> 
> A bridge driver is really wanted for several situations in today's 
> hardware...

There's a very good reason not to have a bridge driver at the moment -
some PCI to PCI bridges need special drivers.  Currently, as the device
model stands today, we can only have ONE PCI to PCI bridge driver for
all P2P bridges, which is bad news if you need a specific driver for,
eg, a mobility docking station P2P bridge.

As I said back in 2002, the device model needs a way to have driver
priories - how well a driver matches the hardware.

My idea was for the bus match function to return the "goodness"
factor of the match.  For PCI, matching on just the class IDs would
be low goodness, but an exact match with both the vendor and device
IDs would yeild a good match.

When the device model has a driver or device added, it scans all current
devices or drivers (respectively) and chooses the best matched pair.
If the device already has an existing driver, it calls the ->remove
method to unbind the current device driver relationship before handing
it over to the more specific driver.

Unfortunately, I never got around to writing the mobility P2P bridge
driver because I didn't see much chance of this idea being adopted.

However, if we're going to start having generic drivers for such
hardware, this kind of functionality needs to be thought about.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
