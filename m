Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265086AbUGIK2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbUGIK2V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 06:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265075AbUGIK2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 06:28:21 -0400
Received: from [217.222.53.238] ([217.222.53.238]:31493 "EHLO mail.gts.it")
	by vger.kernel.org with ESMTP id S265086AbUGIK2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 06:28:06 -0400
Message-ID: <40EE732C.5020404@gts.it>
Date: Fri, 09 Jul 2004 12:27:56 +0200
From: Stefano Rivoir <s.rivoir@gts.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm7
References: <20040708235025.5f8436b7.akpm@osdl.org>	<40EE5418.2040000@gts.it> <20040709024112.7ef44d1d.akpm@osdl.org>
In-Reply-To: <20040709024112.7ef44d1d.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------040109040104060403070602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040109040104060403070602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

[...]

> 
> 
> Does the `acpi=off' boot option help?

Yes, disabling acpi makes it boot.

> Could you please try reverting bk-acpi.patch?

Unpatching bk-acpi it _sometimes_ hangs during boot.

It seems that hotplug "subsystem" is having problems (I use debian/sid), 
because it stucks during

/sbin/modprobe -s -q ehci_hcd

Note that I'm seeing this after a /etc/init.d/hotplug start (after a 
successfull boot), but just before I had a kernel oops (see attached 
file) when issuing a /etc/init.d/hotplug stop.

Hope it's helpful someway.

-- 
Stefano RIVOIR


--------------040109040104060403070602
Content-Type: text/plain;
 name="kern.fail.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kern.fail.log"

Jul  9 12:18:19 nbsteu kernel: ehci_hcd 0000:00:03.3: remove, state 1
Jul  9 12:18:19 nbsteu kernel: usb usb4: USB disconnect, address 1
Jul  9 12:18:19 nbsteu kernel: ehci_hcd 0000:00:03.3: USB bus 4 deregistered
Jul  9 12:18:19 nbsteu kernel: ohci_hcd 0000:00:03.0: remove, state 1
Jul  9 12:18:19 nbsteu kernel: usb usb1: USB disconnect, address 1
Jul  9 12:18:19 nbsteu kernel: usb 1-2: USB disconnect, address 2
Jul  9 12:18:19 nbsteu kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000002c
Jul  9 12:18:19 nbsteu kernel:  printing eip:
Jul  9 12:18:19 nbsteu kernel: c01ef3f5
Jul  9 12:18:19 nbsteu kernel: *pde = 00000000
Jul  9 12:18:19 nbsteu kernel: Oops: 0000 [#1]
Jul  9 12:18:19 nbsteu kernel: PREEMPT 
Jul  9 12:18:19 nbsteu kernel: Modules linked in: lp parport fan button usbhid yenta_socket pcmcia_core ohci_hcd 8250_pci 8250 serial_core vfat fat radeon sis_agp agpgart thermal processor asus_acpi ac battery evdev snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore sk98lin
Jul  9 12:18:19 nbsteu kernel: CPU:    0
Jul  9 12:18:19 nbsteu kernel: EIP:    0060:[usb_unlink_urb+0/53]    Not tainted VLI
Jul  9 12:18:19 nbsteu kernel: EFLAGS: 00010246   (2.6.7-mm7) 
Jul  9 12:18:19 nbsteu kernel: EIP is at usb_unlink_urb+0x0/0x35
Jul  9 12:18:19 nbsteu kernel: eax: 00000000   ebx: df844000   ecx: df76e58c   edx: dffe8d88
Jul  9 12:18:19 nbsteu kernel: esi: e0977680   edi: dffcde00   ebp: dffc15b0   esp: de603e7c
Jul  9 12:18:19 nbsteu kernel: ds: 007b   es: 007b   ss: 0068
Jul  9 12:18:19 nbsteu kernel: Process rmmod (pid: 2149, threadinfo=de602000 task=df9c19b0)
Jul  9 12:18:19 nbsteu kernel: Stack: e0973590 dffe8c80 c01ea2c6 dffe8c94 e09776a0 c01cc42d dffe8c94 dffcdec4 
Jul  9 12:18:19 nbsteu kernel:        c01cc613 dffe8c94 dffcdec4 c01cb798 00000001 dffe8c80 c01f04a4 00000010 
Jul  9 12:18:19 nbsteu kernel:        00000030 dffcde00 c01ec2b3 c026d960 c0265a26 dffcdf1c 00000002 00000001 
Jul  9 12:18:19 nbsteu kernel: Call Trace:
Jul  9 12:18:19 nbsteu kernel:  [pg0+543475088/1070428160] hid_disconnect+0x2c/0x9b [usbhid]
Jul  9 12:18:19 nbsteu kernel:  [usb_unbind_interface+110/112] usb_unbind_interface+0x6e/0x70
Jul  9 12:18:19 nbsteu kernel:  [device_release_driver+86/88] device_release_driver+0x56/0x58
Jul  9 12:18:19 nbsteu kernel:  [bus_remove_device+82/142] bus_remove_device+0x52/0x8e
Jul  9 12:18:19 nbsteu kernel:  [device_del+90/136] device_del+0x5a/0x88
Jul  9 12:18:19 nbsteu kernel:  [usb_disable_device+160/213] usb_disable_device+0xa0/0xd5
Jul  9 12:18:19 nbsteu kernel:  [usb_disconnect+150/291] usb_disconnect+0x96/0x123
Jul  9 12:18:19 nbsteu kernel:  [usb_disconnect+278/291] usb_disconnect+0x116/0x123
Jul  9 12:18:19 nbsteu kernel:  [usb_hcd_pci_remove+124/327] usb_hcd_pci_remove+0x7c/0x147
Jul  9 12:18:19 nbsteu kernel:  [pci_device_remove+40/42] pci_device_remove+0x28/0x2a
Jul  9 12:18:19 nbsteu kernel:  [device_release_driver+86/88] device_release_driver+0x56/0x58
Jul  9 12:18:19 nbsteu kernel:  [driver_detach+22/33] driver_detach+0x16/0x21
Jul  9 12:18:19 nbsteu kernel:  [bus_remove_driver+66/114] bus_remove_driver+0x42/0x72
Jul  9 12:18:19 nbsteu kernel:  [driver_unregister+8/23] driver_unregister+0x8/0x17
Jul  9 12:18:19 nbsteu kernel:  [pci_unregister_driver+11/19] pci_unregister_driver+0xb/0x13
Jul  9 12:18:19 nbsteu kernel:  [sys_delete_module+300/350] sys_delete_module+0x12c/0x15e
Jul  9 12:18:19 nbsteu kernel:  [unmap_vma_list+14/23] unmap_vma_list+0xe/0x17
Jul  9 12:18:19 nbsteu kernel:  [do_munmap+277/327] do_munmap+0x115/0x147
Jul  9 12:18:19 nbsteu kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Jul  9 12:18:19 nbsteu kernel: Code: 00 c1 f8 0b 83 e0 03 83 c0 01 0f af e8 e9 e6 fe ff ff c1 f8 0f 83 e0 0f 8b 6c 83 3c e9 bc fe ff ff b8 ed ff ff ff e9 49 ff ff ff <f6> 40 2c 10 74 27 8b 50 20 85 d2 74 11 8b 92 c0 00 00 00 85 d2 

--------------040109040104060403070602--
