Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbUDKQoU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 12:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUDKQoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 12:44:19 -0400
Received: from pileup.ihatent.com ([217.13.24.22]:42647 "EHLO
	pileup.ihatent.com") by vger.kernel.org with ESMTP id S262424AbUDKQoN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 12:44:13 -0400
To: wim delvaux <wim.delvaux@adaptiveplanet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: crash of usb ... backtrace included.
References: <200404111408.08828.wim.delvaux@adaptiveplanet.com>
From: Alexander Hoogerhuis <alexh@boxed.no>
Date: Sun, 11 Apr 2004 18:34:31 +0200
In-Reply-To: <200404111408.08828.wim.delvaux@adaptiveplanet.com> (wim
 delvaux's message of "Sun, 11 Apr 2004 14:08:08 +0200")
Message-ID: <878yh24go8.fsf@dorker.boxed.no>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having similar oopses with bluetooth on my laptop (HP nc6000);
when "removing" the bluetooth from the USB bus (hotkey on laptop that
can disable it), or when shutting down and hotplug shuts down and
starts to remove modules, I get this one:

usb 3-1: USB disconnect, address 2
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01b27ec
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c01b27ec>]    Not tainted VLI
EFLAGS: 00010246   (2.6.5-mm4)
EIP is at get_kobj_path_length+0x16/0x2d
eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: ddcdbd38
esi: 00000001   edi: 00000000   ebp: dea03e20   esp: dea03e14
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 5220, threadinfo=dea03000 task=df13b8b0)
Stack: 000000cf c031d0a0 c1578c0e dea03e64 c01b2981 c1578c0e c02bc318 000000cf
       c1578c00 ddd09600 00000000 c1578c19 ddcdbd38 c02e68e0 e09b5c9e 00000000
       c02c1826 ddcdbd38 ddcdbd30 e09bad80 dea03e70 c01b2da9 e09bade0 dea03e8c
Call Trace:
 [<c01b2981>] kset_hotplug+0x12d/0x234
 [<c01b2da9>] kobject_del+0x12/0x22
 [<c01f9a5d>] class_device_del+0x97/0xb9
 [<e09b1177>] hci_unregister_dev+0xb/0x94 [bluetooth]
 [<e093dc52>] hci_usb_disconnect+0x30/0x6e [hci_usb]
 [<e08c6b61>] usb_disable_interface+0x2f/0x3f [usbcore]
 [<e08c10c6>] usb_unbind_interface+0x63/0x65 [usbcore]
 [<c01f8fa7>] device_release_driver+0x59/0x5b
 [<c01f90d1>] bus_remove_device+0x64/0xa4
 [<c01f81f9>] device_del+0x65/0x8e
 [<c01f822d>] device_unregister+0xb/0x14
 [<e08c6bde>] usb_disable_device+0x68/0x9b [usbcore]
 [<e08c1b36>] usb_disconnect+0xb6/0xfe [usbcore]
 [<e08c3c03>] hub_port_connect_change+0x260/0x265 [usbcore]
 [<e08c35ac>] hub_port_status+0x39/0x9f [usbcore]
 [<e08c3ee9>] hub_events+0x2e1/0x353 [usbcore]
 [<c011a68a>] reparent_to_init+0xea/0x160
 [<e08c3f8b>] hub_thread+0x30/0xdd [usbcore]
 [<c0116368>] default_wake_function+0x0/0xc
 [<e08c3f5b>] hub_thread+0x0/0xdd [usbcore]
 [<c0102269>] kernel_thread_helper+0x5/0xb
                                                                                
Code: d8 e8 79 ff ff ff 85 c0 89 c6 74 e6 89 d8 e8 5a ec fc ff eb dd 55 89 e5 57 56 be 01 00 00 00 53 31 db 8b 3a b9 ff ff ff ff 89 d8 <f2> ae f7 d1 49 8b 52 24 8d 74 31 01 85 d2 75 e7 5b 89 f0 5e 5f

This is on 2.6.5-mm[34]

mvh,
A

wim delvaux <wim.delvaux@adaptiveplanet.com> writes:

