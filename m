Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266523AbRGLTMv>; Thu, 12 Jul 2001 15:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266528AbRGLTMm>; Thu, 12 Jul 2001 15:12:42 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:2579 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S266523AbRGLTMc>; Thu, 12 Jul 2001 15:12:32 -0400
Date: Thu, 12 Jul 2001 21:11:44 +0200 (CEST)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [MINOR PROBLEM] RTL8139C: transmit timed out
Message-ID: <Pine.LNX.4.33.0107122043350.1097-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings

I have a minor problem with an rtl8139 card. Please tell, if you need 
more information - I will try to get it.

[1.] One line summary of the problem:
Transmit times out with RTL8139C at medium load

[2.] Full description of the problem/report: I am running a K6-2 300MHz
with 256Mb RAM and a via-based motherboard.  The box acts as firewall
(iptables) and squid proxy for our 2mbit/2mbit internet connection (280
student apartments). The machine has been running linux 2.4.X since
february. It has two network cards - a D-link DFE-530TX aimed at the
internet cisco router and a RTL8139C aimed at out 100mbit LAN. We have
two logical nets: 172.16.0.0/12 and a routable /27 network.  Boxes on
those two net do not have routing information to contact each other
although they are physically connected, so all cross-net traffic goes
through the firewall. This has given trouble before, but today there
were network outages on the LAN interface of the firewall as two boxes
(one on each subnet) exchanged a large number of data through the
firewall:

Jul 12 20:36:43 wiibroe kernel: NETDEV WATCHDOG: eth0: transmit timed 
out
Jul 12 20:36:43 wiibroe kernel: eth0: Setting 100mbps full-duplex based 
on auto-negotiated partner ability 41e1.
Jul 12 20:36:55 wiibroe kernel: NETDEV WATCHDOG: eth0: transmit timed 
out
Jul 12 20:36:55 wiibroe kernel: eth0: Setting 100mbps full-duplex based 
on auto-negotiated partner ability 41e1.
Jul 12 20:37:19 wiibroe kernel: NETDEV WATCHDOG: eth0: transmit timed 
out
Jul 12 20:37:19 wiibroe kernel: eth0: Setting 100mbps full-duplex based 
on auto-negotiated partner ability 41e1.
Jul 12 20:37:43 wiibroe kernel: NETDEV WATCHDOG: eth0: transmit timed 
out
Jul 12 20:37:43 wiibroe kernel: eth0: Setting 100mbps full-duplex based 
on auto-negotiated partner ability 41e1.
Jul 12 20:38:01 wiibroe kernel: NETDEV WATCHDOG: eth0: transmit timed 
out
Jul 12 20:38:01 wiibroe kernel: eth0: Setting 100mbps full-duplex based 
on auto-negotiated partner ability 41e1.
Jul 12 20:38:13 wiibroe kernel: NETDEV WATCHDOG: eth0: transmit timed 
out
Jul 12 20:38:13 wiibroe kernel: eth0: Setting 100mbps full-duplex based 
on auto-negotiated partner ability 41e1.
Jul 12 20:38:25 wiibroe kernel: NETDEV WATCHDOG: eth0: transmit timed 
out
Jul 12 20:38:25 wiibroe kernel: eth0: Setting 100mbps full-duplex based 
on auto-negotiated partner ability 41e1.
Jul 12 20:39:01 wiibroe kernel: NETDEV WATCHDOG: eth0: transmit timed 
out
Jul 12 20:39:01 wiibroe kernel: eth0: Setting 100mbps full-duplex based 
on auto-negotiated partner ability 41e1.
Jul 12 20:39:43 wiibroe kernel: NETDEV WATCHDOG: eth0: transmit timed 
out
Jul 12 20:39:43 wiibroe kernel: eth0: Setting 100mbps full-duplex based 
on auto-negotiated partner ability 41e1.
Jul 12 20:40:07 wiibroe kernel: NETDEV WATCHDOG: eth0: transmit timed 
out
Jul 12 20:40:07 wiibroe kernel: eth0: Setting 100mbps full-duplex based 
on auto-negotiated partner ability 41e1.

I do not know for sure, but I believe that it was two Windows boxes 
copying large files over NetBIOS. I did not see anymore than this as the 
transmission ended here and everything went back to normal. During the 
transmission, MRTG (via ucd-snmp 4.2) reported 9.5Mb/s outgoing and 
9.5Mb incoming data on the RTL8139 interface. The RTL card is connected 
via a proper cat5 cable to a HP Procurve 9000M switch with a standard 
8port 10/100 module. I have never seen this behaviour before with older 
RTL8139 drivers (this is the one from 2.4.6).
While doing these timeouts it (of course) hangs, but goes back to 
normal shortly after. There was no other special traffic going through 
the box (except for the usual 2x1.3 mbit).

