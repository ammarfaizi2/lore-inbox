Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWBDQDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWBDQDp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 11:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWBDQDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 11:03:45 -0500
Received: from mail.bencastricum.nl ([213.84.203.196]:31965 "EHLO
	bencastricum.nl") by vger.kernel.org with ESMTP id S932336AbWBDQDp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 11:03:45 -0500
Message-ID: <000701c629a4$5df090e0$0602a8c0@links>
From: "Ben Castricum" <lk@bencastricum.nl>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: 2.6.16-rc[12] weirdness
Date: Sat, 4 Feb 2006 17:02:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2670
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-bencastricum-MailScanner-Information: Please contact the ISP for more information
X-bencastricum-MailScanner: Found to be clean
X-MailScanner-From: lk@bencastricum.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just want to report a couple of things I think are kernel related (since 
they only occur when I run 2.6.16-rc*) but are too weird to be sure.

The most annoying is that my PPP connection to my ADSL modem randomly seems 
to stop functioning. No messages are other signs of problems. It just hangs. 
Killing the pppd and restarting it fixes this.

My /dev/null device gets replaced by a file. Some of my cronjobs have a 
 >/dev/null and can see the ouput of the scripts in /dev/null. Deleting the 
file and recreating the device again is fixes this. And again.. this seems 
to happen randomly.

When comparing the bootmessages from 2.6.15 and 2.6.16-rc2:

------------------------------------------------------------------------------------------------------------------
root@gateway:/var/log# diff -u bootmessages-2.6.15 bootmessages-2.6.16-rc2
--- bootmessages-2.6.15 2006-02-03 20:57:40.000000000 +0100
+++ bootmessages-2.6.16-rc2     2006-02-03 19:29:53.000000000 +0100
@@ -1,4 +1,4 @@
-Linux version 2.6.15 (root@gateway) (gcc version 3.4.4) #34 Tue Jan 3 
08:37:04 CET 2006
+Linux version 2.6.16-rc2 (root@gateway) (gcc version 3.4.4) #37 Fri Feb 3 
08:54:42 CET 2006
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
@@ -20,20 +20,22 @@
 ACPI: PM-Timer IO Port: 0x4008
 Allocating PCI resources starting at 20000000 (gap: 13800000:ec7f0000)
 Built 1 zonelists
-Kernel command line: auto BOOT_IMAGE=2.6.15 ro root=301 init=/sbin/there 
nmi_watchdog=2 mce lapic
+Kernel command line: BOOT_IMAGE=Linux-2.6 ro root=301 init=/sbin/there 
nmi_watchdog=2 mce lapic
 Local APIC disabled by BIOS -- reenabling.
 Found and enabled local APIC!
 mapped APIC to ffffd000 (fee00000)
+Enabling fast FPU save and restore... done.
+Enabling unmasked SIMD FPU exception support... done.
 Initializing CPU#0
 PID hash table entries: 2048 (order: 11, 32768 bytes)
-Detected 933.512 MHz processor.
+Detected 933.506 MHz processor.
 Using pmtmr for high-res timesource
 Console: colour VGA+ 132x43
 Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
 Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
-Memory: 314076k/319424k available (1395k kernel code, 4884k reserved, 300k 
data, 124k init, 0k highmem)
+Memory: 314048k/319424k available (1403k kernel code, 4912k reserved, 324k 
data, 124k init, 0k highmem)
 Checking if this processor honours the WP bit even in supervisor mode... 
Ok.
-Calibrating delay using timer specific routine.. 1869.02 BogoMIPS 
(lpj=3738054)
+Calibrating delay using timer specific routine.. 1869.76 BogoMIPS 
(lpj=3739526)
 Mount-cache hash table entries: 512
 CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 
00000000 00000000 00000000
 CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 
00000000 00000000 00000000
@@ -42,16 +44,13 @@
 CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 
00000000 00000000
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#0.
-mtrr: v2.0 (20020519)
 CPU: Intel Pentium III (Coppermine) stepping 0a
-Enabling fast FPU save and restore... done.
-Enabling unmasked SIMD FPU exception support... done.
 Checking 'hlt' instruction... OK.
 ACPI: setting ELCR to 0020 (from 1c20)
 NET: Registered protocol family 16
 ACPI: bus type pci registered
 PCI: Using configuration type 1
-ACPI: Subsystem revision 20050902
+ACPI: Subsystem revision 20060127
 ACPI: Interpreter enabled
 ACPI: Using PIC for interrupt routing
 ACPI: PCI Root Bridge [PCI0] (0000:00)
@@ -68,7 +67,7 @@
 ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
 Linux Plug and Play Support v0.97 (c) Adam Belay
 pnp: PnP ACPI init
-pnp: PnP ACPI: found 11 devices
+pnp: PnP ACPI: found 12 devices
 PCI: Using ACPI for IRQ routing
 PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
 PCI: Bridge: 0000:00:01.0
@@ -80,7 +79,7 @@
 Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
 Initializing Cryptographic API
 io scheduler noop registered
-io scheduler anticipatory registered
+io scheduler anticipatory registered (default)
 PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
 PNP: PS/2 controller doesn't have AUX irq; using default 12
 serio: i8042 AUX port at 0x60,0x64 irq 12
@@ -104,7 +103,7 @@
 ide1 at 0x170-0x177,0x376 on irq 15
 hda: max request size: 128KiB
 hda: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=58168/16/63, UDMA(66)
-hda: cache flushes not supported
+hda: cache flushes notsupported
  hda: hda1
 hdb: max request size: 128KiB
 hdb: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=65535/16/63, 
UDMA(66)
@@ -135,8 +134,9 @@
 EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
 EXT3 FS on hdb3, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
-Real Time Clock Driver v1.12
+Real Time Clock Driver v1.12ac
 Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 sec 
(nowayout= 0)
+Driver 'via686a' needs updating - please use bus_type methods
 i2c_adapter i2c-9191: forcing ISA address 0x6000
 usbcore: registered new driver usbfs
 usbcore: registered new driver hub
@@ -147,12 +147,14 @@
 uhci_hcd 0000:00:04.2: UHCI Host Controller
 uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
 uhci_hcd 0000:00:04.2: irq 10, io base 0x0000d400
+usb usb1: configuration #1 chosen from 1 choice
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 2 ports detected
 usb 1-2: new full speed USB device using uhci_hcd and address 2
+usb 1-2: configuration #1 chosen from 1 choice
 cdc_acm 1-2:1.0: ttyACM0: USB ACM device
 usbcore: registered new driver cdc_acm
-drivers/usb/class/cdc-acm.c: v0.23:USB Abstract Control Model driver for 
USB modems and ISDN adapters
+drivers/usb/class/cdc-acm.c: v0.25:USB Abstract Control Model driver for 
USB modems and ISDN adapters
 8139too Fast Ethernet driver 0.9.27
 ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [LNKD] -> GSI 10 (level, 
low) -> IRQ 10
 eth0: RealTek RTL8139 at 0xd4078000, 00:50:fc:85:89:e0, IRQ 10
@@ -169,8 +171,7 @@
 PPP BSD Compression module registered
 PPP Deflate Compression module registered
 ip_conntrack version 2.4 (2495 buckets, 19960 max) - 212 bytes per 
conntrack
-ip_tables: (C) 2000-2002 Netfilter core team
+ip_tables: (C) 2000-2006 Netfilter Core Team
 process `sockd' is using obsolete setsockopt SO_BSDCOMPAT
 process `named' is using obsolete setsockopt SO_BSDCOMPAT
-process `sockd' is using obsolete setsockopt SO_BSDCOMPAT
 NET: Registered protocol family 17
------------------------------------------------------------------------------------------------------------------

I seem to have lost my MTRR (although I am not sure if I really have them 
and are properly detected) and gained a PnP ACPI device. (And there is a new 
typo in the hda cache flush detection).

I know this is a useless bug report, but I'll gladly supply more information 
if somebody has a clue on what's going on. I've placed a copy of my .config 
at http://www.bencastricum.nl/.config

Thanks,
Ben 

