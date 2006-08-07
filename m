Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWHGJ2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWHGJ2P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 05:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWHGJ2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 05:28:15 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:36494 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751178AbWHGJ2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 05:28:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=D0QP4HFLK5Jbskd7RHdKeEjzSfn4p6EtBRQwY3wbgaj1nHuRVrv8m2xhrGin728jrh9eSU6dmw4mCPaXWIpSq+X3lFZgq7TuDJqwRKDuG4pM83lpQECspY390gTmDl7hoNKOPm06NJzIl+d4PtxHQLPz6OrWY5YNqJspwQ/g9UE=
Message-ID: <44D707B6.20501@gmail.com>
Date: Mon, 07 Aug 2006 11:27:59 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, andre@linux-ide.org, pavel@suse.cz,
       linux-pm@osdl.org, linux-ide@vger.kernel.org
Subject: swsusp regression [Was: 2.6.18-rc3-mm2]
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
In-Reply-To: <20060806030809.2cfb0b1e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/

I tried it and guess what :)... swsusp doesn't work :@.

This time I was able to dump process states with sysrq-t:
http://www.fi.muni.cz/~xslaby/sklad/ide2.gif

My guess is ide2/2.0 dies (hpt370 driver), since last thing kernel prints is 
suspending device 2.0

diff of dmesgs:
--- rc2 2006-08-07 11:13:34.000000000 +0200
+++ rc3 2006-08-07 11:13:39.000000000 +0200
@@ -1,4 +1,4 @@
-Linux version 2.6.18-rc2-mm1 (ku@bellona) (gcc version 4.1.1 20060721 (Red Hat 
4.1.1-13)) #155 SMP Tue Aug 1 01:17:45 CEST 2006
+Linux version 2.6.18-rc3-mm2 (ku@bellona) (gcc version 4.1.1 20060802 (Red Hat 
4.1.1-14)) #157 SMP Sun Aug 6 19:38:53 CEST 2006
  BIOS-provided physical RAM map:
  sanitize start
  sanitize end
@@ -49,7 +49,7 @@
  Enabling APIC mode:  Flat.  Using 1 I/O APICs
  Using ACPI (MADT) for SMP configuration information
  Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
-Detected 2736.278 MHz processor.
+Detected 2736.289 MHz processor.
  Built 1 zonelists.  Total pages: 262128
  Kernel command line: ro root=/dev/hda2 reboot=w vga=1 2
  mapped APIC to ffffd000 (fee00000)
@@ -57,14 +57,22 @@
  Enabling fast FPU save and restore... done.
  Enabling unmasked SIMD FPU exception support... done.
  Initializing CPU#0
-CPU 0 irqstacks, hard=c0505000 soft=c0502000
+CPU 0 irqstacks, hard=c0509000 soft=c0506000
  PID hash table entries: 4096 (order: 12, 16384 bytes)
  Console: colour VGA+ 80x50
  Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
  Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
-Memory: 1034488k/1048512k available (2514k kernel code, 13456k reserved, 1349k 
data, 200k init, 131008k highmem)
+Memory: 1034472k/1048512k available (2522k kernel code, 13472k reserved, 1353k 
data, 204k init, 131008k highmem)
+virtual kernel memory layout:
+    fixmap  : 0xfff90000 - 0xfffff000   ( 444 kB)
+    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
+    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
+    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
+      .init : 0xc04ce000 - 0xc0501000   ( 204 kB)
+      .data : 0xc03768d2 - 0xc04c8ff8   (1353 kB)
+      .text : 0xc0100000 - 0xc03768d2   (2522 kB)
  Checking if this processor honours the WP bit even in supervisor mode... Ok.
-Calibrating delay using timer specific routine.. 5476.47 BogoMIPS (lpj=10952942)
+Calibrating delay using timer specific routine.. 5476.48 BogoMIPS (lpj=10952969)
  Mount-cache hash table entries: 512
  CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 
00004400 00000000 00000000
  CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 
00000000 00000000
@@ -82,9 +90,9 @@
  CPU0: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
  SMP alternatives: switching to SMP code
  Booting processor 1/1 eip 3000
-CPU 1 irqstacks, hard=c0506000 soft=c0503000
+CPU 1 irqstacks, hard=c050a000 soft=c0507000
  Initializing CPU#1
-Calibrating delay using timer specific routine.. 5472.77 BogoMIPS (lpj=10945546)
+Calibrating delay using timer specific routine.. 5472.79 BogoMIPS (lpj=10945581)
  CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 
00004400 00000000 00000000
  CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 
00000000 00000000
  CPU: Trace cache: 12K uops, L1 D cache: 8K
@@ -96,15 +104,15 @@
  CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
  CPU1: Thermal monitoring enabled
  CPU1: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
-Total of 2 processors activated (10949.24 BogoMIPS).
+Total of 2 processors activated (10949.27 BogoMIPS).
  ENABLING IO-APIC IRQs
  ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
  checking TSC synchronization across 2 CPUs: passed.
  Brought up 2 CPUs
-migration_cost=111
+migration_cost=1
  NET: Registered protocol family 16
  ACPI: bus type pci registered
-PCI: PCI BIOS revision 2.10 entry at 0xfb670, last bus=2
+PCI: Using configuration type 1
  Setting up standard PCI resources
  ACPI: Interpreter enabled
  ACPI: Using IOAPIC for interrupt routing
