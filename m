Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263895AbUFPOJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbUFPOJw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 10:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263932AbUFPOJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 10:09:51 -0400
Received: from [80.103.4.112] ([80.103.4.112]:260 "EHLO kiopa.local")
	by vger.kernel.org with ESMTP id S263895AbUFPOJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 10:09:46 -0400
From: Carlos Martin <cmn@sokra.cjb.net>
Subject: Re: PROBLEM: [2.6.7] irq 3: nobody cared!
To: linux-kernel@vger.kernel.org
Date: Wed, 16 Jun 2004 16:11:09 +0200
References: <20040616124708.GD21984@jail.schiach.de>
User-Agent: KNode/0.7.6
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20040616141219.87E7373A61@kiopa.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ablassmeier wrote:

> hi kernel Volks,
> 
> 2.6.7 runs into problems while setting up usb stuff and disables IRQ#3,
> (at least, for me) see kern.log:
I have that, only in IRQ#5
This didn't happen with linux-2.6.6 with the exact same configuration.
The kernel isn't tainted yet, as it happens during bootup.
I don't have anyting plugged in the USB ports, if that helps.
--start-dmesg-output--
ehci_hcd 0000:00:02.2: irq 5, pci mem e0b5e000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
irq 5: nobody cared!
 [<c01051d3>] __report_bad_irq+0x33/0x90
 [<c01052b0>] note_interrupt+0x50/0x80
 [<c0105442>] do_IRQ+0x92/0xf0
 [<c0103cd0>] common_interrupt+0x18/0x20
 [<c01185af>] __do_softirq+0x2f/0x80
 [<c0118622>] do_softirq+0x22/0x30
 [<c010548d>] do_IRQ+0xdd/0xf0
 [<c0103cd0>] common_interrupt+0x18/0x20
 [<c02082a1>] pci_bus_read_config_byte+0x41/0x50
 [<c0299109>] ehci_start+0xe9/0x320
 [<c0115bde>] release_console_sem+0x2e/0xa0
 [<c0115b50>] printk+0xe0/0xf0
 [<c028c42b>] usb_register_bus+0x14b/0x160
 [<c02908d6>] usb_hcd_pci_probe+0x446/0x490
 [<c020b04c>] pci_device_probe_static+0x2c/0x40
 [<c020b07f>] __pci_device_probe+0x1f/0x40
 [<c020b0bc>] pci_device_probe+0x1c/0x40
 [<c0246311>] bus_match+0x31/0x60
 [<c0246400>] driver_attach+0x40/0x80
 [<c024665f>] bus_add_driver+0x6f/0x90
 [<c0246a64>] driver_register+0x34/0x40
 [<c020b2c4>] pci_register_driver+0x54/0x80
 [<c042ea36>] init+0x16/0x30
 [<c041c659>] do_initcalls+0x69/0xc0
 [<c0100390>] init+0x0/0xe0
 [<c041c6c9>] do_basic_setup+0x19/0x20
 [<c01003b7>] init+0x27/0xe0
 [<c0102265>] kernel_thread_helper+0x5/0x10

handlers:
[<c028d020>] (usb_hcd_irq+0x0/0x60)
Disabling IRQ #5
--end-dmesg-output--

[carlos@kiopa ~]$ cat /proc/interrupts
           CPU0
  0:    3944742          XT-PIC  timer
  1:       4203          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:     103946          XT-PIC  ehci_hcd, ohci_hcd, eth0
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 11:     230852          XT-PIC  ohci_hcd, NVidia nForce2, nvidia
 12:     100550          XT-PIC  i8042
 14:         38          XT-PIC  ide0
 15:      47478          XT-PIC  ide1
NMI:          0
LOC:    3915857
ERR:      34742

[carlos@kiopa ~]$ cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #02
  c000-c07f : 0000:02:01.0
    c000-c07f : 0000:02:01.0
d000-d007 : 0000:00:04.0
d400-d4ff : 0000:00:06.0
d800-d87f : 0000:00:06.0
  d800-d83f : NVidia nForce2 - Controller
e400-e41f : 0000:00:01.1
f000-f00f : 0000:00:09.0

[carlos@kiopa ~]$ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000ce7ff : Video ROM
000d0000-000d17ff : Adapter ROM
000d2000-000d27ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-0030b1a5 : Kernel code
  0030b1a6-0041917f : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-d7ffffff : 0000:00:00.0
d8000000-e7ffffff : PCI Bus #03
  d8000000-dfffffff : 0000:03:00.0
    d8000000-d82fffff : vesafb
  e0000000-e007ffff : 0000:03:00.0
e8000000-e9ffffff : PCI Bus #03
  e8000000-e8ffffff : 0000:03:00.0
ea000000-ebffffff : PCI Bus #02
  eb000000-eb00007f : 0000:02:01.0
ec000000-ec07ffff : 0000:00:05.0
ec080000-ec080fff : 0000:00:02.0
  ec080000-ec080fff : ohci_hcd
ec081000-ec081fff : 0000:00:06.0
  ec081000-ec0811ff : NVidia nForce2 - AC'97
ec083000-ec083fff : 0000:00:02.1
  ec083000-ec083fff : ohci_hcd
ec084000-ec0840ff : 0000:00:02.2
  ec084000-ec0840ff : ehci_hcd
ec085000-ec085fff : 0000:00:04.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

-- 
Carlos Martin
SoKrA-BTS
Registered Linux User 350487
