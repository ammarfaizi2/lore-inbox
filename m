Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbTLJFbH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 00:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbTLJFbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 00:31:06 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:13391 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S262181AbTLJFaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 00:30:52 -0500
Message-ID: <3FD6AF84.5010805@samwel.tk>
Date: Wed, 10 Dec 2003 06:30:44 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ide-scsi scheduling while atomic in linux-2.6.0-test11
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

ide-scsi scheduling while atomic in linux-2.6.0-test11

[2.] Full description of the problem/report:

ide-scsi gives me "scheduling while atomic" while burning a CDRW in 
linux-2.6.0-test11, when an interrupt is lost. I have no clue what 
caused this; I was writing a CDRW that might have been faulty, but 
otherwise nothing unusual. The CDRW is a Samsung SW-408B on the 
secondary slave. While burning, I was extracting audio data from a CD in 
the DVD player that was on the secondary master.

[3.] Keywords (i.e., modules, networking, kernel):

ide-scsi, cd-writing

[4.] Kernel version (from /proc/version):

Linux version 2.6.0-test11 (root@samwel.tk) (gcc version 3.3.2 (Debian)) 
#6 Sun Nov 30 22:25:31 CET 2003

[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)

Dec  9 22:31:17 samwel kernel: hdd: lost interrupt
Dec  9 22:31:17 samwel kernel: ide-scsi: The scsi wants to send us more 
data than expected - d
iscarding data
Dec  9 22:31:17 samwel kernel: ide-scsi: abort called for 4947
Dec  9 22:31:17 samwel kernel: bad: scheduling while atomic!
Dec  9 22:31:17 samwel kernel: Call Trace:
Dec  9 22:31:17 samwel kernel:  [schedule+1413/1424] schedule+0x585/0x590
Dec  9 22:31:17 samwel kernel:  [poke_blanked_console+107/128] 
poke_blanked_console+0x6b/0x80
Dec  9 22:31:17 samwel kernel:  [vt_console_print+541/768] 
vt_console_print+0x21d/0x300
Dec  9 22:31:17 samwel kernel:  [__down+149/272] __down+0x95/0x110
Dec  9 22:31:17 samwel kernel:  [default_wake_function+0/32] 
default_wake_function+0x0/0x20
Dec  9 22:31:17 samwel kernel:  [__wake_up_common+58/112] 
__wake_up_common+0x3a/0x70
Dec  9 22:31:17 samwel kernel:  [__down_failed+8/12] __down_failed+0x8/0xc
Dec  9 22:31:17 samwel kernel:  [.text.lock.scsi_error+55/73] 
.text.lock.scsi_error+0x37/0x49
Dec  9 22:31:17 samwel kernel:  [scsi_sleep_done+0/32] 
scsi_sleep_done+0x0/0x20
Dec  9 22:31:17 samwel kernel: 
[__crc_xfrm_state_unregister_afinfo+509762/1539753] idescsi_ab
ort+0xd8/0xf0 [ide_scsi]
Dec  9 22:31:17 samwel kernel:  [scsi_try_to_abort_cmd+95/128] 
scsi_try_to_abort_cmd+0x5f/0x80
Dec  9 22:31:17 samwel kernel:  [scsi_eh_abort_cmds+87/240] 
scsi_eh_abort_cmds+0x57/0xf0
Dec  9 22:31:17 samwel kernel:  [__wake_up_locked+33/48] 
__wake_up_locked+0x21/0x30
Dec  9 22:31:17 samwel kernel:  [scsi_unjam_host+176/512] 
scsi_unjam_host+0xb0/0x200
Dec  9 22:31:17 samwel kernel:  [default_wake_function+0/32] 
default_wake_function+0x0/0x20
Dec  9 22:31:17 samwel kernel:  [scsi_error_handler+264/448] 
scsi_error_handler+0x108/0x1c0
Dec  9 22:31:17 samwel kernel:  [scsi_error_handler+0/448] 
scsi_error_handler+0x0/0x1c0
Dec  9 22:31:17 samwel kernel:  [kernel_thread_helper+5/16] 
kernel_thread_helper+0x5/0x10

This output (from "bad: ..." down) repeats a couple of times, at 
intervals of about a second, and then control is returned to cdrecord.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux samwel.tk 2.6.0-test11 #6 Sun Nov 30 22:25:31 CET 2003 i686 GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre4
e2fsprogs              1.35-WIP
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.14
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         nvidia msr microcode dummy

