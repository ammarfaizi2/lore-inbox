Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbUKQGIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbUKQGIT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 01:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbUKQGIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 01:08:19 -0500
Received: from [202.96.154.178] ([202.96.154.178]:63442 "EHLO mailgw1.963.net")
	by vger.kernel.org with ESMTP id S262178AbUKQGIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 01:08:01 -0500
X-Originating-IP: [202.96.154.159]
Message-ID: <001401c4cc6d$765574b0$fd00a8c0@magf>
From: "???" <magf@bitland.com.cn>
To: <linux-kernel@vger.kernel.org>
Cc: "Ingo Molnar" <mingo@elte.hu>
References: <OFE5FC77BB.DA8F1FAE-ON86256F4E.0058C5CF-86256F4E.0058C604@raytheon.com><20041116184315.GA5492@elte.hu><419A5A53.6050100@cybsft.com><20041116212401.GA16845@elte.hu><20041116222039.662f41ac@mango.fruits.de><20041116223243.43feddf4@mango.fruits.de><20041116224257.GB27550@elte.hu><20041116230443.452497b9@mango.fruits.de><20041116231145.GC31529@elte.hu> <20041116235535.6867290d@mango.fruits.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-11
Date: Wed, 17 Nov 2004 14:19:55 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have one USB removable HDD.  After plugging it to my usb ports, I can
mount FS and read/write,
but if I unmount it and unplug it , the system gives so many errors. Even
though I do not mount and umount FS,
only plug and  then unplug USB HDD,  the errors occur as well. The following
is my syslog after unplug and plug
this USB HDD:


