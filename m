Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319103AbSH1X0q>; Wed, 28 Aug 2002 19:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319106AbSH1X0q>; Wed, 28 Aug 2002 19:26:46 -0400
Received: from mail.smdm.net ([12.33.8.12]:39689 "HELO sonitrol.com")
	by vger.kernel.org with SMTP id <S319103AbSH1X0i>;
	Wed, 28 Aug 2002 19:26:38 -0400
From: "Gene Gomez" <gegomez@tycoint.com>
To: <linux-kernel@vger.kernel.org>
Cc: <neteng@tfssit.com>
Subject: PROBLEM: kjournald
Date: Wed, 28 Aug 2002 16:30:57 -0700
Message-ID: <ECEDKOOBMPNAIMGMBDFGCEFOCCAA.gegomez@tycoint.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a problem report for the kernel.  I'm not certain how to classify it
other than "system failure"...the system just stopped execution.
Hopefully this isn't something strange that Red Hat did to the kernel. :)
If there's something I missed, feel free to rant at me and I'll get any info
you need.  Thanks!

[1.] One line summary of the problem:
System failure/vanilla install
[2.] Full description of the problem/report:
Clean Red Hat installation (no applications have been deployed to it
yet...server deployment was scheduled to start next  week.  Prior to this
event, the server had run for a week with no problems).  Our monitoring
suite noticed it was down.   Ports still appeared to be opened, but after
connecting to them, the session is immediately torn down (we attempted to
connect via SSH and our sessions ended before we got a chance to log
in...they last less than a second).
[3.] Keywords (i.e., modules, networking, kernel):
kernel
[4.] Kernel version (from /proc/version):
[root@lmsapp proc]# cat /proc/version
Linux version 2.4.18-3smp (bhcompile@daffy.perf.redhat.com) (gcc version
2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 SMP  Thu Apr 18 07:27:31 EDT
2002
[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
Aug 28 14:15:30 lmsapp kernel: Assertion failure in
journal_commit_transaction() at commit.c:535: "buffer_jdirty(bh)"
Aug 28 14:15:30 lmsapp kernel: ------------[ cut here ]------------
Aug 28 14:15:30 lmsapp kernel: kernel BUG at commit.c:535!
Aug 28 14:15:30 lmsapp kernel: invalid operand: 0000
Aug 28 14:15:30 lmsapp kernel: autofs tg3 usb-ohci usbcore ext3 jbd aacraid
sd_mod scsi_mod
Aug 28 14:15:30 lmsapp kernel: CPU:    3
Aug 28 14:15:30 lmsapp kernel: EIP:    0010:[<f883d0e4>]    Not tainted
Aug 28 14:15:30 lmsapp kernel: EFLAGS: 00010286
Aug 28 14:15:30 lmsapp kernel:
Aug 28 14:15:30 lmsapp kernel: EIP is at journal_commit_transaction [jbd]
0xb04 (2.4.18-3smp)
Aug 28 14:15:30 lmsapp kernel: eax: 0000001c   ebx: 0000000a   ecx: c02eee60
edx: 0000459f
Aug 28 14:15:30 lmsapp kernel: esi: eb384340   edi: f74ee6e0   ebp: f74e6000
esp: f74e7e78
Aug 28 14:15:30 lmsapp kernel: ds: 0018   es: 0018   ss: 0018
Aug 28 14:15:30 lmsapp kernel: Process kjournald (pid: 19,
stackpage=f74e7000)
Aug 28 14:15:30 lmsapp kernel: Stack: f8843eee 00000217 00000000 00000000
00000fc4 ef8f903c 00000000 f6318720
Aug 28 14:15:30 lmsapp kernel:        c2d8adc0 00001a02 37363534 42413938
46454443 4a494847 ef935420 eb54a780
Aug 28 14:15:30 lmsapp kernel:        ebacfa80 eb54a4e0 f5be4380 f5be45c0
f59ad980 f76320c0 f7628f20 f6d6a800
Aug 28 14:15:30 lmsapp kernel: Call Trace: [<f8843eee>] .rodata.str1.1 [jbd]
0x26e
Aug 28 14:15:30 lmsapp kernel: [<c010758d>] __switch_to [kernel] 0x3d
Aug 28 14:15:30 lmsapp kernel: [<c0119048>] schedule [kernel] 0x348
Aug 28 14:15:30 lmsapp kernel: [<f883f7d6>] kjournald [jbd] 0x136
Aug 28 14:15:30 lmsapp kernel: [<f883f680>] commit_timeout [jbd] 0x0
Aug 28 14:15:30 lmsapp kernel: [<c0107286>] kernel_thread [kernel] 0x26
Aug 28 14:15:30 lmsapp kernel: [<f883f6a0>] kjournald [jbd] 0x0
Aug 28 14:15:30 lmsapp kernel:
Aug 28 14:15:30 lmsapp kernel:
Aug 28 14:15:30 lmsapp kernel: Code: 0f 0b 5a 59 6a 04 8b 44 24 18 50 56 e8
4b f1 ff ff 8d 47 48
[6.] A small shell script or example program which triggers the
     problem (if possible)
NA
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
I don't have this script.
[7.2.] Processor information (from /proc/cpuinfo):
[root@lmsapp proc]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) CPU 2.00GHz
stepping        : 4
cpu MHz         : 1993.631
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2  ss ht tm
bogomips        : 3971.48

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) CPU 2.00GHz
stepping        : 4
cpu MHz         : 1993.631
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2  ss ht tm
bogomips        : 3984.58

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) CPU 2.00GHz
stepping        : 4
cpu MHz         : 1993.631
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2  ss ht tm
bogomips        : 3984.58

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) CPU 2.00GHz
stepping        : 4
cpu MHz         : 1993.631
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2  ss ht tm
bogomips        : 3984.58
[7.3.] Module information (from /proc/modules):
[root@lmsapp proc]# cat /proc/modules
autofs                 12804   0 (autoclean) (unused)
tg3                    45184   1
usb-ohci               21600   0 (unused)
usbcore                77024   1 [usb-ohci]
ext3                   70752   3
jbd                    53632   3 [ext3]
aacraid                28244   4
sd_mod                 12896   8
scsi_mod              112272   2 [aacraid sd_mod]
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
[root@lmsapp proc]# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
08b0-08bf : ServerWorks CSB5 IDE Controller
  08b0-08b7 : ide0
  08b8-08bf : ide1
