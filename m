Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbUJYPKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbUJYPKN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbUJYPIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:08:55 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:57301 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261877AbUJYOsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:48:54 -0400
Date: Mon, 25 Oct 2004 16:48:46 +0200
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: 2.6.9-mm1, kernel Ooops in visor_open
Message-ID: <20041025144846.GA2137@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, USB developers, list!

With:
	linux-2.6.9-mm1
	debian/sid
I get the following kernel warning:

usb 4-2: new full speed USB device using address 2
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for Handspring Visor / Palm OS
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Clie 3.5
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Clie 5.0
visor 4-2:1.0: Handspring Visor / Palm OS converter detected
usb 4-2: Handspring Visor / Palm OS converter now attached to ttyUSB0
usb 4-2: Handspring Visor / Palm OS converter now attached to ttyUSB1
usbcore: registered new driver visor
drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver v2.1
Unable to handle kernel NULL pointer dereference at virtual address 00000008
 printing eip:
e09eb036
*pde = 00000000
Oops: 0002 [#1]
PREEMPT 
Modules linked in: visor usbserial radeon irtty_sir sir_dev irda crc_ccitt eth1394 sd_mod ehci_hcd ohci1394 ieee1394 yenta_socket pcmcia_core snd_intel8x0m i2c_i801 usbhid usb_storage uhci_hcd usbcore joydev acerhk intel_agp agpgart orinoco_pci orinoco hermes b44 evdev
CPU:    0
EIP:    0060:[<e09eb036>]    Not tainted VLI
EFLAGS: 00010002   (2.6.9-mm1) 
EIP is at visor_open+0x36/0x1c6 [visor]
eax: 00000282   ebx: 00000000   ecx: d888a580   edx: d13e4000
esi: c3cf8ec0   edi: cba9b600   ebp: 00000000   esp: d13e5eb4
ds: 007b   es: 007b   ss: 0068
Process jpilot (pid: 12278, threadinfo=d13e4000 task=d205b0a0)
Stack: 00000001 00000000 00000000 d13e5ee8 00000000 00000001 c3cf8ec0 cba9b600 
       e09c7369 d5843400 d9405100 00000000 d5218580 ffffffed c4d30000 d5218580 
       00000000 c01ea00e 08028ad6 0bc00001 c4d30000 00000001 d13e4000 c788a804 
Call Trace:
 [<e09c7369>] serial_open+0xbc/0x14f [usbserial]
 [<c01ea00e>] tty_open+0x211/0x288
 [<c015894a>] chrdev_open+0xe9/0x1c2
 [<c014ffdd>] dentry_open+0x134/0x210
 [<c014fea7>] filp_open+0x4c/0x4e
 [<c01500e5>] get_unused_fd+0x2c/0xce
 [<c0150239>] sys_open+0x3c/0x76
 [<c0105ecb>] syscall_call+0x7/0xb
Code: 98 ec 00 00 00 a1 80 f1 9e e0 85 c0 0f 85 80 01 00 00 8b 4f 20 85 c9 0f 84 40 01 00 00 9c 58 fa ba 00 e0 ff ff 21 e2 83 42 14 01 <c7> 43 08 00 00 00 00 c7 03 00 00 00 00 c7 43 04 00 00 00 00 50 
 <6>note: jpilot[12278] exited with preempt_count 1
scheduling while atomic: jpilot/0x10000001/12278
 [<c02e4a6c>] schedule+0x50c/0x511
 [<c02e4ed2>] cond_resched+0x2d/0x43
 [<c0142585>] unmap_vmas+0x19e/0x1f7
 [<c01466e5>] exit_mmap+0x78/0x143
 [<c011a8f5>] mmput+0x2f/0xb6
 [<c011e840>] do_exit+0x149/0x41e
 [<c0107045>] do_divide_error+0x0/0x10e
 [<c0117d2b>] do_page_fault+0x0/0x5aa
 [<c0117d2b>] do_page_fault+0x0/0x5aa
 [<c0117ff1>] do_page_fault+0x2c6/0x5aa
 [<c0187a1a>] ext3_mark_inode_dirty+0x39/0x3b
 [<c0139a90>] buffered_rmqueue+0xf0/0x1b3
 [<c0139d78>] __alloc_pages+0x225/0x3a1
 [<c01b7cc2>] vsnprintf+0x24b/0x4b9
 [<c0117d2b>] do_page_fault+0x0/0x5aa
 [<c0106919>] error_code+0x2d/0x38
 [<c01e007b>] pnp_device_probe+0x74/0x94
 [<e09eb036>] visor_open+0x36/0x1c6 [visor]
 [<e09c7369>] serial_open+0xbc/0x14f [usbserial]
 [<c01ea00e>] tty_open+0x211/0x288
 [<c015894a>] chrdev_open+0xe9/0x1c2
 [<c014ffdd>] dentry_open+0x134/0x210
 [<c014fea7>] filp_open+0x4c/0x4e
 [<c01500e5>] get_unused_fd+0x2c/0xce
 [<c0150239>] sys_open+0x3c/0x76
 [<c0105ecb>] syscall_call+0x7/0xb
usb 4-2: USB disconnect, address 2
visor 4-2:1.0: device disconnected

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
CORSTORPHINE (n.)
A very short peremptory service held in monasteries prior to teatime
to offer thanks for the benediction of digestive biscuits.
			--- Douglas Adams, The Meaning of Liff
