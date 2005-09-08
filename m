Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbVIHHlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbVIHHlO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 03:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbVIHHlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 03:41:14 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:53010 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S1751331AbVIHHlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 03:41:13 -0400
Date: Thu, 8 Sep 2005 09:41:04 +0200 (CEST)
From: gl@dsa-ac.de
To: linux-kernel@vger.kernel.org
Cc: len.brown@intel.com, acpi-devel@lists.sourceforge.net
Subject: [OOPS] vanilla 2.6.13 + "rmmod processor"
Message-ID: <Pine.LNX.4.63.0509080931260.11341@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Just booted a 2.6.13 compiled with UP, ACPI, APIC, LAPIC, sensor modules 
with "nolapic noapic acpi=off". The processor module was still loaded by 
the hotplug. On rmmod it Oopsed:

Linux version 2.6.13 (gl@X) (gcc version 3.3.3 (SuSE Linux)) #10 Mon Sep 5 13:25:58 CEST 2005

...

Processor #0 6:13 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Allocating PCI resources starting at 0e000000 (gap: 0e000000:f0c00000)
Built 1 zonelists
Kernel command line: root=/dev/hda2 ro vga=785 acpi=off noapic nolapic
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0

...

CPU: Intel(R) Celeron(R) M processor         1.00GHz stepping 08

...

ACPI: Subsystem revision 20050408
ACPI: Interpreter disabled.

...

shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x1001
Unable to handle kernel NULL pointer dereference at virtual address 00000004
  printing eip:
c020f944
*pde = 00000000
Oops: 0002 [#1]
Modules linked in: evdev snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc pci_hotplug ehci_hcd autofs4 af_packet vfat fat e100 mii i2c_i801 i2c_core parport_pc parport ohci1394 ieee1394 usbhid uhci_hcd usbcore processor
CPU:    0
EIP:    0060:[<c020f944>]    Not tainted VLI
EFLAGS: 00010246   (2.6.13) 
EIP is at acpi_bus_unregister_driver+0x21/0x38
eax: 00000000   ebx: ce93d3c0   ecx: ccb09f68   edx: 00000000
esi: 00000000   edi: 00000880   ebp: ccb09f58   esp: ccb09f50
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 2991, threadinfo=ccb08000 task=cd640530)
Stack: ce93d780 00000000 ccb09f60 ce93b058 ccb09fb4 c0133368 00000000 636f7270
        6f737365 b7ef0072 b7efc000 ccb09fa0 c014cbdc b7efc000 b7efd000 cd3e1280
        c139b074 cd3e1280 cd3e12b0 b7efc000 ccb09fb4 0014cc6d b7efc000 bfc13a98 
Call Trace:
  [<c0103db6>] show_stack+0xa6/0xb0
  [<c0103f29>] show_registers+0x149/0x1c0
  [<c010410b>] die+0xbb/0x140
  [<c0117732>] do_page_fault+0x512/0x693
  [<c0103a03>] error_code+0x4f/0x54
  [<ce93b058>] acpi_processor_exit+0x1c/0x2e [processor]
  [<c0133368>] sys_delete_module+0x138/0x150
  [<c0102f59>] syscall_call+0x7/0xb
Code: 04 89 d0 e8 fd fe ff ff 5d c3 55 89 e5 56 31 f6 85 c0 53 89 c3 74 20 e8 56 ff ff ff 8b 83 a8 00 00 00 85 c0 75 16 8b 53 04 8b 03 <89> 50 04 89 02 89 5b 04 89 1b eb 05 be ea ff ff ff 5b 89 f0 5e

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
