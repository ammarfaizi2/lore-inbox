Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266286AbUA2SNn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 13:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266253AbUA2SNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 13:13:34 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:64445 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266256AbUA2SLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 13:11:25 -0500
From: tomepperly@comcast.net
To: linux-kernel@vger.kernel.org
Subject: CPU lockup during halt for Shuttle SB61G2 p4 with hyperthreading 2.4.24
Date: Thu, 29 Jan 2004 18:11:24 +0000
Message-Id: <012920041811.27663.702d@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Oct 27 2003)
X-Authenticated-Sender: dG9tZXBwZXJseUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] CPU lockup during halt for Shuttle SB61G2 p4 with hyperthreading

[2.] Full description
I've got a Shuttle SB61G2 purchased 12/31/03 with a 2.6GHz P4 with
hyperthreading. Sometimes when shutting down, I get the "Power down."
message, but it doesn't actually power down the system. It just sits
there indefinitely. I tried enabling nmi_watchdog=1, and I
intermittently get kernel oopses. I only started having problems when I
compiled the kernel with SMP enabled. A non-SMP kernel never locks up.

I transcribed the oops message from my screen and ran ksymoops on it. I
am running a vanilla 2.4.24 downloaded from kernel.org compiled with
gcc-2.95.

Please Cc me on replies as I am not subscribed to linux-kernel.

