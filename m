Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266975AbRGKXsR>; Wed, 11 Jul 2001 19:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267004AbRGKXr7>; Wed, 11 Jul 2001 19:47:59 -0400
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:12294 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S266975AbRGKXrq>; Wed, 11 Jul 2001 19:47:46 -0400
Message-ID: <3B4CE432.44DA91A6@cornils.org>
Date: Thu, 12 Jul 2001 01:41:38 +0200
From: Malte Cornils <malte@cornils.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Once again an eth0: transmit timeout problem, with 8319too
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I originally posted a similar bug report under
http://sourceforge.net/tracker/
index.php?func=detail&aid=440357&group_id=3242&atid=103242

but as I guess that this list is a much more appropriate place for
it, here it goes, slightly modified:

---cut---
Hello, 

I've tried reading LKML archives etc for this problem 
and the advice usually is "fixed in the latest kernel 
versions". So I've tried 2.2.18 (not with the 8139too 
driver but Don Becker's, which is IIRC actually known 
to have this bug) and the 8139too driver with 2.4.0 
upwards to 2.4.6 and 2.4.6ac2. 

After bootup, if I do something network-wise which takes up more 
bandwidth than ICQ and IRC, soon I get in the syslog: 

      NETDEV WATCHDOG: eth0: transmit timed out 
      eth0: Tx queue start entry 4346 dirty entry 4342. 
      eth0: Tx descriptor 0 is 00002000. 
      eth0: Tx descriptor 1 is 00002000. 
      eth0: Tx descriptor 2 is 00002000. (queue head) 
      eth0: Tx descriptor 3 is 00002000. 
      eth0: Setting half-duplex based on auto-negotiated 
      partner ability 0000. 

and this makes the network stop for a few seconds 
before the Watchdog resets the ethernet card and makes 
it work again, dropping my download throughput from 
approx. 400 kB/s to 10 kB/s. Ugh. 

I've also tried just setting the #define RTL8139_DEBUG 
1, at least in the more up-to-date 0.9.18 (without the pre4) from
Jeff Garzik's Sourceforge project site, but this gave very strange 
results (like the driver displaying it had 100Mpbs and Full Duplex,
while the card's connected to a normal 10 Mbit hub (which I guess
can
only handle half-duplex!?)

OK, without having enabled debug info I'll also attach 
the lspci -vvv and the rtl8139diag output as indicated in the
8139too.c
source file.

If you need further information, please do Cc: me as I'm not on this
list,
and while I'll check the archive answers will be faster with a Cc.
I'll answer almost everything (because I tried switching 
motherboards, processors, a new RTL8319C, network 
cables... and I always got the same error. Argh. It 
also happened on my old SuSE distro as it does now on 
Debian unstable. It's probably some kind of "user too dumb" error
:-(

So, now the output of lspci -vvv: 

                 wh36-b407:/home/mcornils/8139too-0.9.18# lspci -vvv 
                 00:00.0 Host bridge: VIA Technologies, Inc.
VT8363/8365 
                 [KT133/KM133] (rev 03) 
                 Subsystem: Elitegroup Computer Systems: Unknown 
                 device 0987 
                 Control: I/O- Mem+ BusMaster+ SpecCycle- 
                 MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- 
                 Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- 
                 DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR-
<PERR- 
                 Latency: 32 
                 Region 0: Memory at d0000000 (32-bit, 
                 prefetchable) [size=64M] 
                 Capabilities: [a0] AGP version 2.0 
                 Status: RQ=31 SBA+ 64bit- FW- 
                 Rate=x1,x2 
                 Command: RQ=0 SBA- AGP- 64bit- FW- 
                 Rate=<none> 
                 Capabilities: [c0] Power Management version 2 
                 Flags: PMEClk- DSI- D1- D2- 
                 AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) 
                 Status: D0 PME-Enable- DSel=0 DScale=0 
                 PME- 

                 00:01.0 PCI bridge: VIA Technologies, Inc.
VT8363/8365 
                 [KT133/KM133 AGP] (prog-if 00 [Normal decode]) 
                 Control: I/O+ Mem+ BusMaster+ SpecCycle- 
                 MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- 
                 Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- 
                 DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR-
