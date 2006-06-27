Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbWF0TgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbWF0TgG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWF0TgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:36:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51354 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932546AbWF0TgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:36:05 -0400
Date: Tue, 27 Jun 2006 12:35:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Dmitry Torokhov <dtor_core@ameritech.net>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] Input update for 2.6.17
In-Reply-To: <Pine.LNX.4.64.0606271211110.3927@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0606271231440.3927@g5.osdl.org>
References: <200606260235.03718.dtor_core@ameritech.net>
 <Pine.LNX.4.64.0606262247040.3927@g5.osdl.org> <20060627063734.GA28135@kroah.com>
 <Pine.LNX.4.64.0606271131590.3927@g5.osdl.org> <Pine.LNX.4.64.0606271211110.3927@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Jun 2006, Linus Torvalds wrote:
> 
> There were _no_ kernel messages just before the oops. Not even with USB 
> debugging turned on. Of course, they may have been marked "informational", 
> and not shown on the console. Every distribution seems to think that debug 
> messages are more annoying than useful, so they tend to set the console 
> debug level down (even if you boot with "debug" to turn it on!). Gaah!

Ok, with that fixed, I get

	hub 4-1:1.0: 300mA power budget left
	hub 5-0:1.0: state 7 ports 2 chg 0000 evt 0000
	hub 4-1:1.0: state 7 ports 3 chg 0000 evt 0008
	usbcore: registered new driver libusual
	usbcore: registered new driver hiddev
	usbhid 5-1:1.0: usb_probe_interface
	usbhid 5-1:1.0: usb_probe_interface - got id
	input: HID 05ac:1000 as /class/input/input0
	input: USB HID v1.11 Keyboard [HID 05ac:1000] on usb-0000:00:1d.3-1
	usbhid 5-1:1.1: usb_probe_interface
	usbhid 5-1:1.1: usb_probe_interface - got id
	input: HID 05ac:1000 as /class/input/input1
	input: USB HID v1.11 Mouse [HID 05ac:1000] on usb-0000:00:1d.3-1
	usbhid 5-2:1.0: usb_probe_interface
	usbhid 5-2:1.0: usb_probe_interface - got id
	drivers/usb/core/file.c: looking for a minor, starting at 96
	PM: Adding info for No Bus:hiddev0
	hiddev96: USB HID v1.11 Device [Apple Computer, Inc. IR Receiver] on usb-0000:00:1d.3-2
	usbhid 1-6.3:1.0: usb_probe_interface
	usbhid 1-6.3:1.0: usb_probe_interface - got id
	drivers/usb/core/file.c: looking for a minor, starting at 96
	PM: Adding info for No Bus:hiddev1
	hiddev97: USB HID v1.11 Device [Apple Cinema Display] on usb-0000:00:1d.7-6.3
	usbhid 4-1.1:1.0: usb_probe_interface
	usbhid 4-1.1:1.0: usb_probe_interface - got id
	input: Mitsumi Electric Apple Optical USB Mouse as /class/input/input2
	input: USB HID v1.10 Mouse [Mitsumi Electric Apple Optical USB Mouse] on usb-0000:00:1d.2-1.1
	usbhid 4-1.3:1.0: usb_probe_interface
	usbhid 4-1.3:1.0: usb_probe_interface - got id
	input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input3
	input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB 
	Keyboard] on usb-0000:00:1d.2-1.3
	usbhid 4-1.3:1.1: usb_probe_interface
	usbhid 4-1.3:1.1: usb_probe_interface - got id
	input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input4
	input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] on usb-0000:00:1d.2-1.3
	usbcore: registered new driver usbhid
	drivers/usb/input/hid-core.c: v2.6:USB HID core driver
	PNP: No PS/2 controller found. Probing ports directly.
	PM: Adding info for platform:i8042
	i8042.c: No controller found.
	mice: PS/2 mouse device common for all mice
	i2c /dev entries driver

	... snip snip, mounting root filesystem etc - time passes ..

	usb 5-1: uhci_result_common: failed with status 440000
	usb 5-1: usbfs: USBDEVFS_CONTROL failed cmd hid2hci rqt 64 rq 0 len 0 ret -84
	usb 5-1: uhci_result_common: failed with status 440000
	usbhid 5-1:1.0: retrying intr urb
	usb 5-1: uhci_result_common: failed with status 440000
	hub 5-0:1.0: state 7 ports 2 chg 0000 evt 0002
	uhci_hcd 0000:00:1d.3: port 1 portsc 008a,00
	hub 5-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
	usb 5-1: USB disconnect, address 2
	usb 5-1: usb_disable_device nuking all URBs
	usb 5-1: unregistering interface 5-1:1.0
	PM: Removing info for No Bus:usbdev5.2_ep81
	 usbdev5.2_ep81: ep_device_release called for usbdev5.2_ep81

followed by the oops:

	BUG: spinlock bad magic on CPU#0, khubd/131
	BUG: unable to handle kernel paging request at virtual address 6b6b6c0b
	....

which just doesn't tell me anything.

		Linus
