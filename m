Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268121AbUILQJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268121AbUILQJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 12:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268365AbUILQJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 12:09:27 -0400
Received: from share.sks3.muni.cz ([147.251.211.22]:57009 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S268121AbUILQJP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 12:09:15 -0400
Date: Sun, 12 Sep 2004 18:09:09 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc1-mm4 - USB suspend issues
Message-ID: <20040912160909.GQ2260@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've tried suspend/resume code of USB devices. Unfortunately it does not work :(

First it complains that USB device has 0 interrupts (as module was not used
since start but it was loaded)

Second I got following messages:
Sep 11 12:55:33 debian kernel: usb_unlink_urb() is deprecated for synchronous
unlinks.  Use usb_kill_urb()
Sep 11 12:55:33 debian kernel: Badness in usb_unlink_urb at
drivers/usb/core/urb.c:456
Sep 11 12:55:33 debian kernel:  [usb_unlink_urb+132/144]
usb_unlink_urb+0x84/0x90
Sep 11 12:55:33 debian kernel:  [port_release+142/195] port_release+0x8e/0xc3
Sep 11 12:55:33 debian kernel:  [destroy_inode+78/80] destroy_inode+0x4e/0x50
Sep 11 12:55:33 debian kernel:  [device_release+25/92] device_release+0x19/0x5c
Sep 11 12:55:33 debian kernel:  [iput+85/111] iput+0x55/0x6f
Sep 11 12:55:33 debian kernel:  [kobject_cleanup+152/154]
kobject_cleanup+0x98/0x9a
Sep 11 12:55:33 debian kernel:  [kobject_release+0/10] kobject_release+0x0/0xa
Sep 11 12:55:33 debian kernel:  [kref_put+57/147] kref_put+0x39/0x93
Sep 11 12:55:33 debian kernel:  [kobject_put+30/34] kobject_put+0x1e/0x22
Sep 11 12:55:33 debian kernel:  [kobject_put+30/34] kobject_put+0x1e/0x22
Sep 11 12:55:33 debian kernel:  [kobject_release+0/10] kobject_release+0x0/0xa
Sep 11 12:55:33 debian kernel:  [destroy_serial+313/373]
destroy_serial+0x139/0x175
Sep 11 12:55:33 debian kernel:  [hcd_endpoint_disable+179/323]
hcd_endpoint_disable+0xb3/0x143
Sep 11 12:55:33 debian kernel:  [destroy_serial+0/373] destroy_serial+0x0/0x175
Sep 11 12:55:33 debian kernel:  [kref_put+57/147] kref_put+0x39/0x93
Sep 11 12:55:33 debian kernel:  [usb_disable_endpoint+79/81]
usb_disable_endpoint+0x4f/0x51
Sep 11 12:55:33 debian kernel:  [usb_serial_disconnect+64/147]
usb_serial_disconnect+0x40/0x93
Sep 11 12:55:33 debian kernel:  [destroy_serial+0/373] destroy_serial+0x0/0x175
Sep 11 12:55:33 debian kernel:  [usb_unbind_interface+122/124]
usb_unbind_interface+0x7a/0x7c
Sep 11 12:55:33 debian kernel:  [device_release_driver+100/102]
device_release_driver+0x64/0x66
Sep 11 12:55:33 debian kernel:  [bus_remove_device+100/165]
bus_remove_device+0x64/0xa5
Sep 11 12:55:33 debian kernel:  [device_del+93/155] device_del+0x5d/0x9b
Sep 11 12:55:33 debian kernel:  [usb_disable_device+185/249]
usb_disable_device+0xb9/0xf9
Sep 11 12:55:33 debian kernel:  [usb_disconnect+173/300]
usb_disconnect+0xad/0x12c
Sep 11 12:55:33 debian kernel:  [hub_port_connect_change+901/951]
hub_port_connect_change+0x385/0x3b7
Sep 11 12:55:33 debian kernel:  [clear_port_feature+88/92]
clear_port_feature+0x58/0x5c 
Sep 11 12:55:33 debian kernel:  [hub_events+625/947] hub_events+0x271/0x3b3
Sep 11 12:55:33 debian kernel:  [hub_thread+47/290] hub_thread+0x2f/0x122
Sep 11 12:55:33 debian kernel:  [autoremove_wake_function+0/87]
autoremove_wake_function+0x0/0x57
Sep 11 12:55:33 debian kernel:  [autoremove_wake_function+0/87]
autoremove_wake_function+0x0/0x57
Sep 11 12:55:33 debian kernel:  [hub_thread+0/290] hub_thread+0x0/0x122
Sep 11 12:55:33 debian kernel:  [kernel_thread_helper+5/11]
kernel_thread_helper+0x5/0xb

After resume it disables IRQ 11 for USB and that IRQ is shared with eth0:

Sep 11 12:56:04 debian kernel:
....................................................swsusp: Need to copy 22829
pages
Sep 11 12:56:04 debian kernel: ..<3>irq 11: nobody cared!
Sep 11 12:56:04 debian kernel:  [__report_bad_irq+42/139]
__report_bad_irq+0x2a/0x8b
Sep 11 12:56:04 debian kernel:  [note_interrupt+124/222]
note_interrupt+0x7c/0xde
Sep 11 12:56:04 debian kernel:  [do_IRQ+235/237] do_IRQ+0xeb/0xed
Sep 11 12:56:04 debian kernel:  [common_interrupt+24/32]
common_interrupt+0x18/0x20
Sep 11 12:56:05 debian kernel:  [__do_softirq+47/138] __do_softirq+0x2f/0x8a
Sep 11 12:56:05 debian kernel:  [do_softirq+38/40] do_softirq+0x26/0x28
Sep 11 12:56:05 debian kernel:  [do_IRQ+202/237] do_IRQ+0xca/0xed
Sep 11 12:56:05 debian kernel:  [common_interrupt+24/32]
common_interrupt+0x18/0x20
Sep 11 12:56:05 debian kernel:  [setup_irq+120/170] setup_irq+0x78/0xaa
Sep 11 12:56:05 debian kernel:  [usb_hcd_irq+0/103] usb_hcd_irq+0x0/0x67
Sep 11 12:56:05 debian kernel:  [request_irq+167/220] request_irq+0xa7/0xdc
Sep 11 12:56:05 debian kernel:  [pci_find_capability+41/45]
pci_find_capability+0x29/0x2d
Sep 11 12:56:05 debian kernel:  [usb_hcd_pci_resume+143/326]
usb_hcd_pci_resume+0x8f/0x146
Sep 11 12:56:05 debian kernel:  [usb_hcd_irq+0/103] usb_hcd_irq+0x0/0x67
Sep 11 12:56:05 debian kernel:  [pci_device_resume+44/46]
pci_device_resume+0x2c/0x2e
Sep 11 12:56:05 debian kernel:  [resume_device+39/41] resume_device+0x27/0x29
Sep 11 12:56:05 debian kernel:  [dpm_resume+98/100] dpm_resume+0x62/0x64
Sep 11 12:56:05 debian kernel:  [device_resume+21/33] device_resume+0x15/0x21
Sep 11 12:56:05 debian kernel:  [finish+8/58] finish+0x8/0x3a
Sep 11 12:56:05 debian kernel:  [pm_suspend_disk+65/126]
pm_suspend_disk+0x41/0x7e
Sep 11 12:56:05 debian kernel:  [enter_state+140/144] enter_state+0x8c/0x90
Sep 11 12:56:05 debian kernel:  [software_suspend+15/19]
software_suspend+0xf/0x13
Sep 11 12:56:05 debian kernel:  [acpi_system_write_sleep+139/141]
acpi_system_write_sleep+0x8b/0x8d
Sep 11 12:56:05 debian kernel:  [vfs_write+188/295] vfs_write+0xbc/0x127
Sep 11 12:56:05 debian kernel:  [sys_write+81/128] sys_write+0x51/0x80
Sep 11 12:56:05 debian kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

-- 
Luká¹ Hejtmánek
