Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbTIEFgI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 01:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbTIEFgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 01:36:08 -0400
Received: from a3hr6fay45cl.bc.hsia.telus.net ([216.232.206.119]:3851 "EHLO
	cyclops.implode.net") by vger.kernel.org with ESMTP id S262092AbTIEFgE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 01:36:04 -0400
Date: Thu, 4 Sep 2003 22:35:49 -0700
From: John Wong <kernel@implode.net>
To: linux-kernel@vger.kernel.org
Subject: USB mouse lockup
Message-ID: <20030905053549.GA480@gambit.implode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While in X, the mouse all of a sudden stopped working.  This is a usb
mouse on 2.6.0-test4 on a nForce2 system.  Previously, when I had this
problem on 2.4.21-x when the various nForce2 support was being worked
on, my temp fix was to remove the ohci-usb module and reload.  I haven't
run into problems in 2.4.22.  With 2.6.0-test4 however, when I try
remove the usb module, I got this:

Sep  4 22:24:17 gambit kernel: ohci-hcd 0000:00:02.0: remove, state 3
Sep  4 22:24:17 gambit kernel: usb usb2: USB disconnect, address 1
Sep  4 22:24:17 gambit kernel: usb 2-1: USB disconnect, address 2
Sep  4 22:24:17 gambit kernel: PM: Removing info for usb:2-1:0
Sep  4 22:24:17 gambit kernel: PM: Removing info for usb:2-1
Sep  4 22:24:17 gambit kernel: usb 2-2: USB disconnect, address 3
Sep  4 22:24:18 gambit kernel: Badness in ohci_endpoint_disable at
drivers/usb/host/ohci-hcd.c:342
Sep  4 22:24:18 gambit kernel: Call Trace:
Sep  4 22:24:18 gambit kernel:  [__crc_blk_rq_map_sg+5050497/5710020]
ohci_endpoint_disable+0xdc/0x1b0 [ohci_hcd]
Sep  4 22:24:18 gambit kernel:  [__wake_up_common+49/96]
__wake_up_common+0x31/0x60
Sep  4 22:24:18 gambit kernel:  [hcd_endpoint_disable+231/416]
hcd_endpoint_disable+0xe7/0x1a0
Sep  4 22:24:18 gambit kernel:  [usb_disable_endpoint+116/128]
usb_disable_endpoint+0x74/0x80
Sep  4 22:24:18 gambit kernel:  [usb_disable_device+55/64]
usb_disable_device+0x37/0x40
Sep  4 22:24:18 gambit kernel:  [usb_disconnect+138/272]
usb_disconnect+0x8a/0x110
Sep  4 22:24:18 gambit kernel:  [usb_disconnect+251/272]
usb_disconnect+0xfb/0x110
Sep  4 22:24:18 gambit kernel:  [usb_hcd_pci_remove+127/384]
usb_hcd_pci_remove+0x7f/0x180
Sep  4 22:24:18 gambit kernel:  [pci_device_remove+59/64]
pci_device_remove+0x3b/0x40
Sep  4 22:24:18 gambit kernel:  [device_release_driver+100/112]
device_release_driver+0x64/0x70
Sep  4 22:24:18 gambit kernel:  [driver_detach+32/48]
driver_detach+0x20/0x30
Sep  4 22:24:18 gambit kernel:  [bus_remove_driver+61/128]
bus_remove_driver+0x3d/0x80
Sep  4 22:24:18 gambit kernel:  [driver_unregister+19/40]
driver_unregister+0x13/0x28
Sep  4 22:24:18 gambit kernel:  [pci_unregister_driver+22/48]
pci_unregister_driver+0x16/0x30
Sep  4 22:24:18 gambit kernel:  [__crc_blk_rq_map_sg+5053396/5710020]
ohci_hcd_pci_cleanup+0xf/0x13 [ohci_hcd]
Sep  4 22:24:18 gambit kernel:  [sys_delete_module+307/336]
sys_delete_module+0x133/0x150
Sep  4 22:24:18 gambit kernel:  [sys_munmap+68/112] sys_munmap+0x44/0x70
Sep  4 22:24:18 gambit kernel:  [syscall_call+7/11] syscall_call+0x7/0xb


John
