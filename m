Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751564AbWDARMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbWDARMU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 12:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWDARMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 12:12:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5641 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751562AbWDARMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 12:12:19 -0500
Date: Sat, 1 Apr 2006 18:12:12 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Handling devices that don't have a bus
Message-ID: <20060401171212.GA31107@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Stern <stern@rowland.harvard.edu>,
	Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
	Kernel development list <linux-kernel@vger.kernel.org>
References: <20060401094736.GB2636@flint.arm.linux.org.uk> <Pine.LNX.4.44L0.0604011128020.17557-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0604011128020.17557-100000@netrider.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2006 at 11:46:26AM -0500, Alan Stern wrote:
> On Sat, 1 Apr 2006, Russell King wrote:
> 
> > On Thu, Mar 30, 2006 at 03:45:50PM -0500, Alan Stern wrote:
> > > I recently tried running the dummy_hcd driver for the first time in a 
> > > while, and it crashed when the gadget driver was unloaded.  It turns out 
> > > this was because the gadget's embedded struct device is registered without 
> > > a bus, which triggers an oops when the device's driver is unbound.  The 
> > > oops could be fixed by doing this:
> > 
> > Can you provide the oops itself please?
> 
> No, I don't have it any more.  But I can tell you exactly where the oops 
> occurred.  In __device_release_driver() (in drivers/base/dd.c), this line 
> you added:
> 
> 		if (dev->bus->remove)
> 
> crashed because dev->bus was NULL.  My patch changes the line to:
> 
> 		if (dev->bus && dev->bus->remove)
> 
> Any objection to that?

Nope.

> I think you have misunderstood my point.

Yes I did.  Oops.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
