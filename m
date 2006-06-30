Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWF3Ee7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWF3Ee7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 00:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWF3Ee7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 00:34:59 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:43137 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750901AbWF3Ee6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 00:34:58 -0400
Subject: Re: [PATCH] cardbus: revert IO window limit
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Alessio Sangalli <alesan@manoweb.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       ink@jurassic.park.msu.ru, dtor_core@ameritech.net
In-Reply-To: <449B0B3C.2020904@manoweb.com>
References: <Pine.LNX.4.58.0606220947250.15059@sbz-30.cs.Helsinki.FI>
	 <20060622001104.9e42fc54.akpm@osdl.org>
	 <1150976158.15275.148.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606220917080.5498@g5.osdl.org>
	 <20060622093606.2b3b1eb7.akpm@osdl.org>
	 <Pine.LNX.4.64.0606221005410.5498@g5.osdl.org>
	 <449B0B3C.2020904@manoweb.com>
Date: Fri, 30 Jun 2006 07:34:55 +0300
Message-Id: <1151642095.4592.4.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alessio,

On Thu, 2006-06-22 at 23:27 +0200, Alessio Sangalli wrote:
> Ok I've found how to enable PCI_DEBUG (I had to enable kernel debugging
> first).

The I/O windows are at a different place for your Cardbus bridge. No
idea why that kills your boot, though.  Did you try commit
4196c3af25d98204216a5d6c37ad2cb303a1f2bf reverted and CONFIG_APM
disabled to see if I/O windows move due to the commit or enabling APM?

				Pekka

--- lspci-noapm	2006-06-30 07:23:20.000000000 +0300
+++ lspci-reverted	2006-06-30 07:28:23.000000000 +0300
@@ -1,4 +1,4 @@
-# /sbin/lspci -vvx (CONFIG_APM disabled)
+# /sbin/lspci -vvx (Commit 4196c3af25d98204216a5d6c37ad2cb303a1f2bf reverted, CONFIG_APM enabled)
 00:00.0 Host bridge: Intel Corp. 82440MX Host Bridge (rev 01)
         Subsystem: Compaq Computer Corporation: Unknown device 000d
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
@@ -72,11 +72,11 @@
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
 ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
-<TAbort- <MAbort- >SERR- <PERR-
+<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 240
         Interrupt: pin D routed to IRQ 11
         Region 4: I/O ports at 1200 [size=32]
-00: 86 80 9a 71 05 00 80 02 00 00 03 0c 00 f0 00 00
+00: 86 80 9a 71 05 00 80 22 00 00 03 0c 00 f0 00 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 01 12 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 00
@@ -104,15 +104,15 @@
         Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
         Memory window 0: 20000000-21fff000 (prefetchable)
         Memory window 1: 22000000-23fff000
-        I/O window 0: 00001000-000010ff
-        I/O window 1: 00001400-000014ff
+        I/O window 0: 00002000-00002fff
+        I/O window 1: 00004000-00004fff
         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
 PostWrite+
         16-bit legacy interface ports at 0001
 00: 4c 10 50 ac 07 00 10 02 01 00 07 06 08 a8 02 00
 10: 00 00 02 24 a0 00 00 02 00 01 04 b0 00 00 00 20
-20: 00 f0 ff 21 00 00 00 22 00 f0 ff 23 00 10 00 00
-30: fc 10 00 00 00 14 00 00 fc 14 00 00 0a 01 c0 05
+20: 00 f0 ff 21 00 00 00 22 00 f0 ff 23 00 20 00 00
+30: fc 2f 00 00 00 40 00 00 fc 4f 00 00 0a 01 c0 05
 40: 11 0e 0d 00 01 00 00 00 00 00 00 00 00 00 00 00
 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--- dmesg-noapm	2006-06-30 07:28:10.000000000 +0300
+++ dmesg-reverted	2006-06-30 07:27:34.000000000 +0300
@@ -1,6 +1,6 @@
-# dmesg (CONFIG_APM DISABLED)
-Linux version 2.6.17-g9fda2669 (root@thor) (gcc version 3.4.6 (Gentoo
-3.4.6-r1, ssp-3.4.5-1.0, pie-8.7.9)) #9 PREEMPT Thu Jun 22 23:12:24 CEST
+# dmesg (Commit 4196c3af25d98204216a5d6c37ad2cb303a1f2bf reverted, CONFIG_APM enabled)
+Linux version 2.6.17-g95e5c611 (root@thor) (gcc version 3.4.6 (Gentoo
+3.4.6-r1, ssp-3.4.5-1.0, pie-8.7.9)) #5 PREEMPT Thu Jun 22 22:12:00 CEST
 2006
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
@@ -17,21 +17,21 @@
 DMI not present or invalid.
 Allocating PCI resources starting at 20000000 (gap: 10000000:effc0000)
 Built 1 zonelists
