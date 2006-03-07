Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752135AbWCGKvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbWCGKvF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 05:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbWCGKvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 05:51:04 -0500
Received: from tao.natur.cuni.cz ([195.113.56.1]:17168 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id S1752135AbWCGKvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 05:51:02 -0500
X-Obalka-From: mmokrejs@ribosome.natur.cuni.cz
X-Obalka-To: <linux-kernel@vger.kernel.org>
Message-ID: <440D6581.9080000@ribosome.natur.cuni.cz>
Date: Tue, 07 Mar 2006 11:50:41 +0100
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051002
X-Accept-Language: cs
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.16-rc5 huge memory detection regression
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/mixed;
 boundary="------------020101080006000807050200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020101080006000807050200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
   I just tested 2.6.16-rc5 kernel on MSI 9136 dual Xeon server 
motherboard with 16 GB of memory and the kernel detects only 8 GB of 
RAM instead. 2.6.15 kernel detected properly 16 GB. I haven't tested 
any kernel revisions in between these two, but could if you point me 
in a specific direction. Attaching diff(1) output of dmesg(1) outputs.
Please Cc: me in replies. Thanks!
Martin

--------------020101080006000807050200
Content-Type: text/plain;
 name="boot-2.6.15_to_16-rc5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot-2.6.15_to_16-rc5.diff"

--- tmp/boot-2.6.15.txt	2006-03-07 11:45:48.015509048 +0100
+++ tmp/boot-2.6.16-rc5.txt	2006-03-07 11:45:48.029506920 +0100
@@ -1,4 +1,4 @@
-Linux version 2.6.15 (root@phylo) (gcc version 3.4.5 (Gentoo 3.4.5-r1, ssp-3.4.5-1.0, pie-8.7.9)) #1 SMP Mon Mar 6 20:20:06 MET 2006
+Linux version 2.6.16-rc5 (root@phylo) (gcc version 3.4.5 (Gentoo 3.4.5-r1, ssp-3.4.5-1.0, pie-8.7.9)) #1 SMP Mon Mar 6 19:58:24 MET 2006
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009a800 (usable)
  BIOS-e820: 000000000009a800 - 00000000000a0000 (reserved)
@@ -12,16 +12,16 @@
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
  BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
- BIOS-e820: 0000000100000000 - 0000000430000000 (usable)
-16256MB HIGHMEM available.
+ BIOS-e820: 0000000100000000 - 0000000230000000 (usable)
+8064MB HIGHMEM available.
 896MB LOWMEM available.
 found SMP MP-table at 000f6af0
 NX (Execute Disable) protection: active
-On node 0 totalpages: 4390912
+On node 0 totalpages: 2293760
   DMA zone: 4096 pages, LIFO batch:0
   DMA32 zone: 0 pages, LIFO batch:0
   Normal zone: 225280 pages, LIFO batch:31
-  HighMem zone: 4161536 pages, LIFO batch:31
+  HighMem zone: 2064384 pages, LIFO batch:31
 DMI 2.3 present.
 ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6a70
 ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0xcff726a2
@@ -58,16 +58,18 @@
 mapped APIC to ffffd000 (fee00000)
 mapped IOAPIC to ffffc000 (fec00000)
 mapped IOAPIC to ffffb000 (fec10000)
+Enabling fast FPU save and restore... done.
+Enabling unmasked SIMD FPU exception support... done.
 Initializing CPU#0
 PID hash table entries: 4096 (order: 12, 65536 bytes)
-Detected 2993.281 MHz processor.
+Detected 2993.175 MHz processor.
 Using pmtmr for high-res timesource
 Console: colour VGA+ 80x25
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
 Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
-Memory: 16632528k/17563648k available (2699k kernel code, 142932k reserved, 1389k data, 196k init, 15859136k highmem)
+Memory: 8309408k/9175040k available (2725k kernel code, 77456k reserved, 1415k data, 200k init, 7470528k highmem)
 Checking if this processor honours the WP bit even in supervisor mode... Ok.
-Calibrating delay using timer specific routine.. 5991.31 BogoMIPS (lpj=11982622)
+Calibrating delay using timer specific routine.. 5995.49 BogoMIPS (lpj=11990992)
 Mount-cache hash table entries: 512
 CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
 CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
@@ -76,52 +78,50 @@
 CPU: Trace cache: 12K uops, L1 D cache: 16K
 CPU: L2 cache: 1024K
 CPU: Physical Processor ID: 0
-CPU: After all inits, caps: bfebfbff 20100000 00000000 00000080 0000641d 00000000 00000000
+CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000641d 00000000 00000000
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#0.
 CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
 CPU0: Thermal monitoring enabled
-mtrr: v2.0 (20020519)
-Enabling fast FPU save and restore... done.
-Enabling unmasked SIMD FPU exception support... done.
 Checking 'hlt' instruction... OK.
  tbxface-0109 [02] load_tables           : ACPI Tables successfully acquired
-Parsing all Control Methods:........................................................................................................................................
+Parsing all Control Methods:
 Table [DSDT](id 0005) - 404 Objects with 54 Devices 136 Methods 12 Regions
-ACPI Namespace successfully loaded at root c0579d9c
+ACPI Namespace successfully loaded at root c0588170
 evxfevnt-0091 [03] enable                : Transition to ACPI mode successful
 CPU0: Intel(R) Xeon(TM) CPU 3.00GHz stepping 01
 Booting processor 1/6 eip 2000
 Initializing CPU#1
-Calibrating delay using timer specific routine.. 5985.50 BogoMIPS (lpj=11971016)
+Calibrating delay using timer specific routine.. 5985.79 BogoMIPS (lpj=11971595)
 CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
 CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
 monitor/mwait feature present.
 CPU: Trace cache: 12K uops, L1 D cache: 16K
 CPU: L2 cache: 1024K
 CPU: Physical Processor ID: 3
-CPU: After all inits, caps: bfebfbff 20100000 00000000 00000080 0000641d 00000000 00000000
+CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000641d 00000000 00000000
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#1.
 CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
 CPU1: Thermal monitoring enabled
 CPU1: Intel(R) Xeon(TM) CPU 3.00GHz stepping 01
-Total of 2 processors activated (11976.81 BogoMIPS).
+Total of 2 processors activated (11981.29 BogoMIPS).
 ENABLING IO-APIC IRQs
 ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
 checking TSC synchronization across 2 CPUs: passed.
 Brought up 2 CPUs
+migration_cost=4000
 NET: Registered protocol family 16
 ACPI: bus type pci registered
 PCI: PCI BIOS revision 3.00 entry at 0xfd663, last bus=9
 PCI: Using MMCONFIG
-ACPI: Subsystem revision 20050902
-evgpeblk-0988 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
-evgpeblk-0996 [06] ev_create_gpe_block   : Found 5 Wake, Enabled 2 Runtime GPEs in this block
+ACPI: Subsystem revision 20060127
+evgpeblk-0941 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
+evgpeblk-1037 [05] ev_initialize_gpe_bloc: Found 5 Wake, Enabled 2 Runtime GPEs in this block
 Completing Region/Field/Buffer/Package initialization:...................................................
 Initialized 12/12 Regions 0/0 Fields 36/36 Buffers 3/15 Packages (413 nodes)
 Executing all Device _STA and_INI methods:............................................................
-60 Devices found containing: 60 _STA, 2 _INI methods
+60 Devices found - executed 1 _STA, 2 _INI methods
 ACPI: Interpreter enabled
 ACPI: Using IOAPIC for interrupt routing
 ACPI: PCI Root Bridge [PCI0] (0000:00)
@@ -224,7 +224,7 @@
 SGI XFS with no debug enabled
 Initializing Cryptographic API
 io scheduler noop registered
-io scheduler anticipatory registered
+io scheduler anticipatory registered (default)
 io scheduler deadline registered
 io scheduler cfq registered
 radeonfb_pci_register BEGIN
@@ -237,9 +237,9 @@
 ACPI: Power Button (CM) [PWRB]
 ACPI: Processor [CPU0] (supports 8 throttling states)
 ACPI: Processor [CPU1] (supports 8 throttling states)
-acpi_processor-0507 [06] processor_get_info    : Error getting cpuindex for acpiid 0x2
-acpi_processor-0507 [06] processor_get_info    : Error getting cpuindex for acpiid 0x3
-Real Time Clock Driver v1.12
+acpi_processor-0495 [06] processor_get_info    : Error getting cpuindex for acpiid 0x2
+acpi_processor-0495 [06] processor_get_info    : Error getting cpuindex for acpiid 0x3
+Real Time Clock Driver v1.12ac
 Non-volatile memory driver v1.2
 Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
 Hangcheck: Using monotonic_clock().
@@ -255,16 +255,19 @@
 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
 FDC 0 is a National Semiconductor PC87306
 loop: loaded (max 8 devices)
-Intel(R) PRO/1000 Network Driver - version 6.1.16-k2
+Intel(R) PRO/1000 Network Driver - version 6.3.9-k2
 Copyright (c) 1999-2005 Intel Corporation.
 acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
 ACPI: PCI Interrupt 0000:08:02.0[A] -> GSI 25 (level, low) -> IRQ 18
+e1000: 0000:08:02.0: e1000_probe: (PCI:66MHz:32-bit) 00:11:09:b6:c1:7a
 e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
 acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
 ACPI: PCI Interrupt 0000:08:03.0[A] -> GSI 26 (level, low) -> IRQ 19
+e1000: 0000:08:03.0: e1000_probe: (PCI:66MHz:32-bit) 00:11:09:b6:c1:7b
 e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
 acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
 ACPI: PCI Interrupt 0000:09:01.0[A] -> GSI 17 (level, low) -> IRQ 20
+e1000: 0000:09:01.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:84:83:71
 e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
 LXT970: Registered new driver
 LXT971: Registered new driver
@@ -303,14 +306,22 @@
   Type:   Direct-Access                      ANSI SCSI revision: 05
 st: Version 20050830, fixed bufsize 32768, s/g segs 256
 SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
+sda: Write Protect is off
+sda: Mode Sense: 00 3a 00 00
 SCSI device sda: drive cache: write back
 SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
+sda: Write Protect is off
+sda: Mode Sense: 00 3a 00 00
 SCSI device sda: drive cache: write back
  sda: sda1 sda2 sda3 sda4
 sd 0:0:0:0: Attached scsi disk sda
 SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
+sdb: Write Protect is off
+sdb: Mode Sense: 00 3a 00 00
 SCSI device sdb: drive cache: write back
 SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
+sdb: Write Protect is off
+sdb: Mode Sense: 00 3a 00 00
 SCSI device sdb: drive cache: write back
  sdb: sdb1
 sd 1:0:0:0: Attached scsi disk sdb
@@ -319,7 +330,6 @@
 ieee1394: Initialized config rom entry `ip1394'
 video1394: Installed video1394 module
 ieee1394: raw1394: /dev/raw1394 device initialized
-sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
 ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
 ieee1394: sbp2: Try serialize_io=0 for better performance
 usbmon: debugfs is not available
@@ -330,7 +340,7 @@
 input: PC Speaker as /class/input/input0
 i2c /dev entries driver
 NET: Registered protocol family 2
-IP route cache hash table entries: 1048576 (order: 10, 4194304 bytes)
+IP route cache hash table entries: 524288 (order: 9, 2097152 bytes)
 TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
 TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
 TCP: Hash tables configured (established 524288 bind 65536)
@@ -341,13 +351,12 @@
 p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
 Starting balanced_irq
 Using IPI Shortcut mode
-input: AT Translated Set 2 keyboard as /class/input/input1
 BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
 UDF-fs: No VRS found
 XFS mounting filesystem sda4
 Ending clean XFS mount for filesystem: sda4
 VFS: Mounted root (xfs filesystem) readonly.
-Freeing unused kernel memory: 196k freed
+Freeing unused kernel memory: 200k freed
 Adding 31254448k swap on /dev/sda2.  Priority:-1 extents:1 across:31254448k
 XFS mounting filesystem sdb1
 Ending clean XFS mount for filesystem: sdb1
@@ -358,6 +367,7 @@
 uhci_hcd 0000:00:1d.0: UHCI Host Controller
 uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
 uhci_hcd 0000:00:1d.0: irq 16, io base 0x00001400
+usb usb1: configuration #1 chosen from 1 choice
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 2 ports detected
 ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 22
@@ -365,6 +375,7 @@
 uhci_hcd 0000:00:1d.1: UHCI Host Controller
 uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
 uhci_hcd 0000:00:1d.1: irq 22, io base 0x00001420
+usb usb2: configuration #1 chosen from 1 choice
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 2 ports detected
 ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
@@ -375,6 +386,7 @@
 ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 3
 ehci_hcd 0000:00:1d.7: irq 23, io mem 0xd0001400
 ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
+usb usb3: configuration #1 chosen from 1 choice
 hub 3-0:1.0: USB hub found
 hub 3-0:1.0: 4 ports detected
 ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)

--------------020101080006000807050200--
