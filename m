Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129118AbRBFW6N>; Tue, 6 Feb 2001 17:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129130AbRBFW6E>; Tue, 6 Feb 2001 17:58:04 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:18371 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129118AbRBFW5s>; Tue, 6 Feb 2001 17:57:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [BUG] linux 2.4.1 to 2.4.1-ac3 hangs
Date: Tue, 6 Feb 2001 17:57:28 -0500
X-Mailer: KMail [version 1.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Message-Id: <01020617572800.00870@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been see quite a few hangs on 2.4.1 thru 2.4.1-ac3.  By hang I mean 
that the box stops Shift scroll-lock etc have no effect.  I use a screen 
switch to share a monitor with a box setup as a serial console.  Even switch 
this freezes leading me to suspect the video signal is dieing.  Until it 
happen today I had no clue as to what was happening.  This time the following 
appeared on the serial console.

Starting periodic command scheduler: cron.
eth1: Oversized Ethernet frame spanned multiple buffers, entry 0x7 length 0 
sta!eth1: Oversized Ethernet frame c6f96070 vs c6f96070.
eth1: Oversized Ethernet frame spanned multiple buffers, entry 0x8 length 0 
sta!eth1: Oversized Ethernet frame c6f96080 vs c6f96080.
eth1: Oversized Ethernet frame spanned multiple buffers, entry 0x9 length 
1518 !eth1: Oversized Ethernet frame c6f96090 vs c6f96090.
Scheduling in interrupt

After this its dead.  

Here is some info on the boot and other stuff that might help.

PCI: PCI BIOS revision 2.10 entry at 0xfb520, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
matroxfb: Matrox Millennium G400 MAX (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x26208)
matroxfb: framebuffer at 0xE8000000, mapped to 0xc8805000, size 33554432
Console: switching to colour frame buffer device 80x30
fb0: MATROX VGA frame buffer device

and a bit later (note: the this is how it appears on the serial console...)

alculating module dependencies... done.
Loading modules: tulip Note: /etc/modulLinux Tulip driver version 0.9.13b 
(Janu)es.conf is more PCI: Found IRQ 12 for device 00:09.0
:C0ent than /libeth0: Digital DS21140 Tulip rev 34 at 0xe800,/modules/2.4.1-a 
0p   :F0:32:30:70, IRQ 12.
eth0:  EEPROM default media type Autosense.
eth0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
eth0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
via-rhine Note: /etc/modulvia-rhine.c:v1.08b-LK1.1.6  8/9/2000  Written by 
Donares.conf is more   http://www.scyld.com/network/via-rhine.html
recent than /libPCI: Found IRQ 11 for device 00:0a.0
/modules/2.4.1-aIRQ routing conflict in pirq table for device 00:0a.0
eth1: VIA VT3043 Rhine at 0xec00,
                                  00:80:c8:f9:ee:ba, IRQ 9.
eth1: MII PHY found at address 8, status 0x782d advertising 05e1 Link 0000.
linear Note: /etc/modulmd driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
es.conf is more md.c: sizeof(mdp_super_t) = 4096
recent than /lib/modules/2.4.1-alinear personality registered
c3+/modules.dep

NOTE the message about a routing conflict of device 00:0a.0 

eth1 is used to run pppoeoscar# 

ifconfig eth1
eth1      Link encap:Ethernet  HWaddr 00:80:C8:F9:EE:BA
          UP BROADCAST RUNNING NOARP MULTICAST  MTU:1500  Metric:1
          RX packets:2057 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2007 errors:0 dropped:0 overruns:0 carrier:0
          collisions:2 txqueuelen:100
          Interrupt:9 Base address:0xec00

oscar# ifconfig ppp0
ppp0      Link encap:Point-to-Point Protocol
          inet addr:64.229.192.179  P-t-P:64.229.192.1  Mask:255.255.255.255
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1492  Metric:1
          RX packets:2116 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2063 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:3

oscar% cat interrupts
           CPU0
  0:     116087          XT-PIC  timer
  1:       1910          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:        835          XT-PIC  serial
  5:      34255          XT-PIC  Sound Blaster 16
  7:          0          XT-PIC  serial
  9:       3554          XT-PIC  eth1
 10:      10857          XT-PIC  usb-uhci
 11:          0          XT-PIC  mga@PCI:1:0:0
 12:       2339          XT-PIC  eth0
 14:      12146          XT-PIC  ide0
 15:          2          XT-PIC  ide1
NMI:          0
ERR:          0

lspci -vvxxx
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR+
	Latency: 16
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1
00: 06 11 98 05 06 00 90 82 04 00 00 06 00 10 00 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 80 0a 85 50 00 00 00 00 18 00 00 00 08 10 10 10
60: 0c 0a 00 23 ee e4 ee 00 01 00 65 01 60 21 00 00
70: c1 08 ec 01 00 80 40 00 00 00 00 00 00 00 80 40
80: 0f 45 00 00 c0 00 00 00 03 00 33 07 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 02 00 10 00 03 02 00 07 01 03 00 00 0a 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 97 05

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x 
AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: e4000000-e7ffffff
	Prefetchable memory behind bridge: e8000000-e9ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: 06 11 98 85 07 00 20 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 d0 d0 00 00
20: 00 e4 f0 e7 00 e8 f0 e9 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00
40: e0 ec 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo 
VP] (rev 47)
	Subsystem: VIA Technologies, Inc. MVP3 ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
