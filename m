Return-Path: <linux-kernel-owner+w=401wt.eu-S965278AbXAHA4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965278AbXAHA4B (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 19:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965279AbXAHA4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 19:56:01 -0500
Received: from yumi.tdiedrich.de ([85.10.210.183]:2773 "EHLO yumi.tdiedrich.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965278AbXAHA4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 19:56:00 -0500
Date: Mon, 8 Jan 2007 01:55:56 +0100
From: Tobias Diedrich <ranma+kernel@tdiedrich.de>
To: Yinghai Lu <yinghai.lu@amd.com>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.20-rc3: known unfixed regressions - x86_64 boot failure: "IO-APIC + timer doesn't work"
Message-ID: <20070108005556.GA2542@melchior.yamamaya.is-a-geek.org>
Mail-Followup-To: Tobias Diedrich <ranma+kernel@tdiedrich.de>,
	Yinghai Lu <yinghai.lu@amd.com>, Andrew Morton <akpm@osdl.org>,
	Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
	Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5986589C150B2F49A46483AC44C7BCA490733F@ssvlexmb2.amd.com> <86802c440701022223q418bd141qf4de8ab149bf144b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86802c440701022223q418bd141qf4de8ab149bf144b@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yinghai Lu wrote:
> Please check the latest version. ( 01/02/2007)

Works for me, with both BIOS versions / routing variants.

patches/series:
patch-2.6.20-rc4
patch-2.6.19-rc3-nokmem
myconfig
ccache
timer_01022007.diff
hpet-quirk

dmesg diff:
--- dmesg-20070108-2.6.20-rc4-bios-0402	2007-01-08 01:51:57.000000000 +0100
+++ dmesg-20070108-2.6.20-rc4-bios-0609	2007-01-08 01:52:05.000000000 +0100
@@ -13,14 +13,15 @@
 Entering add_active_range(0, 0, 159) 0 entries of 256 used
 Entering add_active_range(0, 256, 261856) 1 entries of 256 used
 end_pfn_map = 1048576
-DMI 2.3 present.
-ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7ce0
-ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fee3040
-ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fee30c0
-ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 0x000000003feec2c0
-ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003feec400
-ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003feec200
-ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
+DMI 2.4 present.
+ACPI: RSDP (v002 Nvidia                                ) @ 0x00000000000f7b70
+ACPI: XSDT (v001 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fee30c0
+ACPI: FADT (v003 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003feec5c0
+ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 0x000000003feec7c0
+ACPI: HPET (v001 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000098) @ 0x000000003feec900
+ACPI: MCFG (v001 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003feec980
+ACPI: MADT (v001 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003feec700
+ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x03000000) @ 0x0000000000000000
 Entering add_active_range(0, 0, 159) 0 entries of 256 used
 Entering add_active_range(0, 256, 261856) 1 entries of 256 used
 Zone PFN ranges:
@@ -37,8 +38,6 @@
   DMA32 zone: 3524 pages used for memmap
   DMA32 zone: 254236 pages, LIFO batch:31
   Normal zone: 0 pages used for memmap
-Nvidia board detected. Ignoring ACPI timer override.
-If you got timer trouble try acpi_use_timer_override
 ACPI: PM-Timer IO Port: 0x1008
 ACPI: Local APIC address 0xfee00000
 ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
@@ -48,13 +47,17 @@
 ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
 ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
 IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
+ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
 ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
 ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
 ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
+ACPI: IRQ0 used by override.
+ACPI: IRQ2 used by override.
 ACPI: IRQ9 used by override.
 ACPI: IRQ14 used by override.
 ACPI: IRQ15 used by override.
 Setting APIC routing to flat
+ACPI: HPET id: 0x10de8201 base: 0xfefff000
 Using ACPI (MADT) for SMP configuration information
 mapped APIC to ffffffffff5fd000 (        fee00000)
 mapped IOAPIC to ffffffffff5fc000 (00000000fec00000)
@@ -72,10 +75,8 @@
 netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
 Initializing CPU#0
 PID hash table entries: 4096 (order: 12, 32768 bytes)
-trying to force-enable HPET
-HPET force-enabled at 0xfef00000
 time.c: Using 25.000000 MHz WALL HPET GTOD HPET/TSC timer.
-time.c: Detected 2009.512 MHz processor.
+time.c: Detected 2009.511 MHz processor.
 Console: colour VGA+ 80x60
 Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
 Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
@@ -84,7 +85,7 @@
 Aperture too small (32 MB)
 No AGP bridge found
 Memory: 1025348k/1047424k available (3242k kernel code, 21444k reserved, 1470k data, 200k init)
-Calibrating delay using timer specific routine.. 4023.44 BogoMIPS (lpj=6703119)
+Calibrating delay using timer specific routine.. 4023.45 BogoMIPS (lpj=6703124)
 Mount-cache hash table entries: 256
 CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
 CPU: L2 Cache: 512K (64 bytes/line)
@@ -95,11 +96,10 @@
 ESR value after enabling vector: 00000000, after 00000004
 ENABLING IO-APIC IRQs
 init IO_APIC IRQs
- IO-APIC (apicid-pin) 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
-..TIMER: vector=0x20 apic1=0 pin1=0 apic2=-1 pin2=-1
-..TIMER: trying IO-APIC=0 PIN=0 with 8259 IRQ0 disabled<3> .. failed
-..TIMER: trying IO-APIC=0 PIN=2 fallback with 8259 IRQ0 disabled<6>Using local APIC timer interrupts.
-result 12559465
+ IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
+..TIMER: vector=0x20 apic1=0 pin1=2 apic2=-1 pin2=-1
+..TIMER: trying IO-APIC=0 PIN=2 with 8259 IRQ0 disabled<6>Using local APIC timer interrupts.
+result 12559463
 Detected 12.559 MHz APIC timer.
 testing NMI watchdog ... OK.
 NET: Registered protocol family 16
@@ -168,7 +168,7 @@
 usbcore: registered new device driver usb
 PCI: Using ACPI for IRQ routing
 PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
-number of MP IRQ sources: 16.
+number of MP IRQ sources: 15.
 number of IO-APIC #2 registers: 24.
 testing the IO APIC.......................
 
@@ -210,7 +210,6 @@
 IRQ to pin mappings:
 IRQ0 -> 0:2
 IRQ1 -> 0:1
-IRQ2 -> 0:2
 IRQ3 -> 0:3
 IRQ4 -> 0:4
 IRQ5 -> 0:5
@@ -225,7 +224,7 @@
 IRQ14 -> 0:14
 IRQ15 -> 0:15
 .................................... done.
-hpet0: at MMIO 0xfef00000, IRQs 2, 8, 31
+hpet0: at MMIO 0xfefff000, IRQs 2, 8, 31
 hpet0: 3 32-bit timers, 25000000 Hz
 pnp: 00:01: ioport range 0x1000-0x107f could not be reserved
 pnp: 00:01: ioport range 0x1080-0x10ff has been reserved
@@ -312,9 +311,9 @@
 ACPI: Fan [FAN] (on)
 ACPI: Processor [CPU0] (supports 8 throttling states)
 ACPI: Getting cpuindex for acpiid 0x1
-ACPI: Thermal Zone [THRM] (28 C)
+ACPI: Thermal Zone [THRM] (24 C)
 Real Time Clock Driver v1.12ac
-hpet_acpi_add: no address or irqs in _CRS
+hpet_resources: 0xfefff000 is busy
 Linux agpgart interface v0.101 (c) Dave Jones
 loop: loaded (max 8 devices)
 tun: Universal TUN/TAP device driver, 1.6

-- 
Tobias						PGP: http://9ac7e0bc.uguu.de
このメールは十割再利用されたビットで作られています。