[3.] Keywords: Lockup SMP
[4.] Linux version 2.4.24-vanilla (root@faerun) (gcc version 2.95.4
20011002 (Debian prerelease)) #3 SMP Fri Jan 16 07:30:34 PST 2004
[5.] 
I had to write this on paper and then type it in by hand. I was very
careful, but transcription errors are always a possibility:
ksymoops 2.4.9 on i686 2.4.24-vanilla.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.24-vanilla/ (default)
     -m /boot/System.map-2.4.24-vanilla (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_system_map stat
/boot/System.map-2.4.24-vanilla failed
ksymoops: No such file or directory
Warning (compare_maps): mismatch on symbol _nv000173rm  , nvidia says
f8e4bb20, /lib/modules/2.4.24-vanilla/kernel/drivers/video/nvidia.o says
f8e4b900.  Ignoring
/lib/modules/2.4.24-vanilla/kernel/drivers/video/nvidia.o entry
NMI Watchdog detected LOCKUP on CPU1, eip c01a6757, registers:
EIP: 0010: [<c01a6757>] Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000046
eax: 00000011 ebx: f7cc9e48 ecx: f7cc9e48 edx: 00000400
esi: 00000010 edi: 00000000 ebp: bffffbc8 esp: f7cc9e08
ds: 0018 es: 0018 ss: 0018
Process halt (pid: 1220, stackpage=f7cc9000)
Stack: 00000018 c01b29cb 00000400 f7cc9e48 00000010 00002001 c02e5e18
00000011
       c02e5e18 c01b26d7 00000010 f7cc9e48 c1c32114 00002001 00000000
00000000
       00000000 c01b24b9 00000000 00000001 f7cc9e68 00002001 c02e5e40
c02e5e40
Call Trace: [<c01b29cb>] [<c01b26d7>] [<c01b24b9>] [<c01b2d5e>]
[<c01c1394>]
 [<c0105523>] [<c012487d>] [<c0122d8a>] [<c0122e11>] [<c01231067>]
[<c01239a5>]
 [<c0141864>] [<c014954d>] [<c0106f27>]
Code: 66 89 01 eb 11 eb 11 8d 74 26 00 ed 89 01 eb 08 0f 0b 4f 01 ec ff


>>EIP; c01a6757 <acpi_os_stall_R__ver_acpi_os_stall+67/17c>   <=====

>>ebx; f7cc9e48 <_end+3794bfe4/385cf1fc>
>>ecx; f7cc9e48 <_end+3794bfe4/385cf1fc>
>>esp; f7cc9e08 <_end+3794bfa4/385cf1fc>

Trace; c01b29cb <acpi_set_register_R__ver_acpi_set_register+4db/6cc>
Trace; c01b26d7 <acpi_set_register_R__ver_acpi_set_register+1e7/6cc>
Trace; c01b24b9 <acpi_get_register_R__ver_acpi_get_register+51/88>
Trace; c01b2d5e
<acpi_enter_sleep_state_R__ver_acpi_enter_sleep_state+1a2/1bc>
Trace; c01c1394
<acpi_pci_irq_enable_R__ver_acpi_pci_irq_enable+bb4/2868>
Trace; c0105523 <machine_power_off+b/314>
Trace; c012487d <unregister_reboot_notifier+365/11a4>
Trace; c0122d8a <dequeue_signal+432/438>
Trace; c0122e11 <send_sig_info+81/98>
Trace; c01231067 <END_OF_CODE+b083c2710/????>
Trace; c01239a5 <notify_parent+685/edc>
Trace; c0141864 <blkdev_put+148/154>
Trace; c014954d <kill_fasync+4f5/528>
Trace; c0106f27 <__read_lock_failed+115f/1520>

Code;  c01a6757 <acpi_os_stall_R__ver_acpi_os_stall+67/17c>
00000000 <_EIP>:
Code;  c01a6757 <acpi_os_stall_R__ver_acpi_os_stall+67/17c>   <=====
   0:   66 89 01                  mov    %ax,(%ecx)   <=====
Code;  c01a675a <acpi_os_stall_R__ver_acpi_os_stall+6a/17c>
   3:   eb 11                     jmp    16 <_EIP+0x16>
Code;  c01a675c <acpi_os_stall_R__ver_acpi_os_stall+6c/17c>
   5:   eb 11                     jmp    18 <_EIP+0x18>
Code;  c01a675e <acpi_os_stall_R__ver_acpi_os_stall+6e/17c>
   7:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c01a6762 <acpi_os_stall_R__ver_acpi_os_stall+72/17c>
   b:   ed                        in     (%dx),%eax
Code;  c01a6763 <acpi_os_stall_R__ver_acpi_os_stall+73/17c>
   c:   89 01                     mov    %eax,(%ecx)
Code;  c01a6765 <acpi_os_stall_R__ver_acpi_os_stall+75/17c>
   e:   eb 08                     jmp    18 <_EIP+0x18>
Code;  c01a6767 <acpi_os_stall_R__ver_acpi_os_stall+77/17c>
  10:   0f 0b                     ud2a   
Code;  c01a6769 <acpi_os_stall_R__ver_acpi_os_stall+79/17c>
  12:   4f                        dec    %edi
Code;  c01a676a <acpi_os_stall_R__ver_acpi_os_stall+7a/17c>
  13:   01 ec                     add    %ebp,%esp
Code;  c01a676c <acpi_os_stall_R__ver_acpi_os_stall+7c/17c>
  15:   ff 00                     incl   (%eax)


2 warnings and 1 error issued.  Results may not be reliable.

[6.]
I booted my machine. gdm (X11) fires up using nVidia drivers. Choose
shutdown from gdm menu. Oops. It happens every once in a while when I
shutdown.
[7.]
[7.1]
faerun:/usr/src/linux-2.4.24# sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
  
Linux faerun 2.4.24-vanilla #3 SMP Fri Jan 16 07:30:34 PST 2004 i686
GNU/Linux
  
Gnu C                  3.3.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
modutils               2.4.26
e2fsprogs              1.35-WIP
PPP                    2.4.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.15
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         nvidia joydev mousedev hid input binfmt_misc uhci
ide-scsi scsi_mod it87 i2c-proc i2c-isa i2c-core v_midi sound i810_audio
ehci-hcd

I used "make CC=gcc-2.95 HOSTCC=gcc-2.95" when compiling the kernel and
its modules.

faerun:/usr/src/linux-2.4.24#
[7.2.]
faerun:/usr/src/linux-2.4.24# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.60GHz
stepping        : 9
cpu MHz         : 2605.987
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5203.55
 
processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.60GHz
stepping        : 9
cpu MHz         : 2605.987
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5203.55

Intel 865G chipset
faerun:/usr/src/linux-2.4.24#
[7.3.]
faerun:/usr/src/linux-2.4.24# cat /proc/modules
nvidia               1969376  14 (autoclean)
joydev                  7104   0 (unused)
mousedev                3864   1
hid                    13864   0 (unused)
input                   3456   0 [joydev mousedev hid]
binfmt_misc             5896   1
uhci                   24752   0 (unused)
ide-scsi                8976   0
scsi_mod               87496   1 [ide-scsi]
it87                    9768   0 (unused)
i2c-proc                5972   0 [it87]
i2c-isa                  788   0 (unused)
i2c-core               14788   0 [it87 i2c-proc i2c-isa]
v_midi                  4996   0 (unused)
sound                  56428   0 [v_midi]
i810_audio             24312   1
ehci-hcd               15880   0 (unused)
faerun:/usr/src/linux-2.4.24#
[7.4.]
faerun:/usr/src/linux-2.4.24# cat /proc/ioports
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
0290-0297 : it87
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0500-051f : Intel Corp. 82801EB SMBus Controller
0cf8-0cff : PCI conf1
9000-90ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  9000-90ff : 8139too
9400-947f : VIA Technologies, Inc. IEEE 1394 Host Controller
a000-a01f : Intel Corp. 82801EB USB
  a000-a01f : usb-uhci
a400-a41f : Intel Corp. 82801EB USB
  a400-a41f : usb-uhci
a800-a81f : Intel Corp. 82801EB USB
  a800-a81f : usb-uhci
ac00-ac1f : Intel Corp. 82801EB USB
  ac00-ac1f : usb-uhci
b400-b4ff : Intel Corp. 82801EB AC'97 Audio Controller
  b400-b4ff : Intel ICH5
b800-b83f : Intel Corp. 82801EB AC'97 Audio Controller
  b800-b83f : Intel ICH5
f000-f00f : Intel Corp. 82801EB Ultra ATA Storage Controller
  f000-f007 : ide0
  f008-f00f : ide1
faerun:/usr/src/linux-2.4.24# cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-00281001 : Kernel code
  00281002-0031e83f : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
40000000-400003ff : Intel Corp. 82801EB Ultra ATA Storage Controller
e8000000-efffffff : PCI Bus #01
  e8000000-efffffff : PCI device 10de:0322 (nVidia Corporation)
f0000000-f3ffffff : Intel Corp. 82865G/PE/P Processor to I/O Controller
f4000000-f5ffffff : PCI Bus #01
  f4000000-f4ffffff : PCI device 10de:0322 (nVidia Corporation)
f7000000-f70000ff : Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+
  f7000000-f70000ff : 8139too
f7001000-f70017ff : VIA Technologies, Inc. IEEE 1394 Host Controller
f8000000-f80003ff : Intel Corp. 82801EB USB2
  f8000000-f80003ff : ehci_hcd
f8001000-f80011ff : Intel Corp. 82801EB AC'97 Audio Controller
  f8001000-f80011ff : ich_audio MMBAR
f8002000-f80020ff : Intel Corp. 82801EB AC'97 Audio Controller
  f8002000-f80020ff : ich_audio MBBAR
fec00000-ffffffff : reserved
faerun:/usr/src/linux-2.4.24#
[7.5.]
faerun:/usr/src/linux-2.4.24# lspci -vvv
00:00.0 Host bridge: Intel Corp. 82865G/PE/P Processor to I/O Controller
(rev 02)
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown
device fb61
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [0106]
        Capabilities: [a0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=2 SBA+ AGP+ GART64- 64bit- FW-
Rate=x8 
00:01.0 PCI bridge: Intel Corp. 82865G/PE/P Processor to AGP Controller
(rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f4000000-f5ffffff
        Prefetchable memory behind bridge: e8000000-efffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
 
00:1d.0 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00
[UHCI])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown
device fb61
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at ac00 [size=32]
 
00:1d.1 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00
[UHCI])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown
device fb61
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at a000 [size=32]
 
00:1d.2 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00
[UHCI])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown
device fb61
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 4: I/O ports at a400 [size=32]
 
