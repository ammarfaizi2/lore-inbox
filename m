Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbVHWOsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbVHWOsi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 10:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbVHWOsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 10:48:38 -0400
Received: from dns.toxicfilms.tv ([150.254.220.184]:10449 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S932172AbVHWOsh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 10:48:37 -0400
Date: Tue, 23 Aug 2005 16:48:35 +0200
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Mailer: The Bat! (v3.0) UNREG / CD5BF9353B3B7091
Reply-To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <1543900094.20050823164835@dns.toxicfilms.tv>
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3com 3c59x stopped working with 2.6.13-rc[56]
In-Reply-To: <20050822143642.5686ecc8.akpm@osdl.org>
References: <20050822202740.9793.qmail@dns.toxicfilms.tv>
 <20050822143642.5686ecc8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=Windows-1250
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

> I assume it worked OK in 2.6.12.
Yes, sorry, forgot to mention that.

>> 18:27:47: eth1: Setting full-duplex based on MII #24 link partner capability of 05e1.
>> 18:32:02: NETDEV WATCHDOG: eth1: transmit timed out
>> 18:32:02: eth1: transmit timed out, tx_status 00 status e601.
>> 18:32:02:   diagnostics: net 0cfa media 8880 dma 0000003a fifo 8800
>> 18:32:02: eth1: Interrupt posted but not delivered -- IRQ blocked by another device?

> gargh, I have acpi feelings.  Could you please
It seems you had a good hunch.

> a) Compare /proc/interrupts for 2.6.12 and 2.6.13-rc6
/proc/interrputs for 2.6.12:
           CPU0
  0:   76133896          XT-PIC  timer
  1:       1170          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  9:          0          XT-PIC  acpi
 11:    2483056          XT-PIC  eth1
 14:     603767          XT-PIC  ide0
 15:         13          XT-PIC  ide1
NMI:          0
ERR:          0

/proc/interrputs for 2.6.13:
           CPU0
  0:     851172          XT-PIC  timer
  1:        802          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  eth1
 14:      30180          XT-PIC  ide0
 15:         13          XT-PIC  ide1
NMI:          0
ERR:          0

What is missing is acpi on irq9

> b) Generate the boot-time dmesg output for 2.6.12 and 2.6.13-rc6
>    (dmesg -s 1000000 > foo), then do
> 	diff -u dmesg-2.6.12 dmesg-2.6.13-rc6 > foo
>    and send foo?
Here is foo:

--- dmesg-2.6.12        2005-08-23 12:53:43.000000000 +0200
+++ dmesg-2.6.13        2005-08-23 14:26:54.000000000 +0200
@@ -1,4 +1,4 @@
-Linux version 2.6.12 (root@dns) (gcc version 4.0.1 (Debian 4.0.1-2)) #1 Mon Aug 22 14:49:40 CEST 2005
+Linux version 2.6.13-rc6-git13 (root@dns) (gcc version 4.0.1 (Debian 4.0.1-2)) #2 Mon Aug 22 15:22:10 CEST 2005
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
@@ -13,25 +13,20 @@
   Normal zone: 126956 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:1
 DMI 2.3 present.
-ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6c20
-ACPI: RSDT (v001 ASUS   A7V266-C 0x30303031 MSFT 0x31313031) @ 0x1ffec000
-ACPI: FADT (v001 ASUS   A7V266-C 0x30303031 MSFT 0x31313031) @ 0x1ffec080
-ACPI: BOOT (v001 ASUS   A7V266-C 0x30303031 MSFT 0x31313031) @ 0x1ffec040
-ACPI: DSDT (v001   ASUS A7V266-C 0x00001000 MSFT 0x0100000b) @ 0x00000000
 Allocating PCI resources starting at 20000000 (gap: 20000000:dfff0000)
 Built 1 zonelists
-Kernel command line: BOOT_IMAGE=Linux.old ro root=301 lapic pci=usepirqmask
+Kernel command line: auto BOOT_IMAGE=Linux ro root=301 lapic pci=usepirqmask
 Initializing CPU#0
