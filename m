Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269607AbUJFXCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269607AbUJFXCM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269617AbUJFW7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 18:59:40 -0400
Received: from web11207.mail.yahoo.com ([216.136.131.189]:11302 "HELO
	web11207.mail.yahoo.com") by vger.kernel.org with SMTP
	id S269607AbUJFW4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 18:56:53 -0400
Message-ID: <20041006225653.44008.qmail@web11207.mail.yahoo.com>
Date: Wed, 6 Oct 2004 15:56:53 -0700 (PDT)
From: todd nguyen <toddnguyen@yahoo.com>
Subject: Oops in loading cardbus bridge drivers in kernel version 2.6.9-rc1
To: linux-kernel@vger.kernel.org
Cc: majordomo@vger.kernel.org, toddnguyen@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi friends
 I have a problem loading the yenta_socket.ko under
"Linux winter-lnx 2.6.9-rc1 #1 Wed Sep 29 15:39:33 PDT
2004 i686 i686 i386 GNU/Linux".  From dmesg outtput it
gave me an error like 
" Unable to handle kernel NULL pointer dereference at
virtual address 00000008"  Can anyone give me some
pointer on why I'm seeing this error?

Thanks in advance,
Todd Nguyen


output log from dmesg
======================Linux Kernel Card Services
  options:  [pci] [cardbus]
PCI: Found IRQ 11 for device 0000:02:01.0
PCI: Sharing IRQ 11 with 0000:00:1d.1
PCI: Sharing IRQ 11 with 0000:02:01.1
Yenta: CardBus bridge found at 0000:02:01.0
[1028:011d]
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000820
PCI: Found IRQ 11 for device 0000:02:01.1
PCI: Sharing IRQ 11 with 0000:00:1d.1
PCI: Sharing IRQ 11 with 0000:02:01.0
Yenta: CardBus bridge found at 0000:02:01.1
[1028:011d]
Yenta: ISA IRQ mask 0x06b8, PCI irq 11
Socket status: 30000410
Unable to handle kernel NULL pointer dereference at
virtual address 00000008
 printing eip:
c017e5fb
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: yenta_socket pcmcia_core windrvr6
usbcore nfs lockd sunrpc rade on agpgart autofs4 tg3
microcode ide_scsi ide_cd cdrom
CPU:    0
EIP:    0060:[<c017e5fb>]    Tainted: P   VLI
EFLAGS: 00010292   (2.6.9-rc1)
EIP is at sysfs_add_file+0x1b/0xa0
eax: 00000000   ebx: f7f93dc0   ecx: c0336fe8   edx:
f7f93e00
esi: f7f93d80   edi: c02ff3bc   ebp: 00000000   esp:
ee851e64
ds: 007b   es: 007b   ss: 0068
Process pccardd (pid: 5940, threadinfo=ee850000
task=eb2587d0)
Stack: c02ff340 c01ee199 f7f93e00 f7f93dc0 f7f93d80
f7f902c0 00000004 c01edd03
       00000000 c02ff3bc c01ca003 f7f93df8 c02ff3bc
00000000 00000004 ea3f2800
       00000000 00000004 00000000 c01ca2a6 f7f902c0
ea3f2800 00000004 00000004
Call Trace:
 [<c01ee199>] class_device_add+0x129/0x140
 [<c01edd03>] class_device_create_file+0x23/0x30
 [<c01ca003>] pci_alloc_child_bus+0x93/0xe0
 [<c01ca2a6>] pci_scan_bridge+0x206/0x240
 [<c01ca959>] pci_scan_child_bus+0xa9/0xb0
 [<c01ca263>] pci_scan_bridge+0x1c3/0x240
 [<f8a7989e>] cb_alloc+0xde/0xf0 [pcmcia_core]
 [<f8a76769>] socket_insert+0x99/0x110 [pcmcia_core]
 [<f8a769f8>] socket_detect_change+0x58/0x90
[pcmcia_core]
 [<f8a76bad>] pccardd+0x17d/0x1f0 [pcmcia_core]
 [<c0110a70>] default_wake_function+0x0/0x20
 [<c0110a70>] default_wake_function+0x0/0x20
 [<f8a76a30>] pccardd+0x0/0x1f0 [pcmcia_core]
 [<c0104065>] kernel_thread_helper+0x5/0x10
Code: dc 1b f9 ff eb c6 8d 76 00 8d bc 27 00 00 00 00
83 ec 1c 89 6c 24 18 8b 6c 2 4 20 89 7c 24 14 8b 7c 24
24 89 5c 24 0c 89 74 24 10 <8b> 45 08 8d 48 68 ff 48
68 0f 88 90 01 00 00 8b 07 89 2c 24 89


output from lspci -v
========================
00:1f.5 Multimedia audio controller: Intel Corp.
82801DB AC'97 Audio Controller (rev 01)
        Subsystem: Dell Computer Corporation: Unknown
device 011d
        Flags: bus master, medium devsel, latency 0,
IRQ 11
        I/O ports at b800 [size=256]
        I/O ports at bc40 [size=64]
        Memory at f4fff800 (32-bit, non-prefetchable)
[size=512]
        Memory at f4fff400 (32-bit, non-prefetchable)
[size=256]
        Capabilities: <available only to root>

01:00.0 VGA compatible controller: ATI Technologies
Inc Radeon R250 Lf [Radeon Mobility 9000 M9] (rev 02)
(prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown
device 011d
        Flags: bus master, VGA palette snoop,
stepping, 66Mhz, medium devsel, latency 32, IRQ 11
        Memory at e8000000 (32-bit, prefetchable)
[size=128M]
        I/O ports at c000 [size=256]
        Memory at fcff0000 (32-bit, non-prefetchable)
[size=64K]
        Expansion ROM at <unassigned> [disabled]
[size=128K]
        Capabilities: <available only to root>

02:00.0 Ethernet controller: Broadcom Corporation
NetXtreme BCM5705M Gigabit Ethernet (rev 01)
        Subsystem: Dell Computer Corporation: Unknown
device 865d
        Flags: bus master, 66Mhz, medium devsel,
latency 32, IRQ 11
        Memory at faff0000 (64-bit, non-prefetchable)
[size=64K]
        Capabilities: <available only to root>

02:01.0 CardBus bridge: O2 Micro, Inc.: Unknown device
7113 (rev 20)
        Subsystem: Dell Computer Corporation: Unknown
device 011d
        Flags: bus master, stepping, slow devsel,
latency 168, IRQ 11
        Memory at 40001000 (32-bit, non-prefetchable)
[size=4K]
        Bus: primary=02, secondary=03, subordinate=06,
sec-latency=176
        Memory window 0: 40400000-407ff000
(prefetchable)
        Memory window 1: 40800000-40bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        16-bit legacy interface ports at 0001

02:01.1 CardBus bridge: O2 Micro, Inc.: Unknown device
7113 (rev 20)
        Subsystem: Dell Computer Corporation: Unknown
device 011d
        Flags: bus master, stepping, slow devsel,
latency 168, IRQ 11
        Memory at 40002000 (32-bit, non-prefetchable)
[size=4K]
        Bus: primary=02, secondary=07, subordinate=0a,
sec-latency=176
        Memory window 0: 40c00000-40fff000
(prefetchable)
        Memory window 1: 41000000-413ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        16-bit legacy interface ports at 0001



		

