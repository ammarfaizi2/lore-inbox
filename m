Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbTINF7E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 01:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTINF7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 01:59:04 -0400
Received: from smtp.easystreet.com ([206.26.36.40]:11427 "EHLO
	easystreet01.easystreet.com") by vger.kernel.org with ESMTP
	id S262327AbTINF66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 01:58:58 -0400
Message-Id: <200309140558.h8E5wuMo015798@oldred.easystreet.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test5-mm1 - usbserial oops
Date: Sat, 13 Sep 2003 22:58:56 -0700
From: cliffw@easystreet.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


System:
VIA C3, 256 MB ram
Kernel: 2.6.0-test5-mm1 w/ usbserial.c patch from:
http://marc.theaimsgroup.com/?l=linux-kernel&m=106330324016154&w=2


Symptom: hotsync fails to connect. Oops occurs when hotsync
is canceled on device.  
-----------------------------------------

usb 3-1: palm_os_4_probe - error -32 getting connection info
usbserial 3-1:0: Handspring Visor / Palm OS converter detected
usb 3-1: Handspring Visor / Palm OS converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
usb 3-1: Handspring Visor / Palm OS converter now attached to ttyUSB1 (or usb/tts/1 for devfs)
usb 3-1: USB disconnect, address 3
usbserial 3-1:0: device disconnected
visor ttyUSB0: Handspring Visor / Palm OS converter now disconnected from ttyUSB0
Unable to handle kernel NULL pointer dereference at virtual address 00000024
 printing eip:
c016d0bd
*pde = 00000000
Oops: 0002 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<c016d0bd>]    Not tainted VLI
EFLAGS: 00010202
EIP is at simple_rmdir+0x1d/0x40
eax: 00000000   ebx: c79c7880   ecx: 05fe7cc8   edx: ffffffd9
esi: cbb3a500   edi: c7b22000   ebp: c79c789c   esp: c7b23d58
ds: 007b   es: 007b   ss: 0068
Process jpilot (pid: 1025, threadinfo=c7b22000 task=c809c080)
Stack: c7143280 c79c7880 c018120c cbb3a500 c79c7880 c7923b00 c79c7680 c79c7880 
       c01812ea c79c7880 c831589c ca3ed8cc cb1d0200 00000001 c01ede11 c831589c 
       c8315878 c0227a81 c831589c c8315878 ce8e2bb4 c8315878 00000000 c0227acb 
Call Trace:
 [<c018120c>] remove_dir+0x3c/0x60
 [<c01812ea>] sysfs_remove_dir+0xaa/0x100
 [<c01ede11>] kobject_del+0x41/0x70
 [<c0227a81>] device_del+0x61/0xa0
 [<c0227acb>] device_unregister+0xb/0x20
 [<ce8de262>] destroy_serial+0x182/0x1c0 [usbserial]
 [<c01edf03>] kobject_cleanup+0x63/0x70
 [<ce8dd441>] serial_close+0x61/0x90 [usbserial]
 [<c02039c8>] release_dev+0x5d8/0x620
 [<c01b9894>] nfs_flush_file+0x34/0x90
 [<c0203dd2>] tty_release+0x22/0x60
 [<c014ffd4>] __fput+0x104/0x120
 [<c014e823>] filp_close+0x43/0x70
 [<c011d7a7>] put_files_struct+0x67/0xc0
 [<c011e384>] do_exit+0x154/0x3d0
 [<c011e68f>] do_group_exit+0x2f/0xa0
 [<c0126e44>] get_signal_to_deliver+0x254/0x350
 [<c010aee4>] do_signal+0x54/0xe0
 [<c0160850>] __pollwait+0x0/0xa0
 [<c0160f5f>] sys_select+0x24f/0x500
 [<c010afa7>] do_notify_resume+0x37/0x40
 [<c03394fe>] work_notifysig+0x13/0x15

Code: c0 c3 8d b6 00 00 00 00 8d bf 00 00 00 00 56 53 8b 5c 24 10 8b 74 24 0c 53 e8 40 ff ff ff 85 c0 5a ba d9 ff ff ff 74 14 8b 43 08 <ff> 48 24 53 56 e8 b9 ff ff ff ff 4e 24 58 31 d2 59 5b 89 d0 5e 
 <6>hub 1-0:0: debounce: port 3: delay 100ms stable 4 status 0x501
