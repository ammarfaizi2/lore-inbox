Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUDPQ3E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 12:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263334AbUDPQ3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 12:29:03 -0400
Received: from relay1.paracel.com ([192.187.140.8]:11994 "EHLO
	relay.paracel.com") by vger.kernel.org with ESMTP id S263370AbUDPQ20 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 12:28:26 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: PROBLEM: Second processor not responding in 2.4.21 and later
Date: Fri, 16 Apr 2004 08:45:21 -0700
Message-ID: <9D8C1A43309BAD4A9B46071DAF911D9E80B537@exch01.pas.paracel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROBLEM: Second processor not responding in 2.4.21 and later
Thread-Index: AcQjPG8oNwwcthZtQPyZNcSiRqAHCw==
From: "Marc Rieffel" <marc@paracel.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    

The kernel sometimes fails to initialize the second processor in 2.4.21 and later kernels.

[2.] Full description of the problem/report:

I have an 18-node cluster running Rocks 3.1.0, which is based on RHEL 2.1 and uses the 2.4.21-4.0.1.ELsmp kernel.  Each node has dual Intel Xeon processors on Intel motherboards.  I have configured each node to reboot continuously.  Sometimes the nodes fail to initialize the second processor, printing messages like this,

Apr 15 04:14:43 compute-0-14 kernel: Booting processor 1/6 eip 2000
Apr 15 04:14:43 compute-0-14 kernel: Not responding.
Apr 15 04:14:43 compute-0-14 kernel: Error: only one processor found.

Once up, the system behaves as normal, but with only one processor instead of two.

I have rebooted these systems thousands of times over two days.  Most (15) of my nodes have Intel SE7501CW2 motherboards with dual 2.4 GHz Xeon processors.  These nodes exhibit this failure about 2% of the time, but with a wide variation.  Some nodes get it as often as 10% of the time, and others as infrequently as 0.3% of the time, but every node with this motherboard and this kernel has done it at least twice.

One of my nodes has an Intel SE7501CW2 motherboard with dual 2.8 GHz Xeon processors and a different chassis and power supply.  This has about the same failure rate as the 2.4 GHz CW2 nodes.

Two of my nodes have Intel SE7501BR2 motherboards with dual 2.4 GHz Xeon processors.  Neither of these motherboards has ever shown this problem.

I have a separate 8-node cluster running Rocks 2.3.2, which is based on RedHat 7.3 and uses the 2.4.18-27.7.xsmp kernel.  This has nodes that are identical to the 15 nodes in the first cluster -- Intel SE7501CW2 motherboards with dual 2.4 GHz Xeons.  None of the nodes in this configuration has ever failed to initialize a processor.

I ran one of these nodes with a custom-build 2.4.25 kernel, and it exhibited about the same failure rate as the CW2's running 2.4.21.

This evidence seems to suggest that a bug was introduced in the linux kernel sometime between 2.4.18 and 2.4.21, and that this bug only exhibits itself infrequently and only on the CW2 motherboard (not the BR2).

[3.] Keywords (i.e., modules, networking, kernel):

SMP, Intel, Xeon, processor, initialization, booting

[4.] Kernel version (from /proc/version):

Linux version 2.4.21-4.0.1.ELsmp (root@compute-0-1.local) (gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-20)) #1 SMP Sat Nov 29 04:15:49 GMT 2003

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

No oops

[6.] A small shell script or example program which triggers the
     problem (if possible)

/etc/rc3.d/S99testandboot:
grep -c Xeon /proc/cpuinfo >> /tmp/logfile
reboot


