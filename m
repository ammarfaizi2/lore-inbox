Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWDAJrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWDAJrt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 04:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWDAJrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 04:47:49 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17672 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750790AbWDAJrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 04:47:48 -0500
Date: Sat, 1 Apr 2006 10:47:36 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Handling devices that don't have a bus
Message-ID: <20060401094736.GB2636@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Stern <stern@rowland.harvard.edu>,
	Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
	Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0603301520330.4652-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0603301520330.4652-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 03:45:50PM -0500, Alan Stern wrote:
> I recently tried running the dummy_hcd driver for the first time in a 
> while, and it crashed when the gadget driver was unloaded.  It turns out 
> this was because the gadget's embedded struct device is registered without 
> a bus, which triggers an oops when the device's driver is unbound.  The 
> oops could be fixed by doing this:

Can you provide the oops itself please?

> Part of the problem here is that most of the USB controllers are platform
> devices and so belong on the platform bus.

You're making a connection where no such connection exists.  Devices
are only part of the platform bus if they explicitly want to be (in
much the same way that devices are only part of the PCI bus if they
explicitly set dev->bus to be the PCI bus.)

> But struct usb_gadget contains an embedded struct device, not an embedded
> struct platform_device... so the gadget _can't_ be registered on its 
> parent's bus.

>From what I can see, the embedded device does not belong to any bus at
all since dev->bus is NULL.  Hence, I don't think it's the embedded
struct device which is causing the problem here.

It would be good to see the entire oops to see what's going on.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
