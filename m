Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266202AbUFJGGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266202AbUFJGGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 02:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUFJGGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 02:06:46 -0400
Received: from prosun.first.gmd.de ([194.95.168.2]:45023 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266202AbUFJGGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 02:06:43 -0400
Subject: oops on wake up using usb-keyb/mouse on powerbook
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Benjamin Herrenschmidt <benh@KERNEL.CRASHING.ORG>
Content-Type: text/plain
Message-Id: <1086811906.24317.4.camel@localhost>
Mime-Version: 1.0
Date: Thu, 10 Jun 2004 08:06:20 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I get this oops when I use a usb keyboard to wakeup the powerbook.
Kernel is 2.6.7-rc2, usb keyboard is infect a ps2 keyboard attached via
a usb->ps2 adapter.

Any ideas ?
Soeren.

kernel: ohci_hcd 0001:01:18.0: HC died; cleaning up
kernel: drivers/usb/input/hid-core.c: can't resubmit intr, 0001:01:18.0-1/input1, status -108
kernel: usb 1-1: USB disconnect, address 3
kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1359
kernel: Call trace:
kernel: [c0009c84] dump_stack+0x18/0x28
kernel: [c0006ed4] check_bug_trap+0xb4/0xf0
kernel: [c0007070] ProgramCheckException+0x160/0x190
kernel: [c0006514] ret_from_except_full+0x0/0x4c
kernel: [c02870b8] hcd_endpoint_disable+0x44/0x190
kernel: [c0288804] usb_disable_endpoint+0xa8/0xac
kernel: [c028897c] usb_disable_device+0x10c/0x128
kernel: [c028289c] usb_disconnect+0xac/0x110
kernel: [c0287400] hcd_panic+0x68/0x70
kernel: [c0030124] worker_thread+0x17c/0x21c
kernel: [c0033ff0] kthread+0xb8/0xc0
kernel: [c0009384] kernel_thread+0x44/0x60
kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1359
kernel: ohci_hcd 0001:01:18.0: leak ed efb69040 (#2) state 0 (has tds)
[repeating several times]
kernel: Call trace:
kernel: [c0009c84] dump_stack+0x18/0x28
kernel: [c0006ed4] check_bug_trap+0xb4/0xf0
kernel: [c0007070] ProgramCheckException+0x160/0x190
kernel: [c0006514] ret_from_except_full+0x0/0x4c
kernel: [c0286edc] hcd_unlink_urb+0xa4/0x23c
kernel: [c02878a4] usb_unlink_urb+0x5c/0x64
kernel: [c0297ab0] hid_disconnect+0x40/0xcc
kernel: [c0281b48] usb_unbind_interface+0x88/0x8c
kernel: [c021c6e0] device_release_driver+0x84/0x88
kernel: [c021c880] bus_remove_device+0x74/0xd0
kernel: [c021b250] device_del+0xa8/0x114
kernel: [c0288958] usb_disable_device+0xe8/0x128
kernel: [c028289c] usb_disconnect+0xac/0x110
kernel: [c0287400] hcd_panic+0x68/0x70
kernel: [c0030124] worker_thread+0x17c/0x21c
kernel: Badness in hcd_unlink_urb at drivers/usb/core/hcd.c:1246
times]
kernel: Call trace:
kernel: [c0009c84] dump_stack+0x18/0x28
kernel: [c0006ed4] check_bug_trap+0xb4/0xf0
kernel: [c0007070] ProgramCheckException+0x160/0x190
kernel: [c0006514] ret_from_except_full+0x0/0x4c
kernel: [c0286edc] hcd_unlink_urb+0xa4/0x23c
kernel: [c02878a4] usb_unlink_urb+0x5c/0x64
kernel: [c0297190] hid_close+0x38/0x3c
kernel: [c029a88c] hidinput_close+0x14/0x24
kernel: [c029b22c] input_close_device+0x50/0x54
kernel: [c029eb88] evdev_disconnect+0x44/0x6c
kernel: [c029bd08] input_unregister_device+0x90/0x114
kernel: [c029ab58] hidinput_disconnect+0x3c/0x80
kernel: [c0297b20] hid_disconnect+0xb0/0xcc
kernel: [c0281b48] usb_unbind_interface+0x88/0x8c
kernel: [c021c6e0] device_release_driver+0x84/0x88


