Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbVATPY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbVATPY5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 10:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVATPY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 10:24:57 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:4082 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262153AbVATPYP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 10:24:15 -0500
In-Reply-To: <20050120114328.A3110@flint.arm.linux.org.uk>
References: <20050120114328.A3110@flint.arm.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <4D4277A8-6AF7-11D9-A0BF-000393DBC2E8@freescale.com>
Content-Transfer-Encoding: 8BIT
Cc: "Linux Kernel list" <linux-kernel@vger.kernel.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: serial8250_init and platform_device
Date: Thu, 20 Jan 2005 09:23:56 -0600
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to convert some PPC embedded code from using the old "ISA 
compat" style with SERIAL_PORT_DFNS to using platform_device.

> On Thu, Jan 20, 2005 at 01:14:49AM -0600, Kumar Gala wrote:
>  > I dont get how it is you dont have more platform_devices register 
> than
> > you should based on how serial8250_init works if you have additional
> > code registering a serial8250 device.  For example,
> > arch/arm/mach-s3c2410/mach-vr1000.c will register one serial8250
> > device, and it appears to me that serial8250_init will register a 
> 2nd. 
> > Is this the expected behavior or am I missing something?
>
> I don't understand what you're saying, sorry.

No problem, let me try to clarify.  I'm trying to figure out in the ARM 
case if there are 2 platform_devices that are registered and if this is 
the desired behavior (and if so why?).

> serial8250_init() registers an "ISA compatibility" 8250 device for 
> those
>  architectures which haven't converted themselves to the new scheme.
>
> It then creates all the 8250 ports from 0..UART_NR.  In the case of an
>  architecture which doesn't have any SERIAL_PORT_DFNS defined (eg, ARM)
>  these are just dummy placeholder registrations.

In serial8250_init() we call platform_device_register_simple(), this 
will be one registration of a serial8250 device.  In my example of 
vr1000, arch/arm/mach-s3c2410/cpu.c:s3c_arch_init() calls 
platform_device_register, the 2nd time a serial8250 device is 
registered.

> We then register the device driver, which allows us to pick up on the
>  platform devices.  This causes the placeholder registrations to be
>  reassigned to the platform devices on a first come first served basis
>  via the standard registration call serial8250_register_port().

I'm not following you here, its not clear if you mean we have 2 
platform devices registered in the system, but only one actually has 
serial ports that are registered.  If you are using SERIAL_PORT_DFNS, 
it will be the platform_device created in serial8250_init(), if you are 
not it will be the platform_device created elsewhere?

> While you can have both the "ISA compatibility" scheme and the
>  "platform device" scheme contain the same port description, you'll
>  only end up with just the one port registered in the end.  That just
>  happens to be correct and desired behaviour.

- kumar

