Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266203AbUGAVxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266203AbUGAVxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 17:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266303AbUGAVxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 17:53:44 -0400
Received: from mid-1.inet.it ([213.92.5.18]:49382 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S266305AbUGAVxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 17:53:13 -0400
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: linux-kernel@vger.kernel.org
Subject: SATA problems in 2.6.7-mm[1,5] vanilla works
Date: Thu, 1 Jul 2004 23:52:16 +0200
User-Agent: KMail/1.6.2
Cc: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QeI5AjjYL7P8Br1"
Message-Id: <200407012352.16816.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_QeI5AjjYL7P8Br1
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm having problems with sata starting from 2.6.7-mm1: 
the system hangs at boot, during the sata bus scan.

reverting this patch 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm1/broken-out/bk-libata.patch
on -mm1 restores the right behaviour.
(BTW: it reports IRQ 18: nobody cared during sata scan, but I can provide in a 
(hopefully) short time boot messages captured by serial console, if needed.)

I can make any test needed to narrow down the problem, just let me know.

system:
PIV 2.8 HT, i875p MB (ICH5)
graphic board: nvidia but without nvidia modules loaded.
2.6.7 vanilla config attached (-mm1 config is obtained by make oldconfig from 
this)

lspci -v:
[root@kefk root]# lspci -v
00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, fast devsel, latency 0
        Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [e4] #09 [2106]
        Capabilities: [a0] AGP version 3.0

00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02) 
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        Memory behind bridge: f8000000-f9ffffff
        Prefetchable memory behind bridge: f0000000-f7ffffff

00:03.0 PCI bridge: Intel Corp. 82875P Processor to PCI to CSA Bridge (rev 02) 
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 32
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: fa000000-fa0fffff

00:1d.0 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at bc00 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, medium devsel, latency 0, IRQ 19
        I/O ports at b000 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at b400 [size=32]

00:1d.3 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at b800 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801EB USB2 (rev 02) (prog-if 20 [EHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, medium devsel, latency 0, IRQ 23
        Memory at fa200000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [20a0]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev c2) (prog-if 
00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: fa100000-fa1fffff

00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev 02)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev 
02) (prog-if 8a [Master SecP PriP])
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at f000 [size=16]
        Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

00:1f.2 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev 
02) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 18
        I/O ports at c000 [size=8]
        I/O ports at c400 [size=4]
        I/O ports at c800 [size=8]
        I/O ports at cc00 [size=4]
        I/O ports at d000 [size=16]

00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: medium devsel, IRQ 17
        I/O ports at 0500 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801EB AC'97 Audio 
Controller (rev 02)
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, medium devsel, latency 0, IRQ 17
        I/O ports at d800 [size=256]
        I/O ports at dc00 [size=64]
        Memory at fa202000 (32-bit, non-prefetchable) [size=512]
        Memory at fa203000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200] 
(rev a1) (prog-if 00 [VGA])
        Subsystem: Unknown device 1682:1280
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 16
        Memory at f8000000 (32-bit, non-prefetchable) [size=16M]
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 3.0

02:01.0 Ethernet controller: Intel Corp.: Unknown device 1019
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 18
        Memory at fa000000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at 9000 [size=32]
        Capabilities: [dc] Power Management version 2

03:06.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
        Subsystem: Adaptec AHA-2904/Integrated AIC-7850
        Flags: bus master, medium devsel, latency 32, IRQ 22
        I/O ports at a000 [disabled] [size=256]
        Memory at fa100000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 1


-- 
Fabio Coatti       http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

--Boundary-00=_QeI5AjjYL7P8Br1
Content-Type: application/x-gzip;
  name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config.gz"

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

--Boundary-00=_QeI5AjjYL7P8Br1--
