Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVATLni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVATLni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 06:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVATLni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 06:43:38 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15882 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262127AbVATLne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 06:43:34 -0500
Date: Thu, 20 Jan 2005 11:43:28 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: serial8250_init and platform_device
Message-ID: <20050120114328.A3110@flint.arm.linux.org.uk>
Mail-Followup-To: Kumar Gala <kumar.gala@freescale.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <F8A43C8A-6AB2-11D9-9DDC-000393DBC2E8@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <F8A43C8A-6AB2-11D9-9DDC-000393DBC2E8@freescale.com>; from kumar.gala@freescale.com on Thu, Jan 20, 2005 at 01:14:49AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 01:14:49AM -0600, Kumar Gala wrote:
> I dont get how it is you dont have more platform_devices register than 
> you should based on how serial8250_init works if you have additional 
> code registering a serial8250 device.  For example, 
> arch/arm/mach-s3c2410/mach-vr1000.c will register one serial8250 
> device, and it appears to me that serial8250_init will register a 2nd.  
> Is this the expected behavior or am I missing something?

I don't understand what you're saying, sorry.

serial8250_init() registers an "ISA compatibility" 8250 device for those
architectures which haven't converted themselves to the new scheme.

It then creates all the 8250 ports from 0..UART_NR.  In the case of an
architecture which doesn't have any SERIAL_PORT_DFNS defined (eg, ARM)
these are just dummy placeholder registrations.

We then register the device driver, which allows us to pick up on the
platform devices.  This causes the placeholder registrations to be
reassigned to the platform devices on a first come first served basis
via the standard registration call serial8250_register_port().

While you can have both the "ISA compatibility" scheme and the
"platform device" scheme contain the same port description, you'll
only end up with just the one port registered in the end.  That just
happens to be correct and desired behaviour.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