hub 3-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 3-0:0: new USB device on port 1, assigned address 4
usb 3-1: palm_os_4_probe - error -32 getting connection info
usbserial 3-1:0: Handspring Visor / Palm OS converter detected
usb 3-1: Handspring Visor / Palm OS converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
Unable to handle kernel paging request at virtual address ffffffef
 printing eip:
c01f04f0
*pde = 00035067
*pte = 00000000
Oops: 0000 [#2]
PREEMPT 
CPU:    0
EIP:    0060:[<c01f04f0>]    Not tainted VLI
EFLAGS: 00010282
EIP is at atomic_dec_and_lock+0x10/0x60
eax: ffffffef   ebx: ffffffef   ecx: ffffffef   edx: cdfd8180
esi: ffffffef   edi: c03f2920   ebp: cde3dd38   esp: cde3dc60
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 5, threadinfo=cde3c000 task=cdfa0080)
Stack: ffffffef ffffffef c0164b1b ffffffef c04774b0 ffffffef cdfd8180 c03f2920 
       c018111a ffffffef c6fe5494 00000000 c0181175 c6fe5494 cdfd8180 c6fe5498 
       00000000 c6fe5494 c01ed7d4 c6fe5494 c6fe5494 c03eb254 c01edc20 c6fe5494 
Call Trace:
 [<c0164b1b>] dput+0x1b/0x280
 [<c018111a>] create_dir+0x6a/0x80
 [<c0181175>] sysfs_create_dir+0x25/0x80
 [<c01ed7d4>] create_dir+0x14/0x40
 [<c01edc20>] kobject_add+0x90/0x120
 [<c0229560>] class_device_add+0x70/0x140
 [<c0229641>] class_device_register+0x11/0x20
 [<c02051bc>] tty_add_class_device+0x5c/0xd0
 [<c0205355>] tty_register_device+0x55/0x70
 [<c018080b>] sysfs_create+0x5b/0x90
 [<c0164b1b>] dput+0x1b/0x280
 [<c0180f69>] sysfs_add_file+0x79/0x90
 [<ce8dfe6e>] usb_serial_device_probe+0xae/0x140 [usbserial]
 [<c022897e>] bus_match+0x2e/0x60
 [<c02289fa>] device_attach+0x4a/0xb0
 [<c0228bec>] bus_add_device+0x4c/0x90
 [<c022793b>] device_add+0x8b/0x120
 [<c02279e1>] device_register+0x11/0x20
 [<ce8de932>] usb_serial_probe+0x512/0xc10 [usbserial]
 [<c018080b>] sysfs_create+0x5b/0x90
 [<c0164b1b>] dput+0x1b/0x280
 [<c0180f69>] sysfs_add_file+0x79/0x90
 [<c0296dd3>] usb_probe_interface+0x53/0x80
 [<c022897e>] bus_match+0x2e/0x60
 [<c02289fa>] device_attach+0x4a/0xb0
 [<c0228bec>] bus_add_device+0x4c/0x90
 [<c022793b>] device_add+0x8b/0x120
 [<c0297ec8>] usb_new_device+0x2c8/0x420
 [<c0299e14>] hub_port_connect_change+0x1a4/0x2f0
 [<c029a1ee>] hub_events+0x28e/0x310
 [<c029a2a5>] hub_thread+0x35/0x100
 [<c0118de0>] default_wake_function+0x0/0x20
 [<c029a270>] hub_thread+0x0/0x100
 [<c0109165>] kernel_thread_helper+0x5/0x10

Code: 8d 76 02 66 89 17 8d 7f 02 74 07 c1 e2 10 8a 16 88 17 01 d0 83 d0 00 5e 5f 5b c3 56 53 8b 4c 24 0c 8d 76 00 8d bc 27 00 00 00 00 <8b> 31 89 f2 4a 74 11 89 f0 f0 0f b1 11 31 db 39 f0 75 ed 89 d8 
 <4>usb 3-1: control timeout on ep0in

----------------------

cliffw
