Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWDDNiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWDDNiZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 09:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWDDNiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 09:38:25 -0400
Received: from mail.gondor.com ([212.117.64.182]:30478 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S964804AbWDDNiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 09:38:25 -0400
Date: Tue, 4 Apr 2006 15:38:14 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Ken Moffat <zarniwhoop@ntlworld.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Slab corruptions & Re: 2.6.17-rc1: Oops in sound applications
Message-ID: <20060404133814.GA11741@knautsch.gondor.com>
References: <Pine.LNX.4.63.0604032155220.17605@deepthought.mydomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0604032155220.17605@deepthought.mydomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2006 at 10:01:08PM +0100, Ken Moffat wrote:
> 1. One line summary:
> 
>  On x86, sound applications oops when I refresh the browser.

I also see Oopses which seem to be sound related, although I did
not notice a correllation with the browser. The oopses below are from
2.6.17-rc1 with additional ipw2200 patches (first one), and from a clean
2.6.17 (second one). The -dirty suffix in the version numbers comes from
compiling with make-kpkg, not from actual changes to the source.

Please also note the slab corruptions mentioned below.

Apr  3 18:14:04 knautsch kernel: [17179569.184000] Linux version 2.6.17-rc1-g336da66c-dirty (root@knautsch) (gcc version 4.0.3 (Debian 4.0.3-1)) #2 Mon Apr 3 09:52:19 CEST 2006
      [^^ here the clock was wrong, this should be 16:00 - this has been
      corrected before the following lines were printed]
[...]
Apr  3 16:49:55 knautsch kernel: [17181753.596000] BUG: unable to handle kernel NULL pointer dereference at virtual address 0000005c
Apr  3 16:49:55 knautsch kernel: [17181753.596000]  printing eip:
Apr  3 16:49:55 knautsch kernel: [17181753.596000] e05275fd
Apr  3 16:49:55 knautsch kernel: [17181753.596000] *pde = 00000000
Apr  3 16:49:55 knautsch kernel: [17181753.596000] Oops: 0000 [#1]
Apr  3 16:49:55 knautsch kernel: [17181753.596000] Modules linked in: tun lp i915 drm ipv6 rfcomm l2cap bluetooth thermal processor fan button battery asus_acpi ac usb_storage usbmouse sbp2 usbkbd autofs4 af_packet nls_iso8859_1 nls_cp437 8250_pci 8250 serial_core cm4000_cs usbhid eth1394 pcmcia joydev nsc_ircc pcspkr irda snd_intel8x0m snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97_bus ipw2200 evdev crc_ccitt ohci1394 ieee1394 parport_pc parport 8139too mii rtc yenta_socket rsrc_nonstatic pcmcia_core ieee80211 ieee80211_crypt snd_pcm snd_timer firmware_class snd ehci_hcd soundcore snd_page_alloc uhci_hcd usbcore intel_agp agpgart
Apr  3 16:49:55 knautsch kernel: [17181753.596000] CPU:    0
Apr  3 16:49:55 knautsch kernel: [17181753.596000] EIP:    0060:[pg0+537753085/1069212672]    Not tainted VLI
Apr  3 16:49:55 knautsch kernel: [17181753.596000] EFLAGS: 00010246   (2.6.17-rc1-g336da66c-dirty #2) 
Apr  3 16:49:55 knautsch kernel: [17181753.596000] EIP is at snd_pcm_oss_get_formats+0x1d/0xe0 [snd_pcm_oss]
Apr  3 16:49:55 knautsch kernel: [17181753.596000] eax: 00000000   ebx: d89b28fc   ecx: 8004500b   edx: 00000000
Apr  3 16:49:55 knautsch kernel: [17181753.596000] esi: 8004500b   edi: cab671f4   ebp: ca31e000   esp: ca31eee8
Apr  3 16:49:55 knautsch kernel: [17181753.596000] ds: 007b   es: 007b   ss: 0068
Apr  3 16:49:55 knautsch kernel: [17181753.596000] Process soffice.bin (pid: 22759, threadinfo=ca31e000 task=c7081550)
Apr  3 16:49:55 knautsch kernel: [17181753.596000] Stack: <0>ca31ef2c c0161cb0 c0158025 d89b2940 de4fda4c c1460f28 deea13c4 00000001 
Apr  3 16:49:55 knautsch kernel: [17181753.596000]        00000000 ca31ef2c 00000000 d89b28fc 8004500b cab671f4 e052822d 6b000000 
Apr  3 16:49:55 knautsch kernel: [17181753.596000]        ca31ef2c ded02000 fffffffe c1456bc0 ded02000 c0153f75 00000101 00000001 
Apr  3 16:49:55 knautsch kernel: [17181753.596000] Call Trace:
Apr  3 16:49:55 knautsch kernel: [17181753.596000]  <c0161cb0> chrdev_open+0x0/0x170   <c0158025> __dentry_open+0xe5/0x220
Apr  3 16:49:55 knautsch kernel: [17181753.596000]  <e052822d> snd_pcm_oss_ioctl+0x50d/0xb00 [snd_pcm_oss]   <c0153f75> cache_free_debugcheck+0x195/0x2b0
Apr  3 16:49:55 knautsch kernel: [17181753.596000]  <c016b23a> do_ioctl+0x2a/0x80   <c016b2e2> vfs_ioctl+0x52/0x2b0
Apr  3 16:49:55 knautsch kernel: [17181753.596000]  <c0158364> do_sys_open+0xd4/0x100   <c016b585> sys_ioctl+0x45/0x70
Apr  3 16:49:55 knautsch kernel: [17181753.596000]  <c0102e97> syscall_call+0x7/0xb  
Apr  3 16:49:55 knautsch kernel: [17181753.596000] Code: 00 00 00 76 c6 5b b8 ea ff ff ff 5e c3 90 57 56 53 83 ec 2c 8d 54 24 28 e8 d1 fe ff ff 85 c0 89 c2 0f 88 b4 00 00 00 8b 54 24 28 <8b> 42 5c 8b 80 a0 00 00 00 85 c0 75 18 0f b6 82 98 00 00 00 ba 


Apr  4 11:39:18 knautsch kernel: [17179569.184000] Linux version 2.6.17-rc1-dirty (root@knautsch) (gcc version 4.0.3 (Debian 4.0.3-1)) #1 Mon Apr 3 17:15:08 CEST 2006
[...]
Apr  4 15:05:29 knautsch kernel: [17199176.204000] BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
Apr  4 15:05:29 knautsch kernel: [17199176.204000]  printing eip:
Apr  4 15:05:29 knautsch kernel: [17199176.204000] e04d0d65
Apr  4 15:05:29 knautsch kernel: [17199176.204000] *pde = 00000000
Apr  4 15:05:29 knautsch kernel: [17199176.204000] Oops: 0000 [#1]
Apr  4 15:05:29 knautsch kernel: [17199176.204000] Modules linked in: tun lp i915 drm ipv6 rfcomm l2cap bluetooth usbhid thermal processor fan button battery asus_acpi ac usb_storage usbmouse sbp2 usbkbd autofs4 af_packet nls_iso8859_1 nls_cp437 eth1394 cm4000_cs pcmcia 8250_pci 8250 serial_core ohci1394 parport_pc parport ipw2200 8139too mii snd_intel8x0m snd_pcm_oss ieee1394 ieee80211 ieee80211_crypt snd_intel8x0 snd_ac97_codec snd_ac97_bus firmware_class nsc_ircc snd_mixer_oss irda yenta_socket rsrc_nonstatic pcmcia_core joydev evdev pcspkr snd_pcm snd_timer crc_ccitt rtc snd ehci_hcd soundcore snd_page_alloc uhci_hcd usbcore intel_agp agpgart
Apr  4 15:05:29 knautsch kernel: [17199176.204000] CPU:    0
Apr  4 15:05:29 knautsch kernel: [17199176.204000] EIP:    0060:[pg0+537398629/1069212672]    Not tainted VLI
Apr  4 15:05:29 knautsch kernel: [17199176.204000] EFLAGS: 00210246   (2.6.17-rc1-dirty #1) 
Apr  4 15:05:29 knautsch kernel: [17199176.204000] EIP is at snd_pcm_oss_ioctl+0x45/0xb00 [snd_pcm_oss]
Apr  4 15:05:29 knautsch kernel: [17199176.204000] eax: 00000000   ebx: cf5db74c   ecx: 805c4d65   edx: 00000002
Apr  4 15:05:29 knautsch kernel: [17199176.204000] esi: 805c4d65   edi: df08aa60   ebp: da0c1000   esp: da0c1f24
Apr  4 15:05:29 knautsch kernel: [17199176.204000] ds: 007b   es: 007b   ss: 0068
Apr  4 15:05:29 knautsch kernel: [17199176.204000] Process twinkle (pid: 11906, threadinfo=da0c1000 task=c6300a70)
Apr  4 15:05:29 knautsch kernel: [17199176.204000] Stack: <0>6b9e4288 da0c1f2c de822000 fffffffe c1456bc0 de822000 c0153f75 00000101 
Apr  4 15:05:29 knautsch kernel: [17199176.204000]        00000001 cf5db74c 805c4d65 00000010 da0c1000 c016b23a cf5db74c 805c4d65 
Apr  4 15:05:29 knautsch kernel: [17199176.204000]        bf9e422c 00200286 cf5db74c fffffff7 c016b2e2 00000010 c0158364 c1456bc0 
Apr  4 15:05:29 knautsch kernel: [17199176.204000] Call Trace:
Apr  4 15:05:29 knautsch kernel: [17199176.204000]  <c0153f75> cache_free_debugcheck+0x195/0x2b0   <c016b23a> do_ioctl+0x2a/0x80
Apr  4 15:05:29 knautsch kernel: [17199176.204000]  <c016b2e2> vfs_ioctl+0x52/0x2b0   <c0158364> do_sys_open+0xd4/0x100
Apr  4 15:05:29 knautsch kernel: [17199176.204000]  <c016b585> sys_ioctl+0x45/0x70   <c0102e97> syscall_call+0x7/0xb
Apr  4 15:05:29 knautsch kernel: [17199176.204000] Code: 4d 04 80 89 6c 24 30 8b 7a 74 74 4b 81 f9 f9 4d 04 80 74 65 0f b6 c5 83 f8 4d 75 7f 31 d2 8b 04 97 85 c0 75 06 42 83 fa 02 75 f3 <8b> 00 8b 7c 24 40 8b 00 89 7c 24 08 89 4c 24 04 89 04 24 e8 63 


With 2.6.17-rc1 with ipw2200 patches (rtap0 interface, antenna selection,
both available from ipw2200.sourceforge.net) I also got the following
slab corruption, both during a shutdown. This has not yet happened with
clean 2.6.17-rc1:

Apr  3 15:32:07 knautsch kernel: [17189908.444000] Slab corruption: start=df6008f8, len=2048
Apr  3 15:32:07 knautsch kernel: [17189908.448000] Redzone: 0x5a2cf071/0x5a2cf071.
Apr  3 15:32:07 knautsch kernel: [17189908.448000] Last user: [release_mem+314/512](release_mem+0x13a/0x200)
Apr  3 15:32:07 knautsch kernel: [17189908.452000] 0a0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b ff ff ff ff
Apr  3 15:32:07 knautsch kernel: [17189908.456000] 0b0: 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Apr  3 15:32:07 knautsch kernel: [17189908.456000] Prev obj: start=df6000ec, len=2048
Apr  3 15:32:07 knautsch kernel: [17189908.460000] Redzone: 0x170fc2a5/0x170fc2a5.
Apr  3 15:32:07 knautsch kernel: [17189908.460000] Last user: [input_allocate_device+26/112](input_allocate_device+0x1a/0x70)
Apr  3 15:32:07 knautsch kernel: [17189908.464000] 000: ec 88 52 c1 8c 89 52 c1 cc 89 52 c1 00 00 00 00
Apr  3 15:32:07 knautsch kernel: [17189908.468000] 010: 11 00 02 00 07 00 00 00 0b 00 00 00 00 00 00 00
Apr  3 15:32:07 knautsch kernel: [17189908.468000] Next obj: start=df601104, len=2048
Apr  3 15:32:07 knautsch kernel: [17189908.472000] Redzone: 0x170fc2a5/0x170fc2a5.
Apr  3 15:32:07 knautsch kernel: [17189908.476000] Last user: [journal_init_inode+135/368](journal_init_inode+0x87/0x170)
Apr  3 15:32:07 knautsch kernel: [17189908.476000] 000: 4c cd a9 c4 40 ca a9 c4 d8 c8 a9 c4 08 c6 a9 c4
Apr  3 15:32:07 knautsch kernel: [17189908.480000] 010: f0 ce a9 c4 20 cc a9 c4 b4 2e a0 de 7c 2a a0 de

Very similar, with 2.6.16.1 + some ipw patches (unfortunately, here I'm
not completely sure about the applied patches; ipw2200 firmare error
messages may not be related to the corruption):

Mar 29 18:28:45 knautsch kernel: [17185449.008000] ipw2200: Firmware error detected.  Restarting.
Mar 29 18:28:46 knautsch kernel: [17185449.008000] ipw2200: Sysfs 'error' log captured.
Mar 29 18:32:47 knautsch kernel: [17185690.876000] ipw2200: Firmware error detected.  Restarting.
Mar 29 18:32:47 knautsch kernel: [17185690.876000] ipw2200: Sysfs 'error' log already exists.
Mar 29 18:33:08 knautsch kernel: [17185711.468000] tap0: no IPv6 routers present
Mar 29 18:36:44 knautsch kernel: [17185927.988000] Slab corruption: start=cbb4c1ac, len=2048
Mar 29 18:36:44 knautsch kernel: [17185927.988000] Redzone: 0x5a2cf071/0x5a2cf071.
Mar 29 18:36:44 knautsch kernel: [17185927.988000] Last user: [release_mem+134/512](release_mem+0x86/0x200)
Mar 29 18:36:44 knautsch kernel: [17185927.988000] 0a0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b ff ff ff ff
Mar 29 18:36:44 knautsch kernel: [17185927.988000] 0b0: 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Mar 29 18:36:44 knautsch kernel: [17185927.988000] Next obj: start=cbb4c9b8, len=2048
Mar 29 18:36:44 knautsch kernel: [17185927.988000] Redzone: 0x170fc2a5/0x170fc2a5.
Mar 29 18:36:44 knautsch kernel: [17185927.988000] Last user: [vfs_write+181/400](vfs_write+0xb5/0x190)
Mar 29 18:36:44 knautsch kernel: [17185927.988000] 000: 65 78 69 74 0d 0a 6a 61 6e 40 61 70 70 3a 7e 24
Mar 29 18:36:44 knautsch kernel: [17185927.988000] 010: 20 6d 61 6e 64 20 6e 6f 74 20 66 6f 75 6e 64 0d
Mar 29 18:45:06 knautsch kernel: [17186429.588000] ipw2200: Firmware error detected.  Restarting.
Mar 29 18:45:06 knautsch kernel: [17186429.588000] ipw2200: Sysfs 'error' log already exists.

These slab corruptions, btw., look very similar to the one reported in:
Date:   Tue, 7 Mar 2006 18:59:40 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: yet more slab corruption.
Message-ID: <20060307235940.GA16843@redhat.com>


About my hardware:


0000:00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
0000:00:00.1 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
0000:00:00.3 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
0000:00:02.0 VGA compatible controller: Intel Corporation 82852/855GM Integrated Graphics Device (rev 02)
0000:00:02.1 Display controller: Intel Corporation 82852/855GM Integrated Graphics Device (rev 02)
0000:00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03)
0000:00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03)
0000:00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03)
0000:00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller (rev 03)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 83)
0000:00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface Bridge (rev 03)
0000:00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE Controller (rev 03)
0000:00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 03)
0000:00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
0000:00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 03)
0000:01:03.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a9)
0000:01:03.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a9)
0000:01:03.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 01)
0000:01:04.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:01:05.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 05)


Jan

