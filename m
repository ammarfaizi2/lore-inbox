Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130927AbRAYVVS>; Thu, 25 Jan 2001 16:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130938AbRAYVVI>; Thu, 25 Jan 2001 16:21:08 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:52018 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S130927AbRAYVU4>; Thu, 25 Jan 2001 16:20:56 -0500
Message-ID: <3A709946.51505EF6@ngforever.de>
Date: Thu, 25 Jan 2001 14:23:18 -0700
From: Thunder from the hill <thunder@ngforever.de>
X-Mailer: Mozilla 4.76 [en]C-CCK-MCD QXW03240  (WinNT; U)
X-Accept-Language: de,en-US
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: In kernel 2.4.0 in alloc_uhci when doing request_irq()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using an usual VIA MPV3 onboard USB device (on a AMD K6-II 400
machine), and it has ever worked fine on Linux (until including
2.4.0-test10). Now I wanted to use the "retail" 2.4.0-kernel, and USB
gets stuck while booting. Last messages are:
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.251 $time 07:06:37 Jan 14 2001
usb-uhci.c: high bandwidth mode enabled
PCI: Assigned IRQ 10 for device 00:07.2
usb-uhci.c: USB UHCI at I/O 0xe400, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1

That's all.
I debugged a while and noticed that the error occurs beyond
drivers/usb/usb-uhci.c in the function alloc_uhci() after start_hc (s);
when calling request_irq(), the line reads:
	if (request_irq (irq, uhci_interrupt, SA_SHIRQ, MODNAME, s)) {
The called function crashes somewhere on top, as I noticed.
Is there a patch avariable, or should I do further investigation?

Thunder
---
I did a "cat /boot/vmlinuz >> /dev/audio" - and I think I heard god...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