NOTE: this is output from a fixed system in which I removed ide-scsi; in 
the configuration in which this oops occurred ide-scsi was loaded, of 
course.

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 1000.350
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1970.17

[7.3.] Module information (from /proc/modules):

Unfortunately this does not include ide-scsi, because I rebooted since 
the oops.

nvidia 1702604 10 - Live 0xe8b04000
msr 2784 0 - Live 0xe8928000
microcode 6656 0 - Live 0xe8930000
dummy 1956 0 - Live 0xe892a000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

Same problem here.

# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
4000-40ff : 0000:00:07.4
5000-500f : 0000:00:07.4
c000-c00f : 0000:00:07.1
   c000-c007 : ide0
   c008-c00f : ide1
c400-c41f : 0000:00:07.2
   c400-c41f : uhci_hcd
c800-c81f : 0000:00:07.3
   c800-c81f : uhci_hcd
d000-d0ff : 0000:00:0e.0
   d000-d0ff : 8139too
d400-d407 : 0000:00:0f.0
d800-d8ff : 0000:00:0f.0
dc00-dcff : 0000:00:10.0
   dc00-dcff : 8139too
e000-e01f : 0000:00:11.0
   e000-e01f : EMU10K1
e400-e407 : 0000:00:11.1

# cat /proc/iomem

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-27feffff : System RAM
   00100000-0042f54c : Kernel code
   0042f54d-005458ff : Kernel data
27ff0000-27ff2fff : ACPI Non-volatile Storage
27ff3000-27ffffff : ACPI Tables
d0000000-d7ffffff : PCI Bus #01
   d0000000-d7ffffff : 0000:01:00.0
d8000000-dbffffff : 0000:00:00.0
dc000000-ddffffff : PCI Bus #01
   dc000000-dcffffff : 0000:01:00.0
de000000-de0000ff : 0000:00:0e.0
   de000000-de0000ff : 8139too
de001000-de0010ff : 0000:00:0f.0
de002000-de0020ff : 0000:00:10.0
   de002000-de0020ff : 8139too
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo 
PRO133x] (rev c4)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [a0] AGP version 2.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- 
FW- Rate=x2
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo 
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: dc000000-ddffffff
         Prefetchable memory behind bridge: d0000000-d7ffffff
         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 22)
         Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 10) 
(prog-if 8a [Master SecP PriP])
         Subsystem: VIA Technologies, Inc. 
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Region 4: I/O ports at c000 [size=16]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin D routed to IRQ 11
         Region 4: I/O ports at c400 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin D routed to IRQ 11
         Region 4: I/O ports at c800 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
         Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin ? routed to IRQ 9
         Capabilities: [68] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
         Subsystem: Unex Technology Corp. ND010
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (8000ns min, 16000ns max)
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at d000 [size=256]
         Region 1: Memory at de000000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:0f.0 Communication controller: Lucent Microelectronics F-1156IV 
WinModem (V90, 56KFlex) (rev 01)
         Subsystem: Askey Computer Corp. LT WinModem 56k 
Data+Fax+Voice+VoiceView+Dsvd
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (63000ns min, 3500ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at de001000 (32-bit, non-prefetchable) [size=256]
         Region 1: I/O ports at d400 [size=8]
         Region 2: I/O ports at d800 [size=256]
         Capabilities: [f8] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
         Subsystem: Edimax Computer Co.: Unknown device 9503
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (8000ns min, 16000ns max)
         Interrupt: pin A routed to IRQ 5
         Region 0: I/O ports at dc00 [size=256]
         Region 1: Memory at de002000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:11.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
         Subsystem: Creative Labs CT4760 SBLive! OEM version
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (500ns min, 5000ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at e000 [size=32]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 08)
         Subsystem: Creative Labs Gameport Joystick
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Region 0: I/O ports at e400 [size=8]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 
MX/MX 400] (rev a1) (prog-if 00 [VGA])
         Subsystem: PROLINK Microsystems Corp: Unknown device 1081
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 248 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
         Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 2.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2
                 Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- 
FW- Rate=x2

[7.6.] SCSI information (from /proc/scsi/scsi)

Not very useful when I've already removed ide-scsi from the system. :( 
It says no devices are attached. D'oh!

[X.] Other notes, patches, fixes, workarounds:

If you want to know if the ATAPI interface works any better, I'll be 
trying this for now so please mail me if you want to know.

