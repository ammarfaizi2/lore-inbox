Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264766AbTFLKTK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 06:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264801AbTFLKTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 06:19:09 -0400
Received: from sea2-f40.sea2.hotmail.com ([207.68.165.40]:23812 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264766AbTFLKTD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 06:19:03 -0400
X-Originating-IP: [194.7.240.2]
X-Originating-Email: [lode_leroy@hotmail.com]
From: "lode leroy" <lode_leroy@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: lode_leroy@hotmail.com
Subject: 2.5.70 oops in ohci_hcd
Date: Thu, 12 Jun 2003 12:32:48 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F40xHyM96DX9QW0000c97a@hotmail.com>
X-OriginalArrivalTime: 12 Jun 2003 10:32:48.0615 (UTC) FILETIME=[F8259F70:01C330CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,
can anyone enlighten me on this OOPS:

I'm trying to boot 2.5.70 on a system with only USB keyboard and mouse
(i.e. no AT or PS/2 interface present)

-- lode

Jan  1 02:03:56 localhost kernel: hub 2-0:0: new USB device on port 1, 
assigned address 2
Jan  1 02:03:56 localhost kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 0000002b
Jan  1 02:03:56 localhost kernel:  printing eip:
Jan  1 02:03:56 localhost kernel: cf818ce5
Jan  1 02:03:56 localhost kernel: *pde = 00000000
Jan  1 02:03:56 localhost kernel: Oops: 0000 [#1]
Jan  1 02:03:56 localhost kernel: CPU:    0
Jan  1 02:03:56 localhost kernel: EIP:    0060:[<cf818ce5>]    Not tainted
Jan  1 02:03:56 localhost kernel: EFLAGS: 00010006
Jan  1 02:03:56 localhost kernel: EIP is at ed_get+0x55/0x210 [ohci_hcd]
Jan  1 02:03:56 localhost kernel: eax: 00000000   ebx: 00000000   ecx: 
cea7d400  edx: 00000003
Jan  1 02:03:56 localhost kernel: esi: cead4820   edi: 80000280   ebp: 
ce69bbfc  esp: ce69bbd0
Jan  1 02:03:56 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jan  1 02:03:56 localhost kernel: Process khubd (pid: 150, 
threadinfo=ce69a000 task=cecec080)
Jan  1 02:03:56 localhost kernel: Stack: f3080000 013eb4a0 00000000 ce6a69c0 
00000246 00000003 00000002 00000000
Jan  1 02:03:56 localhost kernel:        80000280 cea7d630 00000000 ce69bc34 
cf819995 cea7d400 ce43a800 80000280
Jan  1 02:03:56 localhost kernel:        00000000 00000002 00000000 00000000 
c02070f8 cea7d400 ce6a67e0 cea7d630
Jan  1 02:03:56 localhost kernel: Call Trace:
Jan  1 02:03:56 localhost kernel:  [<cf819995>] ohci_urb_enqueue+0x45/0x290 
[ohci_hcd]
Jan  1 02:03:56 localhost kernel:  [<c02070f8>] get_device+0x18/0x30
Jan  1 02:03:56 localhost kernel:  [<cf835b47>] hcd_submit_urb+0xf7/0x160 
[usbcore]
Jan  1 02:03:56 localhost kernel:  [<cf84a320>] usb_hcd_operations+0x0/0x20 
[usbcore]
Jan  1 02:03:56 localhost kernel:  [<cf8363b5>] usb_submit_urb+0x1d5/0x250 
[usbcore]
Jan  1 02:03:56 localhost kernel:  [<cf83652c>] 
usb_start_wait_urb+0x8c/0x190 [usbcore]
Jan  1 02:03:56 localhost kernel:  [<c013ca1d>] __get_free_pages+0x1d/0x60
Jan  1 02:03:56 localhost kernel:  [<c0111a7d>] dma_alloc_coherent+0x4d/0x90
Jan  1 02:03:56 localhost kernel:  [<c011d900>] 
default_wake_function+0x0/0x30
Jan  1 02:03:56 localhost kernel:  [<cf83617f>] usb_alloc_urb+0x2f/0x50 
[usbcore]
Jan  1 02:03:56 localhost kernel:  [<cf836697>] 
usb_internal_control_msg+0x67/0x80 [usbcore]
Jan  1 02:03:56 localhost kernel:  [<cf83673e>] usb_control_msg+0x8e/0xb0 
[usbcore]
Jan  1 02:03:56 localhost kernel:  [<cf836ef3>] usb_get_string+0x63/0x70 
[usbcore]
Jan  1 02:03:56 localhost kernel:  [<cf83761e>] usb_string+0xfe/0x1c0 
[usbcore]
Jan  1 02:03:56 localhost kernel:  [<cf84e464>] 
usb_hid_configure+0x2d4/0x6b0 [hid]
Jan  1 02:03:56 localhost kernel:  [<c011d900>] 
default_wake_function+0x0/0x30
Jan  1 02:03:56 localhost kernel:  [<c011d900>] 
default_wake_function+0x0/0x30
Jan  1 02:03:56 localhost kernel:  [<cf85389c>] hid_driver+0x7c/0xa0 [hid]
Jan  1 02:03:56 localhost kernel:  [<cf853838>] hid_driver+0x18/0xa0 [hid]
Jan  1 02:03:56 localhost kernel:  [<cf853820>] hid_driver+0x0/0xa0 [hid]
Jan  1 02:03:56 localhost kernel:  [<cf84e934>] hid_probe+0x14/0x1d0 [hid]
Jan  1 02:03:56 localhost kernel:  [<c012d660>] 
__call_usermodehelper+0x0/0x70
Jan  1 02:03:56 localhost kernel:  [<cf83e05b>] +0x23/0x8a8 [usbcore]
Jan  1 02:03:56 localhost kernel:  [<cf85389c>] hid_driver+0x7c/0xa0 [hid]
Jan  1 02:03:56 localhost kernel:  [<cf853838>] hid_driver+0x18/0xa0 [hid]
Jan  1 02:03:56 localhost kernel:  [<cf853820>] hid_driver+0x0/0xa0 [hid]
Jan  1 02:03:56 localhost kernel:  [<cf831092>] usb_device_probe+0x72/0xa0 
[usbcore]
Jan  1 02:03:56 localhost kernel:  [<cf8537e0>] hid_usb_ids+0x0/0x40 [hid]
Jan  1 02:03:56 localhost kernel:  [<cf853838>] hid_driver+0x18/0xa0 [hid]
Jan  1 02:03:56 localhost kernel:  [<c0207c53>] bus_match+0x43/0x80
Jan  1 02:03:56 localhost kernel:  [<cf853838>] hid_driver+0x18/0xa0 [hid]
Jan  1 02:03:56 localhost kernel:  [<cf853868>] hid_driver+0x48/0xa0 [hid]
Jan  1 02:03:56 localhost kernel:  [<cf84a13c>] usb_bus_type+0x5c/0x100 
[usbcore]
Jan  1 02:03:56 localhost kernel:  [<c0207cdf>] device_attach+0x4f/0x90
Jan  1 02:03:56 localhost kernel:  [<cf853838>] hid_driver+0x18/0xa0 [hid]
Jan  1 02:03:56 localhost kernel:  [<cf84a0e0>] usb_bus_type+0x0/0x100 
[usbcore]
Jan  1 02:03:56 localhost kernel:  [<c0207e93>] bus_add_device+0x63/0xb0
Jan  1 02:03:56 localhost kernel:  [<c020707f>] device_add+0xcf/0x100
Jan  1 02:03:56 localhost kernel:  [<cf832362>] usb_new_device+0x3f2/0x540 
[usbcore]
Jan  1 02:03:56 localhost kernel:  [<cf83e0c8>] +0x90/0x8a8 [usbcore]
Jan  1 02:03:56 localhost kernel:  [<cf834247>] 
usb_hub_port_connect_change+0x1c7/0x330 [usbcore]
Jan  1 02:03:56 localhost kernel:  [<cf8346c6>] usb_hub_events+0x316/0x360 
[usbcore]
Jan  1 02:03:56 localhost kernel:  [<cf834745>] usb_hub_thread+0x35/0xf0 
[usbcore]
Jan  1 02:03:56 localhost kernel:  [<c011d900>] 
default_wake_function+0x0/0x30
Jan  1 02:03:56 localhost kernel:  [<cf84a200>] khubd_wait+0x0/0x8 [usbcore]
Jan  1 02:03:56 localhost kernel:  [<cf84a200>] khubd_wait+0x0/0x8 [usbcore]
Jan  1 02:03:56 localhost kernel:  [<cf834710>] usb_hub_thread+0x0/0xf0 
[usbcore]
Jan  1 02:03:56 localhost kernel:  [<c010926d>] 
kernel_thread_helper+0x5/0x18
Jan  1 02:03:56 localhost kernel:
Jan  1 02:03:56 localhost kernel: Code: 80 7a 28 00 0f 85 e8 00 00 00 89 fe 
c1 ee 08 d1 eb c1 e3 07

_________________________________________________________________
Receive your Hotmail & Messenger messages on your mobile phone with MSN 
Mobile http://www.msn.be/gsm/smsservices

