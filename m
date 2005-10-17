Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbVJQVL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbVJQVL1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 17:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVJQVL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 17:11:27 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:2499 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932329AbVJQVL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 17:11:26 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] 2.6.14-rc1-mm1: usb breaks suspend
Date: Mon, 17 Oct 2005 23:11:34 +0200
User-Agent: KMail/1.8.2
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       linux-usb-devel@lists.sourceforge.net
References: <Pine.LNX.4.44L0.0510171450460.4446-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0510171450460.4446-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510172311.35500.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 17 of October 2005 20:54, Alan Stern wrote:
> On Mon, 17 Oct 2005, Pavel Machek wrote:
> 
> > Hi!
> > 
> > In -mm, usb breaks suspend to disk. Compiled without
> > CONFIG_USB_SUSPEND, it just plainly fails; iwth USB_SUSPEND, it
> > actually tries to suspend USB, but it fails and machine refuses to
> > suspend. Is it known or is it worth debugging?
> 
> More details please.

Fails for me too on x86-64, with the following messages:

Stopping tasks: ========================|
Freeing memory... done (14642 pages freed)
Suspending device card0-0
Suspending device 2-2:1.0
Suspending device 2-2
Suspending device 3-0:1.0
hub 3-0:1.0: no suspend?
Suspending device usb3
Could not suspend device usb3: error -16
Some devices failed to suspend
Restarting tasks... done

where the USB-related info returned by the kernel is this:

ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LUS0] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 11, io mem 0xfebfb000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [LUS1] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUS1] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: OHCI Host Controller
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.1: irq 11, io mem 0xfebfc000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 5
usb 2-2: new low speed USB device using ohci_hcd and address 2
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [LUS2] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: EHCI Host Controller
ehci_hcd 0000:00:02.2: debug port 1
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:02.2: irq 5, io mem 0xfebfdc00
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: park 0
ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
usb 2-2: device descriptor read/all, error -110
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 6 ports detected
ohci_hcd 0000:00:02.1: wakeup
usb 2-2: new low speed USB device using ohci_hcd and address 4
usbcore: registered new driver hiddev
input: Logitech USB Receiver//class/input_dev as input3
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:02.1-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver

Greetings,
Rafael