[3.] Keywords (i.e., modules, networking, kernel):
Network driver, rtl8139, networking

[4.] Kernel version (from /proc/version):
Linux version 2.4.6 (root@wiibroe) (gcc version 2.96 20000731 (Red Hat 
Linux 7.1 2.96-85)) #4 ons jul 4 10:27:34 CEST 2001

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
none

[6.] A small shell script or example program which triggers the
     problem (if possible)
none, but as told above copying large files over NetBIOS apparently 
triggered the problem (but someone copied 25 hours ago where no problems 
occured).

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux wiibroe 2.4.6 #4 ons jul 4 10:27:34 CEST 2001 i586 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.0.18
util-linux             2.10s
mount                  2.10r
modutils               2.4.6
e2fsprogs              1.19
reiserfsprogs          3.x.0j
Linux C Library        > libc.2.2
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         via-rhine 8139too

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 299.758
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow 
k6_mtrr
bogomips        : 598.01

[7.3.] Module information (from /proc/modules):
via-rhine              10928   1 (autoclean)
8139too                11680   1 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, 
/proc/iomem)
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0fffffff : System RAM
  00100000-001e3629 : Kernel code
  001e362a-00227fb3 : Kernel data
e0000000-e3ffffff : VIA Technologies, Inc. VT82C598 [Apollo MVP3]
e4000000-e5ffffff : PCI Bus #01
  e5000000-e5000fff : ATI Technologies Inc 3D Rage IIC AGP
e6000000-e6ffffff : PCI Bus #01
  e6000000-e6ffffff : ATI Technologies Inc 3D Rage IIC AGP
e8000000-e800007f : VIA Technologies, Inc. VT86C100A [Rhine 10/100]
  e8000000-e800007f : via-rhine
e8001000-e80010ff : Realtek Semiconductor Co., Ltd. RTL-8139
  e8001000-e80010ff : 8139too
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 
04)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 64
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=7 SBA+ 64bit- FW- Rate=x1
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
 
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo 
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: e4000000-e5ffffff
        Prefetchable memory behind bridge: e6000000-e6ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
 
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA 
[Apollo VP] (rev 41)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
 
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at e000 [size=16]
 
00:07.3 Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
 
00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 
(rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at e8001000 (32-bit, non-prefetchable) 
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:09.0 Ethernet controller: VIA Technologies, Inc. VT86C100A [Rhine 
10/100] (rev 06)
        Subsystem: D-Link System Inc DFE-530TX
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (29500ns min, 38000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at ec00 [size=128]
        Region 1: Memory at e8000000 (32-bit, non-prefetchable) 
[size=128]
        Expansion ROM at e7000000 [disabled] [size=64K]
 
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC AGP 
(rev 3a) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0084
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at e6000000 (32-bit, prefetchable) [size=16M]
        Region 1: I/O ports at d000 [size=256]

[7.6.] SCSI information (from /proc/scsi/scsi)
No SCSI

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
moffe@wiibroe:/usr/src/linux# cat /proc/net/dev
Inter-|   Receive                                                |  
Transmit
 face |bytes    packets errs drop fifo frame compressed multicast|bytes    
packets errs drop fifo colls carrier compressed
    lo:26472090   72241    0    0    0     0          0         0 
26472090   72241    0    0    0     0       0          0
  eth0:1989291108 16987637    0    0    0     0          0         0 
3183711286 16481260    0    0    2     0       0          0
  eth1:1735540413 14577261    0    0    0     0          0         0 
634429559 15585952    2    0    0 618312       0          0

[X.] Other notes, patches, fixes, workarounds:
>From dmesg:

Jul 11 17:40:36 wiibroe kernel: 8139too Fast Ethernet driver 0.9.18-pre4
Jul 11 17:40:36 wiibroe kernel: PCI: Assigned IRQ 11 for device 00:08.0
Jul 11 17:40:36 wiibroe kernel: eth0: RealTek RTL8139 Fast Ethernet at 
0xd0805000, 00:40:95:30:0d:9c, IRQ 11
Jul 11 17:40:36 wiibroe kernel: eth0: Setting 100mbps full-duplex based 
on auto-negotiated partner ability 41e1.

Regards
Rasmus

-- 
-- [ Rasmus 'Møffe' Bøg Hansen ] ---------------------------------------
"Memory is like gasoline. You use it up when you are running. Of 
course you get it all back when you reboot.
                                          -- Microsoft help desk
--------------------------------- [ moffe at amagerkollegiet dot dk ] --

