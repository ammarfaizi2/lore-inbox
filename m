Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTGXMW3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 08:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTGXMW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 08:22:28 -0400
Received: from pop.gmx.net ([213.165.64.20]:28136 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263638AbTGXMWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 08:22:25 -0400
Date: Thu, 24 Jul 2003 14:37:31 +0200
From: Dominik Brugger <ml.dominik83@gmx.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: OHCI problems with suspend/resume
Message-Id: <20030724143731.5fe40b4e.ml.dominik83@gmx.net>
In-Reply-To: <20030723220805.GA278@elf.ucw.cz>
References: <20030723220805.GA278@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In 2.6.0-test1, OHCI is non-functional after first suspend/resume, and
> kills machine during secon suspend/resume cycle.

I experience similar problems with UHCI:

Before suspending to S3 I unload usb modules and afterwards I reload them, but it does not work again.
(For testing I also plugged in an USB card reader with an LED.
The LED is on except when I resume from S3)

Here is some dmesg output

After booting:

drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 0000:00:11.2: VIA Technologies, In USB
uhci-hcd 0000:00:11.2: irq 10, io base 0000dc00
uhci-hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci-hcd 0000:00:11.2: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: VIA Technologies, In USB
usb usb1: Manufacturer: Linux 2.6.0-test1-bk2 uhci-hcd
usb usb1: SerialNumber: 0000:00:11.2
drivers/usb/core/usb.c: usb_hotplug
usb usb1: usb_new_device - registering interface 1-0:0
drivers/usb/core/usb.c: usb_hotplug
hub 1-0:0: usb_device_probe
hub 1-0:0: usb_device_probe - got id
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
hub 1-0:0: standalone hub
hub 1-0:0: ganged power switching
hub 1-0:0: global over-current protection
hub 1-0:0: Port indicators are not supported
hub 1-0:0: power on to power good time: 2ms
hub 1-0:0: hub controller current requirement: 0mA
hub 1-0:0: local power source is good
hub 1-0:0: no over-current condition exists
hub 1-0:0: enabling power on all ports
hub 1-0:0: port 1, status 100, change 3, 12 Mb/s
hub 1-0:0: port 2, status 301, change 3, 1.5 Mb/s
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
hub 1-0:0: new USB device on port 2, assigned address 2
usb 1-2: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-2: Product: USB-PS/2 Optical Mouse
usb 1-2: Manufacturer: Logitech
drivers/usb/core/usb.c: usb_hotplug
usb 1-2: usb_new_device - registering interface 1-2:0
drivers/usb/core/usb.c: usb_hotplug
hub 1-0:0: port 1 enable change, status 100
hid 1-2:0: usb_device_probe
hid 1-2:0: usb_device_probe - got id
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:11.2-2
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver

rmmod uhci_hcd hid usbcore:

uhci-hcd 0000:00:11.2: remove, state 3
uhci-hcd 0000:00:11.2: roothub graceful disconnect
usb usb1: USB disconnect, address 1
usb 1-2: USB disconnect, address 2
drivers/usb/core/usb.c: nuking urbs assigned to 1-2
usb 1-2: unregistering interfaces
drivers/usb/core/usb.c: nuking urbs assigned to 1-2
usb 1-2: hcd_unlink_urb df5047c0 fail -22
usb 1-2: hcd_unlink_urb df504740 fail -22
drivers/usb/core/usb.c: usb_hotplug
usb 1-2: unregistering device
drivers/usb/core/usb.c: usb_hotplug
drivers/usb/core/usb.c: nuking urbs assigned to usb1
uhci-hcd 0000:00:11.2: shutdown urb df504940 pipe 40408180 ep1in-intr
usb usb1: unregistering interfaces
drivers/usb/core/usb.c: nuking urbs assigned to usb1
usb usb1: hcd_unlink_urb df504940 fail -22
drivers/usb/core/usb.c: usb_hotplug
usb usb1: unregistering device
drivers/usb/core/usb.c: usb_hotplug
uhci-hcd 0000:00:11.2: USB bus 1 deregistered
drivers/usb/core/usb.c: deregistering driver hid
drivers/usb/core/usb.c: deregistering driver usbfs
drivers/usb/core/hub.c: hub_thread exiting
drivers/usb/core/usb.c: deregistering driver hub

echo 3 > /proc/acpi/sleep
modprobe usbcore uhci_hcd

(Sometimes the optical mouse blinks for a moment)

drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 0000:00:11.2: VIA Technologies, In USB
uhci-hcd 0000:00:11.2: irq 10, io base 0000dc00
uhci-hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci-hcd 0000:00:11.2: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: VIA Technologies, In USB
usb usb1: Manufacturer: Linux 2.6.0-test1-bk2 uhci-hcd
usb usb1: SerialNumber: 0000:00:11.2
drivers/usb/core/usb.c: usb_hotplug
usb usb1: usb_new_device - registering interface 1-0:0
drivers/usb/core/usb.c: usb_hotplug
hub 1-0:0: usb_device_probe
hub 1-0:0: usb_device_probe - got id
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
hub 1-0:0: standalone hub
hub 1-0:0: ganged power switching
hub 1-0:0: global over-current protection
hub 1-0:0: Port indicators are not supported
hub 1-0:0: power on to power good time: 2ms
hub 1-0:0: hub controller current requirement: 0mA
hub 1-0:0: local power source is good
hub 1-0:0: no over-current condition exists
hub 1-0:0: enabling power on all ports
hub 1-0:0: port 1, status 100, change 3, 12 Mb/s
hub 1-0:0: port 2, status 301, change 3, 1.5 Mb/s
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
hub 1-0:0: new USB device on port 2, assigned address 2
drivers/usb/core/message.c: usb_control/bulk_msg: timeout

-Dominik Brugger
