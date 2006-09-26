Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWIZMAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWIZMAf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 08:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWIZMAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 08:00:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:7053 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751191AbWIZMAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 08:00:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=eS+B3BD+ah6qWsw01GBxpORaEJ1uanONpoah0t1NyOOCLTDcFIndkaDT8w2lBSVX0gVfK4VOCHxB5ZGKYCyqFaGSBlEa/7oWjhDAtd16qw4S+tHfsu0EjrgN5nn+oXeVjUJook0nV4BMXq+LoK8CzT+DrV/BIxc1MuNJeur3DpY=
Date: Tue, 26 Sep 2006 14:00:16 +0200
From: Diego Calleja <diegocg@gmail.com>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: pata_serverworks oopses in latest -git
Message-Id: <20060926140016.54d532ba.diegocg@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to test the new libata PATA drivers in the latest -git tree, I 
got this when udev tried to load the module:

[   13.006189] FDC 0 is a National Semiconductor PC87306
[   13.136324] ata3: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
[   13.136355] BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
[   13.136366]  printing eip:
[   13.136370] 00000000
[   13.136373] *pde = 00000000
[   13.136380] Oops: 0000 [#1]
[   13.136383] PREEMPT SMP
[   13.136391] Modules linked in: pata_serverworks floppy psmouse snd_page_alloc e100 serio_raw i2c_piix4 pcspkr i2c_core sworks_agp agpgart evdev ext3 jbd mbcache ohci_hcd usbcore sd_mod sata_sil libata scsi_mod thermal processor fan vga16fb vgastate
[   13.136430] CPU:    0
[   13.136432] EIP:    0060:[<00000000>]    Not tainted VLI
[   13.136435] EFLAGS: 00010246   (2.6.18custom1 #2)
[   13.136451] EIP is at stext+0x3feffd6c/0xc
[   13.136458] eax: f898c480   ebx: 0000ffa0   ecx: 00000000   edx: f7c62ca0
[   13.136465] esi: 000003f6   edi: 000001f0   ebp: f7b38308   esp: dff67d2c
[   13.136471] ds: 007b   es: 007b   ss: 0068
[   13.136478] Process modprobe (pid: 3643, ti=dff67000 task=dfcaf250 task.ti=dff67000)
[   13.136483] Stack: f885bf04 f7b38308 00000003 00000050 f88650da 000001f0 000003f6 0000ffa0
[   13.136498]        0000000e 0000000d c1916048 f7c62ca0 0000000e f7c62ca0 00000000 00000079
[   13.136512]        f7dc9800 00000000 00000002 00000002 f8860973 f7dc9800 f898c640 00000000
[   13.136526] Call Trace:
[   13.136534]  [<f885bf04>] ata_device_add+0x264/0x630 [libata]
[   13.136660]  [<f8860973>] ata_pci_init_one+0x203/0x550 [libata]
[   13.136689]  [<c01f8ca8>] pci_bus_write_config_dword+0x68/0x80
[   13.136716]  [<f898a5b8>] serverworks_init_one+0xa8/0x420 [pata_serverworks]
[   13.136734]  [<c01fe1c3>] pci_device_probe+0x63/0x80
[   13.136749]  [<c024ff24>] driver_probe_device+0x54/0xf0
[   13.136766]  [<c0250040>] __driver_attach+0x0/0x80
[   13.136774]  [<c02500b1>] __driver_attach+0x71/0x80
[   13.136783]  [<c024f1ed>] bus_for_each_dev+0x5d/0x80
[   13.136794]  [<c024fd95>] driver_attach+0x25/0x30
[   13.136802]  [<c0250040>] __driver_attach+0x0/0x80
[   13.136809]  [<c024f60c>] bus_add_driver+0x8c/0x180
[   13.136818]  [<c02504e0>] driver_register+0x60/0xa0
[   13.136828]  [<c01fdd01>] __pci_register_driver+0x61/0x90
[   13.136837]  [<f895e018>] serverworks_init+0x18/0x1c [pata_serverworks]
[   13.136848]  [<c01415ab>] sys_init_module+0x18b/0x1d30
[   13.136884]  [<c0107fc1>] sys_mmap2+0x81/0xb0
[   13.136910]  [<c010326d>] sysenter_past_esp+0x56/0x79
[   13.136924] Code:  Bad EIP value.
[   13.136932] EIP: [<00000000>] stext+0x3feffd6c/0xc SS:ESP 0068:dff67d2c


No hard disk are connected to this controller, just a cdrom/dvd.


0000:00:00.0 Host bridge: Broadcom CNB20-LE Host Bridge (rev 23)
	Flags: fast devsel
	Memory at d0000000 (32-bit, prefetchable) [disabled] [size=128M]
	Memory at cffff000 (32-bit, non-prefetchable) [disabled] [size=4K]
00: 66 11 07 00 00 00 00 00 23 00 00 06 08 20 80 00
10: 08 00 00 d0 00 f0 ff cf 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 02 00 00 00 5d f1 60 00 00 00 00
50: 03 00 00 00 00 00 00 00 00 00 00 87 40 00 00 00
60: 00 00 00 10 00 01 00 07 72 02 00 00 00 00 00 00
70: 10 aa 2a af e3 0d ff 2f 01 20 82 00 04 00 00 00
80: 00 20 00 00 00 00 00 00 ff ff ff ff ff ff ff ff
90: 01 03 3e df 01 10 00 81 03 10 00 81 00 00 00 00
a0: 20 00 00 00 04 05 06 07 00 00 00 00 00 00 00 00
b0: ff ff ff ff 00 00 00 00 ff 7f 00 00 ff fb 00 00
c0: e6 0f eb 0f e3 0d e5 0f ff ff ff ff 05 07 c0 fe
d0: 00 c0 fc df 00 e0 fc ef 00 00 00 00 03 00 00 00
e0: 04 00 ff 7f 00 00 3b 4c 00 a1 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 c0 00 00 00

0000:00:00.1 PCI bridge: Broadcom CNB20-LE Host Bridge (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fe600000-fe6fffff
	Prefetchable memory behind bridge: de300000-fe3fffff
	Capabilities: [80] AGP version 2.0
00: 66 11 05 00 07 01 b0 22 01 00 04 06 08 40 81 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 c0 c0 a0 22
20: 60 fe 60 fe 30 de 30 fe 00 00 00 00 ff ff ff fe
30: 00 00 00 00 80 00 00 00 00 00 00 00 ff 00 0b 00
40: 00 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 02 00 20 00 01 02 00 1f 01 03 00 00 05 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: ff ff ff fc ff ff ff 05 ff ff ff fe 00 00 00 00
d0: fc ff fc fc 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: df ff fe ff ff bf ff ff 00 00 00 00 c2 0f 00 00

0000:00:00.2 Host bridge: Broadcom CNB20HE Host Bridge (rev 01)
	Flags: medium devsel
00: 66 11 06 00 02 00 00 22 01 00 00 06 08 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 01 00 00 02 00 00 c4 00 00 00 20
50: 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 aa 2a af e3 0d ff 0f 00 00 00 00 00 00 00 00
80: 40 00 00 00 f5 f7 fd ff fd ff df ff 00 00 00 00
90: 5c 5f 74 ff f8 f7 74 fd 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: e6 0f ea 0f e3 0d e4 0f 55 ff 75 ff 0d 07 00 00
d0: 00 c0 fc df fc 75 dc 6f 5c ff f4 7f 01 00 00 00
e0: ff d7 ff ff 00 00 00 00 00 00 00 00 c4 00 00 00
f0: 40 e0 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:00.3 Host bridge: Broadcom CNB20HE Host Bridge (rev 01)
	Flags: medium devsel
00: 66 11 06 00 02 00 00 22 01 00 00 06 08 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 02 02 00 00 12 00 00 0e 00 00 00 e0
50: 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 aa 2a af e3 0d ff 0f 00 00 00 00 00 00 00 00
80: 40 00 00 00 f5 f7 fd ff fd ff df ff 00 00 00 00
90: fc 7d dc fc fc ff f8 57 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: eb 0f eb 0f e5 0f e5 0f d7 7f ff ff 0d 07 00 00
d0: 00 e0 fc ef f8 7f f4 f7 58 ff dc ff 01 00 00 00
e0: 77 7f 7d 7d 00 00 00 00 00 00 00 00 c6 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:04.0 Mass storage controller: Silicon Image, Inc. SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev 02)
	Subsystem: Silicon Image, Inc. SiI 3112 SATALink Controller
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
	I/O ports at dff0 [size=8]
	I/O ports at dfe4 [size=4]
	I/O ports at dfa8 [size=8]
	I/O ports at dfe0 [size=4]
	I/O ports at df90 [size=16]
	Memory at feafbc00 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at fea00000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
00: 95 10 12 31 07 01 b0 02 02 00 80 01 08 40 00 00
10: f1 df 00 00 e5 df 00 00 a9 df 00 00 e1 df 00 00
20: 91 df 00 00 00 bc af fe 00 00 00 00 95 10 12 31
30: 00 00 a0 fe 60 00 00 00 00 00 00 00 0a 01 00 00
40: 02 00 00 00 5a 00 08 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 22 06 00 40 00 64 00 00 00 00 00 00 00 00
70: 00 00 60 00 00 30 d8 37 00 00 00 00 00 00 00 00
80: 03 00 00 00 22 00 00 00 00 00 00 00 df 7d f4 bf
90: 00 fc 01 0d ff ff ff 38 00 00 00 19 00 00 00 00
a0: 01 21 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
b0: 01 21 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
c0: 84 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:06.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corporation EtherExpress PRO/100+ Server Adapter (PILA8470B)
	Flags: bus master, medium devsel, latency 64, IRQ 17
	Memory at feafd000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at d800 [size=64]
	Memory at fe900000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 2
00: 86 80 29 12 17 01 90 02 08 00 00 02 08 40 00 00
10: 00 d0 af fe 01 d8 00 00 00 00 90 fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 0c 10
30: 00 00 00 00 dc 00 00 00 00 00 00 00 09 01 08 38
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 22 fe
e0: 00 40 00 3a 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:0f.0 ISA bridge: Broadcom OSB4 South Bridge (rev 50)
	Subsystem: Broadcom OSB4 South Bridge
	Flags: bus master, medium devsel, latency 0
00: 66 11 00 02 07 00 00 02 50 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 00 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: f0 33 00 00 00 00 00 00 07 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 00 00 0f c1 20 00 00 00 00 00 00 00 00 00
70: 00 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 81 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:0f.1 IDE interface: Broadcom OSB4 IDE Controller (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 64
	I/O ports at ffa0 [size=16]
00: 66 11 11 02 05 00 00 02 00 8a 01 01 00 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 5d 20 5d 5d 00 20 00 00 08 00 00 00 00 00 00 00
50: 00 00 00 00 01 00 02 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:0f.2 USB Controller: Broadcom OSB4/CSB5 OHCI USB Controller (rev 04) (prog-if 10 [OHCI])
	Subsystem: Broadcom OSB4/CSB5 OHCI USB Controller
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
00: 66 11 20 02 17 01 80 02 04 10 03 0c 08 40 80 00
10: 00 f0 af fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 20 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 50
40: 00 00 0f 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 PRO] (rev 01) (prog-if 00 [VGA])
	Subsystem: PC Partner Limited: Unknown device 0260
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 18
	Memory at f0000000 (32-bit, prefetchable) [size=128M]
	I/O ports at c800 [size=256]
	Memory at fe6f0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at fe6c0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2
00: 02 10 60 59 07 01 b0 02 01 00 00 03 08 40 80 00
10: 08 00 00 f0 01 c8 00 00 00 00 6f fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 60 02
30: 00 00 6c fe 58 00 00 00 00 00 00 00 0b 01 08 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 60 02
50: 01 00 02 06 00 00 00 00 02 50 20 00 13 02 00 4f
60: 01 03 00 1f 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 PRO] (Secondary) (rev 01)
	Subsystem: PC Partner Limited: Unknown device 0261
	Flags: bus master, 66MHz, medium devsel, latency 64
	Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Memory at fe6e0000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 2
00: 02 10 40 59 07 00 b0 02 01 00 80 03 08 40 00 00
10: 08 00 00 e8 00 00 6e fe 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 61 02
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 08 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 02 06 00 00 00 00 02 50 20 00 13 02 00 4f
60: 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:02:02.0 Multimedia audio controller: Creative Labs SB Audigy LS
	Subsystem: Creative Labs SB0410 SBLive! 24-bit
	Flags: bus master, medium devsel, latency 64, IRQ 5
	I/O ports at ef80 [size=32]
	Capabilities: [dc] Power Management version 2
00: 02 11 07 00 05 01 90 02 00 00 01 04 00 40 00 00
10: 81 ef 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 06 10
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 02 14
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 82 00 00
50: 00 80 00 00 ff ff 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 22 06
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