08c0-08c7 : ServerWorks CSB5 IDE Controller
08c8-08cb : ServerWorks CSB5 IDE Controller
08d0-08d7 : ServerWorks CSB5 IDE Controller
08d8-08db : ServerWorks CSB5 IDE Controller
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #05
  c800-c8ff : Adaptec RAID subsystem HBA (#2)
  cc00-ccff : Adaptec RAID subsystem HBA
e800-e8ff : ATI Technologies Inc Rage XL
ec80-ecbf : Dell Computer Corporation PowerEdge Expandable RAID Controller
3/Di
ece8-ecef : PCI device 1028:000c (Dell Computer Corporation)
ecf4-ecf7 : PCI device 1028:000d (Dell Computer Corporation)
ecf8-ecff : PCI device 1028:000c (Dell Computer Corporation)
[root@lmsapp proc]# cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cc5ff : Extension ROM
000f0000-000fffff : System ROM
00100000-7ffeffff : System RAM
  00100000-002342b0 : Kernel code
  002342b1-00306b3f : Kernel data
7fff0000-7fffebff : ACPI Tables
7fffec00-7fffefff : reserved
f0000000-f7ffffff : Dell Computer Corporation PowerEdge Expandable RAID
Controller 3/Di
fcc00000-fcdfffff : PCI Bus #05
  fccfe000-fccfefff : Adaptec RAID subsystem HBA (#2)
  fccff000-fccfffff : Adaptec RAID subsystem HBA
fcf00000-fcf0ffff : BROADCOM Corporation NetXtreme BCM5701 Gigabit Ethernet
(#2)
  fcf00000-fcf0ffff : tg3
fcf10000-fcf1ffff : BROADCOM Corporation NetXtreme BCM5701 Gigabit Ethernet
  fcf10000-fcf1ffff : tg3
fd000000-fdffffff : ATI Technologies Inc Rage XL
fe100000-fe100fff : ServerWorks OSB4/CSB5 OHCI USB Controller
  fe100000-fe100fff : usb-ohci
fe101000-fe101fff : ATI Technologies Inc Rage XL
fe102000-fe102fff : Dell Computer Corporation PowerEdge Expandable RAID
Controller 3/Di
feb00000-feb7ffff : Dell Computer Corporation PowerEdge Expandable RAID
Controller 3/Di
feb80000-feb80fff : PCI device 1028:000c (Dell Computer Corporation)
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
fff80000-ffffffff : reserved
[7.5.] PCI information ('lspci -vvv' as root)
[root@lmsapp proc]# lspci -vvv
00:00.0 Host bridge: ServerWorks: Unknown device 0012 (rev 13)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:00.1 Host bridge: ServerWorks: Unknown device 0012
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:00.2 Host bridge: ServerWorks: Unknown device 0000
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:04.0 Class ff00: Dell Computer Corporation Embedded Systems Management
Device 4
        Subsystem: Dell Computer Corporation Embedded Systems Management
Device 4
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at feb80000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at ecf8 [size=8]
        Region 2: I/O ports at ece8 [size=8]
        Expansion ROM at fe000000 [disabled] [size=64K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.1 Class ff00: Dell Computer Corporation PowerEdge Expandable RAID
Controller 3/Di
        Subsystem: Dell Computer Corporation PowerEdge Expandable RAID
Controller 3/Di
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 23
        Region 0: Memory at fe102000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at ec80 [size=64]
        Region 2: Memory at feb00000 (32-bit, prefetchable) [size=512K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 Class 0c07: Dell Computer Corporation: Unknown device 000d
        Subsystem: Dell Computer Corporation: Unknown device 000d
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 27
        Region 0: I/O ports at ecf4 [size=4]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
(prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown device 0121
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at e800 [size=256]
        Region 2: Memory at fe101000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Host bridge: ServerWorks CSB5 South Bridge (rev 93)
        Subsystem: ServerWorks CSB5 South Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93) (prog-if 82
[Master PriP])
        Subsystem: ServerWorks CSB5 IDE Controller
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 0: I/O ports at 08c0 [size=8]
        Region 1: I/O ports at 08c8 [size=4]
        Region 2: I/O ports at 08d0 [size=8]
        Region 3: I/O ports at 08d8 [size=4]
        Region 4: I/O ports at 08b0 [size=16]

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 05)
(prog-if 10 [OHCI])
        Subsystem: ServerWorks OSB4/CSB5 USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at fe100000 (32-bit, non-prefetchable) [size=4K]

00:0f.3 ISA bridge: ServerWorks: Unknown device 0225
        Subsystem: ServerWorks: Unknown device 0230
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:10.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=4
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

00:10.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=4
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=4
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=4
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

03:06.0 Ethernet controller: BROADCOM Corporation NetXtreme BCM5701 Gigabit
Ethernet (rev 15)
        Subsystem: Dell Computer Corporation NetXtreme BCM5701 1000BaseTX
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 28
        Region 0: Memory at fcf10000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3
Enable-
                Address: 07f817eecebfec00  Data: ca40

03:08.0 Ethernet controller: BROADCOM Corporation NetXtreme BCM5701 Gigabit
Ethernet (rev 15)
        Subsystem: Dell Computer Corporation NetXtreme BCM5701 1000BaseTX
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 29
        Region 0: Memory at fcf00000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3
Enable-
                Address: 258dd433ff4a5910  Data: 0bd1

04:08.0 PCI bridge: Intel Corp.: Unknown device 0309 (rev 01) (prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 10
        Bus: primary=04, secondary=05, subordinate=05, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fcc00000-fcdfffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

04:08.1 RAID bus controller: Dell Computer Corporation PowerEdge Expandable
RAID Controller 3/Di (rev 01)
        Subsystem: Dell Computer Corporation: Unknown device 0121
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 30
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at fcb00000 [disabled] [size=64K]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

05:06.0 SCSI storage controller: Adaptec RAID subsystem HBA (rev 01)
        Subsystem: Dell Computer Corporation: Unknown device 00c5
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 30
        BIST result: 00
        Region 0: I/O ports at cc00 [size=256]
        Region 1: Memory at fccff000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at fcd00000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

05:06.1 SCSI storage controller: Adaptec RAID subsystem HBA (rev 01)
        Subsystem: Dell Computer Corporation: Unknown device 00c5
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin B routed to IRQ 31
        BIST result: 00
        Region 0: I/O ports at c800 [size=256]
        Region 1: Memory at fccfe000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at fcd00000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
[7.6.] SCSI information (from /proc/scsi/scsi)
[root@lmsapp proc]# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: DELL     Model: PERCRAID RAID5   Rev: 0001
  Type:   Direct-Access                    ANSI SCSI revision: 02
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
NA
[X.] Other notes, patches, fixes, workarounds:
NA