-CPU 0 irqstacks, hard=c0442000 soft=c0441000
+CPU 0 irqstacks, hard=c041b000 soft=c041a000
 PID hash table entries: 2048 (order: 11, 32768 bytes)
 Detected 1210.984 MHz processor.
 Using tsc for high-res timesource
 Console: colour VGA+ 80x25
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
 Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
-Memory: 515260k/524208k available (2114k kernel code, 8412k reserved, 801k data, 392k init, 0k highmem)
+Memory: 515424k/524208k available (2010k kernel code, 8252k reserved, 753k data, 388k init, 0k highmem)
 Checking if this processor honours the WP bit even in supervisor mode... Ok.
-Calibrating delay loop... 2383.87 BogoMIPS (lpj=1191936)
+Calibrating delay using timer specific routine.. 2424.59 BogoMIPS (lpj=1212295)
 Mount-cache hash table entries: 512
 CPU: After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000000 00000000 00000000
 CPU: After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000000 00000000 00000000
@@ -40,65 +35,49 @@
 CPU: After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000020 00000000 00000000 00000000
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#0.
+mtrr: v2.0 (20020519)
 CPU: AMD Duron(TM)Processor stepping 01
 Enabling fast FPU save and restore... done.
 Enabling unmasked SIMD FPU exception support... done.
 Checking 'hlt' instruction... OK.
-ACPI: setting ELCR to 0200 (from 0400)
 NET: Registered protocol family 16
 PCI: PCI BIOS revision 2.10 entry at 0xf0f00, last bus=1
 PCI: Using configuration type 1
-mtrr: v2.0 (20020519)
-ACPI: Subsystem revision 20050309
-ACPI: Interpreter enabled
-ACPI: Using PIC for interrupt routing
-ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
-ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
-ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
-ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
-ACPI: PCI Root Bridge [PCI0] (0000:00)
+PCI: Probing PCI hardware
 PCI: Probing PCI hardware (bus 00)
 Boot video device is 0000:01:00.0
-ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
-ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
-Linux Plug and Play Support v0.97 (c) Adam Belay
-pnp: PnP ACPI init
-pnp: PnP ACPI: found 9 devices
-PCI: Using ACPI for IRQ routing
-PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
-pnp: 00:02: ioport range 0xe400-0xe47f could not be reserved
-pnp: 00:02: ioport range 0xe800-0xe80f has been reserved
-pnp: 00:02: ioport range 0x290-0x291 has been reserved
-pnp: 00:02: ioport range 0x370-0x373 has been reserved
-Simple Boot Flag at 0x3a set to 0x80
+PCI: Using IRQ router VIA [1106/3147] at 0000:00:11.0
+PCI: Bridge: 0000:00:01.0
+  IO window: d000-dfff
+  MEM window: f6000000-f6dfffff
+  PREFETCH window: f6f00000-f7ffffff
+PCI: Setting latency timer of device 0000:00:01.0 to 64
 Machine check exception polling timer started.
 Total HugeTLB memory allocated, 0
 Initializing Cryptographic API
-PNP: PS/2 controller doesn't have AUX irq; using default 0xc
-PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 112
 serio: i8042 AUX port at 0x60,0x64 irq 12
 serio: i8042 KBD port at 0x60,0x64 irq 1
 io scheduler noop registered
 io scheduler anticipatory registered
 io scheduler deadline registered
 io scheduler cfq registered
-ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
 PCI: setting IRQ 10 as level-triggered
-ACPI: PCI Interrupt 0000:00:0c.0[A] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
+PCI: Assigned IRQ 10 for device 0000:00:0c.0
 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
 0000:00:0c.0: 3Com PCI 3c905C Tornado at 0xb800. Vers LK1.1.19
 PCI: Enabling device 0000:00:0d.0 (0014 -> 0017)
-ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
-PCI: setting IRQ 11 as level-triggered
-ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
+PCI: setting IRQ 5 as level-triggered
+PCI: Assigned IRQ 5 for device 0000:00:0d.0
+PCI: Sharing IRQ 5 with 0000:00:11.1
 0000:00:0d.0: 3Com PCI 3c905C Tornado at 0xb400. Vers LK1.1.19
 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 VP_IDE: IDE controller at PCI slot 0000:00:11.1
-ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
-PCI: Via IRQ fixup for 0000:00:11.1, from 0 to 11
+PCI: Found IRQ 5 for device 0000:00:11.1
+PCI: Sharing IRQ 5 with 0000:00:0d.0
+PCI: Via IRQ fixup for 0000:00:11.1, from 0 to 5
 VP_IDE: chipset revision 6
-VP_IDE: not 100% native mode: will probe irqs later
+VP_IDE: not 100%% native mode: will probe irqs later
 VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci0000:00:11.1
     ide0: BM-DMA at 0xb000-0xb007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xb008-0xb00f, BIOS settings: hdc:pio, hdd:DMA
@@ -120,21 +99,30 @@
 input: PC Speaker
 i2c /dev entries driver
 NET: Registered protocol family 2
-IP: routing cache hash table of 4096 buckets, 32Kbytes
+IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
 TCP established hash table entries: 32768 (order: 6, 262144 bytes)
 TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
 TCP: Hash tables configured (established 32768 bind 32768)
+TCP reno registered
+TCP bic registered
+TCP westwood registered
+TCP highspeed registered
+TCP hybla registered
+TCP htcp registered
+TCP vegas registered
+TCP scalable registered
 Initializing IPsec netlink socket
 NET: Registered protocol family 1
 NET: Registered protocol family 10
 IPv6 over IPv4 tunneling driver
 NET: Registered protocol family 17
 NET: Registered protocol family 15
+Using IPI Shortcut mode
 BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
 kjournald starting.  Commit interval 5 seconds
 EXT3-fs: mounted filesystem with ordered data mode.
 VFS: Mounted root (ext3 filesystem) readonly.
-Freeing unused kernel memory: 392k freed
+Freeing unused kernel memory: 388k freed
 input: AT Translated Set 2 keyboard on isa0060/serio0
 Adding 497972k swap on /dev/hda6.  Priority:-1 extents:1
 EXT3 FS on hda1, internal journal
@@ -153,6 +141,30 @@
 ReiserFS: hda5: journal params: device hda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
 ReiserFS: hda5: checking transaction log (hda5)
 ReiserFS: hda5: Using r5 hash to sort names
-ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
+PCI: Found IRQ 5 for device 0000:00:0d.0
+PCI: Sharing IRQ 5 with 0000:00:11.1
 ip_tables: (C) 2000-2002 Netfilter core team
 Generic RTC Driver v1.07
+NETDEV WATCHDOG: eth1: transmit timed out
+eth1: transmit timed out, tx_status 00 status e601.
+  diagnostics: net 0cfa media 8880 dma 0000003a fifo 0000
+eth1: Interrupt posted but not delivered -- IRQ blocked by another device?
+  Flags; bus-master 1, dirty 16(0) current 16(0)
+  Transmit list 00000000 vs. dff22200.
+  0: @dff22200  length 8000005a status 0001005a
+  1: @dff222a0  length 8000006e status 0001006e
+  2: @dff22340  length 8000004e status 0001004e
+  3: @dff223e0  length 8000004e status 0001004e
+  4: @dff22480  length 8000005a status 0001005a
+  5: @dff22520  length 8000002a status 0001002a
+  6: @dff225c0  length 8000002a status 0001002a
+  7: @dff22660  length 8000002a status 0001002a
+  8: @dff22700  length 8000002a status 0001002a
+  9: @dff227a0  length 8000002a status 0001002a
+  10: @dff22840  length 8000002a status 0001002a
+  11: @dff228e0  length 8000002a status 0001002a
+  12: @dff22980  length 8000002a status 0001002a
+  13: @dff22a20  length 8000002a status 0001002a
+  14: @dff22ac0  length 8000002a status 8001002a
+  15: @dff22b60  length 8000002a status 8001002a
+eth1: Resetting the Tx ring pointer.

It seemed like ACPI was dead so I did `make menuconfig` and checked
if it is enabled. It was not. After reenabling ACPI the machine
booted perfectly.

Anyway it should boot without ACPI I guess.

Regards,
Maciej