-Kernel command line: BOOT_IMAGE=git ro root=301
+Kernel command line: BOOT_IMAGE=git-b ro root=301
 Enabling fast FPU save and restore... done.
 Enabling unmasked SIMD FPU exception support... done.
 Initializing CPU#0
 PID hash table entries: 1024 (order: 10, 4096 bytes)
-Detected 500.182 MHz processor.
+Detected 500.038 MHz processor.
 Using tsc for high-res timesource
 Console: colour dummy device 80x25
 Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
 Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
-Memory: 256432k/262080k available (1946k kernel code, 5152k reserved,
-657k data, 120k init, 0k highmem)
+Memory: 256420k/262080k available (1951k kernel code, 5164k reserved,
+660k data, 124k init, 0k highmem)
 Checking if this processor honours the WP bit even in supervisor mode... Ok.
-Calibrating delay using timer specific routine.. 1001.09 BogoMIPS
-(lpj=500548)
+Calibrating delay using timer specific routine.. 1001.07 BogoMIPS
+(lpj=500536)
 Mount-cache hash table entries: 512
 CPU: After generic identify, caps: 0387f9ff 00000000 00000000 00000000
 00000000 00000000 00000000
@@ -58,57 +58,57 @@
 PCI: Probing PCI hardware (bus 00)
 PCI: Scanning bus 0000:00
 PCI: Found 0000:00:00.0 [8086/7194] 000600 00
-PCI: Calling quirk c01de102 for 0000:00:00.0
-PCI: Calling quirk c02941c5 for 0000:00:00.0
-PCI: Calling quirk c029432b for 0000:00:00.0
-PCI: Calling quirk c029448a for 0000:00:00.0
+PCI: Calling quirk c01df586 for 0000:00:00.0
+PCI: Calling quirk c0295649 for 0000:00:00.0
+PCI: Calling quirk c02957af for 0000:00:00.0
+PCI: Calling quirk c029590e for 0000:00:00.0
 PCI: Found 0000:00:00.1 [8086/7195] 000401 00
-PCI: Calling quirk c01de102 for 0000:00:00.1
-PCI: Calling quirk c02941c5 for 0000:00:00.1
-PCI: Calling quirk c029432b for 0000:00:00.1
-PCI: Calling quirk c029448a for 0000:00:00.1
+PCI: Calling quirk c01df586 for 0000:00:00.1
+PCI: Calling quirk c0295649 for 0000:00:00.1
+PCI: Calling quirk c02957af for 0000:00:00.1
+PCI: Calling quirk c029590e for 0000:00:00.1
 PCI: Found 0000:00:00.2 [8086/7196] 000703 00
-PCI: Calling quirk c01de102 for 0000:00:00.2
-PCI: Calling quirk c02941c5 for 0000:00:00.2
-PCI: Calling quirk c029432b for 0000:00:00.2
-PCI: Calling quirk c029448a for 0000:00:00.2
+PCI: Calling quirk c01df586 for 0000:00:00.2
+PCI: Calling quirk c0295649 for 0000:00:00.2
+PCI: Calling quirk c02957af for 0000:00:00.2
+PCI: Calling quirk c029590e for 0000:00:00.2
 PCI: Found 0000:00:07.0 [8086/7198] 000601 00
-PCI: Calling quirk c01de102 for 0000:00:07.0
-PCI: Calling quirk c02941c5 for 0000:00:07.0
-PCI: Calling quirk c029432b for 0000:00:07.0
-PCI: Calling quirk c029448a for 0000:00:07.0
+PCI: Calling quirk c01df586 for 0000:00:07.0
+PCI: Calling quirk c0295649 for 0000:00:07.0
+PCI: Calling quirk c02957af for 0000:00:07.0
+PCI: Calling quirk c029590e for 0000:00:07.0
 PCI: Found 0000:00:07.1 [8086/7199] 000101 00
-PCI: Calling quirk c01de102 for 0000:00:07.1
-PCI: Calling quirk c02941c5 for 0000:00:07.1
-PCI: Calling quirk c029432b for 0000:00:07.1
-PCI: Calling quirk c029448a for 0000:00:07.1
+PCI: Calling quirk c01df586 for 0000:00:07.1
+PCI: Calling quirk c0295649 for 0000:00:07.1
+PCI: Calling quirk c02957af for 0000:00:07.1
+PCI: Calling quirk c029590e for 0000:00:07.1
 PCI: Found 0000:00:07.2 [8086/719a] 000c03 00
