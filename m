Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265502AbUABKpr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 05:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265503AbUABKpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 05:45:46 -0500
Received: from elma.elma.fi ([192.89.233.77]:52181 "EHLO elma.elma.fi")
	by vger.kernel.org with ESMTP id S265502AbUABKpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 05:45:34 -0500
Date: Fri, 2 Jan 2004 12:45:32 +0200 (EET)
From: Antti Lankila <alankila@elma.net>
To: linux-kernel@vger.kernel.org
Subject: USB_UHCI hangs with Thinkpad A31 in 2.6.1-rc1
Message-ID: <Pine.A41.4.58.0401021209360.56310@tokka.elma.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the 2.6.0 kernel, my Microsoft Notebook USB mouse does not recover from
APM suspend. The light on the backside stays dark. /var/log/messages says:

Dec 31 20:43:37 laptop kernel: usb 2-1: control timeout on ep0out

but this works in the 2.4 kernels. With -rc1, the system locked solid when the
usb_uhci driver got modprobed. No keyboard input, no disk activity, and when
re-inserting the USB mouse (which is enabled by BIOS at reset), the light
remained dark.  I saw the first 3 or 4 lines about detected hubs before it
froze, but I don't have those lines in my system logs.  I only remember they
were very similar to lines from my 2.6.0:

Jan  2 09:57:01 laptop kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Jan  2 09:57:01 laptop kernel: uhci_hcd 0000:00:1d.1: irq 10, io base 00001820
Jan  2 09:57:01 laptop kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2

Here's what lspci -v has to say about the controllers:

00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02) (prog-if 00 [UHCI])
        Subsystem: IBM ThinkPad A/T/X Series
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at 1800 [size=32]

And two more near-identical entries with IRQ10, io-port 1820 and IRQ10, 1840.
My kernel config's enabled USB options are as follows:

CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y

Please reply with a CC to me if there is any more information you need.

-- 
Antti
