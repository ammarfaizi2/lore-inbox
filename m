Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVARVkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVARVkC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 16:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVARVkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 16:40:02 -0500
Received: from hal-5.inet.it ([213.92.5.24]:506 "EHLO hal-5.inet.it")
	by vger.kernel.org with ESMTP id S261428AbVARVjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 16:39:42 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.6.11-rc1-mm1 (and others): heavy disk I/O -> poor performance
Date: Tue, 18 Jan 2005 22:39:35 +0100
User-Agent: KMail/1.7.91
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XIY7B/w5U7OW8PA"
Message-Id: <200501182239.35992.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_XIY7B/w5U7OW8PA
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Under heavy disk I/O, the system becomes very unresponsive (i.e. even a drop 
down menu takes several seconds to open).
I've noticed this under 2.6.11-rc1-mm1 and 2.6.10-mm2, but I can try whatever 
version is suggested. The way to reproduce this is quite simple: I'm using 
gentoo, when emerge --sync rebuilds cache the systems slows like a crawl; the 
same behaviour can be seen during a updatedb operation. with top, bdflush is 
often stuck in "D" state, as well the I/O bound process (say, emerge or 
updatedb).
vmstat under load is the following, and config.gz attached. Of course I can 
provide any other needed detail; many thanks for any hint.


cova@kefk ~ $ vmstat 1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0    628   5252 499696 217712    0    0    19    14   80    60  3  1 95  1
 0  1    628  25764 498764 205384    0    0   444  1252 2121   943  7  6 48 39
 0  1    628  24412 498812 206628    0    0   596   948 2032  1634 11  5 58 27
 0  1    628  23584 498816 207372    0    0   380  2604 2045  1408  6  5 70 18
 0  1    628  23360 498816 207576    0    0    56  1528 1982   559  3  2 50 45
 0  1    628  22292 498820 208592    0    0   496   980 2092  1120 11  5 51 33
 0  1    628  20372 498856 210120    0    0   772  1504 2293  1621 21  9 49 21
 0  1    628  18964 498912 211356    0    0   620  1432 2170  1615 13  7 53 28
 0  1    628  18340 498920 211892    0    0   292  2924 2137   883  5  4 57 34
 0  0    628  17636 498956 212536    0    0   264   712 2018   954  5  3 65 28
 0  1    628  17316 498968 212796    0    0   148  1096 1983   607  2  3 51 44
 0  1    628  16356 499032 213548    0    0   416   952 2061  1417  7  3 58 32
 0  0    628  15708 499060 214132    0    0   256  1912 1993  1409  4  4 53 38
 1  0    628  14804 499068 214736    0    0   352  2644 2136  1475  7  4 72 16
 0  1    628  14548 499076 215136    0    0   196  1676 2046   526  4  2 49 45
 0  1    628  13972 499104 215856    0    0   384   816 2062  1033  9  4 51 37
 0  1    628  12916 499172 216808    0    0   504  1056 2135  1311 14  5 51 30
 0  1    628  12020 499236 217560    0    0   448  1044 2111  1280 17  5 51 27
 0  0    628  11380 499268 218072    0    0   256  2048 2039   838 10  4 62 24
 1  0    628  11060 499288 218392    0    0   156  2436 2043   832  7  4 83  5
 0  1    628  10612 499328 218692    0    0   124  2180 1899   442  5  2 50 44
 1  0    628  10292 499336 218888    0    0   104   368 1883   599  2  2 50 47
 0  1    628   8292 499384 220540    0    0   788  1536 2283  1524 18  8 49 27
 0  0    628   7652 499388 221080    0    0   276  2044 2039   796  5  4 69 22
 0  1    628   6948 499392 221688    0    0   288  2352 2086   783  6  4 52 38
 1  0    628   6308 499396 222228    0    0   256   356 2008   797  7  3 50 41
 1  0    628   5024 499404 223104    0    0   476  1012 2092   983 13  5 49 32
 0  1    628   9848 498300 223936    0    0   420  1096 2075  1243  8  4 53 34
 0  1    628   9344 498312 224400    0    0   236  3744 2097  1181  5  4 73 19

