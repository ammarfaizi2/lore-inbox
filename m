Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262298AbSJOCnq>; Mon, 14 Oct 2002 22:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262301AbSJOCnq>; Mon, 14 Oct 2002 22:43:46 -0400
Received: from x101-201-88-dhcp.reshalls.umn.edu ([128.101.201.88]:8576 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S262298AbSJOCnq>;
	Mon, 14 Oct 2002 22:43:46 -0400
Date: Mon, 14 Oct 2002 21:49:34 -0500
From: Matt Reppert <arashi@arashi.yi.org>
To: linux-kernel@vger.kernel.org
Subject: "sleeping function called ... " on modprobe uhci-hcd
Message-Id: <20021014214934.35069015.arashi@arashi.yi.org>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this when I modprobed uhci-hcd ...

drivers/usb/core/hub.c: USB hub found at 0
drivers/usb/core/hub.c: 2 ports detected
PCI: Found IRQ 10 for device 00:1f.4
PCI: Sharing IRQ 10 with 01:0b.0
PCI: Setting latency timer of device 00:1f.4 to 64
drivers/usb/core/hcd-pci.c: uhci-hcd @ 00:1f.4, Intel Corp. 82801BA/BAM USB (Hub #2)
drivers/usb/core/hcd-pci.c: irq 10, io base 0000ef80
drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 2
drivers/usb/core/hub.c: USB hub found at 0
drivers/usb/core/hub.c: 2 ports detected
Debug: sleeping function called from illegal context at include/asm/semaphore.h:126
Call Trace:
 [<c0114054>] __might_sleep+0x54/0x60
 [<c01f46ad>] usb_hub_events+0x65/0x2b8
 [<c01f4935>] usb_hub_thread+0x35/0xe4
 [<c01f4900>] usb_hub_thread+0x0/0xe4
 [<c0112f50>] default_wake_function+0x0/0x34
 [<c01054a9>] kernel_thread_helper+0x5/0xc

drivers/usb/core/hub.c: new USB device 00:1f.2-1, assigned address 2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-00:1f.2-1

(This? :)
                /* Grab the next entry from the beginning of the list */
                tmp = hub_event_list.next;

                hub = list_entry(tmp, struct usb_hub, event_list);
                dev = interface_to_usbdev(hub->intf);

                list_del_init(tmp);

                down(&hub->khubd_sem); /* never blocks, we were on list */
                spin_unlock_irqrestore(&hub_event_lock, flags);


Linux-2.5.42-mm2 on i686.

Matt
