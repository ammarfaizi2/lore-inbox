Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264129AbUFXJwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUFXJwQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 05:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbUFXJwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 05:52:16 -0400
Received: from ip213-185-39-113.laajakaista.mtv3.fi ([213.185.39.113]:45730
	"HELO dag.newtech.fi") by vger.kernel.org with SMTP id S264129AbUFXJwG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 05:52:06 -0400
Message-ID: <20040624095205.29088.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-0.27
To: linux-kernel@vger.kernel.org
Subject: 2.6.7 Oops when removing PCMCIA memory card
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Thu, 24 Jun 2004 12:52:05 +0300
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

just an into this Oops on my laptop during the following procedure:

- Inserted a PCMCIA adapter with a CompactFlash
- This was recognized and mounted readonly as requested
- A number of pictures was copied from it
- The card was unmounted
- Ejected the PCMCIA adapter and got the Oops

Data:
- Latitude Cpi 300XT Laptop
- Linux 2.6.7 selfcompiled

This seems to be repeatable as it happened again after a reboot.

The Oops report:
==================
Unable to handle kernel NULL pointer dereference at virtual address 00000019
 printing eip:
c011d250
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: ide_cs snd_cs4236 snd_opl3_lib snd_hwdep snd_cs4236_lib 
snd_mpu401_uart snd_rawmidi snd_seq_device snd_cs4231_lib snd_pcm snd_timer 
snd_page_alloc snd soundcore uhci_hcd usbcore eeprom i2c_sensor i2c_piix4 
i2c_core orinoco_cs orinoco hermes ds yenta_socket pcmcia_core button ac 
battery fan thermal processor ntfs nls_iso8859_15 vfat fat rtc
CPU:    0
EIP:    0060:[__release_resource+16/64]    Not tainted
EIP:    0060:[<c011d250>]    Not tainted
EFLAGS: 00010202   (2.6.7) 
EIP is at __release_resource+0x10/0x40
eax: caf787e8   ebx: cf50c000   ecx: 00000019   edx: 00001050
esi: 00000001   edi: 00001040   ebp: 00000010   esp: cf50debc
ds: 007b   es: 007b   ss: 0068
Process pccardd (pid: 845, threadinfo=cf50c000 task=cfbf3110)
Stack: cf50c000 c011d351 caf787e8 cf84782c 00000001 d0a2409b caf787e8 0000001d 
       cf2f8df8 cf84782c cf84782c d0a25097 cf84782c 00001040 00000010 cf2f8de0 
       cf2f8de0 cf2f8e58 d0ad29f7 c80adc80 cf2f8df8 00000010 cf2f8e58 c80adc80 
Call Trace:
 [release_resource+33/80] release_resource+0x21/0x50
 [<c011d351>] release_resource+0x21/0x50
 [__crc_pci_enable_device+2601376/8768991] release_io_space+0x7b/0x90 
[pcmcia_core]
 [<d0a2409b>] release_io_space+0x7b/0x90 [pcmcia_core]
 [__crc_pci_enable_device+2605468/8768991] pcmcia_release_io+0xb7/0xe0 
[pcmcia_core]
 [<d0a25097>] pcmcia_release_io+0xb7/0xe0 [pcmcia_core]
 [__crc_pci_enable_device+3316476/8768991] ide_release+0x47/0xe0 [ide_cs]
 [<d0ad29f7>] ide_release+0x47/0xe0 [ide_cs]
 [__crc_pci_enable_device+3316707/8768991] ide_event+0x4e/0xe0 [ide_cs]
 [<d0ad2ade>] ide_event+0x4e/0xe0 [ide_cs]
 [__crc_pci_enable_device+2598003/8768991] send_event+0x5e/0x70 [pcmcia_core]
 [<d0a2336e>] send_event+0x5e/0x70 [pcmcia_core]
 [__crc_pci_enable_device+2598055/8768991] socket_remove_drivers+0x22/0x50 
[pcmcia_core]
 [<d0a233a2>] socket_remove_drivers+0x22/0x50 [pcmcia_core]
 [__crc_pci_enable_device+2598120/8768991] socket_shutdown+0x13/0x70 
[pcmcia_core]
 [<d0a233e3>] socket_shutdown+0x13/0x70 [pcmcia_core]
 [__crc_pci_enable_device+2599672/8768991] socket_remove+0x13/0x70 
[pcmcia_core]
 [<d0a239f3>] socket_remove+0x13/0x70 [pcmcia_core]
 [__crc_pci_enable_device+2599871/8768991] socket_detect_change+0x6a/0x90 
[pcmcia_core]
 [<d0a23aba>] socket_detect_change+0x6a/0x90 [pcmcia_core]
 [__crc_pci_enable_device+2600349/8768991] pccardd+0x1b8/0x240 [pcmcia_core]
 [<d0a23c98>] pccardd+0x1b8/0x240 [pcmcia_core]
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0115b20>] default_wake_function+0x0/0x20
 [ret_from_fork+6/20] ret_from_fork+0x6/0x14
 [<c0104f52>] ret_from_fork+0x6/0x14
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0115b20>] default_wake_function+0x0/0x20
 [__crc_pci_enable_device+2599909/8768991] pccardd+0x0/0x240 [pcmcia_core]
 [<d0a23ae0>] pccardd+0x0/0x240 [pcmcia_core]
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
 [<c01032ad>] kernel_thread_helper+0x5/0x18