To be honest I can't say when this started, I've installed gentoo and seen 
emerge --sync load only with 2.6.10-mm2

system: P4 IV 2.8/1Gb ram/i875p MB (abit IC7-g)
ide:  
hda: MAXTOR 6L060J3
hdc: TEAC DV-W58G 
scsi/Sata:
PLEXTOR         CD-ROM PX-40TS          1.01
YAMAHA          CRW6416S                1.0c
ATA             Maxtor 6Y160M0          YAR5

lspci -v:
kefk ide # lspci -v
0000:00:00.0 Host bridge: Intel Corp. 82875P/E7210 Memory Controller Hub (rev 
02)
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, fast devsel, latency 0
        Memory at d0000000 (32-bit, prefetchable)
        Capabilities: [e4] #09 [2106]
        Capabilities: [a0] AGP version 3.0

0000:00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 
02) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        Memory behind bridge: f0000000-f1ffffff
        Prefetchable memory behind bridge: e8000000-efffffff

0000:00:03.0 PCI bridge: Intel Corp. 82875P/E7210 Processor to PCI to CSA 
Bridge (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 32
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: f2000000-f20fffff
        Expansion ROM at 00009000 [disabled] [size=4K]

0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI 
Controller #1 (rev 02) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, medium devsel, latency 0, IRQ 193
        I/O ports at bc00 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI 
Controller #2 (rev 02) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, medium devsel, latency 0, IRQ 201
        I/O ports at b000 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 
(rev 02) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, medium devsel, latency 0, IRQ 169
        I/O ports at b400 [size=32]

0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI 
Controller #4 (rev 02) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, medium devsel, latency 0, IRQ 193
        I/O ports at b800 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI 
Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, medium devsel, latency 0, IRQ 185
        Memory at f2200000 (32-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2) (prog-if 00 
[Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: f2100000-f21fffff

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Interface 
Bridge (rev 02)
        Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) IDE Controller 
(rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, medium devsel, latency 0, IRQ 169
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at f000 [size=16]
        Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) SATA Controller (rev 
02) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 169
        I/O ports at c000
        I/O ports at c400 [size=4]
        I/O ports at c800 [size=8]
        I/O ports at cc00 [size=4]
        I/O ports at d000 [size=16]

0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 
02)
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: medium devsel, IRQ 9
        I/O ports at 0500 [size=32]

0000:01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 
5200] (rev a1) (prog-if 00 [VGA])
        Subsystem: Unknown device 1682:1280
        Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 193
        Memory at f0000000 (32-bit, non-prefetchable)
        Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 3.0

0000:02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet 
Controller (LOM)
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 169
        Memory at f2000000 (32-bit, non-prefetchable)
        I/O ports at 9000 [size=32]
        Capabilities: [dc] Power Management version 2

0000:03:04.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
        Subsystem: Creative Labs SB Audigy 2 ZS (SB0350)
        Flags: bus master, medium devsel, latency 32, IRQ 209
        I/O ports at a000
        Capabilities: [dc] Power Management version 2

0000:03:04.1 Input device controller: Creative Labs SB Audigy MIDI/Game port 
(rev 04)
        Subsystem: Creative Labs SB Audigy MIDI/Game Port
        Flags: bus master, medium devsel, latency 32
        I/O ports at a400
        Capabilities: [dc] Power Management version 2

0000:03:04.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 
04) (prog-if 10 [OHCI])
        Subsystem: Creative Labs SB Audigy FireWire Port
        Flags: bus master, medium devsel, latency 32, IRQ 5
        Memory at f2104000 (32-bit, non-prefetchable)
        Memory at f2100000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2

0000:03:06.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
        Subsystem: Adaptec AHA-2904/Integrated AIC-7850
        Flags: bus master, medium devsel, latency 32, IRQ 177
        I/O ports at a800 [disabled]
        Memory at f2105000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 1



-- 
Fabio Coatti       http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

--Boundary-00=_XIY7B/w5U7OW8PA
Content-Type: application/x-gzip;
  name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config.gz"

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
teK1aZjRilx94qvA8fN/ylzDLbuEAAA=

--Boundary-00=_XIY7B/w5U7OW8PA--