<PERR- 
                 Latency: 0 
                 Bus: primary=00, secondary=01, subordinate=01, 
                 sec-latency=0 
                 I/O behind bridge: 0000f000-00000fff 
                 Memory behind bridge: fff00000-000fffff 
                 Prefetchable memory behind bridge: 
                 fff00000-000fffff 
                 BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- 
                 >Reset- FastB2B- 
                 Capabilities: [80] Power Management version 2 
                 Flags: PMEClk- DSI- D1+ D2- 
                 AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) 
                 Status: D0 PME-Enable- DSel=0 DScale=0 
                 PME- 

                 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 
                 [Apollo Super South] (rev 40) 
                 Subsystem: VIA Technologies, Inc. VT82C686/A 
                 PCI to ISA Bridge 
                 Control: I/O+ Mem+ BusMaster+ SpecCycle- 
                 MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B- 
                 Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- 
                 DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR- 
                 Latency: 0 
                 Capabilities: [c0] Power Management version 2 
                 Flags: PMEClk- DSI- D1- D2- 
                 AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) 
                 Status: D0 PME-Enable- DSel=0 DScale=0 
                 PME- 

                 00:07.1 IDE interface: VIA Technologies, Inc. Bus 
                 Master IDE (rev 06) (prog-if 8a [Master SecP PriP]) 
                 Subsystem: VIA Technologies, Inc. Bus Master 
                 IDE 
                 Control: I/O+ Mem+ BusMaster+ SpecCycle- 
                 MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- 
                 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- 
                 DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR- 
                 Latency: 32 
                 Region 4: I/O ports at c000 [size=16] 
                 Capabilities: [c0] Power Management version 2 
                 Flags: PMEClk- DSI- D1- D2- 
                 AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) 
                 Status: D0 PME-Enable- DSel=0 DScale=0 
                 PME- 

                 00:07.4 Host bridge: VIA Technologies, Inc.
VT82C686 
                 [Apollo Super ACPI] (rev 40) 
                 Subsystem: Elitegroup Computer Systems: Unknown 
                 device 0987 
                 Control: I/O- Mem- BusMaster- SpecCycle- 
                 MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- 
                 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- 
                 DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR- 
                 Interrupt: pin ? routed to IRQ 5 
                 Capabilities: [68] Power Management version 2 
                 Flags: PMEClk- DSI- D1- D2- 
                 AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) 
                 Status: D0 PME-Enable- DSel=0 DScale=0 
                 PME- 

                 00:07.5 Multimedia audio controller: VIA
Technologies, 
                 Inc. AC97 Audio Controller (rev 50) 
                 Subsystem: Elitegroup Computer Systems: Unknown 
                 device 0987 
                 Control: I/O+ Mem- BusMaster- SpecCycle- 
                 MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- 
                 Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- 
                 DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR- 
                 Interrupt: pin C routed to IRQ 10 
                 Region 0: I/O ports at cc00 [size=256] 
                 Region 1: I/O ports at d000 [size=4] 
                 Region 2: I/O ports at d400 [size=4] 
                 Capabilities: [c0] Power Management version 2 
                 Flags: PMEClk- DSI- D1- D2- 
                 AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) 
                 Status: D0 PME-Enable- DSel=0 DScale=0 
                 PME- 

                 00:0a.0 Ethernet controller: Realtek Semiconductor
Co., 
                 Ltd. RTL-8139 (rev 10) 
                 Subsystem: Realtek Semiconductor Co., Ltd. 
                 RT8139 
                 Control: I/O+ Mem+ BusMaster+ SpecCycle- 
                 MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- 
                 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- 
                 DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR- 
                 Latency: 32 (8000ns min, 16000ns max) 
                 Interrupt: pin A routed to IRQ 11 
                 Region 0: I/O ports at dc00 [size=256] 
                 Region 1: Memory at d6001000 (32-bit, 
                 non-prefetchable) [size=256] 
                 Capabilities: [50] Power Management version 2 
                 Flags: PMEClk- DSI- D1+ D2+ 
                 AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+) 
                 Status: D0 PME-Enable- DSel=0 DScale=0 
                 PME- 

                 00:0b.0 VGA compatible controller: ATI Technologies
