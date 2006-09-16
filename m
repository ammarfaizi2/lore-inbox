Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751762AbWIPIOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbWIPIOy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 04:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWIPIOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 04:14:54 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:23528 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751762AbWIPIOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 04:14:53 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.18-rc6-mm2 (-mm1): ohci_hcd does not recognize new devices
Date: Sat, 16 Sep 2006 10:13:45 +0200
User-Agent: KMail/1.9.1
Cc: David Brownell <david-b@pacbell.net>, LKML <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
References: <200609160013.16014.rjw@sisk.pl>
In-Reply-To: <200609160013.16014.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609161013.45800.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday, 16 September 2006 00:13, Rafael J. Wysocki wrote:
> It looks like the ohci_hcd driver sometimes has problems with the
> initialization (eg. USB mouse doesn't work after a fresh boot and reloading
> of the driver helps).
> 
> I have observed this on two different x86_64 boxes (HPC 6325, Asus L5D),
> but it is not readily reproducible.  Anyway I've got a dmesg output from a
> failing case which is attached.

Actually, the problem is ohci_hcd doesn't seem to recognize devices plugged
into the USB ports.

For example, if I unplug and replug a mouse (that worked before unplugging),
it doesn't work any more.  I have to reload ohci_hcd to make it work again.

This is 100% reproducible and occurs on the two boxes above.

Appended in a snippet from a dmesg output that I think is relevant to this
issue.  It covers the unplugging and replugging of a USB mouse (there are no
more USB-related messages in the dmesg).

Greetings,
Rafael


hub 3-0:1.0: state 7 ports 4 chg 0000 evt 0010
ohci_hcd 0000:00:13.1: GetStatus roothub.portstatus [3] = 0x00030100 PESC CSC PPS
hub 3-0:1.0: port 4, status 0100, change 0003, 12 Mb/s
usb 3-4: USB disconnect, address 2
usb 3-4: unregistering device
usb 3-4: usb_disable_device nuking all URBs
ohci_hcd 0000:00:13.1: shutdown urb ffff81002f77d4b8 pipe 40408280 ep1in-intr
usb 3-4: unregistering interface 3-4:1.0
PM: Removing info for No Bus:usbdev3.2_ep81
 usbdev3.2_ep81: ep_device_release called for usbdev3.2_ep81
PM: Removing info for usb:3-4:1.0
usb 3-4:1.0: uevent
PM: Removing info for No Bus:usbdev3.2
PM: Removing info for No Bus:usbdev3.2_ep00
 usbdev3.2_ep00: ep_device_release called for usbdev3.2_ep00
PM: Removing info for usb:3-4
usb 3-4: uevent
hub 3-0:1.0: debounce: port 4: total 100ms stable 100ms status 0x100
hub 1-0:1.0: state 7 ports 8 chg 0000 evt 0100
ehci_hcd 0000:00:13.2: GetStatus port 8 status 001403 POWER sig=k CSC CONNECT
hub 1-0:1.0: port 8, status 0501, change 0001, 480 Mb/s
hub 1-0:1.0: debounce: port 8: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:13.2: port 8 low speed --> companion
ehci_hcd 0000:00:13.2: GetStatus port 8 status 003002 POWER OWNER sig=se0 CSC


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
