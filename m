Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268964AbUJEKLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268964AbUJEKLE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 06:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268947AbUJEKKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 06:10:37 -0400
Received: from build.arklinux.osuosl.org ([128.193.0.51]:2541 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S268964AbUJEKIe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 06:08:34 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: LINUX4MEDIA GmbH
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc3-mm2 USB Oopses
Date: Tue, 5 Oct 2004 11:45:32 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200410051145.32824.bero@arklinux.org>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting this on bootup when probing for USB devices when a USB-to-serial 
converter (pl2303, worked in earlier 2.6 and 2.4 kernels) is attached [this is 
2.6.9-rc3-mm2 w/ the patches for the network lockups posted on lkml 
yesterday, on an athlon64 in 32 bit mode]:

usb 3-2: new full speed USB device using address 2
Unable to handle kernel paging request at virtual address 41c5f00c
 printing eip:
c014950d
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: ehci_hcd uhci_hcd usbcore thermal processor fan button 
battery asus_acpi ac rtc sd_mod scsi_mod
CPU:    0
EIP:    0060:[<c014950d>]    Not tainted VLI
EFLAGS: 00010096   (2.6.9-0.rc3.1ark)
EIP is at kmem_cache_alloc+0x1d/0x40
eax: d9f40fff   ebx: 00000086   ecx: c16b0980   edx: d9f5b000
esi: c16b8980   edi: dfe00200   ebp: 00000292   esp: df1fbda0
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 351, threadinfo=df1fb000 task=df2391b0)
Stack: 00000000 e0864a00 fffffff4 e0b8e2b8 c16b0980 00000020 fffffff4 c16b8980
       dfe00200 e0b8f2be dfe00200 c16b8980 c01da217 dfe0bd00 dfe0bc00 00000000
       c16b8980 00000000 dfe00200 00000246 e0864208 dfe00200 c16b8980 00000010
Call Trace:
 [<e0864a00>] urb_destroy+0x0/0x10 [usbcore]
 [<e0b8e2b8>] uhci_alloc_urb_priv+0x28/0x90 [uhci_hcd]
 [<e0b8f2be>] uhci_urb_enqueue+0x7e/0x2d0 [uhci_hcd]
 [<c01da217>] kobject_get+0x17/0x20
 [<e0864208>] hcd_submit_urb+0x138/0x1c0 [usbcore]
 [<e0865011>] usb_start_wait_urb+0x51/0xf0 [usbcore]
 [<e086511b>] usb_internal_control_msg+0x6b/0x80 [usbcore]
 [<e08651c9>] usb_control_msg+0x99/0xc0 [usbcore]
 [<e086183d>] usb_get_descriptor_broken+0x6d/0x80 [usbcore]
 [<e08619c9>] hub_port_init+0x179/0x410 [usbcore]
 [<e0861f4a>] hub_port_connect_change+0xda/0x430 [usbcore]
 [<e085f2c8>] clear_port_feature+0x58/0x60 [usbcore]
 [<e0862493>] hub_events+0x1f3/0x410 [usbcore]
 [<e08626e7>] hub_thread+0x37/0x110 [usbcore]
 [<c0135390>] autoremove_wake_function+0x0/0x60
 [<c01060d2>] ret_from_fork+0x6/0x14
 [<c0135390>] autoremove_wake_function+0x0/0x60
 [<e08626b0>] hub_thread+0x0/0x110 [usbcore]
 [<c01042c5>] kernel_thread_helper+0x5/0x10
Code: ff ff ff 8d 74 26 00 8d bc 27 00 00 00 00 53 83 ec 08 8b 4c 24 10 9c 5b 
fa 8b 11 8b 02 85 c0 74 15 48 c7 42 0c 01 00 00 00 89 02 <8b> 44 82 10 53 9d 
83 c4 08 5b c3 8b 44 24 14 89 0c 24 89 44 24
 <6>note: khubd[351] exited with preempt_count 1

After that the system works well, unless something tries to use USB - starting 
cupsd (which tries to scan for USB printers) hangs, running lsusb shows one 
of the USB ports (first port w/ nothing plugged in), then hangs and can't 
even be stopped with kill -9.

LLaP
bero
