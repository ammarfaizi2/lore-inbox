Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVATTiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVATTiy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 14:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVATTix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 14:38:53 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13327 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261713AbVATTiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 14:38:50 -0500
Date: Thu, 20 Jan 2005 19:38:45 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kumar Gala <kumar.gala@freescale.com>, Greg KH <greg@kroah.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: serial8250_init and platform_device
Message-ID: <20050120193845.H13242@flint.arm.linux.org.uk>
Mail-Followup-To: Kumar Gala <kumar.gala@freescale.com>,
	Greg KH <greg@kroah.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <20050120154420.D13242@flint.arm.linux.org.uk> <736677C2-6B16-11D9-BD44-000393DBC2E8@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <736677C2-6B16-11D9-BD44-000393DBC2E8@freescale.com>; from kumar.gala@freescale.com on Thu, Jan 20, 2005 at 01:06:55PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 01:06:55PM -0600, Kumar Gala wrote:
> Russell,
> 
> I think this all makes sense to me.  I'm just wondering why we would 
> have a platform device register in a system for 'legacy ISA' when we 
> know the system doesnt have any ports that will fit the category.
> 
> As you show in example #2 you have
> 
> .../devices/platform/serial82500
> .../devices/platform/serial8250
> 
> why have the 'serial8250' if you know your system doesnt have any ports 
> that will exist there?

In this case, it is a placeholder, and needs to be there if you're using
power management.

For instance, you may use setserial on /dev/ttyS2 to reconfigure it
to an address where you know a serial port is.  Without the "serial8250"
device, it isn't linked into the device model, and therefore doesn't
receive any power management notifications.

Once the SERIAL_PORT_DFNS are gone, and we have a more modern interface
than setserial for setting up random ports, this "serial8250" device
will vanish.

While we're here, you've reminded me about an annoying point about
platform device naming...

Greg - the name is constructed from "name" + "id num" thusly:

	serial8250
	serial82500
	serial82501
	serial82502

When "name" ends in a number, it gets rather confusing.  Can we have
an optional delimiter in there when we append the ID number, maybe
something like a '.' or ':' ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
