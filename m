Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVDBNiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVDBNiX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 08:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVDBNiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 08:38:23 -0500
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:30726 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S261481AbVDBNiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 08:38:16 -0500
Message-ID: <424EA042.3040100@roarinelk.homelinux.net>
Date: Sat, 02 Apr 2005 15:38:10 +0200
From: Manuel Lauss <mano@roarinelk.homelinux.net>
User-Agent: Thunderbird/1.0 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm4: oops in sysfs/symlink.c
References: <20050331022554.735a1118.akpm@osdl.org>
In-Reply-To: <20050331022554.735a1118.akpm@osdl.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

I get the following oops when I switch a Logitech USB Bluetooth Hub
into HCI mode (hid2hci utility):

usb 1-2.1.1: new low speed USB device using uhci_hcd and address 5
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:04.2-2.1.1
hiddev0: USB HID v1.10 Device [Logitech USB Receiver] on usb-0000:00:04.2-2.1.1

run hid2hci:

usb 1-2.1.2: new full speed USB device using uhci_hcd and address 6
------------[ cut here ]------------
kernel BUG at fs/sysfs/symlink.c:87!
invalid operand: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0060:[<c017afb0>]    Not tainted VLI
EFLAGS: 00010202   (2.6.12-rc1-mm4)
EIP is at sysfs_create_link+0x60/0x70
eax: d5fdba01   ebx: d78182ac   ecx: 00000000   edx: d5b8b201
esi: 00000000   edi: d5b8b274   ebp: d65003e0   esp: d7e9adb8
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 23, threadinfo=d7e9a000 task=d7e99a50)
Stack: d5b8b214 d5b8b274 00000002 c0279163 d5b8b214 c0458840 c02e6cd7 00000002
       d76112e0 c0314d27 d7ff8b70 d7ff414c 00000005 000000d0 d76112d0 00000002
       00000292 d65004c0 d65004a0 00000000 00000002 00000011 d5b8b200 d71517e0
Call Trace:
 [<c0279163>] device_bind_driver+0x33/0x60
 [<c02e6cd7>] usb_driver_claim_interface+0x57/0x60
 [<c0314d27>] hci_usb_probe+0x477/0x560
 [<c02e6a38>] usb_probe_interface+0x58/0x80
 [<c02791c0>] driver_probe_device+0x30/0x90
 [<c0279225>] __device_attach+0x5/0x10
 [<c02789ca>] bus_for_each_drv+0x3a/0x60
 [<c0210a8d>] populate_dir+0x3d/0x60
 [<c0279266>] device_attach+0x36/0x40
 [<c0279220>] __device_attach+0x0/0x10
 [<c0278b4b>] bus_add_device+0x2b/0x80
 [<c0277d81>] device_add+0xb1/0x150
 [<c02ee3f0>] usb_set_configuration+0x2e0/0x470
 [<c02e90e1>] usb_new_device+0x91/0x1c0
 [<c02ea02f>] hub_port_connect_change+0x19f/0x360
 [<c02ea3ad>] hub_events+0x1bd/0x360
 [<c011c91c>] sigprocmask+0x4c/0xc0
 [<c02ea595>] hub_thread+0x45/0x100
 [<c0124340>] autoremove_wake_function+0x0/0x50
 [<c0102812>] ret_from_fork+0x6/0x14
 [<c0124340>] autoremove_wake_function+0x0/0x50
 [<c02ea550>] hub_thread+0x0/0x100
 [<c0100d5d>] kernel_thread_helper+0x5/0x18
Code: 89 f9 89 f2 89 d8 e8 f0 fe ff ff 89 c1 8b 53 08 ff 42 70 0f 8e 35 02 00 00 8b 1c 24 89 c8 8b 74 24 04 8b 7c 24 08 83 c4 0c c3 90 <0f> 0b 57 00 f4 f6 3d c0 eb bf 8d b6 00 00 00 00 8b 40 30 e9 c8

-mm3 works fine, I'll try to find the culprit patch...

Thanks,

-- 
 Manuel Lauss

