Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbTEJSl1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 14:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264469AbTEJSl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 14:41:27 -0400
Received: from qwws.net ([213.133.103.108]:3258 "HELO qwwsII.qwws.net")
	by vger.kernel.org with SMTP id S264434AbTEJSlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 14:41:00 -0400
From: Tom Winkler <tom@qwws.net> (by way of Tom Winkler <tom@qwws.net>)
Reply-To: tom@qwws.net
Subject: [2.5.96] SWSUSP - resume fails
Date: Sat, 10 May 2003 22:54:05 +0200
User-Agent: KMail/1.5.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305102254.05895.tom@qwws.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

[1.] One line summary of the problem:

SWSUSP fails on resume - Kernel BUG in timer.c reported

[2.] Full description of the problem/report:

- SWSUSP fails on resume
- machine becomes totally unuseable
- screen layout and conted gets restored correctly
- terminal switching [Ctrl-Alt Fx] still working but no login possible
- bash session which was open before resume is no longer responsive
- no login from remote machine possible (but machine answers pings)
- ctrl-alt del without effect, machine needs hard reboot

note: I had SWSUSP already working on this machine with kernel 2.4 and the
extra swsusp patch. It was almost stable back then (oops every 5th to 10th
resume).

[4.] Kernel version (from /proc/version):

Linux version 2.5.69 (root@thunder) (gcc version 3.2.3) #6 Sat May 10
 19:15:29 CEST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

