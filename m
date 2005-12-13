Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbVLMSqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbVLMSqS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 13:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbVLMSqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 13:46:18 -0500
Received: from melos.informatik.uni-rostock.de ([139.30.241.22]:11 "EHLO
	melos.informatik.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1751256AbVLMSqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 13:46:17 -0500
From: Denny Priebe <spamtrap@siglost.org>
Date: Tue, 13 Dec 2005 19:46:00 +0100
To: linux-kernel@vger.kernel.org
Subject: Repeated USB disconnect and reconnect with Wacom Intuos3 6x11 tablet
Message-ID: <20051213184600.GA4283@nostromo.dyndns.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just want to report a strange observation that I've made while trying to
setup my Wacom Intuos3 6x11 tablet:

When I use the tablet (e.g. press a button, move the pen) and do not have
any process reading the provided data (e.g. there's no process reading 
/dev/input/mouse0 and there's no process reading /dev/input/event5 in my 
setup) the tablet disconnects from and immediately reconnects to the USB. 
There's one pair of disconnect and reconnect each time I press a button or 
use the pen. These disconnects and reconnects disappear as soon as there's 
a process reading either /dev/input/mouse0 or /dev/input/event5 (mouse0 and
event5 according to my setup).

I'm able to reproduce this with 2.6.15-rc5, 2.6.15-rc4, and 2.6.14.3,
but haven't tried other kernels yet.

This is what's in the logs (from 2.6.15-rc5):

----------------------
+++ plug tablet it +++

kernel: hub 4-0:1.0: state 5 ports 6 chg 0000 evt 0002
kernel: ehci_hcd 0000:00:1d.7: GetStatus port 1 status 001803 POWER sig=j CSC CONNECT
kernel: hub 4-0:1.0: port 1, status 0501, change 0001, 480 Mb/s
kernel: hub 4-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x501
kernel: ehci_hcd 0000:00:1d.7: port 1 full speed --> companion
kernel: ehci_hcd 0000:00:1d.7: GetStatus port 1 status 003801 POWER OWNER sig=j CONNECT
kernel: uhci_hcd 0000:00:1d.0: wakeup_rh (auto-start)
kernel: hub 1-0:1.0: state 5 ports 2 chg 0000 evt 0002
kernel: uhci_hcd 0000:00:1d.0: port 1 portsc 0093,00
kernel: hub 1-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
kernel: hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
kernel: usb 1-1: new full speed USB device using uhci_hcd and address 2
kernel: usb 1-1: ep0 maxpacket = 8
kernel: usb 1-1: skipped 1 descriptor after interface
kernel: usb 1-1: default language 0x0409
kernel: usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=0
kernel: usb 1-1: Product: PTZ-631W
kernel: usb 1-1: Manufacturer: Tablet
kernel: usb 1-1: hotplug
kernel: usb 1-1: adding 1-1:1.0 (config #1, interface 0)
kernel: usb 1-1:1.0: hotplug
kernel: drivers/usb/core/inode.c: creating file '002'
kernel: usbhid 1-1:1.0: usb_probe_interface
kernel: usbhid 1-1:1.0: usb_probe_interface - got id
kernel: usbcore: registered new driver usbhid
kernel: drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usb.agent[3853]:      usbhid: loaded successfully
kernel: wacom 1-1:1.0: usb_probe_interface
kernel: wacom 1-1:1.0: usb_probe_interface - got id
kernel: input: Wacom Intuos3 6x11 as /class/input/input5
kernel: usbcore: registered new driver wacom
kernel: drivers/usb/input/wacom.c: v1.44:USB Wacom Graphire and Wacom Intuos tablet driver
usb.agent[3853]:      wacom: loaded successfully

+++ press a button +++

kernel: hub 1-0:1.0: state 5 ports 2 chg 0000 evt 0002
kernel: uhci_hcd 0000:00:1d.0: port 1 portsc 008a,00
kernel: hub 1-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
kernel: usb 1-1: USB disconnect, address 2
kernel: usb 1-1: usb_disable_device nuking all URBs
kernel: usb 1-1: unregistering interface 1-1:1.0
kernel: usb 1-1:1.0: hotplug
kernel: usb 1-1: unregistering device
kernel: usb 1-1: hotplug
kernel: hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
kernel: hub 4-0:1.0: state 5 ports 6 chg 0000 evt 0002
kernel: ehci_hcd 0000:00:1d.7: GetStatus port 1 status 001803 POWER sig=j CSC CONNECT
kernel: hub 4-0:1.0: port 1, status 0501, change 0001, 480 Mb/s
kernel: hub 4-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x501
kernel: ehci_hcd 0000:00:1d.7: port 1 full speed --> companion
kernel: ehci_hcd 0000:00:1d.7: GetStatus port 1 status 003801 POWER OWNER sig=j CONNECT
kernel: hub 1-0:1.0: state 5 ports 2 chg 0000 evt 0002
kernel: uhci_hcd 0000:00:1d.0: port 1 portsc 0093,00
kernel: hub 1-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
kernel: hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
kernel: usb 1-1: new full speed USB device using uhci_hcd and address 3
kernel: usb 1-1: ep0 maxpacket = 8
kernel: usb 1-1: skipped 1 descriptor after interface
kernel: usb 1-1: default language 0x0409
kernel: usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=0
kernel: usb 1-1: Product: PTZ-631W
kernel: usb 1-1: Manufacturer: Tablet
kernel: usb 1-1: hotplug
kernel: usb 1-1: adding 1-1:1.0 (config #1, interface 0)
kernel: usb 1-1:1.0: hotplug
kernel: usbhid 1-1:1.0: usb_probe_interface
kernel: usbhid 1-1:1.0: usb_probe_interface - got id
kernel: wacom 1-1:1.0: usb_probe_interface
kernel: wacom 1-1:1.0: usb_probe_interface - got id
kernel: input: Wacom Intuos3 6x11 as /class/input/input6
kernel: drivers/usb/core/inode.c: creating file '003'
usb.agent[4019]:      usbhid: already loaded
usb.agent[4019]:      wacom: already loaded

+++ use the pen +++

kernel: hub 1-0:1.0: state 5 ports 2 chg 0000 evt 0002
kernel: uhci_hcd 0000:00:1d.0: port 1 portsc 008a,00
kernel: hub 1-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
kernel: usb 1-1: USB disconnect, address 3
kernel: usb 1-1: usb_disable_device nuking all URBs
kernel: usb 1-1: unregistering interface 1-1:1.0
kernel: usb 1-1:1.0: hotplug
kernel: usb 1-1: unregistering device
kernel: usb 1-1: hotplug
kernel: hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
kernel: hub 4-0:1.0: state 5 ports 6 chg 0000 evt 0002
kernel: ehci_hcd 0000:00:1d.7: GetStatus port 1 status 001803 POWER sig=j CSC CONNECT
kernel: hub 4-0:1.0: port 1, status 0501, change 0001, 480 Mb/s
kernel: hub 4-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x501
kernel: ehci_hcd 0000:00:1d.7: port 1 full speed --> companion
kernel: ehci_hcd 0000:00:1d.7: GetStatus port 1 status 003801 POWER OWNER sig=j CONNECT
kernel: hub 1-0:1.0: state 5 ports 2 chg 0000 evt 0002
kernel: uhci_hcd 0000:00:1d.0: port 1 portsc 0093,00
kernel: hub 1-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
kernel: hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
kernel: usb 1-1: new full speed USB device using uhci_hcd and address 4
kernel: usb 1-1: ep0 maxpacket = 8
kernel: usb 1-1: skipped 1 descriptor after interface
kernel: usb 1-1: default language 0x0409
kernel: usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=0
kernel: usb 1-1: Product: PTZ-631W
kernel: usb 1-1: Manufacturer: Tablet
kernel: usb 1-1: hotplug
kernel: usb 1-1: adding 1-1:1.0 (config #1, interface 0)
kernel: usb 1-1:1.0: hotplug
kernel: usbhid 1-1:1.0: usb_probe_interface
kernel: usbhid 1-1:1.0: usb_probe_interface - got id
kernel: wacom 1-1:1.0: usb_probe_interface
kernel: wacom 1-1:1.0: usb_probe_interface - got id
kernel: input: Wacom Intuos3 6x11 as /class/input/input7
kernel: drivers/usb/core/inode.c: creating file '004'
usb.agent[4138]:      usbhid: already loaded
usb.agent[4138]:      wacom: already loaded

+++ unplug tablet +++

kernel: hub 1-0:1.0: state 5 ports 2 chg 0000 evt 0002
kernel: uhci_hcd 0000:00:1d.0: port 1 portsc 008a,00
kernel: hub 1-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
kernel: usb 1-1: USB disconnect, address 4
kernel: usb 1-1: usb_disable_device nuking all URBs
kernel: usb 1-1: unregistering interface 1-1:1.0
kernel: usb 1-1:1.0: hotplug
kernel: usb 1-1: unregistering device
kernel: usb 1-1: hotplug
kernel: hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
kernel: uhci_hcd 0000:00:1d.0: suspend_rh (auto-stop)

-----------------

Output from lsusb -v is at http://siglost.org/wacom-lsusb.log
My config is at http://siglost.org/config-2.6.15-rc5


Thanks for reading and best regards,
Denny