Code: 8b 11 bb ea ff ff ff 85 d2 74 17 39 c2 74 05 8d 4a 14 eb ec 
 <6>note: pccardd[845] exited with preempt_count 1
Unable to handle kernel NULL pointer dereference at virtual address 00000019
 printing eip:
c011d250
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: snd_cs4236 snd_opl3_lib snd_hwdep snd_cs4236_lib 
snd_mpu401_uart snd_rawmidi snd_seq_device snd_cs4231_lib snd_pcm snd_timer 
snd_page_alloc snd soundcore uhci_hcd usbcore eeprom i2c_sensor i2c_piix4 
i2c_core ide_cs orinoco_cs orinoco hermes ds yenta_socket pcmcia_core button 
ac battery fan thermal processor ntfs nls_iso8859_15 vfat fat rtc
CPU:    0
EIP:    0060:[__release_resource+16/64]    Not tainted
EIP:    0060:[<c011d250>]    Not tainted
EFLAGS: 00010202   (2.6.7) 
EIP is at __release_resource+0x10/0x40
eax: cbca4bc8   ebx: cfbe0000   ecx: 00000019   edx: 00001050
esi: 00000001   edi: 00001040   ebp: 00000010   esp: cfbe1ebc
ds: 007b   es: 007b   ss: 0068
Process pccardd (pid: 870, threadinfo=cfbe0000 task=cf6431f0)
Stack: cfbe0000 c011d351 cbca4bc8 cf84782c 00000001 d0a2409b cbca4bc8 0000001d 
       cd4465d8 cf84782c cf84782c d0a25097 cf84782c 00001040 00000010 cd4465c0 
       cd4465c0 cd446638 d0a1b9f7 cd446680 cd4465d8 00000010 cd446638 cd446680 
Call Trace:
 [release_resource+33/80] release_resource+0x21/0x50
 [<c011d351>] release_resource+0x21/0x50
 [__crc_pci_enable_device+2601376/8768991] release_io_space+0x7b/0x90 
[pcmcia_core]
 [<d0a2409b>] release_io_space+0x7b/0x90 [pcmcia_core]
 [__crc_pci_enable_device+2605468/8768991] pcmcia_release_io+0xb7/0xe0 
[pcmcia_core]
 [<d0a25097>] pcmcia_release_io+0xb7/0xe0 [pcmcia_core]
 [__crc_pci_enable_device+2566908/8768991] ide_release+0x47/0xe0 [ide_cs]
 [<d0a1b9f7>] ide_release+0x47/0xe0 [ide_cs]
 [__crc_pci_enable_device+2567139/8768991] ide_event+0x4e/0xe0 [ide_cs]
 [<d0a1bade>] ide_event+0x4e/0xe0 [ide_cs]
 [__crc_pci_enable_device+2598003/8768991] send_event+0x5e/0x70 [pcmcia_core]
 [<d0a2336e>] send_event+0x5e/0x70 [pcmcia_core]
 [__crc_pci_enable_device+2598055/8768991] socket_remove_drivers+0x22/0x50 
[pcmcia_core]
 [<d0a233a2>] socket_remove_drivers+0x22/0x50 [pcmcia_core]
 [__crc_pci_enable_device+2598120/8768991] socket_shutdown+0x13/0x70 
[pcmcia_core]
 [<d0a233e3>] socket_shutdown+0x13/0x70 [pcmcia_core]
 [__crc_pci_enable_device+2599672/8768991] socket_remove+0x13/0x70 
[pcmcia_core]
 [<d0a239f3>] socket_remove+0x13/0x70 [pcmcia_core]
 [__crc_pci_enable_device+2599871/8768991] socket_detect_change+0x6a/0x90 
[pcmcia_core]
 [<d0a23aba>] socket_detect_change+0x6a/0x90 [pcmcia_core]
 [__crc_pci_enable_device+2600349/8768991] pccardd+0x1b8/0x240 [pcmcia_core]
 [<d0a23c98>] pccardd+0x1b8/0x240 [pcmcia_core]
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0115b20>] default_wake_function+0x0/0x20
 [ret_from_fork+6/20] ret_from_fork+0x6/0x14
 [<c0104f52>] ret_from_fork+0x6/0x14
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0115b20>] default_wake_function+0x0/0x20
 [__crc_pci_enable_device+2599909/8768991] pccardd+0x0/0x240 [pcmcia_core]
 [<d0a23ae0>] pccardd+0x0/0x240 [pcmcia_core]
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
 [<c01032ad>] kernel_thread_helper+0x5/0x18

Code: 8b 11 bb ea ff ff ff 85 d2 74 17 39 c2 74 05 8d 4a 14 eb ec 
 <6>note: pccardd[870] exited with preempt_count 1
==============

Best Regards

-- 
Dag Nygren                               email: dag@newtech.fi
Oy Espoon NewTech Ab                     phone: +358 9 8024910
Träsktorpet 3                              fax: +358 9 8024916
02360 ESBO                              Mobile: +358 400 426312
FINLAND


