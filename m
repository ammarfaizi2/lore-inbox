Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbTLJEb4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 23:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263463AbTLJEb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 23:31:56 -0500
Received: from ferreol-1-82-66-171-16.fbx.proxad.net ([82.66.171.16]:5504 "EHLO
	diablo.hd.free.fr") by vger.kernel.org with ESMTP id S263460AbTLJEbu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 23:31:50 -0500
Message-ID: <3FD6A1A3.1040303@free.fr>
Date: Wed, 10 Dec 2003 05:31:31 +0100
From: Vince <fuzzy77@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031206 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Duncan Sands <baldrick@free.fr>
CC: Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>,
       "Randy.Dunlap" <rddunlap@osdl.org>, mfedyk@matchmail.com,
       zwane@holomorphy.com, linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
References: <Pine.LNX.4.44L0.0312091638140.7053-100000@ida.rowland.org> <200312092307.04924.baldrick@free.fr>
In-Reply-To: <200312092307.04924.baldrick@free.fr>
Content-Type: multipart/mixed;
 boundary="------------060408010409000900010808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060408010409000900010808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Duncan Sands wrote:
>>It's not at all clear how that could happen.  Those pointers are located
>>in static data in the HCD modules.  It doesn't seem likely that the
>>pointer was overwritten.  The only other possibility I can think of is
>>that the module was already unloaded.  But that's not possible since you
>>were holding a reference to a device on that bus.
> 
> 
> It occurred on system shutdown - so I guess the module was unloaded.
> Maybe the bus reference counting is borked.  I've sent Vince a patch that
> should produce some more info.

Actually, no need to be at system shutdown: in my case a simple
"/etc/init.d/hotplug stop" is enough to trigger the oops.
However, it doesn't happen every time, I had to try some times before I 
got another oops again. I enclose the logs with the additional debugging 
information in attachment.

Regards,

Vincent

--------------060408010409000900010808
Content-Type: text/plain;
 name="logs"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="logs"

kernel: ehci_hcd 0000:00:10.3: remove, state 1
kernel: usb usb1: USB disconnect, address 1
kernel: ehci_hcd 0000:00:10.3: USB bus 1 deregistered
kernel: DEBUG
kernel: Call Trace:
kernel: [<e0afca9f>] hcd_pci_release+0x1f/0x70 [usbcore]
kernel: [<c01bea5a>] unlink+0x7a/0x80
kernel: [<e0af857d>] usb_host_release+0x1d/0x20 [usbcore]
kernel: [<c0205eb8>] class_dev_release+0x58/0x60
kernel: [<c01bee7b>] kobject_cleanup+0x7b/0x80
kernel: [<e0afd0ba>] usb_hcd_pci_remove+0x12a/0x180 [usbcore]
kernel: [<c01c650b>] pci_device_remove+0x3b/0x40
kernel: [<c0205494>] device_release_driver+0x64/0x70
kernel: [<c02054c0>] driver_detach+0x20/0x30
kernel: [<c02056ed>] bus_remove_driver+0x3d/0x80
kernel: [<c0205b03>] driver_unregister+0x13/0x28
kernel: [<c01c66e6>] pci_unregister_driver+0x16/0x30
kernel: [<e0a19e6f>] cleanup+0xf/0x13 [ehci_hcd]
kernel: [<c0136e43>] sys_delete_module+0x133/0x150
kernel: [<c014c124>] sys_munmap+0x44/0x70
kernel: [<c02a6f8e>] sysenter_past_esp+0x43/0x65
kernel: 
kernel: DEBUG: hcd->driver: e0a19ee0
kernel: DEBUG: hcd->driver->hcd_free: e0a166d0
kernel: uhci_hcd 0000:00:10.0: remove, state 1
kernel: usb usb2: USB disconnect, address 1
kernel: usb 2-1: USB disconnect, address 2
kernel: drivers/char/lirc/lirc_atiusb.c: USB Remote on #200 now disconnected
kernel: usb 2-2: USB disconnect, address 3
kernel: uhci_hcd 0000:00:10.0: USB bus 2 deregistered
kernel: uhci_hcd 0000:00:10.1: remove, state 1
kernel: usb usb3: USB disconnect, address 1
kernel: uhci_hcd 0000:00:10.1: USB bus 3 deregistered
kernel: DEBUG
kernel: Call Trace:
kernel: [<e0afca9f>] hcd_pci_release+0x1f/0x70 [usbcore]
kernel: [<c01bea5a>] unlink+0x7a/0x80
kernel: [<e0af857d>] usb_host_release+0x1d/0x20 [usbcore]
kernel: [<c0205eb8>] class_dev_release+0x58/0x60
kernel: [<c01bee7b>] kobject_cleanup+0x7b/0x80
kernel: [<e0afd0ba>] usb_hcd_pci_remove+0x12a/0x180 [usbcore]
kernel: [<c01c650b>] pci_device_remove+0x3b/0x40
kernel: [<c0205494>] device_release_driver+0x64/0x70
kernel: [<c02054c0>] driver_detach+0x20/0x30
kernel: [<c02056ed>] bus_remove_driver+0x3d/0x80
kernel: [<c0205b03>] driver_unregister+0x13/0x28
kernel: [<c01c66e6>] pci_unregister_driver+0x16/0x30
kernel: [<e0c8dd4f>] uhci_hcd_cleanup+0xf/0x59 [uhci_hcd]
kernel: [<c0136e43>] sys_delete_module+0x133/0x150
kernel: [<c014c124>] sys_munmap+0x44/0x70
kernel: [<c02a6f8e>] sysenter_past_esp+0x43/0x65
kernel: 
kernel: DEBUG: hcd->driver: e0c8de40
kernel: DEBUG: hcd->driver->hcd_free: e0c8dce0
kernel: uhci_hcd 0000:00:10.2: remove, state 1
kernel: usb usb4: USB disconnect, address 1
kernel: uhci_hcd 0000:00:10.2: USB bus 4 deregistered
kernel: DEBUG
kernel: Call Trace:
kernel: [<e0afca9f>] hcd_pci_release+0x1f/0x70 [usbcore]
kernel: [<c01bea5a>] unlink+0x7a/0x80
kernel: [<e0af857d>] usb_host_release+0x1d/0x20 [usbcore]
kernel: [<c0205eb8>] class_dev_release+0x58/0x60
kernel: [<c01bee7b>] kobject_cleanup+0x7b/0x80
kernel: [<e0afd0ba>] usb_hcd_pci_remove+0x12a/0x180 [usbcore]
kernel: [<c01c650b>] pci_device_remove+0x3b/0x40
kernel: [<c0205494>] device_release_driver+0x64/0x70
kernel: [<c02054c0>] driver_detach+0x20/0x30
kernel: [<c02056ed>] bus_remove_driver+0x3d/0x80
kernel: [<c0205b03>] driver_unregister+0x13/0x28
kernel: [<c01c66e6>] pci_unregister_driver+0x16/0x30
kernel: [<e0c8dd4f>] uhci_hcd_cleanup+0xf/0x59 [uhci_hcd]
kernel: [<c0136e43>] sys_delete_module+0x133/0x150
kernel: [<c014c124>] sys_munmap+0x44/0x70
kernel: [<c02a6f8e>] sysenter_past_esp+0x43/0x65
kernel: 
kernel: DEBUG: hcd->driver: e0c8de40
kernel: DEBUG: hcd->driver->hcd_free: e0c8dce0
kernel: DEBUG
kernel: Call Trace:
kernel: [<e0afca9f>] hcd_pci_release+0x1f/0x70 [usbcore]
kernel: [<e0af857d>] usb_host_release+0x1d/0x20 [usbcore]
kernel: [<c0205eb8>] class_dev_release+0x58/0x60
kernel: [<e0afb854>] usb_destroy_configuration+0xb4/0xf0 [usbcore]
kernel: [<c01bee7b>] kobject_cleanup+0x7b/0x80
kernel: [<e0af48f6>] usb_release_dev+0x46/0x60 [usbcore]
kernel: [<c0204160>] device_release+0x20/0x80
kernel: [<c01bee7b>] kobject_cleanup+0x7b/0x80
kernel: [<e0afdd39>] usbdev_release+0x79/0xb0 [usbcore]
kernel: [<c01586c0>] __fput+0x100/0x120
kernel: [<c0156c99>] filp_close+0x59/0x90
kernel: [<c0156d31>] sys_close+0x61/0xa0
kernel: [<c02a6f8e>] sysenter_past_esp+0x43/0x65
kernel: 
kernel: DEBUG: hcd->driver: e0c8de40
kernel: Unable to handle kernel paging request at virtual address e0c8de68
kernel: printing eip:
kernel: e0afcabf
kernel: *pde = 1da4c067
kernel: *pte = 00000000
kernel: Oops: 0000 [#1]
kernel: PREEMPT 
kernel: CPU:    0
kernel: EIP:    0060:[<e0afcabf>]    Not tainted VLI
kernel: EFLAGS: 00010286
kernel: EIP is at hcd_pci_release+0x3f/0x70 [usbcore]
kernel: eax: e0c8de40   ebx: de529000   ecx: 00000001   edx: c02ef058
kernel: esi: c032265c   edi: c0322680   ebp: decb6200   esp: da1cdee4
kernel: ds: 007b   es: 007b   ss: 0068
kernel: Process modem_run (pid: 2424, threadinfo=da1cc000 task=de73ad00)
kernel: Stack: e0b02781 e0c8de40 de529050 e0af857d de529000 c0205eb8 de529048 e0afb854 
kernel: c0322450 00000282 c01bee7b de529050 decb6200 c0322428 c0322440 e0af48f6 
kernel: de529050 00000000 c0204160 decb62cc da1cc000 de6a4ec0 decf1398 decb62f4 
kernel: Call Trace:
kernel: [<e0af857d>] usb_host_release+0x1d/0x20 [usbcore]
kernel: [<c0205eb8>] class_dev_release+0x58/0x60
kernel: [<e0afb854>] usb_destroy_configuration+0xb4/0xf0 [usbcore]
kernel: [<c01bee7b>] kobject_cleanup+0x7b/0x80
kernel: [<e0af48f6>] usb_release_dev+0x46/0x60 [usbcore]
kernel: [<c0204160>] device_release+0x20/0x80
kernel: [<c01bee7b>] kobject_cleanup+0x7b/0x80
kernel: [<e0afdd39>] usbdev_release+0x79/0xb0 [usbcore]
kernel: [<c01586c0>] __fput+0x100/0x120
kernel: [<c0156c99>] filp_close+0x59/0x90
kernel: [<c0156d31>] sys_close+0x61/0xa0
kernel: [<c02a6f8e>] sysenter_past_esp+0x43/0x65
kernel: 
kernel: Code: e0 e8 46 63 62 df e8 91 e9 60 df 85 db 74 3b 8b 83 08 01 00 00 c7 04 24 81 27 b0 e0 89 44 24 04 e8 27 63 62 df 8b 83 08 01 00 00 <8b> 40 28 c7 04 24 c0 43 b0 e0 89 44 24 04 e8 0e 63 62 df 8b 83 
kernel: <0>Fatal exception: panic in 5 seconds

--------------060408010409000900010808--
