Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbUJXQaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbUJXQaA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 12:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbUJXQXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 12:23:19 -0400
Received: from ipx20189.ipxserver.de ([80.190.249.56]:61830 "EHLO
	ipx20189.ipxserver.de") by vger.kernel.org with ESMTP
	id S261543AbUJXQVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 12:21:16 -0400
Date: Sun, 24 Oct 2004 19:19:37 +0300 (EAT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-mm1: NForce3 problem (IRQ sharing issue?)
In-Reply-To: <200410231909.09931.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.61.0410241917460.2982@musoma.fsmlabs.com>
References: <200410222354.44563.rjw@sisk.pl> <20041022162656.2f9ca653.akpm@osdl.org>
 <200410231909.09931.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2004, Rafael J. Wysocki wrote:

> > Beats me.  Does the interrupt count stop increasing?
> 
> Yes, it does.
> 
> Moreover, 2.6.10-rc1 has this problem too, but here the network adapter 
> stopped working along with the USB (as you can see above, it shares an IRQ 
> with the USB too).  Also, this time I was able to reload the ohci-hcd module 
> (it didn't help) and I got these messages:
> 
> Oct 23 18:32:23 albercik kernel: ohci_hcd 0000:00:02.0: remove, state 1
> Oct 23 18:32:23 albercik kernel: usb usb2: USB disconnect, address 1
> Oct 23 18:32:23 albercik kernel: usb 2-2: USB disconnect, address 2
> Oct 23 18:32:24 albercik kernel: ohci_hcd 0000:00:02.0: IRQ INTR_SF lossage
> Oct 23 18:32:24 albercik kernel: ohci_hcd 0000:00:02.0: USB bus 2 deregistered
> Oct 23 18:32:24 albercik kernel: ohci_hcd 0000:00:02.1: remove, state 1
> Oct 23 18:32:24 albercik kernel: usb usb3: USB disconnect, address 1
> Oct 23 18:32:24 albercik kernel: ohci_hcd 0000:00:02.1: USB bus 3 deregistered
> Oct 23 18:32:41 albercik kernel: ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host 
> Controller (OHCI) Driver (PCI)
> Oct 23 18:32:41 albercik kernel: ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 
> (level, low) -> IRQ 11
> Oct 23 18:32:41 albercik kernel: ohci_hcd 0000:00:02.0: nVidia Corporation 
> nForce3 USB 1.1
> Oct 23 18:32:41 albercik kernel: PCI: Setting latency timer of device 
> 0000:00:02.0 to 64
> Oct 23 18:32:41 albercik kernel: ohci_hcd 0000:00:02.0: irq 11, pci mem 
> 0xfebfb000
> Oct 23 18:32:41 albercik kernel: ohci_hcd 0000:00:02.0: new USB bus 
> registered, assigned bus number 2
> Oct 23 18:32:41 albercik kernel: hub 2-0:1.0: USB hub found
> Oct 23 18:32:41 albercik kernel: hub 2-0:1.0: 3 ports detected
> Oct 23 18:32:41 albercik kernel: ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 5 
> (level, low) -> IRQ 5
> Oct 23 18:32:41 albercik kernel: ohci_hcd 0000:00:02.1: nVidia Corporation 
> nForce3 USB 1.1 (#2)
> Oct 23 18:32:41 albercik kernel: PCI: Setting latency timer of device 
> 0000:00:02.1 to 64
> Oct 23 18:32:41 albercik kernel: ohci_hcd 0000:00:02.1: irq 5, pci mem 
> 0xfebfc000
> Oct 23 18:32:41 albercik kernel: ohci_hcd 0000:00:02.1: new USB bus 
> registered, assigned bus number 3
> ct 23 18:32:41 albercik kernel: hub 3-0:1.0: USB hub found
> Oct 23 18:32:41 albercik kernel: hub 3-0:1.0: 3 ports detected
> Oct 23 18:32:41 albercik kernel: usb 2-2: new low speed USB device using 
> address 2
> Oct 23 18:32:46 albercik kernel: usb 2-2: control timeout on ep0out
> Oct 23 18:32:46 albercik kernel: ohci_hcd 0000:00:02.0: Unlink after no-IRQ?  
> Different ACPI or APIC settings may help.
> Oct 23 18:36:04 albercik kernel: Losing some ticks... checking if CPU 
> frequency changed.
> Oct 23 18:37:28 albercik kernel: eth0: network connection down
> Oct 23 18:37:40 albercik kernel: eth0: no IPv6 routers present
> Oct 23 18:42:45 albercik kernel: Intel ICH 0000:00:06.0: Device was removed 
> without properly calling pci_disable_device(). This may need fixing.
> 
> The "control timeout on ep0out" and "Unlink after no-IRQ?" messages are 
> puzzling, but the last one is just ridiculous as the box has _nothing_ to do 
> with Intel.

That's probably the nforce3 audio device which is an intel part.

> 
> The .config for 2.6.10-rc1 is available at:
> http://www.sisk.pl/kernel/041023/2.6.10-rc1.config
> The .config for 2.6.9-mm1 is available at:
> http://www.sisk.pl/kernel/041023/2.6.9-mm1.config
> 
> The outputs of dmesg and lspci requested by Zwane will follow in a couple of 
> minutes.

Thanks,
	Zwane
