Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266322AbSLCW3Q>; Tue, 3 Dec 2002 17:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266347AbSLCW3P>; Tue, 3 Dec 2002 17:29:15 -0500
Received: from pc2-cmbg2-4-cust80.cmbg.cable.ntl.com ([80.2.247.80]:46589 "EHLO
	flat") by vger.kernel.org with ESMTP id <S266322AbSLCW3P>;
	Tue, 3 Dec 2002 17:29:15 -0500
From: Charles Baylis <cb-lkml@fish.zetnet.co.uk>
To: linux-kernel@vger.kernel.org
Subject: [2.5.50-mm1] scheduling while atomic
Date: Tue, 3 Dec 2002 22:36:45 +0000
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200212032236.45974.cb-lkml@fish.zetnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I get this back trace by removing a usb bluetooth dongle using the in-kernel 
bluetooth stack and the hci_usb driver.

I'm using 2.5.50-mm1 and PREEMPT=y.

Charlie

bad: scheduling while atomic!
Call Trace:
 [<c0116201>] do_schedule+0x3d/0x2c8
 [<c01166f5>] wait_for_completion+0x8d/0xd0
 [<c01164d0>] default_wake_function+0x0/0x34
 [<c01164d0>] default_wake_function+0x0/0x34
 [<c8d112ca>] hcd_unlink_urb+0x16a/0x1ac [usbcore]
 [<c8db498c>] hci_usb_driver+0x8c/0xa0 [hci_usb]
 [<c8db3d10>] hci_usb_interrupt+0x0/0x324 [hci_usb]
 [<c8d11790>] usb_unlink_urb+0x28/0x38 [usbcore]
 [<c8db31b4>] hci_usb_disable_intr+0x14/0x60 [hci_usb]
 [<c8db3603>] hci_usb_close+0x43/0x140 [hci_usb]
 [<c8db498c>] hci_usb_driver+0x8c/0xa0 [hci_usb]
 [<c8db47e4>] hci_usb_disconnect+0x24/0x68 [hci_usb]
 [<c8db4900>] hci_usb_driver+0x0/0xa0 [hci_usb]
 [<c8d0d1dd>] usb_device_remove+0xad/0x110 [usbcore]
 [<c8db4918>] hci_usb_driver+0x18/0xa0 [hci_usb]
 [<c01b043a>] detach+0x46/0x60
 [<c8d1cd80>] usb_bus_type+0x0/0x120 [usbcore]
 [<c01b0467>] device_detach+0x13/0x18
 [<c8db4918>] hci_usb_driver+0x18/0xa0 [hci_usb]
 [<c01b0596>] bus_remove_device+0x56/0xac
 [<c8d18423>] +0x23/0x1a9c [usbcore]
 [<c01afb61>] device_del+0x71/0x94
 [<c01afb91>] device_unregister+0xd/0x1a
 [<c8d0d9fe>] usb_disconnect+0x7a/0xc8 [usbcore]
 [<c8d0f97d>] usb_hub_port_connect_change+0x59/0x258 [usbcore]
 [<c8d0f696>] usb_hub_port_status+0x7a/0x88 [usbcore]
 [<c8d0fcb8>] usb_hub_events+0x13c/0x2d0 [usbcore]
 [<c8d0fe85>] usb_hub_thread+0x39/0xd8 [usbcore]
 [<c8d0fe4c>] usb_hub_thread+0x0/0xd8 [usbcore]
 [<c01164d0>] default_wake_function+0x0/0x34
 [<c8d1cecc>] khubd_wait+0x4/0xc [usbcore]
 [<c8d1cecc>] khubd_wait+0x4/0xc [usbcore]
 [<c0107081>] kernel_thread_helper+0x5/0xc