Inc 
                 3D Rage LT Pro (rev dc) (prog-if 00 [VGA]) 
                 Subsystem: ATI Technologies Inc: Unknown device 
                 0044 
                 Control: I/O+ Mem+ BusMaster+ SpecCycle- 
                 MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B- 
                 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- 
                 DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR- 
                 Latency: 32 (2000ns min), cache line size 08 
                 Interrupt: pin A routed to IRQ 10 
                 Region 0: Memory at d4000000 (32-bit, 
                 non-prefetchable) [size=16M] 
                 Region 1: I/O ports at e000 [size=256] 
                 Region 2: Memory at d6000000 (32-bit, 
                 non-prefetchable) [size=4K] 
                 Expansion ROM at <unassigned> [disabled] 
                 [size=128K] 
                 Capabilities: [5c] Power Management version 1 
                 Flags: PMEClk- DSI- D1+ D2+ 
                 AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-) 
                 Status: D0 PME-Enable- DSel=0 DScale=0 
                 PME- 

                 00:0c.0 Multimedia video controller: Brooktree 
                 Corporation Bt878 (rev 02) 
                 Subsystem: Hauppauge computer works Inc. 
                 WinTV/GO 
                 Control: I/O- Mem+ BusMaster+ SpecCycle- 
                 MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- 
                 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- 
                 DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR- 
                 Latency: 32 (4000ns min, 10000ns max) 
                 Interrupt: pin A routed to IRQ 12 
                 Region 0: Memory at d6002000 (32-bit, 
                 prefetchable) [size=4K] 

                 00:0c.1 Multimedia controller: Brooktree
Corporation 
                 Bt878 (rev 02) 
                 Subsystem: Hauppauge computer works Inc. 
                 WinTV/GO 
                 Control: I/O- Mem+ BusMaster+ SpecCycle- 
                 MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- 
                 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- 
                 DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR- 
                 Latency: 32 (1000ns min, 63750ns max) 
                 Interrupt: pin A routed to IRQ 12 
                 Region 0: Memory at d6003000 (32-bit, 
                 prefetchable) [size=4K] 

and now the rtl-8319-diag-output (unfortunately it was 
impossible to time this so that the output is from the 
exact moment where it resets the card): 

                 rtl8139-diag.c:v2.01 1/8/2001 Donald Becker 
                 (becker@scyld.com) 
                 http://www.scyld.com/diag/index.html 
                 Index #1: Found a RealTek RTL8139 adapter at
0xdc00. 
                 RealTek chip registers at 0xdc00 
                 0x000: 767de000 0000f63d 80000000 00000000 080825ea 
                 9708a5ea 9108a5ea 9408a5ea 
                 0x020: 0f52c000 0f52c600 0f52cc00 0f52d200 0de50000 
                 0d0a0000 45784568 2000c07f 
                 0x040: 78000600 0e00f78e 30482234 00000000 004d10c6 
                 00000000 0080c108 00100000 
                 0x060: 1000e00f 05e1782d 00000000 00000000 00000005 
                 000007c0 58fab388 a438d843. 
                 No interrupt sources are pending. 
                 (null) indication. 
                 The chip configuration is 0x10 0x4d, MII
full-duplex 
                 mode. 
                 EEPROM size test returned 6, 0x204a4 / 0x2. 
                 Parsing the EEPROM of a RealTek chip: 
                 PCI IDs -- Vendor 0x10ec, Device 0x8139, Subsystem 
                 0x10ec. 
                 PCI timer settings -- minimum grant 32, maximum 
                 latency 64. 
                 General purpose pins -- direction 0xe1 value 0x10. 
                 Station Address 00:E0:7D:76:3D:F6. 
                 Configuration register 0/1 -- 0x4d / 0xc2. 
                 EEPROM active region checksum is 0a83. 
                 EEPROM contents: 
                 8129 10ec 8139 10ec 8139 4020 e110 e000 
                 767d f63d 4d10 f7c2 8001 b388 58fa 0708 
                 d843 a438 d843 a438 d843 a438 d843 a438 
                 0000 0000 0000 0000 0000 0000 0000 0000 
                 0000 0000 0000 0000 0000 0000 0000 0000 
                 0000 0000 0000 0000 0000 0000 0000 0000 
                 0000 0000 0000 0000 0000 0000 0000 0000 
                 0000 0000 0000 0000 0000 0000 0000 0000 
                 The word-wide EEPROM checksum is 0xdda6. 

BTW, why it says full-duplex mode above, I don't know. Especially
since
the output from the mii-diag program says differently:

wh36-b407:/home/mcornils/8139too-0.9.18# ./mii-diag.o
Using the default interface 'eth0'.
Basic registers of MII PHY #32:  0000 0000 0000 0000 0000 0000 0000
0000.
 Basic mode control register 0x0000: Auto-negotiation disabled, with
 Speed fixed at 10 mbps, half-duplex.
 Basic mode status register 0x0000 ... 0000.
   Link status: not established.
 Link partner information information is not exchanged when in fixed
speed mode.wh36-b407:/home/mcornils/8139too-0.9.18#

It would be so cool if you could help me out here :-) 

-Malte #8-)
