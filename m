Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbTESVam (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 17:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbTESVam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 17:30:42 -0400
Received: from devil.servak.biz ([209.124.81.2]:18390 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S262963AbTESVak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 17:30:40 -0400
Subject: usbserial OOPS in 2.5.69-bk4
From: Torrey Hoffman <thoffman@arnor.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1053380614.1141.44.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 May 2003 14:43:34 -0700
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a non-fatal oops while trying to hotsync my Handspring Visor. 
My system is still running as I send this email, but the hotsync didn't
work.

The hardware and software is a fairly ordinary single-CPU 
Pentium 3 733, 640 MB of RAM, Intel i820 chipset.  
Red Hat 9 with updates.  

---------------
Here's a bit of the dmesg log showing the USB drivers loading at boot:
---------------

uhci-hcd 00:1f.2: Intel Corp. 82801AA USB
uhci-hcd 00:1f.2: irq 9, io base 00001000
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
uhci-hcd 00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 1-0:0: new USB device on port 1, assigned address 2

---------------
And here's the dmesg and oops which happened when I hotsynced:
---------------

drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for Handspring Visor / Treo / Palm 4.0
 / Cli? 4.x
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Cli? 3.5
Unable to handle kernel paging request at virtual address 10d24d34
 printing eip:
eccdf677
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<eccdf677>]    Not tainted
EFLAGS: 00010246
EIP is at create_serial+0xa7/0xc0 [usbserial]
eax: eccd8554   ebx: eccd8634   ecx: eccd8518   edx: df629c00
esi: 00000000   edi: 00000000   ebp: d610fecc   esp: d610fe14
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 12848, threadinfo=d610e000 task=d2da7860)
Stack: d610fe38 c0135a0b e2e226d8 00000138 eccd84d0 c015dd5e e2e226d4 e7fed580
       00000140 00000000 00000000 00000000 00000000 00000001 c015ec5d 00000000
       e7775ea0 df629c00 00000000 d610fe7c c015ec5d e7fed580 000000d0 e7775ea0

Call Trace:
 [<c0135a0b>] check_poison_obj+0x3b/0x1b0
 [<eccd84d0>] visor_driver+0x30/0xa0 [visor]
 [<c015dd5e>] d_alloc+0x1e/0x1c0
 [<c015ec5d>] alloc_inode+0x12d/0x140
 [<c015ec5d>] alloc_inode+0x12d/0x140
 [<c0173db3>] sysfs_new_inode+0x63/0xb0
 [<c0173e64>] sysfs_create+0x64/0x80
 [<eccd84d0>] visor_driver+0x30/0xa0 [visor]
 [<eccd84d6>] visor_driver+0x36/0xa0 [visor]
 [<eccd8518>] visor_driver+0x78/0xa0 [visor]
 [<eccd84b8>] visor_driver+0x18/0xa0 [visor]
 [<eccd84a0>] visor_driver+0x0/0xa0 [visor]
 [<e8831092>] usb_device_probe+0x72/0xa0 [usbcore]
 [<eccd8320>] id_table_combined+0x0/0x180 [visor]
 [<eccd84b8>] visor_driver+0x18/0xa0 [visor]
 [<c0207233>] bus_match+0x43/0x80
 [<eccd84b8>] visor_driver+0x18/0xa0 [visor]
 [<e8846a58>] usb_bus_type+0x98/0xe0 [usbcore]
 [<eccd84b8>] visor_driver+0x18/0xa0 [visor]
 [<c020735d>] driver_attach+0x5d/0x70
 [<eccd84b8>] visor_driver+0x18/0xa0 [visor]
 [<e8846a04>] usb_bus_type+0x44/0xe0 [usbcore]
 [<eccd84b8>] visor_driver+0x18/0xa0 [visor]
 [<c02075fd>] bus_add_driver+0x9d/0xc0
 [<eccd84b8>] visor_driver+0x18/0xa0 [visor]
 [<e88469c0>] usb_bus_type+0x0/0xe0 [usbcore]
 [<eccd84a0>] visor_driver+0x0/0xa0 [visor]
 [<eccd8700>] +0x0/0xa0 [visor]
 [<c0207a61>] driver_register+0x31/0x40
 [<eccd84b8>] visor_driver+0x18/0xa0 [visor]
 [<c0207a61>] driver_register+0x31/0x40
 [<eccd863c>] clie_3_5_device+0x1c/0xe0 [visor]
 [<e883119b>] usb_register+0x6b/0xb0 [usbcore]
 [<eccd84b8>] visor_driver+0x18/0xa0 [visor]
 [<ecce028e>] usb_serial_register+0x4e/0x90 [usbserial]
 [<ecce1a60>] +0x4e0/0x898 [usbserial]
 [<eccd6a48>] +0x6/0x1fe [visor]
 [<e88d902a>] +0x2a/0x3c [visor]
 [<eccd84a0>] visor_driver+0x0/0xa0 [visor]
 [<c012e622>] sys_init_module+0x102/0x1b0
 [<eccd8700>] +0x0/0xa0 [visor]
 [<c010b02d>] sysenter_past_esp+0x52/0x71

Code: 00 8b 00 c7 04 24 24 14 ce ec 89 44 24 04 e8 66 c7 43 d3 31
 <6>usb 1-2: USB disconnect, address 3

-- 
Torrey Hoffman <thoffman@arnor.net>

