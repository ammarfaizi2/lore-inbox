Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTEEUWN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 16:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbTEEUWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 16:22:13 -0400
Received: from ma-northadams1b-60.bur.adelphia.net ([24.52.166.60]:23168 "EHLO
	ma-northadams1b-60.bur.adelphia.net") by vger.kernel.org with ESMTP
	id S261262AbTEEUWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 16:22:10 -0400
Date: Mon, 5 May 2003 16:34:28 -0400
From: Eric Buddington <eric@ma-northadams1b-60.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.5.69 during 'modprobe uhci-hcd'
Message-ID: <20030505163428.A186@ma-northadams1b-60.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-2.5.69, mostly modular, no third-party drivers
external NEC IDE CD-RW in an USB-IDE converter case
SurfBoard USB Cable modem
USB Controller: VIA Technologies, Inc. USB (rev 128)
USB Controller: VIA Technologies, Inc. USB 2.0 (rev 130)
Athlon XP 2000+ CPU

After burning a CD at 16x with no problems using the ehci-hcd driver,
I ran 'modprobe uhci-hcd' and got the following oops. Hope this is of
interest.

-Eric

-------------- dmesg output ---------------------
hub 3-0:0: port 2, status 101, change 3, 12 Mb/s
hub 3-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 3-0:0: new USB device on port 2, assigned address 2
Unable to handle kernel paging request at virtual address 4cce4162
 printing eip:
d0a615a9
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<d0a615a9>]    Not tainted
EFLAGS: 00010002
EIP is at _uhci_insert_qh+0x2d/0xa0 [uhci_hcd]
eax: 0e4161e2   ebx: ce879568   ecx: ce879569   edx: 4cce4162
esi: ce4161b0   edi: ce87953c   ebp: cf41fd14   esp: cf41fd08
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 45, threadinfo=cf41e000 task=cfa45980)
Stack: cea2c800 c97a75f0 ce4161b0 cf41fd38 d0a616a3 cea2c800 ce4161b0 c97a75f0 
       00000046 ce4161b0 c97a75f0 ffe80069 cf41fd6c d0a629e1 cea2c800 ce4161b0 
       c97a75f0 00000000 00000000 00000008 19800000 ce87953c cea2c800 00000000 
Call Trace:
 [<d0a616a3>] uhci_insert_qh+0x87/0x174 [uhci_hcd]
 [<d0a629e1>] uhci_submit_control+0x21d/0x270 [uhci_hcd]
 [<d0a637ba>] uhci_urb_enqueue+0x31e/0x49c [uhci_hcd]
 [<d0a8ccd2>] hcd_submit_urb+0x19e/0x27c [usbcore]
 [<d0a8e10d>] usb_submit_urb+0x1f5/0x2d4 [usbcore]
 [<d0aa54a0>] usb_hcd_operations+0x0/0x20 [usbcore]
 [<d0a8e2d1>] usb_start_wait_urb+0x91/0x180 [usbcore]
 [<d0a8e370>] usb_start_wait_urb+0x130/0x180 [usbcore]
 [<d0a98072>] +0x84a/0xdf8 [usbcore]
 [<d0a98072>] +0x84a/0xdf8 [usbcore]
 [<c014dc24>] kmalloc+0x148/0x190
 [<c011c9ec>] default_wake_function+0x0/0x14
 [<d0a8e43c>] usb_internal_control_msg+0x7c/0x88 [usbcore]
 [<d0a8e4b6>] usb_control_msg+0x6e/0x80 [usbcore]
 [<d0a87d2e>] usb_set_address+0x4a/0x5c [usbcore]
 [<d0a87f6a>] usb_new_device+0xbe/0x4f4 [usbcore]
 [<c01229b0>] printk+0x20c/0x358
 [<d0a8a8f7>] usb_hub_port_connect_change+0x1eb/0x320 [usbcore]
 [<d0a99b00>] +0x14e0/0x36f4 [usbcore]
 [<d0a97f5d>] +0x735/0xdf8 [usbcore]
 [<d0a8ae53>] usb_hub_events+0x427/0x594 [usbcore]
 [<d0a8afed>] usb_hub_thread+0x2d/0xec [usbcore]
 [<c011c9ec>] default_wake_function+0x0/0x14
 [<d0aa52d8>] khubd_wait+0x18/0x20 [usbcore]
 [<d0aa52d8>] khubd_wait+0x18/0x20 [usbcore]
 [<d0a8afc0>] usb_hub_thread+0x0/0xec [usbcore]
 [<c0107179>] kernel_thread_helper+0x5/0xc

