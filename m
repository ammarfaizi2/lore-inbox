Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbTKGXHm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 18:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbTKGWXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:23:42 -0500
Received: from fmr04.intel.com ([143.183.121.6]:56036 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S264072AbTKGLDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 06:03:43 -0500
Subject: Re: Shared ACPI/USB IRQ working in 2.6 but not in 2.4
From: Len Brown <len.brown@intel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       David van Hoose <david.vanhoose@comcast.net>
In-Reply-To: <Pine.LNX.4.44.0311060949340.7886-100000@logos.cnet>
References: <Pine.LNX.4.44.0311060949340.7886-100000@logos.cnet>
Content-Type: text/plain
Organization: 
Message-Id: <1068203016.2684.976.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 07 Nov 2003 06:03:36 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The details of this issue are here:

http://bugzilla.kernel.org/show_bug.cgi?id=1283

Looks like the IOAPIC is in a different state in 2.4 and 2.6 before ACPI
programs it.  Also 2.6 has sis_apic_bug code that 2.4 does not -- though
I don't know yet if it actually runs on this box.

cheers,
-Len

On Thu, 2003-11-06 at 07:05, Marcelo Tosatti wrote:
> Hi, 
> 
> David van Hoose started having problems with USB on 2.4.23-pre5. USB
> device and acpi were now using irq 20:
> 
> host/usb-ohci.c: USB OHCI at membase 0xe081a000, IRQ 20
> 
> /proc/interrupts:
> 
> 20:          1   IO-APIC-level  acpi, usb-ohci 
> 
> 
> Which makes the USB device not work.
> 
> With -pre4 the USB device was using interrupt 9, because acpi failed to 
> find the correct IRQ:
> 
> pci_irq-0302 [18] acpi_pci_irq_derive   : Unable to derive IRQ for  device 00:03.0 
> PCI: No IRQ known for interrupt pin A of device 00:03.0 
> host/usb-ohci.c: USB OHCI at membase 0xe081a000, IRQ 9 
> 
> Now 2.6 assigns interrupt 20 to acpi and usb-ohci just like in
> 2.4.23-pre5+, but the USB device works!
> 
> Anyone has an idea why the interrupt sharing works with 2.6 but not with
> 2.4?
> 
>  
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

