Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbUDICav (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 22:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbUDICav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 22:30:51 -0400
Received: from [202.28.93.1] ([202.28.93.1]:24843 "EHLO gear.kku.ac.th")
	by vger.kernel.org with ESMTP id S261794AbUDICar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 22:30:47 -0400
Date: Fri, 9 Apr 2004 09:30:46 +0700
From: Kitt Tientanopajai <kitt@gear.kku.ac.th>
To: daniel.ritz@gmx.ch
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5 yenta_socket irq 10: nobody cared!
Message-Id: <20040409093046.51d67994.kitt@gear.kku.ac.th>
In-Reply-To: <200404081717.15794.daniel.ritz@gmx.ch>
References: <200404060227.58325.daniel.ritz@gmx.ch>
	<200404072225.43358.daniel.ritz@gmx.ch>
	<20040408143730.09b29b49.kitt@gear.kku.ac.th>
	<200404081717.15794.daniel.ritz@gmx.ch>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> you're welcome. but i now have the feeling that it's wrong. so another question:
> my patch also changes the interrupt assignment for the USB controller at 00:1d.1
> so the question is: does this one work ok? or is there an interrupt storm as soon
> as you use the device? (like with yenta_socket before)

Ah, right, TM361 has two USB ports, one of them has usb mouse attached and seem to be okay. Another one does not work after applying your patch. This is dmesg when I connect Sony Clie to sync data through the USB port, the pilot-xfer cannot sync any data and then exit without any crash/freeze. 

usb 1-2: new full speed USB device using address 3
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for Handspring Visor / Palm OS
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Clie 3.5
usb 1-2: palm_os_4_probe - error -32 getting connection info
visor 1-2:1.0: Handspring Visor / Palm OS converter detected
usb 1-2: Handspring Visor / Palm OS converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
usb 1-2: Handspring Visor / Palm OS converter now attached to ttyUSB1 (or usb/tts/1 for devfs)
usbcore: registered new driver visor
drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver v2.1
usb 1-2: USB disconnect, address 3
visor 1-2:1.0: device disconnected
visor ttyUSB0: visor_write - usb_submit_urb(write bulk) failed with status = -19
visor ttyUSB0: Handspring Visor / Palm OS converter now disconnected from ttyUSB0
visor ttyUSB1: Handspring Visor / Palm OS converter now disconnected from ttyUSB1

> can you please undo my previous patch and apply the attached one instead.
> the socket may be not working, but it prints the relevant registers from
> the o2micro chip.

Sure, this is dmesg after patch. 

Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 0000:01:05.0 (0000 -> 0002)
PCI: Found IRQ 10 for device 0000:01:05.0
PCI: Sharing IRQ 10 with 0000:01:08.0
Yenta: CardBus bridge found at 0000:01:05.0 [12a3:ab01]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ mask 0x0000, PCI irq 10
Socket status: 30000011
PCI: Found IRQ 11 for device 0000:01:09.0
PCI: Sharing IRQ 11 with 0000:00:1d.1
PCI: Sharing IRQ 11 with 0000:01:09.1
Yenta: CardBus bridge found at 0000:01:09.0 [1025:1022]
Yenta O2: socket 0000:01:09.0, Mux Ctrk: 0c00200f, Mode D: 00
irq 10: nobody cared!
Call Trace:
 [<c0108eca>] __report_bad_irq+0x2a/0x90
 [<c0108fc0>] note_interrupt+0x70/0xb0
 [<c0109270>] do_IRQ+0x120/0x130
 [<c0107618>] common_interrupt+0x18/0x20
 [<c01217ee>] do_softirq+0x3e/0xa0
 [<c010924a>] do_IRQ+0xfa/0x130
 [<c0107618>] common_interrupt+0x18/0x20
 [<c0113284>] delay_pmtmr+0x14/0x20
 [<c01cf512>] __delay+0x12/0x20
 [<d0da2abe>] yenta_probe_irq+0xfe/0x140 [yenta_socket]
 [<d0da2b3a>] yenta_get_socket_capabilities+0x3a/0x70 [yenta_socket]
 [<d0da2e87>] yenta_probe+0x1a7/0x240 [yenta_socket]
 [<c01d3712>] pci_device_probe_static+0x52/0x70
 [<c01d376c>] __pci_device_probe+0x3c/0x50
 [<c01d37ac>] pci_device_probe+0x2c/0x50
 [<c0232b1f>] bus_match+0x3f/0x70
 [<c0232c4c>] driver_attach+0x5c/0xa0
 [<c0232f78>] bus_add_driver+0xa8/0xc0
 [<c02333cf>] driver_register+0x2f/0x40
 [<c01d399c>] pci_register_driver+0x5c/0x90
 [<d0d9500f>] yenta_socket_init+0xf/0x11 [yenta_socket]
 [<c0134722>] sys_init_module+0x142/0x280
 [<c0107459>] sysenter_past_esp+0x52/0x71
 
handlers:
[<d0d55890>] (snd_intel8x0_interrupt+0x0/0x240 [snd_intel8x0])
[<d0d4da10>] (ohci_irq_handler+0x0/0x860 [ohci1394])
[<d0da18a0>] (yenta_interrupt+0x0/0x40 [yenta_socket])
Disabling IRQ #10
Yenta: ISA IRQ mask 0x00b8, PCI irq 11
Socket status: 30000006
PCI: Found IRQ 11 for device 0000:01:09.1
PCI: Sharing IRQ 11 with 0000:00:1d.1
PCI: Sharing IRQ 11 with 0000:01:09.0
Yenta: CardBus bridge found at 0000:01:09.1 [1025:1022]
Yenta O2: socket 0000:01:09.1, Mux Ctrk: 0c00200f, Mode D: 00
Yenta: ISA IRQ mask 0x0038, PCI irq 11
Socket status: 30000410
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x240-0x247 0x378-0x38f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
eth1: Station identity 001f:0001:0006:0010
eth1: Looks like a Lucent/Agere firmware version 6.16
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:02:2D:46:11:44
eth1: Station name "HERMES I"
eth1: ready
eth1: index 0x01: Vcc 3.3, irq 10, io 0x0100-0x013f