Code: 89 02 8b 09 8b 01 0f 18 00 41 39 d9 75 ed 8b 57 10 8b 06 89 
 <6>note: khubd[45] exited with preempt_count 2
Debug: sleeping function called from illegal context at include/linux/rwsem.h:43
Call Trace:
 [<c011e9df>] __might_sleep+0x53/0x68
 [<c0123223>] profile_exit_task+0x13/0x40
 [<c0124d95>] do_exit+0x65/0x908
 [<c010abdf>] die+0x1c7/0x1c8
 [<c011975a>] do_page_fault+0x116/0x428
 [<c0147b68>] mempool_free+0xc8/0x1c4
 [<c012a96c>] add_timer+0xb0/0x1b0
 [<c0148f1b>] buffered_rmqueue+0xaf/0x248
 [<c0149130>] __alloc_pages+0x7c/0x2a4
 [<c014cbe9>] cache_init_objs+0x119/0x130
 [<c0119644>] do_page_fault+0x0/0x428
 [<c010a581>] error_code+0x2d/0x38
 [<d0a615a9>] _uhci_insert_qh+0x2d/0xa0 [uhci_hcd]
 [<d0a616a3>] uhci_insert_qh+0x87/0x174 [uhci_hcd]
 [<d0a629e1>] uhci_submit_control+0x21d/0x270 [uhci_hcd]
 [<d0a637ba>] uhci_urb_enqueue+0x31e/0x49c [uhci_hcd]
 [<d0a8ccd2>] hcd_submit_urb+0x19e/0x27c [usbcore]
 [<d0a8e10d>] usb_submit_urb+0x1f5/0x2d4 [usbcore]
 [<d0aa54a0>] usb_hcd_operations+0x0/0x20 [usbcore]
 [<d0a8e2d1>] usb_start_wait_urb+0x91/0x180 [usbcore]
 [<d0a8e370>] usb_start_wait_urb+0x130/0x180 [usbcore]
 [<d0a98072>] +0x84a/0xdf8 [usbcore]
 [<d0a98072>] +0x84a/0xdf8 [usbcore]
 [<c014dc24>] kmalloc+0x148/0x190
 [<c011c9ec>] default_wake_function+0x0/0x14
 [<d0a8e43c>] usb_internal_control_msg+0x7c/0x88 [usbcore]
 [<d0a8e4b6>] usb_control_msg+0x6e/0x80 [usbcore]
 [<d0a87d2e>] usb_set_address+0x4a/0x5c [usbcore]
 [<d0a87f6a>] usb_new_device+0xbe/0x4f4 [usbcore]
 [<c01229b0>] printk+0x20c/0x358
 [<d0a8a8f7>] usb_hub_port_connect_change+0x1eb/0x320 [usbcore]
 [<d0a99b00>] +0x14e0/0x36f4 [usbcore]
 [<d0a97f5d>] +0x735/0xdf8 [usbcore]
 [<d0a8ae53>] usb_hub_events+0x427/0x594 [usbcore]
 [<d0a8afed>] usb_hub_thread+0x2d/0xec [usbcore]
 [<c011c9ec>] default_wake_function+0x0/0x14
 [<d0aa52d8>] khubd_wait+0x18/0x20 [usbcore]
 [<d0aa52d8>] khubd_wait+0x18/0x20 [usbcore]
 [<d0a8afc0>] usb_hub_thread+0x0/0xec [usbcore]
 [<c0107179>] kernel_thread_helper+0x5/0xc

drivers/usb/host/uhci-hcd.c:1720: spin_lock(drivers/usb/host/uhci-hcd.c:cea2c9bc) already locked by drivers/usb/host/uhci-hcd.c/1437
drivers/usb/host/uhci-hcd.c:755: spin_lock(drivers/usb/host/uhci-hcd.c:cea2c994) already locked by drivers/usb/host/uhci-hcd.c/401
-------------- dmesg output ends ---------------------
