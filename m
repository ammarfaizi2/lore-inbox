Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbTI1RyY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 13:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbTI1RyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 13:54:24 -0400
Received: from vsmtp12.tin.it ([212.216.176.206]:4855 "EHLO vsmtp12.tin.it")
	by vger.kernel.org with ESMTP id S262647AbTI1RyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 13:54:12 -0400
Subject: PPPoE Synchronous mode delivers very much packets errors
From: Marcello <voloterreno@tin.it>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1064771725.2008.6.camel@melchior.magisystem.it>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 28 Sep 2003 19:55:25 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I've tried today to enable the PPP Synchronous mode for my PPPoE
connection , and ifconfig reports a very strange thing:

melchior:/home/melchior# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:40:F4:55:A1:40
          inet addr:192.168.254.1  Bcast:192.168.254.255 
Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:774 errors:0 dropped:0 overruns:0 frame:0
          TX packets:579 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:362290 (353.7 KiB)  TX bytes:51218 (50.0 KiB)
          Interrupt:19 Base address:0x1f00
 
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:80 errors:0 dropped:0 overruns:0 frame:0
          TX packets:80 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:5128 (5.0 KiB)  TX bytes:5128 (5.0 KiB)
 
ppp0      Link encap:Point-to-Point Protocol
          inet addr:80.180.66.58  P-t-P:192.168.100.1 
Mask:255.255.255.255
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1492  Metric:1
          RX packets:189 errors:212 dropped:0 overruns:0 frame:0
          TX packets:129 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:3
          RX bytes:67413 (65.8 KiB)  TX bytes:8740 (8.5 KiB)
 
melchior:/home/melchior#

Look at the ppp0 section , and look at the RX packets area , the
corrupted packages are MORE than the correct packages !! With async mode
this doesn't happen . 
Someone have said me that It could be a kernel bug , is this possible? 

During the connection I don't see any problem , all runs perfectly .

Thank you for your attention :

lsmod

Module                  Size  Used by    Not tainted
ppp_deflate             3448   0  (autoclean)
bsd_comp                4312   0  (autoclean)
ppp_synctty             6208   1  (autoclean)
zlib_inflate           18404   0  (autoclean) [ppp_deflate]
zlib_deflate           18008   0  (autoclean) [ppp_deflate]
af_packet              13352   2  (autoclean)
hdlc                    1608   0  (unused)
syncppp                11120   0  [hdlc]
sunrpc                 67840   0  (unused)
sr_mod                 15704   0  (autoclean)
ext3                   62980   3  (autoclean)
jbd                    41716   3  (autoclean) [ext3]
serial                 48228   0  (autoclean)
n_hdlc                  6720   1
ide-cd                 32096   0
cdrom                  28672   0  [sr_mod ide-cd]
ppp_generic            17412   3  [ppp_deflate bsd_comp ppp_synctty]
slhc                    5440   0  [ppp_generic]
hid                    21572   0  (unused)
ehci-hcd               17260   0  (unused)
thermal                 6308   0  (unused)
processor               8376   0  [thermal]
fan                     1632   0  (unused)
button                  2540   0  (unused)
agpgart                13808   0  (unused)
cmpci                  31492   1
soundcore               3972   4  [cmpci]
evdev                   4640   0  (unused)
mousedev                4180   1
sg                     27644   0  (unused)
ide-scsi               10224   0
ch                     12560   0  (unused)
scsi_mod               57108   4  [sr_mod sg ide-scsi ch]
ip_gre                  9024   0  (unused)
8139too                14952   1
mii                     2464   0  [8139too]
crc32                   2880   0  [8139too]
keybdev                 2084   0  (unused)
input                   3520   0  [hid evdev mousedev keybdev]
usb-uhci               23280   0  (unused)
usbcore                40388   0  [hid ehci-hcd usb-uhci]
unix                   15308 215  (autoclean)
melchior:/home/melchior#


lspci -vvv

melchior:/home/melchior# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host
Bridge
        Subsystem: VIA Technologies, Inc.: Unknown device 0000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit-
FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge (prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: dde00000-dfefffff
        Prefetchable memory behind bridge: d5c00000-ddcfffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 96 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at ec00 [size=256]
        Region 1: Memory at dfffff00 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0c.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
10)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device
5900
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 96 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at e800 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. USB
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 96, cache line size 08
        Interrupt: pin A routed to IRQ 21
        Region 4: I/O ports at e400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if
20 [EHCI])
        Subsystem: VIA Technologies, Inc. USB 2.0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 96, cache line size 10
        Interrupt: pin D routed to IRQ 21
        Region 0: Memory at dffffe00 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
        Subsystem: VIA Technologies, Inc.: Unknown device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. VT8235 Bus Master
ATA133/100/66/33 IDE        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 255
        Region 4: I/O ports at fc00 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
01:00.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3 Ti
200] (rev a3) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 96 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at de000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at d8000000 (32-bit, prefetchable) [size=64M]
        Region 2: Memory at ddc80000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at dfef0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>
 
melchior:/home/melchior#


Thank you

Marcello


