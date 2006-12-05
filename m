Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968583AbWLESfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968583AbWLESfM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 13:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968586AbWLESfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 13:35:12 -0500
Received: from smtp1.pochta.ru ([81.211.64.6]:15863 "EHLO smtp1.pochta.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968583AbWLESfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 13:35:10 -0500
Message-ID: <4575BC35.7050008@hotbox.ru>
Date: Tue, 05 Dec 2006 21:36:37 +0300
From: Oleg Mikheev <mihel@hotbox.ru>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.19 and RealTek RTL8139 interrupt
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SpamTest-Envelope-From: mihel@hotbox.ru
X-SpamTest-Group-ID: 00000000
X-SpamTest-Info: Profiles 566 [Dec 05 2006]
X-SpamTest-Info: helo_type=3
X-SpamTest-Method: none
X-SpamTest-Rate: 0
X-SpamTest-Status: Not detected
X-SpamTest-Status-Extended: not_detected
X-SpamTest-Version: SMTP-Filter Version 3.0.0 [0255], KAS30/Release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I'm using FC5 with vanilla kernels.
Everything worked great until 2.6.19 was released.
Not each time I'm trying to up my eth0 kernel produces this:


eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
irq 18: nobody cared (try booting with the "irqpoll" option)
  [<c01391aa>] __report_bad_irq+0x36/0x7d
  [<c0139379>] note_interrupt+0x188/0x1c3
  [<c0138a19>] handle_IRQ_event+0x1a/0x3f
  [<c01396ca>] handle_fasteoi_irq+0x61/0x73
  [<c0104e34>] do_IRQ+0x6b/0x83
  [<c0120c76>] sys_rt_sigprocmask+0x80/0x93
  [<c01034a2>] common_interrupt+0x1a/0x20
  =======================
handlers:
[<c0257416>] (rtl8139_interrupt+0x0/0x3aa)
Disabling IRQ #18


I'm posting it here b/c I don't think it's a normal behavior.
Here is the diff of dmesg output between 2.6.18.3 and 2.6.19:


140,142c141,143
< 8139too Fast Ethernet driver 0.9.27
< ACPI: PCI Interrupt 0000:01:06.0[A] -> GSI 20 (level, low) -> IRQ 20
< eth0: RealTek RTL8139 at 0xf8806c00, 00:40:45:28:2c:ae, IRQ 20
---
 > 8139too Fast Ethernet driver 0.9.28
 > ACPI: PCI Interrupt 0000:01:06.0[A] -> GSI 20 (level, low) -> IRQ 18
 > eth0: RealTek RTL8139 at 0xf8806c00, 00:40:45:28:2c:ae, IRQ 18
147c148
< ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
---
 > ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 19
197,198c198,200
< TCP bic registered
< Initializing IPsec netlink socket
---
 > input: AT Translated Set 2 keyboard as /class/input/input0
 > TCP cubic registered
 > Initializing XFRM netlink socket
294,306c305,310
< Non-volatile memory driver v1.2
< usb 4-2: new full speed USB device using uhci_hcd and address 2
< PM: Adding info for usb:4-2
< PM: Adding info for No Bus:usbdev4.2_ep00
< usb 4-2: configuration #1 chosen from 1 choice
< PM: Adding info for usb:4-2:1.0
< PM: Adding info for No Bus:usbdev4.2_ep81
< PM: Adding info for No Bus:usbdev4.2_ep02
< PM: Adding info for No Bus:usbdev4.2_ep82
< PM: Adding info for usb:4-2:1.1
< PM: Adding info for No Bus:usbdev4.2_ep03
< PM: Adding info for No Bus:usbdev4.2_ep83
< Bluetooth: Core ver 2.10
---
 > PM: Adding info for No Bus:usbdev3.2_ep02
 > PM: Adding info for No Bus:usbdev3.2_ep82
 > PM: Adding info for usb:3-2:1.1
 > PM: Adding info for No Bus:usbdev3.2_ep03
 > PM: Adding info for No Bus:usbdev3.2_ep83
 > Bluetooth: Core ver 2.11
312,315c316,319
< PM: Removing info for No Bus:usbdev4.2_ep03
< PM: Removing info for No Bus:usbdev4.2_ep83
< PM: Adding info for No Bus:usbdev4.2_ep03
< PM: Adding info for No Bus:usbdev4.2_ep83
---
 > PM: Removing info for No Bus:usbdev3.2_ep03
 > PM: Removing info for No Bus:usbdev3.2_ep83
 > PM: Adding info for No Bus:usbdev3.2_ep03
 > PM: Adding info for No Bus:usbdev3.2_ep83
317,320c321
< usbcore: registered new driver hci_usb
< PM: Adding info for ieee1394:00012f650000d9b3
< ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00012f650000d9b3]
< PM: Adding info for ieee1394:00012f650000d9b3-0
---
 > usbcore: registered new interface driver hci_usb
322c323
< device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: 
dm-devel@redhat.com
---
 > device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: 
dm-devel@redhat.com