00:1d.3 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00
[UHCI])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown
device fb61
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at a800 [size=32]
 
00:1d.7 USB Controller: Intel Corp. 82801EB USB2 (rev 02) (prog-if 20
[EHCI])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown
device fb61
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 23
        Region 0: Memory at f8000000 (32-bit, non-prefetchable)
[size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev c2)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: f6000000-f7ffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
 
00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev
02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
 
00:1f.1 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller
(rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown
device fb61
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at f000 [size=16]
        Region 5: Memory at 40000000 (32-bit, non-prefetchable)
[size=1K]
 
00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown
device fb61
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at 0500 [size=32]
 
00:1f.5 Multimedia audio controller: Intel Corp. 82801EB AC'97 Audio
Controller (rev 02)
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown
device c09d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 17
        Region 0: I/O ports at b400 [size=256]
        Region 1: I/O ports at b800 [size=64]
        Region 2: Memory at f8001000 (32-bit, non-prefetchable)
[size=512]
        Region 3: Memory at f8002000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX
5200] (rev a1) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at f4000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit-
FW- Rate=x8
 
02:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at 9000 [size=256]
        Region 1: Memory at f7000000 (32-bit, non-prefetchable)
[size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
02:08.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 80) (prog-if 10 [OHCI])
        Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at f7001000 (32-bit, non-prefetchable)
[size=2K]
        Region 1: I/O ports at 9400 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
faerun:/usr/src/linux-2.4.24#
[7.6.]
faerun:/usr/src/linux-2.4.24# cat /proc/scsi/scsi
Attached devices: none
[7.7.]
faerun:/usr/src/linux-2.4.24# cat /proc/acpi/info
version:                 20031002
states:                  S0 S1 S4 S5
faerun:/usr/src/linux-2.4.24# cat /proc/acpi/alarm
2004-01-27 11:00:10
