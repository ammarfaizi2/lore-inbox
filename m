Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263130AbUDZMg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbUDZMg6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 08:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUDZMg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 08:36:57 -0400
Received: from web41205.mail.yahoo.com ([66.218.93.38]:24728 "HELO
	web41205.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263130AbUDZMek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 08:34:40 -0400
Message-ID: <20040426123433.48970.qmail@web41205.mail.yahoo.com>
Date: Mon, 26 Apr 2004 05:34:33 -0700 (PDT)
From: Pierre Berthier <berthierp@yahoo.com>
Subject: PROBLEM: memory managment bug in kernel >= 2.4.23
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux kernel people,

a bug report concerning memory managment (?).  I did not subscribe to the list,
please CC me.

Pierre


[1.] One line summary of the problem:    

every two minutes a "__alloc_pages: 0-order allocation failed (gfp=0x21/0)"
message.

[2.] Full description of the problem/report:

After ~5 days of running without problem, the kernel begins to print the
following message, exactly twice every two minutes (see section 7.7 for a
sample):

kernel: __alloc_pages: 0-order allocation failed (gfp=0x21/0)

During this, the machine works as good as usually, and finally after ~ 1.5
days, hangs.  The problem arises using kernel from 2.4.23 to 2.4.26.  No
problems with kernel 2.4.21 (uptime up to 100+ days).  I did not try 2.4.22.


[3.] Keywords (i.e., modules, networking, kernel):

kernel, memory managment

[4.] Kernel version (from /proc/version):

Linux version 2.4.26-1 (root@zooblythii) (gcc version 2.95.3 20010315
(release)) #1 SMP Mon Apr 19 11:06:23 CEST 2004

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

[6.] A small shell script or example program which triggers the
     problem (if possible)

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux zooblythii 2.4.26-1 #1 SMP Mon Apr 19 11:06:23 CEST 2004 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.6
e2fsprogs              1.34
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 3.1.13
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         nfs i2c-proc i2c-core appletalk nfsd lockd sunrpc
ipt_state ipt_LOG ipt_limit iptable_nat iptable_filter ip_conntrack_ftp
ip_conntrack ip_tables binfmt_misc binfmt_aout bcm5700 lp parport_pc parport
rtc


[7.2.] Processor information (from /proc/cpuinfo):

# cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 7
cpu MHz         : 2791.038
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5570.56

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 7
cpu MHz         : 2791.038
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5570.56



[7.3.] Module information (from /proc/modules):
# cat /proc/modules 
nfs                    68016   1 (autoclean)
i2c-proc                6016   0
i2c-core               14832   0 [i2c-proc]
appletalk              23088  13
nfsd                   67632 200
lockd                  48416   1 [nfs nfsd]
sunrpc                 67808   1 [nfs nfsd lockd]
ipt_state                608 194 (autoclean)
ipt_LOG                 3376   6 (autoclean)
ipt_limit               1072   7 (autoclean)
iptable_nat            17616   1 (autoclean)
iptable_filter          1760   1 (autoclean)
ip_conntrack_ftp        3936   0 (unused)
ip_conntrack           21840   1 [ipt_state iptable_nat ip_conntrack_ftp]
ip_tables              12192   7 [ipt_state ipt_LOG ipt_limit iptable_nat
iptable_filter]
binfmt_misc             5952   1
binfmt_aout             4064   0
bcm5700                88912   2
lp                      6208   0 (unused)
parport_pc             11984   1
parport                15360   1 [lp parport_pc]
rtc                     6720   0 (autoclean)


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)


# cat /proc/ioports 
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial(auto)
0378-037a : parport0
03a0-03af : Intel Corp. 82801CA Ultra ATA Storage Controller
  03a0-03a7 : ide0
  03a8-03af : ide1