ernel BUG at kernel/timer.c:162!
invalid operand: 0000 [#1]
CPU:    0
EIP: 0060:[<c0121fe1>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000001   ebx: d4929000     ecx: c0362d80       edx: cfae40a0
esi: cfafd658   edi: cfafd1c0     ebp: 00000000 esp: cde5be74
ds: 007b        es: 007b       ss: 0068
Stack: d4929000 cfafd000 d4929000 cfafd000 c024a243 cfafd658 cfafd6b0
 c12aec08 cfe75834 cfe75820 c01ea6d6 c12aec00 c01ea80b c12aec00 cfe75820
 cfe757ac cfe757a0 c01ea838 cfe76820 cfe757a0 00000003 00000000 c01ea953
 cfe757a0 Call Trace: [<c024a243>] [<c01ea6d6>] [<c01ea80b>] [<c01ea838>]
 [<c01ea953>] [<c01ea9b5>] [<c022605b>] [<c012eb81>] [<c012ec84>]
 [<c0131105>] [<c0131444>] [<c01166bf>] [<c0135de>] [<c0202753>] [<c0143de>]
 [<c014b3de>] [<c014b4ee>] [<c01091df>]
Code: 0f 0b a2 00 ed 98 31 c0 eb bd 90 8d 74 26 00 83 ec 10 31 c0

>>EIP; c0121fe1 <add_timer+61/70>   <=====
>>
>>ebx; d4929000 <_end+14531c7c/3fc06c7c>
>>ecx; c0362d80 <tvec_bases__per_cpu+0/1008>
>>edx; cfae40a0 <_end+f6ecd1c/3fc06c7c>
>>esi; cfafd658 <_end+f7062d4/3fc06c7c>
>>edi; cfafd1c0 <_end+f705e3c/3fc06c7c>
>>esp; cde5be74 <_end+da64af0/3fc06c7c>

Trace; c024a243 <eepro100_resume+d3/100>
Trace; c01ea6d6 <pci_pm_resume_device+26/30>
Trace; c01ea80b <pci_pm_resume_bus+2b/70>
Trace; c01ea838 <pci_pm_resume_bus+58/70>
Trace; c01ea953 <pci_pm_resume+33/50>
Trace; c01ea9b5 <pci_pm_callback+45/50>
Trace; c022605b <agp_power+1b/30>
Trace; c012eb81 <pm_send+71/a0>
Trace; c012ec84 <pm_send_all+74/b0>
Trace; c0131105 <drivers_resume+35/a0>
Trace; c0131444 <do_magic_resume_2+64/d0>
Trace; c01166bf <do_magic+11f/130>
Trace; 0c0135de Before first symbol
Trace; c0202753 <acpi_system_write_sleep+a6/b8>
Trace; 0c0143de Before first symbol
Trace; c014b3de <vfs_write+be/130>
Trace; c014b4ee <sys_write+3e/60>
Trace; c01091df <syscall_call+7/b>

Code;  c0121fe1 <add_timer+61/70>
00000000 <_EIP>:
Code;  c0121fe1 <add_timer+61/70>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0121fe3 <add_timer+63/70>
   2:   a2 00 ed 98 31            mov    %al,0x3198ed00
Code;  c0121fe8 <add_timer+68/70>
   7:   c0 eb bd                  shr    $0xbd,%bl
Code;  c0121feb <add_timer+6b/70>
   a:   90                        nop
Code;  c0121fec <add_timer+6c/70>
   b:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c0121ff0 <add_timer_on+0/70>
   f:   83 ec 10                  sub    $0x10,%esp
Code;  c0121ff3 <add_timer_on+3/70>
  12:   31 c0                     xor    %eax,%eax


1 error issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the
     problem (if possible)

problem is reproducible on this machine at every resume

[7.] Environment

Debian GNU Linux, SID, gcc 3.2
Sony VAIO FX403 Laptop
intel i815 Chipset using onboard graphics

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 695.761
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
 pat pse36 mmx fxsr sse
bogomips        : 1372.16

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

ioports:

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-10ff : PCI CardBus #02
1400-14ff : PCI CardBus #02
1800-180f : Intel Corp. 82801BAM IDE U100
  1800-1807 : ide0
  1808-180f : ide1
1810-181f : Intel Corp. 82801BA/BAM SMBus
1820-183f : Intel Corp. 82801BA/BAM USB (Hub
  1820-183f : uhci-hcd
1840-187f : Intel Corp. 82801BA/BAM AC'97 Au
1880-18ff : Intel Corp. 82801BA/BAM AC'97 Mo
1c00-1cff : Intel Corp. 82801BA/BAM AC'97 Au
2000-20ff : Intel Corp. 82801BA/BAM AC'97 Mo
2400-241f : Intel Corp. 82801BA/BAM USB (Hub
  2400-241f : uhci-hcd
2800-28ff : PCI CardBus #06
2c00-2cff : PCI CardBus #06
3000-303f : Intel Corp. 82801BA/BAM/CA/CAM E
  3000-303f : eepro100

iomem:
00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0fceffff : System RAM
  00100000-003098e6 : Kernel code
  003098e7-003aaa03 : Kernel data
0fcf0000-0fcfefff : ACPI Tables
0fcff000-0fcfffff : ACPI Non-volatile Storage
0fd00000-0fe7ffff : System RAM
0fe80000-0fffffff : reserved
10000000-10000fff : Ricoh Co Ltd RL5c476 II
10001000-10001fff : Ricoh Co Ltd RL5c476 II (#2)
10400000-107fffff : PCI CardBus #02
10800000-10bfffff : PCI CardBus #02
10c00000-10ffffff : PCI CardBus #06
11000000-113fffff : PCI CardBus #06
f4000000-f407ffff : Intel Corp. 82815 CGC [Chipset G
  f4000000-f407ffff : Intel(R) 815 (Internal Graphics with AGP) Framebuffer
Device
f4100000-f4100fff : Intel Corp. 82801BA/BAM/CA/CAM E
  f4100000-f4100fff : eepro100
f4101000-f41017ff : Texas Instruments TSB43AA22 IEEE-1394
f4104000-f4107fff : Texas Instruments TSB43AA22 IEEE-1394
f8000000-fbffffff : Intel Corp. 82815 CGC [Chipset G
  f8000000-fbffffff : Intel(R) 815 (Internal Graphics with AGP) Framebuffer
Device
ff800000-ffbfffff : reserved
fff00000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory
Controller Hub (rev 11)
        Subsystem: Sony Corporation Vaio PCG-FX403
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Capabilities: [88] #09 [f205]

00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphics
Controller] (rev 11) (prog-if 00 [VGA])
        Subsystem: Sony Corporation Vaio PCG-FX403
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Region 1: Memory at f4000000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 03) (prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: f4100000-f41fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801BAM ISA Bridge (LPC) (rev 03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801BAM IDE U100 (rev 03) (prog-if 80
[Master])
        Subsystem: Sony Corporation Vaio PCG-FX403
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at 1800 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 03)
 (prog-if 00 [UHCI])
        Subsystem: Sony Corporation Vaio PCG-FX403
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at 1820 [size=32]

00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 03)
        Subsystem: Sony Corporation Vaio PCG-FX403
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 9
        Region 4: I/O ports at 1810 [size=16]

00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 03)
 (prog-if 00 [UHCI])
        Subsystem: Sony Corporation Vaio PCG-FX403
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 9
        Region 4: I/O ports at 2400 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio (rev
03)
        Subsystem: Sony Corporation Vaio PCG-FX403
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 9
        Region 0: I/O ports at 1c00 [size=256]
        Region 1: I/O ports at 1840 [size=64]

00:1f.6 Modem: Intel Corp. Intel 537 [82801BA/BAM AC'97 Modem] (rev 03)
(prog-if 00 [Generic])
        Subsystem: Sony Corporation Vaio PCG-FX403
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 9
        Region 0: I/O ports at 2000 [size=256]
        Region 1: I/O ports at 1880 [size=128]

01:00.0 FireWire (IEEE 1394): Texas Instruments TSB43AA22 IEEE-1394
 Controller (PHY/Link Integrated) (rev 02) (prog-if 10 [OHCI])
        Subsystem: Sony Corporation Vaio PCG-FX403
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at f4101000 (32-bit, non-prefetchable) [disabled]
[size=2K]
        Region 1: Memory at f4104000 (32-bit, non-prefetchable) [disabled]
[size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:02.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
        Subsystem: Sony Corporation Vaio PCG-FX403
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00001000-000010ff
        I/O window 1: 00001400-000014ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

01:02.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
        Subsystem: Sony Corporation Vaio PCG-FX403
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin B routed to IRQ 9
        Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=06, subordinate=09, sec-latency=176
        Memory window 0: 10c00000-10fff000 (prefetchable)
        Memory window 1: 11000000-113ff000
        I/O window 0: 00002800-000028ff
        I/O window 1: 00002c00-00002cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

01:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM Ethernet
Controller (rev 03)
        Subsystem: Intel Corp. EtherExpress PRO/100 VE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at f4100000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 3000 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME



If you need any further information please let me know.
I'm not subscribed to LKM so please send CCs to me.

Thanks,
--
Tom Winkler
e-mail: tom@qwws.net

