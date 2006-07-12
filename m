Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWGLWL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWGLWL3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 18:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWGLWL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 18:11:29 -0400
Received: from smtp.ono.com ([62.42.230.12]:3221 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S1751061AbWGLWL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 18:11:28 -0400
Date: Thu, 13 Jul 2006 00:11:23 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: AGP mem resource is 64 bits, so no X ?
Message-ID: <20060713001123.6d523a2f@werewolf.auna.net>
X-Mailer: Sylpheed-Claws 2.3.1cvs82 (GTK+ 2.10.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

I have a box with a SuperMicro P4DCE+ mobo.
After an upgrade to the latest bios (v1.3, DC6P6273.zip), the kernel
(2.6.28-rc1-mm1) does not recognize the AGP card (an nvidia GeForce 6600 GT).
The propierary 'nvidia' driver does not load beacuse it says:

agpgart: Detected an Intel i860 Chipset.
agpgart: AGP aperture is 128M @ 0xe8000000
nvidia: module license 'NVIDIA' taints kernel.
NVRM: This PCI I/O region assigned to your NVIDIA device is invalid:
NVRM: BAR1 is 0M @ 0x00000000 (PCI:0001:00.0)
NVRM: The system BIOS may have misconfigured your graphics card.
nvidia: probe of 0000:01:00.0 failed with error -1
NVRM: The NVIDIA probe routine failed for 1 device(s).
NVRM: None of the NVIDIA graphics adapters were initialized!

and the OSS driver 'nv' just gives a bunch of black and white stripes on
the screen.

Googlin a bit I read something about the BIOS asigning a 64 bit address
to the AGP memory. Is really this ?

Hardware:

00:01.0 PCI bridge: Intel Corporation 82850 850 (Tehama) Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, fast devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	Memory behind bridge: f0000000-f2ffffff
	Prefetchable memory behind bridge: d8000000-e7ffffff

00:02.0 PCI bridge: Intel Corporation 82860 860 (Wombat) Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, fast devsel, latency 32
	Bus: primary=00, secondary=02, subordinate=03, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: f3000000-f4ffffff
	Prefetchable memory behind bridge: 50000000-501fffff

01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600/GeForce 6600 GT] (rev a2) (prog-if 00 [VGA])
	Subsystem: XFX Pine Group Inc. Unknown device 2165
	Flags: bus master, VGA palette snoop, 66MHz, medium devsel, latency 32, IRQ 22
	Memory at f0000000 (32-bit, non-prefetchable) [size=16M]
	Memory at <ignored> (32-bit, prefetchable)
	Memory at f1000000 (32-bit, non-prefetchable) [size=16M]
	[virtual] Expansion ROM at d8000000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
	Capabilities: [44] AGP version 3.0

Parts of dmesg:

BIOS-provided physical RAM map: 
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009f800 end: 000000000009f800 type: 1
copy_e820_map() type is E820_RAM
add_memory_region(0000000000000000, 000000000009f800, 1)
copy_e820_map() start: 000000000009f800 size: 0000000000000800 end: 00000000000a0000 type: 2
add_memory_region(000000000009f800, 0000000000000800, 2)
copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 0000000000100000 type: 2
add_memory_region(00000000000f0000, 0000000000010000, 2)
copy_e820_map() start: 0000000000100000 size: 000000003fef0000 end: 000000003fff0000 type: 1
copy_e820_map() type is E820_RAM
add_memory_region(0000000000100000, 000000003fef0000, 1) 
copy_e820_map() start: 000000003fff0000 size: 0000000000003000 end: 000000003fff3000 type: 4
add_memory_region(000000003fff0000, 0000000000003000, 4)
copy_e820_map() start: 000000003fff3000 size: 000000000000d000 end: 0000000040000000 type: 3
add_memory_region(000000003fff3000, 000000000000d000, 3)
copy_e820_map() start: 00000000fec00000 size: 0000000001400000 end: 0000000100000000 type: 2
add_memory_region(00000000fec00000, 0000000001400000, 2)
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)

...

PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0480-04bf claimed by ICH4 GPIO
Boot video device is 0000:01:00.0
PCI: Firmware left 0000:04:04.0 e100 interrupts enabled, disabling
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/2440] at 0000:00:1f.0
PCI->APIC IRQ transform: 0000:00:1f.2[D] -> IRQ 19
PCI->APIC IRQ transform: 0000:00:1f.3[B] -> IRQ 17
PCI->APIC IRQ transform: 0000:00:1f.4[C] -> IRQ 23
PCI->APIC IRQ transform: 0000:00:1f.5[B] -> IRQ 17
PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 22
PCI->APIC IRQ transform: 0000:03:01.0[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:03:02.0[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:03:02.1[B] -> IRQ 18
PCI->APIC IRQ transform: 0000:04:02.0[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:04:04.0[A] -> IRQ 16
PCI: Cannot allocate resource region 1 of device 0000:01:00.0
PCI: Failed to allocate mem resource #1:10000000@e0000000 for 0000:01:00.0
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: f0000000-f2ffffff
  PREFETCH window: d8000000-e7ffffff
PCI: Bridge: 0000:02:1f.0
  IO window: 9000-9fff
  MEM window: f3000000-f4ffffff
  PREFETCH window: 50000000-501fffff
PCI: Bridge: 0000:00:02.0
  IO window: 9000-9fff
  MEM window: f3000000-f4ffffff
  PREFETCH window: 50000000-501fffff
PCI: Bridge: 0000:00:1e.0
  IO window: a000-afff
  MEM window: f5000000-f6ffffff
  PREFETCH window: 50200000-503fffff
PCI: Setting latency timer of device 0000:02:1f.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64


Any idea ?
Anyone has a previous BIOS ;) to share ?

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam03 (gcc 4.1.1 20060518 (prerelease)) #3 SMP PREEMPT Mon
