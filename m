Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284122AbRLKVl2>; Tue, 11 Dec 2001 16:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284175AbRLKVlI>; Tue, 11 Dec 2001 16:41:08 -0500
Received: from quattro-eth.sventech.com ([205.252.89.20]:52498 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S284163AbRLKVlA>; Tue, 11 Dec 2001 16:41:00 -0500
Date: Tue, 11 Dec 2001 16:40:59 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB mouse disconnect/reconnect
Message-ID: <20011211164059.C8227@sventech.com>
In-Reply-To: <20011211222014.A13443@informatics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011211222014.A13443@informatics.muni.cz>; from kas@informatics.muni.cz on Tue, Dec 11, 2001 at 10:20:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2001, Jan Kasprzak <kas@informatics.muni.cz> wrote:
> 	I have (maybe HW) problem w/ my USB mouse. From time to time,
> the kernel thinks it was disconnected and then reconnected again,
> altough nobody touched the cables.
> 
> It would be OK, but there is a problem: after the reconnect, it become
> active as /dev/input/mouse1 instead of /dev/input/mouse0, and my
> X server cannot (of course) find it.
> 
> 	The system is RH7.2, kernel 2.4.16, Athlon 850 (ABIT KT7).
> Here is the dmesg output of the USB after boot:
> 
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> usb-uhci.c: $Revision: 1.268 $ time 19:53:08 Dec  5 2001
> usb-uhci.c: High bandwidth mode enabled
> PCI: Found IRQ 10 for device 00:07.2
> PCI: Sharing IRQ 10 with 00:07.3
> PCI: Sharing IRQ 10 with 00:0b.0
> usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 10
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> hub.c: 2 ports detected
> PCI: Found IRQ 10 for device 00:07.3
> PCI: Sharing IRQ 10 with 00:07.2
> PCI: Sharing IRQ 10 with 00:0b.0
> usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 10
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 2
> hub.c: USB hub found
> hub.c: 2 ports detected
> usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
> usb.c: registered new driver hid
> hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
> hid-core.c: USB HID support drivers
> mice: PS/2 mouse device common for all mice
> hub.c: USB new device connect on bus2/1, assigned device number 2
> input0: USB HID v1.00 Mouse [KYE Systems Genius USB Wheel Mouse   ] on usb2:2.0
> hub.c: USB new device connect on bus2/2, assigned device number 3
> input1: USB HID v1.10 Keyboard [Chicony USB Keyboard] on usb2:3.0
> 
> 	And the disconnect/reconnect looks like this:
> 
> usb.c: USB disconnect on device 2
> hub.c: USB new device connect on bus2/1, assigned device number 4
> input0: USB HID v1.00 Mouse [KYE Systems Genius USB Wheel Mouse   ] on usb2:4.0
> 
> 	Where the disconnect/reconnect come from, and why the mouse
> changes its device number?

It may be because of a flaky cable. Are there any messages above that?

The device number changes because some process still has the first mouse
open, so it assigns it the next available unused device.

There's a shared mouse device as well you might find more to your
liking.

JE

