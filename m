Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266575AbUHTLuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266575AbUHTLuP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 07:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbUHTLuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 07:50:15 -0400
Received: from build.arklinux.oregonstate.edu ([128.193.0.51]:8664 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S266575AbUHTLuC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 07:50:02 -0400
From: bero@arklinux.org
To: linux-kernel@vger.kernel.org
Subject: 2.6.8.1 "modprobe tg3" oopses with gcc 3.4.1
Date: Fri, 20 Aug 2004 11:48:47 +0000
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408201148.48206.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this when trying to modprobe tg3 on an Acer Aspire 1500 notebook (32bit 
mode) when the kernel [tried 2.6.8.1 and 2.6.8.1-mm1] is compiled with gcc 
3.4.1 (3.3.4 works):

tg3.c:v3.8 (July 14, 2004)
Unable to handle kernel NULL pointer dereference at virtual address 00000014
printing eip:
c03ba270
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: tg3 snd_pcm_oss snd_mixer_oss md5 ipv6 snd_via82xx 
snd_ac97_codec snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart 
snd_rawmidi snd_seq_device snd tsdev joydev soundcore evdev psmouse lp ds 
yenta_socket pcmcia_core af_packet floppy parport_pc parport eth1394sr_mod 
ide_scsi scsi_mod ide_cd cdrom ohci1394 ieee1394 ehci_hcd uhci_hcd usbcore 
thermal processor fan button battery asus_acpi ac rtc
CPU:    0
EIP:    0060:[<c03ba270>]    Not tainted VLI
EFLAGS: 00210216   (2.6.8-1ark)
EIP is at add_pin_to_irq+0x0/0x60
eax: 00000014   ebx: 00000001   ecx: 00000080  edx: 00000020
esi: 00000014   edi: ccba0de0   ebp: 00000000  esp: ccba0db0
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 7179, threadinfo=ccba0000 task=dad64030)
Stack: c01175a4 00000014 00000000 00000014 00200292 c1482640 00000001 c027df3d
        00000000 00000000 0001a900 01000000 00000014 00000014 00000000 0000000
        c01154a7 00000000 00000014 00000014 00000001 00000001 00100000 
00000000
Call Trace:
[<c01175a4>] io_apic_set_pci_routing+0x1f4/0x220
[<c027df3d>] pci_read+0x3d/0x50
[<c01154a7>] mp_register_gsi+0x177/0x180
[<c01131f9>] acpi_register_gsi+0x89/0x90
[<c01fbf30>] acpi_pci_irq_enable+0x100/0x160
[<c01db988>] pci_enable_device_bars+0x28/0x40
[<c01db9bf>] pci_enable_device+0x1f/0x40
[<e0d18465>] tg3_init_one+0x25/0x770 [tg3]
[<c0197cfb>] sysfs_make_dirent+0x2b/0xa0
[<c0174c82>] dput+0x92/0x2b0
[<c01dd5f2>] pci_device_probe_static+0x52/0x70
[<c01dd64c>] __pci_device_probe+0x3c/0x50
[<c01dd68c>] pci_device_probe+0x2c/0x60
[<c022226f>] bus_match+0x3f/0x80
[<c02223c2>] driver_attach+0x52/0xa0
[<c02228e1>] bus_add_driver+0x91/0xd0
[<c0222eef>] driver_register+0x2f/0x40
[<c01dd95c>] pci_register_driver+0x5c/0x90
[<e080600f>] tg3_init+0xf/0x1d [tg3]
[<c0136977>] sys_init_module+0xe7/0x230
[<c010618b>] syscall_call+0x7/0xb
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0000 00 00 <00> 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
