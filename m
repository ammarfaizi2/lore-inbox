Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbTJGWmb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 18:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbTJGWmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 18:42:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:39148 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262925AbTJGWm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 18:42:28 -0400
Date: Tue, 7 Oct 2003 15:42:26 -0700
From: cliff white <cliffw@osdl.org>
To: linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: 2.6.0.test6 - ppc - OHCI-1394 - bad: scheduling while atomic!
Message-Id: <20031007154226.5bd55e43.cliffw@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This has been happening to me since ~9/25/2003, with the
linuxppc-2.5 bk tree on an iBook. Have not seen this error
on my Via mini-ITX system, which runs mainline BK, and also
has OHCI 1394. 

Problem: OHCI 1394 puts this error in logs. Happens if
compiled-in or built as module.

Normally i see this once during boot, and the device(s) runs
fine. Discovered i can make it happen at will with modular
driver by plugging/unplugging
devices, so i finally have a copy of the error message to send :) 

Distro: Debian unstable
Hardware: Mac iBook
Devices: two Firewire disk drives (Cypress chipset, afaik)

Log message:

ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
ohci1394_0: Unexpected PCI resource length of 1000!
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[40]  MMIO=[f5000000-f50007ff]  Max Packet=[2048]
bad: scheduling while atomic!
Call trace:
 [c0009e88] dump_stack+0x18/0x28
 [c0017624] schedule+0x830/0x834
 [c00061f4] syscall_exit_work+0x120/0x124
 [d796fd48] 0xd796fd48
 [d997dacc] nodemgr_add_host+0xac/0x11c [ieee1394]
 [d9979474] highlevel_add_host+0xac/0xb4 [ieee1394]
 [d9978684] hpsb_add_host+0x80/0xc0 [ieee1394]
 [d993c154] ohci1394_pci_probe+0x38c/0x4f4 [ohci1394]
 [c00fa00c] pci_device_probe_static+0x6c/0x8c
 [c00fa07c] __pci_device_probe+0x50/0x70
 [c00fa0cc] pci_device_probe+0x30/0x60
 [c01445a0] bus_match+0x50/0x8c
 [c0144720] driver_attach+0x88/0xc8
 [c0144a74] bus_add_driver+0x94/0xfc
 [c0144eec] driver_register+0x30/0x40
raw1394: /dev/raw1394 device initialized
sbp2: $Rev: 1034 $ Ben Collins <bcollins@debian.org>
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000393fffe73cddc]
Found KeyWest i2c on "mac-io", 1 channel, stepping: 4 bits
Found KeyWest i2c on "uni-n", 2 channels, stepping: 4 bits
registering 0-0034
drivers/usb/core/usb.c: registered new driver snd-usb-audio
bad: scheduling while atomic!
Call trace:
 [c0009e88] dump_stack+0x18/0x28
 [c0017624] schedule+0x830/0x834
 [c0017a64] wait_for_completion+0xa8/0x150
 [d997dc08] nodemgr_remove_host+0x60/0x94 [ieee1394]
 [d997952c] highlevel_remove_host+0xb0/0xc4 [ieee1394]
 [d9978760] hpsb_remove_host+0x9c/0xc0 [ieee1394]
 [d993c308] ohci1394_pci_remove+0x4c/0x260 [ohci1394]
 [c00fa15c] pci_device_remove+0x60/0x64
 [c01447e4] device_release_driver+0x84/0x88
 [c0144814] driver_detach+0x2c/0x50
 [c0144b2c] bus_remove_driver+0x50/0xa8
 [c0144f14] driver_unregister+0x18/0x78
 [c00fa3ac] pci_unregister_driver+0x1c/0x34
 [d993c91c] ohci1394_cleanup+0x18/0xf1c [ohci1394]
 [c0033d58] sys_delete_module+0x19c/0x230
Device 'fw-host0' does not have a release() function, it is broken and must be fixed.
Badness in device_release at drivers/base/core.c:85
Call trace:
 [c0009e88] dump_stack+0x18/0x28
 [c0006e9c] check_bug_trap+0x84/0xac
 [c0006ff4] ProgramCheckException+0x130/0x170
 [c00064ec] ret_from_except_full+0x0/0x4c
 [c0142f3c] device_release+0x4c/0x54
 [c00efa18] kobject_cleanup+0x98/0x9c
 [c014330c] put_device+0x14/0x24
 [d997dc18] nodemgr_remove_host+0x70/0x94 [ieee1394]
 [d997952c] highlevel_remove_host+0xb0/0xc4 [ieee1394]
 [d9978760] hpsb_remove_host+0x9c/0xc0 [ieee1394]
 [d993c308] ohci1394_pci_remove+0x4c/0x260 [ohci1394]
 [c00fa15c] pci_device_remove+0x60/0x64
 [c01447e4] device_release_driver+0x84/0x88
 [c0144814] driver_detach+0x2c/0x50
 [c0144b2c] bus_remove_driver+0x50/0xa8
IN from bad port 61 at c01daadc
----------------------

cliffw

