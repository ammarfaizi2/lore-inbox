Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130173AbRCCAJg>; Fri, 2 Mar 2001 19:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130175AbRCCAJ2>; Fri, 2 Mar 2001 19:09:28 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:34246 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S130173AbRCCAJL>;
	Fri, 2 Mar 2001 19:09:11 -0500
Message-ID: <3AA03623.E37EEF04@mandrakesoft.com>
Date: Fri, 02 Mar 2001 19:09:07 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Grant Grundler <grundler@cup.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4.0 parisc PCI support
In-Reply-To: <200103022143.NAA29984@milano.cup.hp.com>
Content-Type: multipart/mixed;
 boundary="------------D17845E22C575FDD6C23AFE9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D17845E22C575FDD6C23AFE9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Just tested your patch on an x86 laptop with two CardBus controllers
(kernel's CardBus bridge code == kernel's PCI-PCI bridge code, for the
most part) and an SMP x86 desktop machine.

The patch worked 100% on my laptop, but failed to allocate a PCI memory
region on my desktop machine.  Two attachments... "diff -u" output for
dmesg before and after your patch, and "diff -u" output for lspci before
and after your patch.

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
--------------D17845E22C575FDD6C23AFE9
Content-Type: text/plain; charset=us-ascii;
 name="dmesg.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.diff"

--- rum-dmesg-before.txt	Fri Mar  2 17:42:33 2001
+++ rum-dmesg-after.txt	Fri Mar  2 17:07:17 2001
@@ -1,4 +1,4 @@
-Linux version 2.4.2 (jgarzik@rum.normnet.org) (gcc version 2.96 20000731 (Linux-Mandrake 8.0)) #5 SMP Fri Mar 2 17:37:39 EST 2001
+Linux version 2.4.2 (jgarzik@rum.normnet.org) (gcc version 2.96 20000731 (Linux-Mandrake 8.0)) #2 SMP Fri Mar 2 16:52:53 EST 2001
 BIOS-provided physical RAM map:
  BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
  BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
@@ -29,7 +29,7 @@
 ide_setup: ide0=autotune
 ide_setup: ide1=autotune
 Initializing CPU#0
-Detected 400.918 MHz processor.
+Detected 400.915 MHz processor.
 Console: colour VGA+ 80x25
 Calibrating delay loop... 799.53 BogoMIPS
 Memory: 126276k/131060k available (1209k kernel code, 4396k reserved, 434k data, 192k init, 0k highmem)
@@ -138,19 +138,19 @@
 IRQ19 -> 19
 .................................... done.
 calibrating APIC timer ...
-..... CPU clock speed is 400.9022 MHz.
-..... host bus clock speed is 100.2254 MHz.
-cpu: 0, clocks: 1002254, slice: 334084
-CPU0<T0:1002240,T1:668144,D:12,S:334084,C:1002254>
-cpu: 1, clocks: 1002254, slice: 334084
-CPU1<T0:1002240,T1:334064,D:8,S:334084,C:1002254>
+..... CPU clock speed is 400.9365 MHz.
+..... host bus clock speed is 100.2340 MHz.
+cpu: 0, clocks: 1002340, slice: 334113
+CPU0<T0:1002336,T1:668208,D:15,S:334113,C:1002340>
+cpu: 1, clocks: 1002340, slice: 334113
+CPU1<T0:1002336,T1:334096,D:14,S:334113,C:1002340>
 checking TSC synchronization across CPUs: passed.
 PCI: Using configuration type 1
 PCI: Probing PCI hardware
 PCI: IDE base address fixup for 00:04.1
 PCI: Scanning for ghost devices on bus 0
 PCI: Scanning for ghost devices on bus 1
-Unknown bridge resource 0: assuming transparent
+PCI : ignoring 00:01.0 PCI-PCI bridge (I/O BASE not configured)
 PCI: IRQ init
 PCI: Interrupt Routing Table found at 0xc00f0d20
 00:0c slot=01 0:60/1eb8 1:61/1eb8 2:62/1eb8 3:63/1eb8
@@ -179,6 +179,8 @@
 PCI: Resource ce800000-ce800fff (f=200, d=0, p=0)
 PCI: Resource 0000b400-0000b47f (f=101, d=0, p=0)
 PCI: Resource d0000000-d7ffffff (f=200, d=0, p=0)
+PCI: Cannot allocate resource region 0 of device 01:00.0
+PCI: Failed to allocate resource 0 for 01:00.0
 Limiting direct PCI/PCI transfers.
 Linux NET4.0 for Linux 2.4
 Based upon Swansea University Computer Society NET3.039
@@ -186,7 +188,7 @@
 IA-32 Microcode Update Driver: v1.08 <tigran@veritas.com>
 Starting kswapd v1.8
 pty: 256 Unix98 ptys configured
-block: queued sectors max/low 83802kB/27934kB, 256 slots per queue
+block: queued sectors max/low 83794kB/27931kB, 256 slots per queue
 RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
 Uniform Multi-Platform E-IDE driver Revision: 6.31
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx

--------------D17845E22C575FDD6C23AFE9
Content-Type: text/plain; charset=us-ascii;
 name="lspci.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.diff"

--- rum-lspci-before.txt	Fri Mar  2 17:42:23 2001
+++ rum-lspci-after.txt	Fri Mar  2 17:07:26 2001
@@ -88,7 +88,7 @@
 	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 64 (1250ns min, 63750ns max), cache line size 08
 	Interrupt: pin A routed to IRQ 16
-	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=128M]
+	Region 0: Memory at <ignored> (32-bit, non-prefetchable) [size=128M]
 	Expansion ROM at e5ff0000 [disabled] [size=64K]
 	Capabilities: [dc] Power Management version 1
 		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)

--------------D17845E22C575FDD6C23AFE9--