> Apr 11 13:58:32 buro kernel: Unable to handle kernel NULL pointer dereference 
> at virtual address 00000070
> Apr 11 13:58:32 buro kernel:  printing eip:
> Apr 11 13:58:32 buro kernel: c01746c1
> Apr 11 13:58:32 buro kernel: *pde = 00000000
> Apr 11 13:58:32 buro kernel: Oops: 0002 [#1]
> Apr 11 13:58:32 buro kernel: PREEMPT
> Apr 11 13:58:32 buro kernel: CPU:    0
> Apr 11 13:58:32 buro kernel: EIP:    0060:[sysfs_hash_and_remove+21/125]    
> Tainted: P   VLI
> Apr 11 13:58:32 buro kernel: EFLAGS: 00010282   (2.6.5-mm3)
> Apr 11 13:58:32 buro kernel: EIP is at sysfs_hash_and_remove+0x15/0x7d
> Apr 11 13:58:32 buro kernel: eax: 00000000   ebx: e1ac33e0   ecx: 00000070   
> edx: ffff0001
> Apr 11 13:58:32 buro kernel: esi: cf512c80   edi: e1ac3380   ebp: e1ac33e0   
> esp: df72be34
> Apr 11 13:58:32 buro kernel: ds: 007b   es: 007b   ss: 0068
> Apr 11 13:58:32 buro kernel: Process khubd (pid: 754, threadinfo=df72b000 
> task=df719130)
> Apr 11 13:58:32 buro kernel: Stack: d9076880 e09d44a0 e1ac33e0 d17b2130 
> c01cb7a0 cf512c80 c0286d6f c01cbb18
> Apr 11 13:58:32 buro kernel:        d17b2130 e1ac33cc d17b2000 d17b2000 
> d13aa400 d13aa524 e1ab92d4 d17b2130
> Apr 11 13:58:32 buro kernel:        d9076890 d9076580 e09d2d8c d17b2000 
> d9076880 e09d44a0 d9076980 e09d44a0
> Apr 11 13:58:32 buro kernel: Call Trace:
> Apr 11 13:58:32 buro kernel:  [class_device_dev_unlink+26/30] 
> class_device_dev_unlink+0x1a/0x1e
> Apr 11 13:58:32 buro kernel:  [class_device_del+117/174] 
> class_device_del+0x75/0xae
> Apr 11 13:58:32 buro kernel:  [__crc_journal_invalidatepage+2591152/3661950] 
> hci_unregister_dev+0x10/0xa1 [bluetooth]
> Apr 11 13:58:32 buro kernel:  [__crc_pci_enable_bridges+182274/4730582] 
> hci_usb_disconnect+0x35/0x7d [hci_usb]
> Apr 11 13:58:32 buro kernel:  [__crc_sleep_on+2905856/3188212] 
> usb_unbind_interface+0x7a/0x7c [usbcore]
> Apr 11 13:58:32 buro kernel:  [device_release_driver+100/102] 
> device_release_driver+0x64/0x66
> Apr 11 13:58:32 buro kernel:  [bus_remove_device+85/150] 
> bus_remove_device+0x55/0x96
> Apr 11 13:58:32 buro kernel:  [device_del+93/155] device_del+0x5d/0x9b
> Apr 11 13:58:32 buro kernel:  [device_unregister+19/35] 
> device_unregister+0x13/0x23
> Apr 11 13:58:32 buro kernel:  [__crc_sleep_on+2933965/3188212] 
> usb_disable_device+0xdb/0x116 [usbcore]
> Apr 11 13:58:32 buro kernel:  [__crc_sleep_on+2908775/3188212] 
> usb_disconnect+0x9f/0x131 [usbcore]
> Apr 11 13:58:32 buro kernel:  [__crc_sleep_on+2919588/3188212] 
> hub_port_connect_change+0x2ca/0x2cf [usbcore]
> Apr 11 13:58:32 buro kernel:  [__crc_sleep_on+2920598/3188212] 
> hub_events+0x3ed/0x4b1 [usbcore]
> Apr 11 13:58:32 buro kernel:  [__crc_sleep_on+2920839/3188212] 
> hub_thread+0x2d/0xe4 [usbcore]
> Apr 11 13:58:32 buro kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
> Apr 11 13:58:32 buro kernel:  [default_wake_function+0/18] 
> default_wake_function+0x0/0x12
> Apr 11 13:58:32 buro kernel:  [__crc_sleep_on+2920794/3188212] 
> hub_thread+0x0/0xe4 [usbcore]
> Apr 11 13:58:32 buro kernel:  [kernel_thread_helper+5/11] 
> kernel_thread_helper+0x5/0xb
> Apr 11 13:58:32 buro kernel:
> Apr 11 13:58:32 buro kernel: Code: 89 44 24 04 8d 44 24 08 89 04 24 e8 2a f1 
> fd ff 83 c4 18 5b 5f c3 83 ec 10 89 74 24 0c 89 5c 24 08 8b 74 24 14 8b 46 08 
> 8
> d 48 70 <ff> 48 70 78 63 89 34 24 8b 44 24 18 89 44 24 04 e8 66 ff ff ff
>
>
> This happened when trying to use a usb bluetooth dongle on my system
>
> 0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
> Controller (rev 0f) (prog-if 10 [OHCI])
>         Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
>         Flags: bus master, medium devsel, latency 32, IRQ 9
>         Memory at e4520000 (32-bit, non-prefetchable)
>
> 0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
> Controller (rev 0f) (prog-if 10 [OHCI])
>         Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
>         Flags: bus master, medium devsel, latency 32, IRQ 3
>         Memory at e4521000 (32-bit, non-prefetchable)
>
> 0000:00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
> Controller (rev 0f) (prog-if 10 [OHCI])
>         Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
>         Flags: bus master, medium devsel, latency 32, IRQ 5
>         Memory at e4522000 (32-bit, non-prefetchable)
>
> 0000:00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 
> Controller (prog-if 20 [EHCI])
>         Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
>         Flags: bus master, medium devsel, latency 32, IRQ 11
>         Memory at e4523000 (32-bit, non-prefetchable)
>         Capabilities: <available only to root>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Alexander Hoogerhuis                               | alexh@boxed.no
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
