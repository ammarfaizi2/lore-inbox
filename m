Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUCUUfE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 15:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbUCUUfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 15:35:04 -0500
Received: from mail.bencastricum.nl ([213.84.203.196]:24836 "EHLO
	gateway.bencastricum.nl") by vger.kernel.org with ESMTP
	id S261262AbUCUUex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 15:34:53 -0500
Message-ID: <002201c40f83$bd82b9d0$0502a8c0@tragebak>
From: "Ben Castricum" <helpdeskie@bencastricum.nl>
To: <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.5-rc2 BUG: NULL pointer dereference in khubd
Date: Sun, 21 Mar 2004 21:33:16 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Found to be clean
X-MailScanner-From: helpdeskie@bencastricum.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the error below after upgrading from 2.6.5-rc1 to 2.6.5-rc2.

This is on a Asus MEW mainboard (intel 810 chipset), kernel compiled with
gcc version 2.95.3 20010315 (release).
I can supply more info in required.

I hope this helps,
Ben

----------------------------------------------------------------------------
------------
Real Time Clock Driver v1.12
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:1f.2: Intel Corp. 82801AA USB
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: irq 9, io base 0000a400
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver cdc_acm
drivers/usb/class/cdc-acm.c: v0.23:USB Abstract Control Model driver for USB
modems and ISDN adapters
hw_random hardware driver 1.0.0 loaded
usb 1-2: new full speed USB device using address 2
Unable to handle kernel NULL pointer dereference at virtual address 00000005
 printing eip:
c8860954
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c8860954>]    Not tainted
EFLAGS: 00010246   (2.6.5-rc2)
EIP is at acm_probe+0x9c/0x51c [cdc_acm]
eax: c7ac8cc0   ebx: 00000000   ecx: c7da0b80   edx: 00000000
esi: c770ed6c   edi: 00000004   ebp: c7ac8dc0   esp: c7b3be3c
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 37, threadinfo=c7b3a000 task=c7b3d760)
Stack: c8861d40 ffffffed c7ac8dd4 c7ac8dc0 c7b17300 c02908f0 00000000
00000001
       c029a3cc c0173a7c c7b17300 c029a3e0 c7ac8cc0 c770ed60 c12d2c00
c888d049
       c7ac8dc0 c8861c80 ffffffed c8861d40 c7ac8dd4 c12d2cd0 c8861d20
c01d06f1
Call Trace:
 [<c0173a7c>] sysfs_add_file+0x5c/0x7c
 [<c888d049>] usb_probe_interface+0x41/0x5c [usbcore]
 [<c01d06f1>] bus_match+0x31/0x54
 [<c01d076a>] device_attach+0x56/0x8c
 [<c01d08e8>] bus_add_device+0x50/0x88
 [<c01cfa48>] device_add+0x88/0x118
 [<c01cfae9>] device_register+0x11/0x18
 [<c8892653>] usb_set_configuration+0x1bb/0x1f4 [usbcore]
 [<c888dd93>] usb_new_device+0x2d3/0x370 [usbcore]
 [<c0117330>] printk+0x12c/0x154
 [<c888f3c6>] hub_port_connect_change+0x1ce/0x254 [usbcore]
 [<c888f57d>] hub_events+0x131/0x2dc [usbcore]
 [<c888f755>] hub_thread+0x2d/0xe4 [usbcore]
 [<c888f728>] hub_thread+0x0/0xe4 [usbcore]
 [<c0113abc>] default_wake_function+0x0/0x1c
 [<c0104e75>] kernel_thread_helper+0x5/0xc

Code: 80 7a 05 0a 0f 85 52 04 00 00 80 7a 04 01 0f 86 48 04 00 00
 <6>8139too Fast Ethernet driver 0.9.27
PCI: Enabling device 0000:01:08.0 (0004 -> 0007)
eth0: RealTek RTL8139 at 0xc8866000, 00:50:fc:85:89:e0, IRQ 12
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
----------------------------------------------------------------------------
------------