Nov 17 13:56:28 magf1 kernel: usb 1-5: USB disconnect, address 2
Nov 17 13:56:29 magf1 kernel: slab error in kmem_cache_destroy(): cache
`scsi_cmd_cache': Can't free all objects
Nov 17 13:56:29 magf1 kernel:  [<c0104164>] dump_stack+0x23/0x27 (20)
Nov 17 13:56:29 magf1 kernel:  [<c0151ba5>] kmem_cache_destroy+0x106/0x194
(28)
Nov 17 13:56:29 magf1 kernel:  [<c02c99b5>]
scsi_destroy_command_freelist+0x53/0x81 (28)
Nov 17 13:56:29 magf1 kernel:  [<c02ca866>] scsi_host_dev_release+0x43/0x164
(172)
Nov 17 13:56:29 magf1 kernel:  [<c0295b4d>] device_release+0x7c/0x80 (32)
Nov 17 13:56:29 magf1 kernel:  [<c0226b94>] kobject_cleanup+0x94/0x96 (32)
Nov 17 13:56:29 magf1 kernel:  [<c02276ba>] kref_put+0x46/0xf0 (40)
Nov 17 13:56:29 magf1 kernel:  [<c0226bd2>] kobject_put+0x25/0x29 (16)
Nov 17 13:56:29 magf1 kernel:  [<d8880146>]
usb_stor_release_resources+0x7e/0x133 [usb_storage] (24)
Nov 17 13:56:29 magf1 kernel:  [<d88806d6>] storage_disconnect+0x9a/0xa8
[usb_storage] (16)
Nov 17 13:56:29 magf1 kernel:  [<d88a118c>] usb_unbind_interface+0x8b/0x8d
[usbcore] (28)
Nov 17 13:56:29 magf1 kernel:  [<c0296d92>] device_release_driver+0x86/0x88
(28)
Nov 17 13:56:29 magf1 kernel:  [<c0296f98>] bus_remove_device+0x56/0x86 (20)
Nov 17 13:56:29 magf1 kernel:  [<c0295f91>] device_del+0x4f/0x88 (20)
Nov 17 13:56:29 magf1 kernel:  [<d88a947c>] usb_disable_device+0xd1/0x172
[usbcore] (44)
Nov 17 13:56:29 magf1 kernel:  [<d88a3c97>] usb_disconnect+0xb0/0x187
[usbcore] (44)
Nov 17 13:56:29 magf1 kernel:  [<d88a5309>]
hub_port_connect_change+0x471/0x4a0 [usbcore] (72)
Nov 17 13:56:29 magf1 kernel:  [<d88a5779>] hub_events+0x441/0x52d [usbcore]
(76)
Nov 17 13:56:29 magf1 kernel:  [<d88a589c>] hub_thread+0x37/0x120 [usbcore]
(96)
Nov 17 13:56:29 magf1 kernel:  [<c0101329>] kernel_thread_helper+0x5/0xb
(691048468)
Nov 17 13:56:29 magf1 kernel: ---------------------------
Nov 17 13:56:29 magf1 kernel: | preempt count: 00000001 ]
Nov 17 13:56:29 magf1 kernel: | 1-level deep critical section nesting:
Nov 17 13:56:29 magf1 kernel: ----------------------------------------
Nov 17 13:56:29 magf1 kernel: .. [<c03cceee>] .... _raw_spin_lock+0x22/0x78
Nov 17 13:56:29 magf1 kernel: .....[<c014737b>] ..   ( <=
__do_IRQ+0x9c/0x159)
Nov 17 13:56:29 magf1 kernel:
Nov 17 13:56:29 magf1 kernel: (IRQ 0/2/CPU#0): new 192 us maximum-latency
wakeup.
Nov 17 13:56:59 magf1 kernel: usb 1-5: new high speed USB device using
ehci_hcd and address 3
Nov 17 13:56:59 magf1 kernel: usb 1-5: config 1 descriptor has 1 excess
byte, ignoring
Nov 17 13:56:59 magf1 kernel: usb 1-5: Product: USB TO IDE
Nov 17 13:56:59 magf1 kernel: kmem_cache_create: duplicate cache
scsi_cmd_cache
Nov 17 13:56:59 magf1 kernel: BUG at mm/slab.c:1447!
Nov 17 13:56:59 magf1 kernel: ------------[ cut here ]------------
Nov 17 13:56:59 magf1 kernel: kernel BUG at mm/slab.c:1447!
Nov 17 13:56:59 magf1 kernel: invalid operand: 0000 [#1]
Nov 17 13:56:59 magf1 kernel: PREEMPT SMP
Nov 17 13:56:59 magf1 kernel: Modules linked in: usb_storage uhci_hcd
ehci_hcd usbcore video asus_acpi rtc
Nov 17 13:56:59 magf1 kernel: CPU:    0
Nov 17 13:56:59 magf1 kernel: EIP:    0060:[<c0151628>]    Not tainted VLI
Nov 17 13:56:59 magf1 kernel: EFLAGS: 00010282
(2.6.10-rc2-mm1-RT-V0.7.27-11)
Nov 17 13:56:59 magf1 kernel: EIP is at kmem_cache_create+0x441/0x66e
Nov 17 13:56:59 magf1 kernel: eax: 00000017   ebx: c91df780   ecx: c0119911
edx: c013aa88
Nov 17 13:56:59 magf1 kernel: esi: c0402af0   edi: c0402af0   ebp: d6cf6c98
esp: d6cf6c5c
Nov 17 13:56:59 magf1 kernel: ds: 007b   es: 007b   ss: 0068   preempt:
00000001
Nov 17 13:56:59 magf1 kernel: Process khubd (pid: 1327, threadinfo=d6cf6000
task=d76f47d0)
Nov 17 13:56:59 magf1 kernel: Stack: c03e4ee2 c03ea285 000005a7 00000565
d6cf6c88 c91df7d8 00000007 c0000000
Nov 17 13:56:59 magf1 kernel:        d7856948 ffffff80 00000000 00000180
d77e0000 c0491dc0 d77e0048 d6cf6cc4
Nov 17 13:56:59 magf1 kernel:        c02c98e2 c0402ae1 00000200 00000080
00002000 00000000 00000000 d77e00f0
Nov 17 13:56:59 magf1 kernel: Call Trace:
Nov 17 13:56:59 magf1 kernel:  [<c010412b>] show_stack+0x85/0x9b (28)
Nov 17 13:56:59 magf1 kernel:  [<c01042d7>] show_registers+0x16f/0x1d3 (56)
Nov 17 13:56:59 magf1 kernel:  [<c01044e5>] die+0x10c/0x192 (64)
Nov 17 13:56:59 magf1 kernel:  [<c0104a8c>] do_invalid_op+0x123/0x125 (192)
Nov 17 13:56:59 magf1 kernel:  [<c0103d87>] error_code+0x2b/0x30 (120)
Nov 17 13:56:59 magf1 kernel:  [<c02c98e2>]
scsi_setup_command_freelist+0x94/0x114 (44)
Nov 17 13:56:59 magf1 kernel:  [<c02cac4e>] scsi_host_alloc+0x2c7/0x3d9
(180)
Nov 17 13:56:59 magf1 kernel:  [<d8880013>]
usb_stor_acquire_resources+0x6f/0x124 [usb_storage] (28)
Nov 17 13:56:59 magf1 kernel:  [<d8880595>] storage_probe+0x1cb/0x272
[usb_storage] (36)
Nov 17 13:56:59 magf1 kernel:  [<d88a10df>] usb_probe_interface+0xc7/0xe9
[usbcore] (48)
Nov 17 13:56:59 magf1 kernel:  [<c0296ba4>] driver_probe_device+0x36/0x73
(24)
Nov 17 13:57:00 magf1 kernel:  [<c0296c31>] device_attach+0x50/0xa3 (40)
Nov 17 13:57:00 magf1 kernel:  [<c0296f03>] bus_add_device+0x51/0x90 (28)
Nov 17 13:57:00 magf1 kernel:  [<c0295e57>] device_add+0xbc/0x134 (40)
Nov 17 13:57:00 magf1 kernel:  [<d88a9c3a>]
usb_set_configuration+0x31c/0x476 [usbcore] (88)
Nov 17 13:57:00 magf1 kernel:  [<d88a4004>] usb_new_device+0x11e/0x225
[usbcore] (52)
Nov 17 13:57:00 magf1 kernel:  [<d88a514b>]
hub_port_connect_change+0x2b3/0x4a0 [usbcore] (72)
Nov 17 13:57:00 magf1 kernel:  [<d88a5779>] hub_events+0x441/0x52d [usbcore]
(76)
Nov 17 13:57:00 magf1 kernel:  [<d88a589c>] hub_thread+0x37/0x120 [usbcore]
(96)
Nov 17 13:57:00 magf1 kernel:  [<c0101329>] kernel_thread_helper+0x5/0xb
(691048468)
Nov 17 13:57:00 magf1 kernel: ---------------------------
Nov 17 13:57:00 magf1 kernel: | preempt count: 00000002 ]
Nov 17 13:57:00 magf1 kernel: | 2-level deep critical section nesting:
Nov 17 13:57:00 magf1 kernel: ----------------------------------------
Nov 17 13:57:00 magf1 kernel: .. [<c03ccf66>] ....
_raw_spin_lock_irqsave+0x22/0x87
Nov 17 13:57:00 magf1 kernel: .....[<c010441d>] ..   ( <= die+0x44/0x192)
Nov 17 13:57:00 magf1 kernel: .. [<c013ce8c>] .... print_traces+0x1d/0x56
Nov 17 13:57:00 magf1 kernel: .....[<c010412b>] ..   ( <=
show_stack+0x85/0x9b)
Nov 17 13:57:00 magf1 kernel:
Nov 17 13:57:00 magf1 kernel: Code: e8 33 04 fd ff b8 a0 48 67 c0 e8 c8 93
fe ff c7 44 24 08 a7 05 00 00 c7 44 24 04 85 a2 3e c0 c7 04 24 e2 4e 3e c0
e8 0d 04 fd ff <0f> 0b a7 05 85 a2 3e c0 8b 45 e4 8b 08 e9 4d ff ff ff 8b 47
50
Nov 17 13:57:00 magf1 kernel:  BUG: khubd/1327, lock held at task exit time!
Nov 17 13:57:00 magf1 kernel:  [d88bb940] {usb_all_devices_rwsem.lock}
Nov 17 13:57:00 magf1 kernel: .. held by:             khubd: 1327 [d76f47d0,
115]
Nov 17 13:57:00 magf1 kernel: ... acquired at:  usb_lock_device+0x16/0x20
[usbcore]
Nov 17 13:57:00 magf1 kernel: BUG: khubd/1327, lock held at task exit time!
Nov 17 13:57:00 magf1 kernel:  [d6852028] {&dev->serialize}
Nov 17 13:57:00 magf1 kernel: .. held by:             khubd: 1327 [d76f47d0,
115]
Nov 17 13:57:00 magf1 kernel: ... acquired at:  locktree+0x84/0x88 [usbcore]
Nov 17 13:57:00 magf1 kernel: BUG: khubd/1327, lock held at task exit time!
Nov 17 13:57:00 magf1 kernel:  [d7683428] {&dev->serialize}
Nov 17 13:57:00 magf1 kernel: .. held by:             khubd: 1327 [d76f47d0,
115]
Nov 17 13:57:00 magf1 kernel: ... acquired at:
hub_port_connect_change+0x1c4/0x4a0 [usbcore]
Nov 17 13:57:00 magf1 kernel: BUG: env/3928, lock held at task exit time!
Nov 17 13:57:00 magf1 kernel:  [d88bba6c] {&s->rwsem}
Nov 17 13:57:00 magf1 kernel: .. held by:               env: 3928 [d76f47d0,
116]
Nov 17 13:57:00 magf1 kernel: ... acquired at:  bus_add_device+0x30/0x90
Nov 17 13:57:00 magf1 kernel: BUG: env/3928, lock held at task exit time!
Nov 17 13:57:00 magf1 kernel:  [c0491e04] {host_cmd_pool_mutex.lock}
Nov 17 13:57:00 magf1 kernel: .. held by:               env: 3928 [d76f47d0,
116]
Nov 17 13:57:00 magf1 kernel: ... acquired at:
scsi_setup_command_freelist+0x4c/0x114

My USB HDD is OK on FC2 and ON RP kernel V0.7.18, V0.7.25-1,V0.7.27-11 all
have this problem.

Paul Ma
magf@bitland.com.cn





