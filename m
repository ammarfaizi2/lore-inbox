Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSFDOSY>; Tue, 4 Jun 2002 10:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311871AbSFDOSX>; Tue, 4 Jun 2002 10:18:23 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:50449 "HELO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with SMTP
	id <S311752AbSFDOSV> convert rfc822-to-8bit; Tue, 4 Jun 2002 10:18:21 -0400
Date: Tue, 4 Jun 2002 16:18:17 +0200 (CEST)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
X-X-Sender: moffe@grignard
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Failure report: tulip driver
Message-ID: <Pine.LNX.4.44.0206041555020.1201-100000@grignard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

tulip.o gives transmit timeouts and a reboot is needed.

[2.] Full description of the problem/report:

Under high network load, the tulip driver sometimes gives transmit
timeouts. After this, the transmit timeouts continues and makes
networking dog slow. A reboot is needed to correct the problem -
neither mii-tool nor mii-diag will fix the problem (the driver is
compiled-in - not as a module).

[3.] Keywords (i.e., modules, networking, kernel):

networking, drivers, tulip.o

[4.] Kernel version (from /proc/version):

Linux version 2.4.19-pre8 (root@freke) (gcc version 2.95.2 20000220
(Debian GNU/Linux)) #1 man maj 6 10:42:42 CEST 2002

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

Jun  3 23:03:03 freke kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jun  3 23:03:03 freke kernel: eth0: 21140 transmit timed out, status fc740000, SIA ffffff5e 00000000 00000000 00000000, resetting...
Jun  3 23:03:03 freke kernel: eth0: transmit timed out, switching to 100baseTx-FDX media.
Jun  3 23:03:11 freke kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jun  3 23:03:11 freke kernel: eth0: 21140 transmit timed out, status fc740000, SIA ffffff5e 00000000 00000000 00000000, resetting...
Jun  3 23:03:11 freke kernel: eth0: transmit timed out, switching to MII media.
Jun  3 23:03:19 freke kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jun  3 23:03:55 freke last message repeated 4 times
<continuing until reboot>

[6.] A small shell script or example program which triggers the
     problem (if possible)

None; the problem seems to arise under network load. There is no special
pattern; it can arise when doing udp traffic over the DSL router
(384kbit), but 8Mb/s file transfers can go well - as well as crash the
NIC.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux freke 2.4.19-pre8 #1 man maj 6 10:42:42 CEST 2002 i586 unknown

Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.9.5.0.37
util-linux             2.10s
mount                  2.10s
modutils               2.4.15
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.1.3
ldd: version 1.9.11
Procps                 2.0.6
Net-tools              1.60
Kbd                    [muligheder...]
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 334.104
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips        : 666.82

[7.3.] Module information (from /proc/modules):