00: 06 11 86 05 8f 00 00 02 47 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 01 00 00 00 00 70 a0 01 00 c4 00 00 00 00 f3
50: 24 00 00 00 00 00 bc 90 00 06 f7 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at e000 [size=16]
00: 06 11 71 05 07 00 80 02 06 8a 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 0b e2 09 3a 68 13 c0 00 20 20 20 20 00 00 20 20
50: 03 03 e0 e0 00 00 00 00 a8 a8 a8 a8 00 00 00 00
60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
70: 02 00 00 00 00 00 00 00 82 00 00 00 00 00 00 00
80: 00 90 f8 07 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 06 00 71 05 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02) (prog-if 00 
[UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at e400 [size=32]
00: 06 11 38 30 07 00 00 02 02 00 03 0c 08 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e4 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 04 00 00
40: 00 00 00 00 02 00 36 34 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
00: 06 11 40 30 00 00 80 02 10 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: e0 88 09 00 f8 78 00 06 01 50 00 00 00 00 00 00
50: 0b 1e a0 88 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:09.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 
[FasterNet] (rev 22)
	Subsystem: Kingston Technologies KNE100TX Fast Ethernet
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at e800 [size=128]
	Region 1: Memory at ec001000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at ea000000 [disabled] [size=256K]
00: 11 10 09 00 07 00 80 02 22 00 00 02 08 40 00 00
10: 01 e8 00 00 00 10 00 ec 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 46 26 01 00
30: 00 00 00 ea 00 00 00 00 00 00 00 00 0c 01 14 28
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0a.0 Ethernet controller: VIA Technologies, Inc. VT86C100A [Rhine 10/100] 
(rev 06)
	Subsystem: D-Link System Inc DFE-530TX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (29500ns min, 38000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at ec00 [size=128]
	Region 1: Memory at ec000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at eb000000 [disabled] [size=64K]
00: 06 11 43 30 07 00 00 02 06 00 00 02 08 40 00 00
10: 01 ec 00 00 00 00 00 ec 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 11 00 14
30: 00 00 00 eb 00 00 00 00 00 00 00 00 09 01 76 98
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 fe 01 fe 01 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 
04) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 32Mb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at e4000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=7 SBA+ AGP+ 64bit- FW- Rate=x1
00: 2b 10 25 05 07 00 90 02 04 00 00 03 08 40 00 00
10: 08 00 00 e8 00 00 00 e4 00 00 00 e5 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 79 21
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 10 20
40: 20 41 57 50 00 3c 00 00 06 ff ff 06 00 00 00 00
50: 00 30 00 01 19 84 9b 01 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 f0 22 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 02 00 20 00 03 02 00 1f 01 03 00 07 00 00 00 00

oscar% cat /proc/ide/via
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.20
South Bridge:                       VIA vt82c586b
Revision:                           ISA 0x47 IDE 0x6
BM-DMA base:                        0xe000
PCI clock:                          33MHz
Master Read  Cycle IRDY:            1ws
Master Write Cycle IRDY:            1ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA      UDMA       PIO       PIO
Address Setup:       30ns      30ns      30ns      30ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns      90ns      90ns      90ns
Data Recovery:       30ns      30ns      30ns      30ns
Cycle Time:          60ns      60ns     120ns     120ns
Transfer Rate:   33.0MB/s  33.0MB/s  16.5MB/s  16.5MB/s

Ed Tomlinson <tomlins@cam.org>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
