Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263533AbTKFMOr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 07:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263539AbTKFMOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 07:14:47 -0500
Received: from intra.cyclades.com ([64.186.161.6]:52132 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263533AbTKFMOq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 07:14:46 -0500
Date: Thu, 6 Nov 2003 10:05:24 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>, "Brown, Len" <len.brown@intel.com>,
       David van Hoose <david.vanhoose@comcast.net>
Subject: Shared ACPI/USB IRQ working in 2.6 but not in 2.4 
Message-ID: <Pine.LNX.4.44.0311060949340.7886-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

David van Hoose started having problems with USB on 2.4.23-pre5. USB
device and acpi were now using irq 20:

host/usb-ohci.c: USB OHCI at membase 0xe081a000, IRQ 20

/proc/interrupts:

20:          1   IO-APIC-level  acpi, usb-ohci 


Which makes the USB device not work.

With -pre4 the USB device was using interrupt 9, because acpi failed to 
find the correct IRQ:

pci_irq-0302 [18] acpi_pci_irq_derive   : Unable to derive IRQ for  device 00:03.0 
PCI: No IRQ known for interrupt pin A of device 00:03.0 
host/usb-ohci.c: USB OHCI at membase 0xe081a000, IRQ 9 

Now 2.6 assigns interrupt 20 to acpi and usb-ohci just like in
2.4.23-pre5+, but the USB device works!

Anyone has an idea why the interrupt sharing works with 2.6 but not with
2.4?

 


