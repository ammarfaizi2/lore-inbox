Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266165AbUBLHI5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 02:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266218AbUBLHI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 02:08:56 -0500
Received: from [61.149.139.68] ([61.149.139.68]:30457 "EHLO
	kapok.exavio.com.cn") by vger.kernel.org with ESMTP id S266165AbUBLHIw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 02:08:52 -0500
Date: Thu, 12 Feb 2004 15:12:02 +0800
From: Isaac Claymore <clay@exavio.com.cn>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.2 hangs with usb flashdisk plugged
Message-ID: <20040212071202.GA536@exavio.com.cn>
Mail-Followup-To: Isaac Claymore <clay@exavio.com.cn>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Every time I plug my usb flashdisk (not sure what you native speakers
call it, it's a key-sized 128M usb storage device) into the system, the
kernel hangs immediately with no panic message, after spitting a few
lines like this:

hub 1-0:1.0 over-current change on port 4
hub 1-0:1.0 over-current change on port 6
hub 1-0:1.0 over-current change on port 4
hub 1-0:1.0 over-current change on port 6

It's absolutely reproduceable on 2.6.2, and here's some context info:

clay kapok:~ [1028]% uname -a
Linux kapok 2.6.2 #1 Thu Feb 12 13:59:28 CST 2004 i686 GNU/Linux

clay kapok:~ [1030]% lspci -v
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 5247
	Flags: bus master, medium devsel, latency 0, IRQ 16
	I/O ports at e800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 5247
	Flags: bus master, medium devsel, latency 0, IRQ 19
        I/O ports at e880 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 5247
	Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at ec00 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 02) (prog-if 20 [EHCI])
        Subsystem: Intel Corp.: Unknown device 5247
        Flags: bus master, medium devsel, latency 0, IRQ 23
        Memory at ffa7fc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: <available only to root>

kapok:~ [10]# modprobe usbcore
drivers/usb/core/usb.c: registered new driver hub

kapok:~ [10]# modprobe ehci-hcd
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem d027fc00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
hub 1-0:1.0: over-current change on port 4
hub 1-0:1.0: over-current change on port 6


To this point, everything goes just fine. But, whenever I plug in my usb
flashdisk, the system completely freezes, and nothing responses but the
poweroff button.

I'm using a vanilla 2.6.2.

If additional information is needed to diagnose it, plz let me known.

-- 

Regards, Isaac
()  ascii ribbon campaign - against html e-mail
/\                        - against microsoft attachments