nls_iso8859-1           2844   2 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  cc00-ccff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
d400-d4ff : Davicom Semiconductor, Inc. Ethernet 100/10 MBit (#2)
  d400-d4ff : tulip
d880-d8ff : Aztech System Ltd 3328 Audio
dc00-dcff : Davicom Semiconductor, Inc. Ethernet 100/10 MBit
  dc00-dcff : tulip
df00-df3f : Aztech System Ltd 3328 Audio
df80-df9f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  df80-df9f : eepro100
dfa8-dfaf : Aztech System Ltd 3328 Audio
dfe4-dfe7 : Aztech System Ltd 3328 Audio
dff0-dff7 : Aztech System Ltd 3328 Audio
ffa0-ffaf : Acer Laboratories Inc. [ALi] M5229 IDE
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-03ffffff : System RAM
  00100000-00224295 : Kernel code
  00224296-0027b833 : Kernel data
cd900000-cf9fffff : PCI Bus #01
  ce000000-ceffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
  cf9ff000-cf9fffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
dfe00000-dfefffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
dfffee00-dfffeeff : Davicom Semiconductor, Inc. Ethernet 100/10 MBit
(#2)
  dfffee00-dfffeeff : tulip
dfffef00-dfffefff : Davicom Semiconductor, Inc. Ethernet 100/10 MBit
  dfffef00-dfffefff : tulip
dffff000-dfffffff : Acer Laboratories Inc. [ALi] USB 1.1 Controller
e0000000-e3ffffff : Acer Laboratories Inc. [ALi] M1541
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ff900000-ff9fffff : PCI Bus #01
ffafd000-ffafdfff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  ffafd000-ffafdfff : eepro100
fffe0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
        Subsystem: Acer Laboratories Inc. [ALi]: Unknown device 1541
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR+ <PERR-
        Latency: 64 set
        Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [b0] AGP version 1.0
                Status: RQ=27 SBA+ 64bit- FW- Rate=21
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: cd900000-cf9fffff
        Prefetchable memory behind bridge: ff900000-ff9fffff
        BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 80 max, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at dffff000 (32-bit, non-prefetchable) [size=4K]

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev c3)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 0 set

00:0e.0 Ethernet controller: Davicom Semiconductor, Inc. Ethernet 100/10 MBit (rev 31)
        Subsystem: Unknown device 3030:5032
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 20 min, 40 max, 64 set
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at dc00 [size=256]
        Region 1: Memory at dfffef00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at dff80000 [disabled] [size=256K]
        Capabilities: [50] Power Management version 1
                Flags: PMEClk- AuxPwr+ DSI+ D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1) (prog-if fa)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 2 min, 4 max, 32 set
        Interrupt: pin A routed to IRQ 14
        Region 4: I/O ports at ffa0 [size=16]

00:10.0 Multimedia audio controller: Aztech System Ltd 3328 Audio (rev 10)
        Subsystem: Aztech System Ltd: Unknown device 1801
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 2 min, 96 max, 64 set
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at d880 [size=128]
        Region 1: I/O ports at dff0 [size=8]
        Region 2: I/O ports at dfe4 [size=4]
        Region 3: I/O ports at dfa8 [size=8]
        Region 4: I/O ports at df00 [size=64]
        Capabilities: [80] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2+ PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: Davicom Semiconductor, Inc. Ethernet 100/10 MBit (rev 31)
        Subsystem: Unknown device 3030:5032
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 20 min, 40 max, 64 set
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d400 [size=256]
        Region 1: Memory at dfffee00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at dff40000 [disabled] [size=256K]
        Capabilities: [50] Power Management version 1
                Flags: PMEClk- AuxPwr+ DSI+ D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:14.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 56 max, 64 set
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ffafd000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at df80 [size=32]
        Region 2: Memory at dfe00000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at dfd00000 [disabled] [size=1M]

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X (rev 5c) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0084
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 64 set, cache line size 08
        Region 0: Memory at ce000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at cc00 [size=256]
        Region 2: Memory at cf9ff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at cf9c0000 [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0
                Status: RQ=255 SBA+ 64bit- FW- Rate=21
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=

[7.6.] SCSI information (from /proc/scsi/scsi)

No scsi.

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

The box is a firewall with iptables running proxy arp between eth0
(DMZ), eth1 (WAN) and eth2 (LAN). eth2 is an eepro100 card which gives
no problems; both eth0 and eth1 (both using tulip.o) gives the problem.
eth0 is connected to a Linux box with a 3com 3C905C with a crossover
cable (full dulpex). eth1 is connected to a Cisco 677 - here the problem
arises with both full and half dulpex. Cisco's documentation claims that
the router is running half duplex, but autonegotiation gives 100mbit
full duplex - forcing 100mbit half duplex does not help.

Running debian potato; upgraded with latest upgrades. Extra packages
from:

deb http://www.fs.tum.de/~bunk/debian potato main
deb-src http://www.fs.tum.de/~bunk/debian potato main

for iptables (1.2.2-1.bunk), ext3-aware e2fsprogs etc.

2.4.18 had the same problems.

[X.] Other notes, patches, fixes, workarounds:

Regards and TIA
/Rasmus Bøg Hansen

-- 
-- [ Rasmus "Møffe" Bøg Hansen ] ---------------------------------------
He who asks a question is a fool for five minutes; he who does not ask a
question remains a fool forever.
----------------------------------[ moffe at amagerkollegiet dot dk ] --

