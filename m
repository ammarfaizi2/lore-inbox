Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266241AbUBQP30 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 10:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266243AbUBQP30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 10:29:26 -0500
Received: from topaz.cx ([66.220.6.227]:8391 "EHLO mail.topaz.cx")
	by vger.kernel.org with ESMTP id S266241AbUBQP3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 10:29:20 -0500
Date: Tue, 17 Feb 2004 10:29:19 -0500
From: Chip Salzenberg <chip@pobox.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.3-rc3: USB subsystem wedged when USB keyboard is re-plugged
Message-ID: <20040217152918.GG1696@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: OUTLOOK ERROR: Message text violates P.A.T.R.I.O.T. act
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got a USB keyboard - a pretty darn cool one, actually: an IBM
SpaceSaver with both a TrackPoint and a trackpad built-in.  And when I
plugged it in to my ThinkPad A30 yesterday, it worked great.  Then I
unplugged it and took my laptop home.

But today when I plugged in the keyboard again, the kernel broke.
Quoting dmesg:

  usb 2-2: new full speed USB device using address 5
  usb 2-2: control timeout on ep0out

And after that timeout, the USB subsystem seems totally stuck.
Nothing I do provokes any further response.  (Kind of makes me wish
I'd built the USB drivers as modules so I could unload and reload
them.)

Is this a known issue?  I'll be glad to test any patches that might help.

Boot time messages:

  drivers/usb/core/usb.c: registered new driver usbfs
  drivers/usb/core/usb.c: registered new driver hub
  ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
  ohci_hcd: block sizes: ed 64 td 64
  drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
  PCI: Found IRQ 11 for device 0000:00:1d.0
  PCI: Sharing IRQ 11 with 0000:01:00.0
  PCI: Sharing IRQ 11 with 0000:02:00.0
  uhci_hcd 0000:00:1d.0: UHCI Host Controller
  PCI: Setting latency timer of device 0000:00:1d.0 to 64
  uhci_hcd 0000:00:1d.0: irq 11, io base 00001800
  uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
  hub 1-0:1.0: USB hub found
  hub 1-0:1.0: 2 ports detected
  PCI: Found IRQ 9 for device 0000:00:1d.1
  uhci_hcd 0000:00:1d.1: UHCI Host Controller
  PCI: Setting latency timer of device 0000:00:1d.1 to 64
  uhci_hcd 0000:00:1d.1: irq 9, io base 00001820
  uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
  hub 2-0:1.0: USB hub found
  hub 2-0:1.0: 2 ports detected
  PCI: Found IRQ 9 for device 0000:00:1d.2
  PCI: Sharing IRQ 9 with 0000:00:1f.1
  PCI: Sharing IRQ 9 with 0000:02:02.0
  uhci_hcd 0000:00:1d.2: UHCI Host Controller
  PCI: Setting latency timer of device 0000:00:1d.2 to 64
  uhci_hcd 0000:00:1d.2: irq 9, io base 00001840
  uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
  hub 3-0:1.0: USB hub found
  hub 3-0:1.0: 2 ports detected

Relevant .config entries:

  CONFIG_INPUT=y
  CONFIG_INPUT_MOUSEDEV=y
  CONFIG_INPUT_MOUSEDEV_PSAUX=y
  CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
  CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
  CONFIG_INPUT_EVDEV=y
  CONFIG_INPUT_KEYBOARD=y
  CONFIG_INPUT_MOUSE=y

  CONFIG_USB=y
  CONFIG_USB_DEVICEFS=y
  CONFIG_USB_EHCI_HCD=y
  CONFIG_USB_OHCI_HCD=y
  CONFIG_USB_UHCI_HCD=y

  CONFIG_USB_HID=y
  CONFIG_USB_HIDINPUT=y
  CONFIG_USB_HIDDEV=y

-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K