-PCI: Calling quirk c01de102 for 0000:00:07.2
-PCI: Calling quirk c02941c5 for 0000:00:07.2
-PCI: Calling quirk c029432b for 0000:00:07.2
-PCI: Calling quirk c029448a for 0000:00:07.2
+PCI: Calling quirk c01df586 for 0000:00:07.2
+PCI: Calling quirk c0295649 for 0000:00:07.2
+PCI: Calling quirk c02957af for 0000:00:07.2
+PCI: Calling quirk c029590e for 0000:00:07.2
 PCI: Found 0000:00:07.3 [8086/719b] 000680 00
-PCI: Calling quirk c01de102 for 0000:00:07.3
-PCI: Calling quirk c02941c5 for 0000:00:07.3
-PCI: Calling quirk c029432b for 0000:00:07.3
-PCI: Calling quirk c029448a for 0000:00:07.3
+PCI: Calling quirk c01df586 for 0000:00:07.3
+PCI: Calling quirk c0295649 for 0000:00:07.3
+PCI: Calling quirk c02957af for 0000:00:07.3
+PCI: Calling quirk c029590e for 0000:00:07.3
 PCI: Found 0000:00:08.0 [104c/ac50] 000607 02
-PCI: Calling quirk c01de102 for 0000:00:08.0
-PCI: Calling quirk c02941c5 for 0000:00:08.0
-PCI: Calling quirk c029448a for 0000:00:08.0
+PCI: Calling quirk c01df586 for 0000:00:08.0
+PCI: Calling quirk c0295649 for 0000:00:08.0
+PCI: Calling quirk c029590e for 0000:00:08.0
 PCI: Found 0000:00:09.0 [1002/4c52] 000300 00
-PCI: Calling quirk c01de102 for 0000:00:09.0
-PCI: Calling quirk c02941c5 for 0000:00:09.0
-PCI: Calling quirk c029448a for 0000:00:09.0
+PCI: Calling quirk c01df586 for 0000:00:09.0
+PCI: Calling quirk c0295649 for 0000:00:09.0
+PCI: Calling quirk c029590e for 0000:00:09.0
 Boot video device is 0000:00:09.0
 PCI: Found 0000:00:0a.0 [10ec/8139] 000200 00
-PCI: Calling quirk c01de102 for 0000:00:0a.0
-PCI: Calling quirk c02941c5 for 0000:00:0a.0
-PCI: Calling quirk c029448a for 0000:00:0a.0
+PCI: Calling quirk c01df586 for 0000:00:0a.0
+PCI: Calling quirk c0295649 for 0000:00:0a.0
+PCI: Calling quirk c029590e for 0000:00:0a.0
 PCI: Found 0000:00:0b.0 [1033/00cd] 000c00 00
-PCI: Calling quirk c01de102 for 0000:00:0b.0
-PCI: Calling quirk c02941c5 for 0000:00:0b.0
-PCI: Calling quirk c029448a for 0000:00:0b.0
+PCI: Calling quirk c01df586 for 0000:00:0b.0
+PCI: Calling quirk c0295649 for 0000:00:0b.0
+PCI: Calling quirk c029590e for 0000:00:0b.0
 PCI: Fixups for bus 0000:00
 PCI: Scanning behind PCI bridge 0000:00:08.0, config 000040, pass 0
 PCI: Scanning behind PCI bridge 0000:00:08.0, config 000040, pass 1
@@ -126,8 +126,8 @@
 0 of 0000:00:0b.0
 PCI: moved device 0000:00:0b.0 resource 0 (200) to 24021000
 PCI: Bus 1, cardbus bridge: 0000:00:08.0
-  IO window: 00001000-000010ff
-  IO window: 00001400-000014ff
+  IO window: 00002000-00002fff
+  IO window: 00004000-00004fff
   PREFETCH window: 20000000-21ffffff
   MEM window: 22000000-23ffffff
 PCI: Found IRQ 10 for device 0000:00:08.0
@@ -137,32 +137,33 @@
 TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
 TCP: Hash tables configured (established 8192 bind 4096)
 TCP reno registered
+apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
 NTFS driver 2.1.27 [Flags: R/O].
 Initializing Cryptographic API
 io scheduler noop registered
 io scheduler cfq registered (default)
