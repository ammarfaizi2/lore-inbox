Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932782AbVLJLlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932782AbVLJLlP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 06:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932784AbVLJLlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 06:41:15 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:28914 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S932782AbVLJLlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 06:41:15 -0500
From: "ph0x" <ph0x@freequest.net>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: bug in e1000 module causes very high CPU load
Date: Sat, 10 Dec 2005 12:41:03 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Thread-Index: AcX9fpcst1UGnM1fTwOEmi4QrR3BEA==
Message-Id: <20051210114100.QFYF676.mxfep01.bredband.com@ph0x>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem: bug in e1000 (ksoftirqd eats all CPU)
[2.] Full description of the problem/report: 

After a while of using the network (uptime is 15 days now..) it suddenly
goes below expected performance. Even tho the utilization of the network is
2-3MiB/s the CPU load gets unrealisticly high (1.0 - 8.0 in l/a) and the
system is very unresponsive via ssh. When freshly rebooted, I'm able to get
18-19MiB/s without noticing any lag on ssh. Files have been transferred by
FTP and samba, still the same result. Kernel is freshly compiled
(http://www.ph0x.org/kernel.config, generated today) and I noticed this
issue with 2.6.11.2 aswell. 

eth0 is a D-Link DFL-530TX (via_rhine) and has no problems using the full
100Mbit/s, but the Intel PRO/1000S has problems using over 10Mbit/s. It's
not related to the computer I transfer to/from, because I've got a gigabit
laptop aswell which can output much traffic without getting this high load.


[3.] Keywords (i.e., modules, networking, kernel):

Seems to be related to networking.

[4.] Kernel version (from /proc/version):
Linux version 2.6.14.2 (root@orion) (gcc version 3.3.4) #1 Sun Nov 20
22:44:30 CET 2005

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

Sorry, not possible

[6.] A small shell script or example program which triggers the
     problem (if possible)

Not possible,

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

ph0x@orion:/usr/src/linux$ scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux orion 2.6.14.2 #1 Sun Nov 20 22:44:30 CET 2005 i686 unknown unknown
GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12a
mount                  2.12a
module-init-tools      3.0
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.6
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   026
Modules Loaded         w83781d hwmon_vid i2c_isa ipt_MASQUERADE ipt_limit
iptable_nat ip_nat ipt_LOG iptable_mangle ipt_state ip_conntrack
iptable_filter ip_tables md5 ipv6 e1000 i2c_viapro i2c_core af_packet
via_rhine

[7.2.] Processor information (from /proc/cpuinfo):

ph0x@orion:/usr/src/linux$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 7
model name      : AMD Duron(TM)Processor
stepping        : 1
cpu MHz         : 1300.669
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 2601.95


[7.3.] Module information (from /proc/modules):

ph0x@orion:/usr/src/linux$ cat /proc/modules
w83781d 30884 0 - Live 0xe08ec000
hwmon_vid 2048 1 w83781d, Live 0xe089a000
i2c_isa 3392 1 w83781d, Live 0xe0859000
ipt_MASQUERADE 2560 1 - Live 0xe08ab000
ipt_limit 1920 9 - Live 0xe0898000
iptable_nat 6724 1 - Live 0xe085d000
ip_nat 16052 2 ipt_MASQUERADE,iptable_nat, Live 0xe089d000
ipt_LOG 6016 7 - Live 0xe0895000
iptable_mangle 2240 1 - Live 0xe085b000
ipt_state 1536 1 - Live 0xe088d000
ip_conntrack 41808 4 ipt_MASQUERADE,iptable_nat,ip_nat,ipt_state, Live
0xe0866000
iptable_filter 2304 1 - Live 0xe0854000
ip_tables 17984 7
ipt_MASQUERADE,ipt_limit,iptable_nat,ipt_LOG,iptable_mangle,ipt_state,iptabl
e_filter, Live 0xe0860000
md5 3776 1 - Live 0xe0857000
ipv6 236416 48 - Live 0xe0926000
e1000 101300 0 - Live 0xe0873000
i2c_viapro 6736 0 - Live 0xe0851000
i2c_core 17296 3 w83781d,i2c_isa,i2c_viapro, Live 0xe0845000
af_packet 16584 2 - Live 0xe084b000
via_rhine 19716 0 - Live 0xe083f000


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

ph0x@orion:/usr/src/linux$ cat /proc/ioports; cat /proc/iomem
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0290-0291 : pnp 00:02
0370-0373 : pnp 00:02
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
b400-b41f : 0000:00:11.3
  b400-b41f : uhci_hcd
b800-b81f : 0000:00:11.2
  b800-b81f : uhci_hcd
d000-d00f : 0000:00:11.1
  d000-d007 : ide0
  d008-d00f : ide1
d400-d43f : 0000:00:0e.0
  d400-d43f : e1000
d800-d8ff : 0000:00:0d.0
  d800-d8ff : via-rhine
e400-e47f : motherboard
  e400-e403 : PM1a_EVT_BLK
  e404-e405 : PM1a_CNT_BLK
  e408-e40b : PM_TMR
  e420-e423 : GPE0_BLK
e800-e80f : motherboard
  e800-e80f : pnp 00:02
    e800-e807 : viapro-smbus
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1ffebfff : System RAM
  00100000-0033906b : Kernel code
  0033906c-003e81a3 : Kernel data
1ffec000-1ffeefff : ACPI Tables
1ffef000-1fffefff : reserved
1ffff000-1fffffff : ACPI Non-volatile Storage
30000000-3001ffff : 0000:00:0e.0
30020000-3002ffff : 0000:00:0d.0
f7000000-f701ffff : 0000:00:0e.0
  f7000000-f701ffff : e1000
f7800000-f781ffff : 0000:00:0e.0
  f7800000-f781ffff : e1000
f8000000-f80000ff : 0000:00:0d.0
  f8000000-f80000ff : via-rhine
f8800000-f9dfffff : PCI Bus #01
  f8800000-f8ffffff : 0000:01:00.0
  f9000000-f9003fff : 0000:01:00.0
f9f00000-fcffffff : PCI Bus #01
  f9ff0000-f9ffffff : 0000:01:00.0
  fa000000-fbffffff : 0000:01:00.0
fd000000-fdffffff : 0000:00:00.0
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

ph0x@orion:/usr/src/linux$ sudo /sbin/lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
        Subsystem: Asustek Computer, Inc. A7V266-E Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fd000000 (32-bit, prefetchable) [size=16M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333
AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f8800000-f9dfffff
        Prefetchable memory behind bridge: f9f00000-fcffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev
43)
        Subsystem: D-Link System Inc DFE-530TX rev A
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d800 [size=256]
        Region 1: Memory at f8000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at 30020000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Ethernet controller: Intel Corp.: Unknown device 107c (rev 05)
        Subsystem: Intel Corp.: Unknown device 1376
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f7800000 (32-bit, non-prefetchable) [size=128K]
        Region 1: Memory at f7000000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at d400 [size=64]
        Expansion ROM at 30000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
        Subsystem: Asustek Computer, Inc.: Unknown device 8052
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at d000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller]
(rev 23) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 12
        Region 4: I/O ports at b800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller]
(rev 23) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 12
        Region 4: I/O ports at b400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev
04) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 32Mb
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fa000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at f9000000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at f8800000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at f9ff0000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW-
Rate=x1


[7.6.] SCSI information (from /proc/scsi/scsi)

No SCSI installed, hence this message ;-)
ph0x@orion:/usr/src/linux$ cat /proc/scsi/scsi
cat: /proc/scsi/scsi: No such file or directory


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

A reboot fixes this issue, and after 10-15 days it starts again.


Please CC all your answers to me, since I'm not a subscriber to the LKML.

Best regards,
Andreas Paulsson