03c0-03df : vga+
03f8-03ff : serial(auto)
0580-059f : Intel Corp. 82801CA/CAM SMBus Controller
0cf8-0cff : PCI conf1
1000-10ff : ATI Technologies Inc Rage XL
1400-14ff : Adaptec AHA-7850
2000-2fff : PCI Bus #02
  2000-2fff : PCI Bus #04
    2000-203f : Intel Corp. 82546EB Gigabit Ethernet Controller (Copper) (#2)
    2040-207f : Intel Corp. 82546EB Gigabit Ethernet Controller (Copper)
3000-301f : Intel Corp. 82801CA/CAM USB (Hub #3)
3020-303f : Intel Corp. 82801CA/CAM USB (Hub #2)
3040-305f : Intel Corp. 82801CA/CAM USB (Hub #1)

# cat /proc/iomem   
00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c97ff : Extension ROM
000c9800-000cafff : Extension ROM
000cb000-000cfbff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-0025755a : Kernel code
  0025755b-002f6bff : Kernel data
3fff0000-3fffefff : ACPI Tables
3ffff000-3fffffff : ACPI Non-volatile Storage
40000000-400003ff : Intel Corp. 82801CA Ultra ATA Storage Controller
fc7f0000-fc7f3fff : ICP Vortex Computersysteme GmbH GDT 6113RS/6513RS
fd000000-fdffffff : ATI Technologies Inc Rage XL
fe5f0000-fe5f0fff : ATI Technologies Inc Rage XL
fe6f0000-fe6f0fff : Adaptec AHA-7850
  fe6f0000-fe6f0fff : aic7xxx
fe900000-febfffff : PCI Bus #02
  fe900000-fe9fffff : PCI Bus #03
    fe9f0000-fe9fffff : Broadcom Corporation NetXtreme BCM5701 Gigabit Ethernet
(#2)
      fe9f0000-fe9fffff : bcm5700
  fea00000-feafffff : PCI Bus #04
    fea60000-fea7ffff : Intel Corp. 82546EB Gigabit Ethernet Controller
(Copper)
    fea80000-fea9ffff : Intel Corp. 82546EB Gigabit Ethernet Controller
(Copper) (#2)
    feaf0000-feafffff : Broadcom Corporation NetXtreme BCM5701 Gigabit Ethernet
      feaf0000-feafffff : bcm5700
  febe0000-febe0fff : Intel Corp. 82870P2 P64H2 I/OxAPIC
  febf0000-febf0fff : Intel Corp. 82870P2 P64H2 I/OxAPIC (#2)
fec00000-fecfffff : reserved
fee00000-fee00fff : reserved
fff00000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation: Unknown device 254c (rev 01)
	Subsystem: Intel Corporation: Unknown device 3424
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping-
SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [40] #09 [1105]

00:00.1 Class ff00: Intel Corporation: Unknown device 2541 (rev 01)
	Subsystem: Intel Corporation: Unknown device 3424
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-

00:03.0 PCI bridge: Intel Corporation: Unknown device 2545 (rev 01) (prog-if 00
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=02, subordinate=04, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: fe900000-febfffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:03.1 Class ff00: Intel Corporation: Unknown device 2546 (rev 01)
	Subsystem: Intel Corporation: Unknown device 3424
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-

00:1d.0 USB Controller: Intel Corporation: Unknown device 2482 (rev 02)
(prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 3424
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at 3040 [size=32]

00:1d.1 USB Controller: Intel Corporation: Unknown device 2484 (rev 02)
(prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 3424
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at 3020 [size=32]

00:1d.2 USB Controller: Intel Corporation: Unknown device 2487 (rev 02)
(prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 3424
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at 3000 [size=32]

00:1e.0 PCI bridge: Intel Corporation: Unknown device 244e (rev 42) (prog-if 00
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping-
SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: fc800000-fe8fffff
	Prefetchable memory behind bridge: fc700000-fc7fffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation: Unknown device 2480 (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr+ Stepping-
SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corporation: Unknown device 248b (rev 02) (prog-if
8a [Master SecP PriP])
	Subsystem: Intel Corporation: Unknown device 3424
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 03a0 [size=16]
	Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corporation: Unknown device 2483 (rev 02)
	Subsystem: Intel Corporation: Unknown device 3424
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at 0580 [size=32]

01:09.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
	Subsystem: Adaptec AHA-2904/Integrated AIC-7850
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 1000ns max), cache line size 10
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 1400 [disabled] [size=256]
	Region 1: Memory at fe6f0000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0a.0 SCSI storage controller: ICP Vortex Computersysteme GmbH: Unknown
device 0136
	Subsystem: ICP Vortex Computersysteme GmbH: Unknown device 0136
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fc7f0000 (32-bit, prefetchable) [size=16K]
	Expansion ROM at fe6e8000 [disabled] [size=32K]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0c.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
(prog-if 00 [VGA])
	Subsystem: Intel Corporation: Unknown device 3424
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 1000 [size=256]
	Region 2: Memory at fe5f0000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at fe5c0000 [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:1c.0 PIC: Intel Corporation: Unknown device 1461 (rev 04) (prog-if 20
[IO(X)-APIC])
	Subsystem: Intel Corporation: Unknown device 3424
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at febe0000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] #07 [0000]

02:1d.0 PCI bridge: Intel Corporation: Unknown device 1460 (rev 04) (prog-if 00
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping-
SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Bus: primary=02, secondary=04, subordinate=04, sec-latency=64
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: fea00000-feafffff
	Prefetchable memory behind bridge: fffffffffff00000-0000000000000000
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort+ >Reset- FastB2B-
	Capabilities: [50] #07 [0083]

02:1e.0 PIC: Intel Corporation: Unknown device 1461 (rev 04) (prog-if 20
[IO(X)-APIC])
	Subsystem: Intel Corporation: Unknown device 3424
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at febf0000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] #07 [0000]

02:1f.0 PCI bridge: Intel Corporation: Unknown device 1460 (rev 04) (prog-if 00
[Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping-
SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fe900000-fe9fffff
	Prefetchable memory behind bridge: fffffffffff00000-0000000000000000
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort+ >Reset- FastB2B-
	Capabilities: [50] #07 [0083]

03:02.0 Ethernet controller: BROADCOM Corporation: Unknown device 1645 (rev 15)
	Subsystem: 3Com Corporation: Unknown device 1006
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (16000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 24
	Region 0: Memory at fe9f0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] #07 [0000]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: ebbf7d179cd35fb4  Data: 3cd6

04:02.0 Ethernet controller: BROADCOM Corporation: Unknown device 1645 (rev 15)
	Subsystem: 3Com Corporation: Unknown device 1006
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (16000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 52
	Region 0: Memory at feaf0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] #07 [0000]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: c4fffdf3289bb5d8  Data: 9e47

04:05.0 Ethernet controller: Intel Corporation: Unknown device 1010 (rev 01)
	Subsystem: Intel Corporation: Unknown device 3424
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 10
	Interrupt: pin A routed to IRQ 58
	Region 0: Memory at fea60000 (64-bit, non-prefetchable) [size=128K]
	Region 4: I/O ports at 2040 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk+ DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] #07 [0002]
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

04:05.1 Ethernet controller: Intel Corporation: Unknown device 1010 (rev 01)
	Subsystem: Intel Corporation: Unknown device 3424
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 10
	Interrupt: pin B routed to IRQ 59
	Region 0: Memory at fea80000 (64-bit, non-prefetchable) [size=128K]
	Region 4: I/O ports at 2000 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk+ DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] #07 [0002]
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000




[7.6.] SCSI information (from /proc/scsi/scsi)

# cat /proc/scsi/scsi
Attached devices: 
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-40TS   Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ICP      Model: Host Drive  #00  Rev:     
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 03 Lun: 00
  Vendor: ICP      Model: Host Drive  #03  Rev:     
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor: ICP      Model: Host Drive  #05  Rev:     
  Type:   Direct-Access                    ANSI SCSI revision: 02



[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

serie of messages:

Apr 24 02:18:02 zooblythii kernel: __alloc_pages: 0-order allocation failed
(gfp=0x21/0)
Apr 24 02:18:02 zooblythii kernel: __alloc_pages: 0-order allocation failed
(gfp=0x21/0)
Apr 24 02:20:04 zooblythii kernel: __alloc_pages: 0-order allocation failed
(gfp=0x21/0)
Apr 24 02:20:04 zooblythii kernel: __alloc_pages: 0-order allocation failed
(gfp=0x21/0)
Apr 24 02:22:02 zooblythii kernel: __alloc_pages: 0-order allocation failed
(gfp=0x21/0)
Apr 24 02:22:02 zooblythii kernel: __alloc_pages: 0-order allocation failed
(gfp=0x21/0)
Apr 24 02:24:02 zooblythii last message repeated 2 times
Apr 24 02:26:02 zooblythii kernel: __alloc_pages: 0-order allocation failed
(gfp=0x21/0)
Apr 24 02:26:02 zooblythii kernel: __alloc_pages: 0-order allocation failed
(gfp=0x21/0)
Apr 24 02:28:02 zooblythii kernel: __alloc_pages: 0-order allocation failed
(gfp=0x21/0)
Apr 24 02:28:02 zooblythii kernel: __alloc_pages: 0-order allocation failed
(gfp=0x21/0)
Apr 24 02:30:03 zooblythii last message repeated 2 times
Apr 24 02:32:02 zooblythii kernel: __alloc_pages: 0-order allocation failed
(gfp=0x21/0)
Apr 24 02:32:02 zooblythii kernel: __alloc_pages: 0-order allocation failed
(gfp=0x21/0)
Apr 24 02:34:02 zooblythii last message repeated 2 times
Apr 24 02:36:02 zooblythii kernel: __alloc_pages: 0-order allocation failed
(gfp=0x21/0)
Apr 24 02:36:02 zooblythii kernel: __alloc_pages: 0-order allocation failed
(gfp=0x21/0)
Apr 24 02:38:02 zooblythii kernel: __alloc_pages: 0-order allocation failed
(gfp=0x21/0)
Apr 24 02:38:02 zooblythii kernel: __alloc_pages: 0-order allocation failed
(gfp=0x21/0)
Apr 24 02:38:02 zooblythii kernel: __alloc_pages: 0-order allocation failed
(gfp=0x21/0)
Apr 24 02:40:03 zooblythii kernel: __alloc_pages: 0-order allocation failed
(gfp=0x21/0)
Apr 24 02:40:03 zooblythii kernel: __alloc_pages: 0-order allocation failed
(gfp=0x21/0)
...



# cat /proc/swaps 
Filename                        Type            Size    Used    Priority
/dev/sda2                       partition       265064  0       4
/dev/sdb1                       partition       2097136 2056    64


# cat /usr/src/linux/.config
#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_HIGHIO=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_NR_CPUS=32
# CONFIG_X86_NUMA is not set
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=y
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
# CONFIG_OOM_KILLER is not set
# CONFIG_PM is not set
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# ACPI Support
#
# CONFIG_ACPI is not set
CONFIG_ACPI_BOOT=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_IP22 is not set
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play configuration
#
CONFIG_PNP=y
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_STATS is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
# CONFIG_IP_PIMSM_V1 is not set
# CONFIG_IP_PIMSM_V2 is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_TFTP is not set
CONFIG_IP_NF_IRC=m
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
# CONFIG_IP_NF_MATCH_RECENT is not set
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
# CONFIG_IP_NF_MATCH_UNCLEAN is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
# CONFIG_IP_NF_TARGET_MIRROR is not set
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_LOCAL=y
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
# CONFIG_IP_NF_TARGET_ULOG is not set
CONFIG_IP_NF_TARGET_TCPMSS=m
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set

#
#   IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set

#
#    SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
#  
#
CONFIG_IPX=m
CONFIG_IPX_INTERN=y
CONFIG_ATALK=m

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
CONFIG_BLK_DEV_RZ1000=y
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_ATARAID is not set

#
# SCSI support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_DEBUG_QUEUES=y
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
CONFIG_SCSI_AIC79XX=y
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
# CONFIG_AIC79XX_ENABLE_RD_STRM is not set
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
CONFIG_SCSI_DPT_I2O=m
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_MEGARAID2 is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
CONFIG_SCSI_GDTH=y
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
CONFIG_VORTEX=m
# CONFIG_TYPHOON is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=m
# CONFIG_E1000_NAPI is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PLIP=m
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPPOE is not set
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_INPUT_SERIO is not set

#
# Joysticks
#
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_SCx200 is not set
# CONFIG_AMD_RNG is not set
CONFIG_INTEL_RNG=m
# CONFIG_HW_RANDOM is not set
# CONFIG_AMD_PM768 is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=m
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
# CONFIG_AGP_AMD_K8 is not set
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_ATI is not set

#
# Direct Rendering Manager (XFree86 DRI support)
#
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_OBMOUSE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=y
# CONFIG_QFMT_V2 is not set
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
# CONFIG_REISERFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
# CONFIG_FAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_TMPFS is not set
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
CONFIG_MINIX_FS=y
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_XFS_FS is not set

#
# Network File Systems
#
CONFIG_CODA_FS=m
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_SMB_UNIX=y
# CONFIG_NCP_FS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_OHCI=m
# CONFIG_USB_SL811HS_ALT is not set
# CONFIG_USB_SL811HS is not set

#
# USB Device Class drivers
#
# CONFIG_USB_BLUETOOTH is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
# CONFIG_USB_HIDINPUT is not set
# CONFIG_USB_HIDDEV is not set
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set

#
# USB Imaging devices
#
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#

#
#   Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set

#
# Support for USB gadgets
#
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_LOG_BUF_SHIFT=0

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
# CONFIG_FW_LOADER is not set







[X.] Other notes, patches, fixes, workarounds:




=====
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Pierre Berthier
Computational and Molecular Population Genetics
Zoologisches Institut, Universität Bern, Baltzerstrasse 6, 3012 Bern
Switzerland 
Tel: +41 31 631 30 28  Fax: +41 31 631 31 88
http://cmpg.unibe.ch/people/berthier.htm