@@ -189,7 +197,7 @@
  ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 21 (level, low) -> IRQ 19
  HPT370: chipset revision 3
  HPT370: no clock data saved by BIOS
-HPT370: DPLL base: 48 MHz, f_CNT: 146, assuming 33 MHz PCI
+HPT370: DPLL base: 48 MHz, f_CNT: 148, assuming 33 MHz PCI
  HPT370: using 33 MHz PCI clock
  HPT370: 100% native mode on irq 19
      ide2: BM-DMA at 0x9000-0x9007, BIOS settings: hde:DMA, hdf:pio
@@ -243,7 +251,7 @@
  usb usb1: new device found, idVendor=0000, idProduct=0000
  usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
  usb usb1: Product: EHCI Host Controller
-usb usb1: Manufacturer: Linux 2.6.18-rc2-mm1 ehci_hcd
+usb usb1: Manufacturer: Linux 2.6.18-rc3-mm2 ehci_hcd
  usb usb1: SerialNumber: 0000:00:1d.7
  usb usb1: configuration #1 chosen from 1 choice
  hub 1-0:1.0: USB hub found
@@ -257,7 +265,7 @@
  usb usb2: new device found, idVendor=0000, idProduct=0000
  usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
  usb usb2: Product: UHCI Host Controller
-usb usb2: Manufacturer: Linux 2.6.18-rc2-mm1 uhci_hcd
+usb usb2: Manufacturer: Linux 2.6.18-rc3-mm2 uhci_hcd
  usb usb2: SerialNumber: 0000:00:1d.0
  usb usb2: configuration #1 chosen from 1 choice
  hub 2-0:1.0: USB hub found
@@ -270,7 +278,7 @@
  usb usb3: new device found, idVendor=0000, idProduct=0000
  usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
  usb usb3: Product: UHCI Host Controller
-usb usb3: Manufacturer: Linux 2.6.18-rc2-mm1 uhci_hcd
+usb usb3: Manufacturer: Linux 2.6.18-rc3-mm2 uhci_hcd
  usb usb3: SerialNumber: 0000:00:1d.1
  usb usb3: configuration #1 chosen from 1 choice
  hub 3-0:1.0: USB hub found
@@ -283,7 +291,7 @@
  usb usb4: new device found, idVendor=0000, idProduct=0000
  usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
  usb usb4: Product: UHCI Host Controller
-usb usb4: Manufacturer: Linux 2.6.18-rc2-mm1 uhci_hcd
+usb usb4: Manufacturer: Linux 2.6.18-rc3-mm2 uhci_hcd
  usb usb4: SerialNumber: 0000:00:1d.2
  usb usb4: configuration #1 chosen from 1 choice
  hub 4-0:1.0: USB hub found
@@ -296,7 +304,7 @@
  usb usb5: new device found, idVendor=0000, idProduct=0000
  usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
  usb usb5: Product: UHCI Host Controller
-usb usb5: Manufacturer: Linux 2.6.18-rc2-mm1 uhci_hcd
+usb usb5: Manufacturer: Linux 2.6.18-rc3-mm2 uhci_hcd
  usb usb5: SerialNumber: 0000:00:1d.3
  usb usb5: configuration #1 chosen from 1 choice
  hub 5-0:1.0: USB hub found
@@ -312,8 +320,8 @@
  input: Wacom Graphire2 4x5 as /class/input/input0
  usbcore: registered new interface driver wacom
  /l/latest/xxx/drivers/usb/input/wacom.c: v1.45:USB Wacom Graphire and Wacom 
Intuos tablet driver
-serio: i8042 AUX port at 0x60,0x64 irq 12
  serio: i8042 KBD port at 0x60,0x64 irq 1
+serio: i8042 AUX port at 0x60,0x64 irq 12
  mice: PS/2 mouse device common for all mice
  it87: Found IT8712F chip at 0x290, revision 5
  md: raid0 personality registered for level 0
@@ -325,6 +333,7 @@
    No soundcards found.
  oprofile: using NMI interrupt.
  ip_conntrack version 2.4 (8191 buckets, 65528 max) - 208 bytes per conntrack
+input: AT Translated Set 2 keyboard as /class/input/input1
  ip_tables: (C) 2000-2006 Netfilter Core Team
  TCP bic registered
  NET: Registered protocol family 1
@@ -336,13 +345,15 @@
  md: Autodetecting RAID arrays.
  md: autorun ...
  md: ... autorun DONE.
+EXT3-fs: INFO: recovery required on readonly filesystem.
+EXT3-fs: write access will be enabled during recovery.
  kjournald starting.  Commit interval 5 seconds
+EXT3-fs: recovery complete.
  EXT3-fs: mounted filesystem with ordered data mode.
  VFS: Mounted root (ext3 filesystem) readonly.
-Freeing unused kernel memory: 200k freed
-input: AT Translated Set 2 keyboard as /class/input/input1
+Freeing unused kernel memory: 204k freed
  ieee1394: Initialized config rom entry `ip1394'
-hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
+hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)
  Uniform CD-ROM driver Revision: 3.20
  hdd: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
  ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 21 (level, low) -> IRQ 19
@@ -387,3 +398,5 @@
  EXT3 FS on md0, internal journal
  EXT3-fs: mounted filesystem with ordered data mode.
  Adding 506036k swap on /dev/hda3.  Priority:-1 extents:1 across:506036k
+JBD: barrier-based sync failed on hda2 - disabling barriers
+JBD: barrier-based sync failed on md0 - disabling barriers

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