[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

[root@localhost linux-2.4]# sh ./scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux localhost.local 2.4.21-4.0.1.ELsmp #1 SMP Sat Nov 29 04:15:49 GMT 2003 i686 i686 i386 GNU/Linux

Gnu C                  3.2.3
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
modutils               2.4.25
e2fsprogs              1.32
jfsutils               1.1.2
pcmcia-cs              3.1.31
PPP                    2.4.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.13
Net-tools              1.60
Kbd                    1.08
Sh-utils               4.5.3
Modules Loaded         nfsd lockd sunrpc autofs e1000 e100 ipt_state iptable_filter ipt_MASQUERADE iptable_nat ip_conntrack ip_tables microcode pvfs ide-scsi scsi_mod ide-cd cdrom keybdev mousedev hid input usb-uhci usbcore

[7.2.] Processor information (from /proc/cpuinfo):

[root@localhost linux-2.4]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 5
cpu MHz         : 2392.067
cache size      : 512 KB
physical id     : 0
siblings        : 1
runqueue        : 0
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4771.02

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 5
cpu MHz         : 2392.067
cache size      : 512 KB
physical id     : 3
siblings        : 1
runqueue        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4771.02

[7.3.] Module information (from /proc/modules):

[root@localhost linux-2.4]# cat /proc/modules
nfsd                   86992   8 (autoclean)
lockd                  60656   1 (autoclean) [nfsd]
sunrpc                 92124   1 (autoclean) [nfsd lockd]
autofs                 13780   1 (autoclean)
e1000                  72320   1
e100                   59140   1
ipt_state               1080   1 (autoclean)
iptable_filter          2444   1 (autoclean)
ipt_MASQUERADE          2424   1 (autoclean)
iptable_nat            22968   1 (autoclean) [ipt_MASQUERADE]
ip_conntrack           29928   2 (autoclean) [ipt_state ipt_MASQUERADE iptable_nat]
ip_tables              16544   6 [ipt_state iptable_filter ipt_MASQUERADE iptable_nat]
microcode               5248   0 (autoclean)
pvfs                   52692   2
ide-scsi               12368   0
scsi_mod              117032   1 [ide-scsi]
ide-cd                 35776   0
cdrom                  34176   0 [ide-cd]
keybdev                 2976   0 (unused)
mousedev                5688   0 (unused)
hid                    22436   0 (unused)
input                   6208   0 [keybdev mousedev hid]
usb-uhci               27532   0 (unused)
usbcore                83168   1 [hid usb-uhci]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

[root@localhost linux-2.4]# cat /proc/ioports /proc/iomem
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
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1100-111f : Intel Corp. 82801CA/CAM SMBus Controller
6c00-6c1f : Intel Corp. 82801CA/CAM USB (Hub #1)
  6c00-6c1f : usb-uhci
6c20-6c3f : Intel Corp. 82801CA/CAM USB (Hub #2)
  6c20-6c3f : usb-uhci
6c40-6c5f : Intel Corp. 82801CA/CAM USB (Hub #3)
  6c40-6c5f : usb-uhci
6c60-6c6f : Intel Corp. 82801CA Ultra ATA Storage Controller
  6c60-6c67 : ide0
  6c68-6c6f : ide1
7000-70ff : ATI Technologies Inc Rage XL
7400-743f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  7400-743f : e100
7440-747f : Intel Corp. 82540EM Gigabit Ethernet Controller
  7440-747f : e1000
00000000-0009b7ff : System RAM
0009b800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c97ff : Extension ROM
000ca000-000cbfff : reserved
000f0000-000fffff : System ROM
00100000-7feeffff : System RAM
  00100000-002a4ede : Kernel code
  002a4edf-003ee987 : Kernel data
7fef0000-7fefbfff : ACPI Tables
7fefc000-7fefffff : ACPI Non-volatile Storage
7ff00000-7ff7ffff : System RAM
7ff80000-7fffffff : reserved
80000000-800003ff : Intel Corp. 82801CA Ultra ATA Storage Controller
fc100000-fc1fffff : PCI Bus #01
  fc100000-fc100fff : Intel Corp. 82870P2 P64H2 I/OxAPIC
  fc101000-fc101fff : Intel Corp. 82870P2 P64H2 I/OxAPIC (#2)
fc200000-fc21ffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  fc200000-fc21ffff : e100
fc220000-fc23ffff : Intel Corp. 82540EM Gigabit Ethernet Controller
  fc220000-fc23ffff : e1000
fc240000-fc240fff : ATI Technologies Inc Rage XL
fc241000-fc241fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  fc241000-fc241fff : e100
fd000000-fdffffff : ATI Technologies Inc Rage XL
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
ff800000-ffbfffff : reserved
fff00000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

[root@localhost linux-2.4]# lspci -vvv
00:00.0 Host bridge: Intel Corp. E7501 Memory Controller Hub (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [40] #09 [1105]

00:00.1 Class ff00: Intel Corp. E7000 Series Host RASUM Controller (rev 01)
        Subsystem: Intel Corp.: Unknown device 3425
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:02.0 PCI bridge: Intel Corp. E7000 Series Hub Interface B PCI-to-PCI Bridge (rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=01, subordinate=03, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fc100000-fc1fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:02.1 Class ff00: Intel Corp. E7000 Series Hub Interface B RASUM Controller (rev 01)
        Subsystem: Intel Corp.: Unknown device 3425
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 3425
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at 6c00 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 3425
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at 6c20 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 3425
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 4: I/O ports at 6c40 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 42) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
        I/O behind bridge: 00007000-00007fff
        Memory behind bridge: fc200000-fdffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801CA LPC Interface Controller (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801CA Ultra ATA Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Intel Corp.: Unknown device 3425
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 6c60 [size=16]
        Region 5: Memory at 80000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller (rev 02)
        Subsystem: Intel Corp.: Unknown device 3425
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 0
        Region 4: I/O ports at 1100 [size=32]

01:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 [IO(X)-APIC])
        Subsystem: Intel Corp.: Unknown device 3425
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fc100000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
01:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 40, cache line size 10
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort+ >Reset- FastB2B-
        Capabilities: [50] PCI-X non-bridge device.
                Command: DPERE+ ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
01:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 [IO(X)-APIC])
        Subsystem: Intel Corp.: Unknown device 3425
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fc101000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
01:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 40, cache line size 10
        Bus: primary=01, secondary=03, subordinate=03, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort+ >Reset- FastB2B-
        Capabilities: [50] PCI-X non-bridge device.
                Command: DPERE+ ERO+ RBC=0 OST=4
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
04:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
        Subsystem: Intel Corp.: Unknown device 3425
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at 7000 [size=256]
        Region 2: Memory at fc240000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

04:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
        Subsystem: Intel Corp.: Unknown device 3425
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at fc241000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 7400 [size=64]
        Region 2: Memory at fc200000 (32-bit, non-prefetchable) [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

04:05.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
        Subsystem: Intel Corp.: Unknown device 3425
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 52 (63750ns min), cache line size 08
        Interrupt: pin A routed to IRQ 23
        Region 0: Memory at fc220000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at 7440 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000


[7.6.] SCSI information (from /proc/scsi/scsi)

[root@localhost linux-2.4]# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SONY     Model: CD-RW  CRX225E   Rev: QYB2
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