-PCI: Calling quirk c01de03c for 0000:00:00.0
-PCI: Calling quirk c0244ebc for 0000:00:00.0
-PCI: Calling quirk c01de03c for 0000:00:00.1
-PCI: Calling quirk c0244ebc for 0000:00:00.1
-PCI: Calling quirk c01de03c for 0000:00:00.2
-PCI: Calling quirk c0244ebc for 0000:00:00.2
-PCI: Calling quirk c01de03c for 0000:00:07.0
-PCI: Calling quirk c0244ebc for 0000:00:07.0
-PCI: Calling quirk c01de03c for 0000:00:07.1
-PCI: Calling quirk c0244ebc for 0000:00:07.1
-PCI: Calling quirk c01de03c for 0000:00:07.2
-PCI: Calling quirk c0244ebc for 0000:00:07.2
-PCI: Calling quirk c01de03c for 0000:00:07.3
-PCI: Calling quirk c0244ebc for 0000:00:07.3
-PCI: Calling quirk c01de03c for 0000:00:08.0
-PCI: Calling quirk c0244ebc for 0000:00:08.0
-PCI: Calling quirk c01de03c for 0000:00:09.0
-PCI: Calling quirk c0244ebc for 0000:00:09.0
-PCI: Calling quirk c01de03c for 0000:00:0a.0
-PCI: Calling quirk c0244ebc for 0000:00:0a.0
-PCI: Calling quirk c01de03c for 0000:00:0b.0
-PCI: Calling quirk c0244ebc for 0000:00:0b.0
+PCI: Calling quirk c01df4c0 for 0000:00:00.0
+PCI: Calling quirk c0246340 for 0000:00:00.0
+PCI: Calling quirk c01df4c0 for 0000:00:00.1
+PCI: Calling quirk c0246340 for 0000:00:00.1
+PCI: Calling quirk c01df4c0 for 0000:00:00.2
+PCI: Calling quirk c0246340 for 0000:00:00.2
+PCI: Calling quirk c01df4c0 for 0000:00:07.0
+PCI: Calling quirk c0246340 for 0000:00:07.0
+PCI: Calling quirk c01df4c0 for 0000:00:07.1
+PCI: Calling quirk c0246340 for 0000:00:07.1
+PCI: Calling quirk c01df4c0 for 0000:00:07.2
+PCI: Calling quirk c0246340 for 0000:00:07.2
+PCI: Calling quirk c01df4c0 for 0000:00:07.3
+PCI: Calling quirk c0246340 for 0000:00:07.3
+PCI: Calling quirk c01df4c0 for 0000:00:08.0
+PCI: Calling quirk c0246340 for 0000:00:08.0
+PCI: Calling quirk c01df4c0 for 0000:00:09.0
+PCI: Calling quirk c0246340 for 0000:00:09.0
+PCI: Calling quirk c01df4c0 for 0000:00:0a.0
+PCI: Calling quirk c0246340 for 0000:00:0a.0
+PCI: Calling quirk c01df4c0 for 0000:00:0b.0
+PCI: Calling quirk c0246340 for 0000:00:0b.0
 vesafb: framebuffer at 0xc0000000, mapped to 0xd0800000, using 1536k,
 total 4096k
 vesafb: mode is 1024x768x8, linelength=1024, pages=4
@@ -235,7 +236,7 @@
 PCI: Setting latency timer of device 0000:00:00.1 to 64
 input: AT Translated Set 2 keyboard as /class/input/input0
 pccard: PCMCIA card inserted into slot 0
-intel8x0_measure_ac97_clock: measured 50113 usecs
+intel8x0_measure_ac97_clock: measured 50190 usecs
 intel8x0: clocking to 48000
 ALSA device list:
   #0: Intel 440MX with CS4299 at 0x1600, irq 5
@@ -251,13 +252,10 @@
 block 18, max trans len 1024, max batch 900, max commit age 30, max
 trans age 30
 ReiserFS: hda1: checking transaction log (hda1)
-ReiserFS: hda1: replayed 12 transactions in 7 seconds
 ReiserFS: hda1: Using r5 hash to sort names
 VFS: Mounted root (reiserfs filesystem) readonly.
-Freeing unused kernel memory: 120k freed
+Freeing unused kernel memory: 124k freed
 Adding 265064k swap on /dev/hda2.  Priority:-1 extents:1 across:265064k
-ReiserFS: hda1: Removing [15923 112983 0x0 SD]..done
-ReiserFS: hda1: There were 1 uncompleted unlinks/truncates. Completed
 NTFS volume version 3.1.
 pcmcia: Detected deprecated PCMCIA ioctl usage from process: cardmgr.
 pcmcia: This interface will soon be removed from the kernel; please


