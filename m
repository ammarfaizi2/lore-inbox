Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264992AbTBOUQW>; Sat, 15 Feb 2003 15:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbTBOUQW>; Sat, 15 Feb 2003 15:16:22 -0500
Received: from ns.mock.com ([209.157.146.194]:30118 "EHLO mail.mock.com")
	by vger.kernel.org with ESMTP id <S264992AbTBOUQV>;
	Sat, 15 Feb 2003 15:16:21 -0500
Message-Id: <5.1.0.14.2.20030215113708.01c398e0@ns.mock.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 15 Feb 2003 12:26:16 -0800
To: linux-kernel@vger.kernel.org
From: Jeff Mock <jeff@mock.com>
Subject: Vertical blanking interrupts
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to write a driver for an embedded application that supports
vertical blanking interrupts from a VGA graphics controller.  This is
to allow for smooth, frame accurate animation in the frame buffer.
I'm doing this work on a 2.4.20 kernel.

In particular, the platform is a VIA mini-ITX motherboard that uses
a VIA PLE133 combined northbridge and Trident Cyberblade graphics
controller.

VGAs have a legacy feature to generate a vertical blanking interrupt.
I don't think windows or linux use this feature.

I'm having trouble getting the vertical blanking interrupt to work.  I'm
a bit out of my depth with this thing, so be gentle.

The BIOS setup program for my target motherboard has a suspicious
option for "Assign IRQ to VGA", which I have enabled.

When I init the driver I find that the IRQ in the PCI configuration
space for the device has assigned an IRQ (10 in my case).  I
call pci_find() and it also reveals IRQ 10.

The problem starts when I call pci_enable_device(). pirq_get_info()
is unable to find the VGA adapter in the IRQ routing table.
request_irq() succeeds, but I get no interrupts.  The VGA appears
on bus number 1, but the other devices in the system appear on bus
number 0 in the PCI configuration space, I guess this is because
the graphics controller integrated into the northbridge is an
AGP device.

I'm also a little suspicious about this endeavor because there is
some code in pcibios_lookup_irq() that does not set the irq routing
table if the device is in the PCI_CLASS_DISPLAY_VGA class.  Hmph.

Does anyone out there have experience getting VGA vertical blanking
interrupts to work?  Why would the VGA device not show up in the
IRQ routing table?  Is this a BIOS bug or are VGA interrupts just not
supported by the hardware anymore?  Any advice appreciated.

thanks,
jeff






