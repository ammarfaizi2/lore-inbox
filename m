Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262670AbSKZKpH>; Tue, 26 Nov 2002 05:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262937AbSKZKpH>; Tue, 26 Nov 2002 05:45:07 -0500
Received: from mta01bw.bigpond.com ([139.134.6.78]:5877 "EHLO
	mta01bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S262670AbSKZKpC> convert rfc822-to-8bit; Tue, 26 Nov 2002 05:45:02 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.49: kernel BUG at drivers/block/ll_rw_blk.c:1950!
Date: Tue, 26 Nov 2002 22:03:20 +1100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211262203.20088.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
kernel BUG at drivers/block/ll_rw_blk.c:1950!

[2.] Full description of the problem/report:
2.5.49 oops during system boot.

[3.] Keywords (i.e., modules, networking, kernel):
No modules support compiled in the kernel.

[4.] Kernel version (from /proc/version):
Linux version 2.5.49 (hari@localhost.localdomain) (gcc version 3.2 20020903 
(Red Hat Linux 8.0 3.2-7)) #9 Tue Nov 26 20:21:25 EST 2002

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
Nov 26 21:36:54 localhost kernel: kernel BUG at 
drivers/block/ll_rw_blk.c:1950!
Nov 26 21:36:54 localhost kernel: invalid operand: 0000
Nov 26 21:36:54 localhost kernel: CPU:    0
Nov 26 21:36:54 localhost kernel: EIP:    0060:[<c01cb341>]    Not tainted
Nov 26 21:36:54 localhost kernel: EFLAGS: 00010246
Nov 26 21:36:54 localhost kernel: EIP is at submit_bio+0x61/0x70
Nov 26 21:36:54 localhost kernel: eax: 00000000   ebx: 00000000   ecx: 
00000000   edx: df5901c4
Nov 26 21:36:54 localhost kernel: esi: df5901c4   edi: 00000040   ebp: 
00000004   esp: df3a3bfc
Nov 26 21:36:54 localhost kernel: ds: 0068   es: 0068   ss: 0068
Nov 26 21:36:54 localhost kernel: Process rpmq (pid: 161, threadinfo=df3a2000 
task=df500740)
Nov 26 21:36:54 localhost kernel: Stack: df989f08 df5901c4 c01601de 00000000 
df5901c4 00001000 c01603fa 00000000 
Nov 26 21:36:54 localhost kernel:        df5901c4 00001000 00000000 df3a3c28 
00000001 dfd7de14 000045f4 00000004 
Nov 26 21:36:54 localhost kernel:        0000000a df18e780 00000010 0000001f 
c0196523 dffee9bc 00002280 ffffffff 
Nov 26 21:36:54 localhost kernel: Call Trace:
Nov 26 21:36:54 localhost kernel:  [<c01601de>] mpage_bio_submit+0x2e/0x40
Nov 26 21:36:54 localhost kernel:  [<c01603fa>] do_mpage_readpage+0x17a/0x310
Nov 26 21:36:54 localhost kernel:  [<c0196523>] radix_tree_extend+0x63/0x90
Nov 26 21:36:54 localhost kernel:  [<c0196625>] radix_tree_insert+0xd5/0xf0
Nov 26 21:36:54 localhost kernel:  [<c01606af>] mpage_readpages+0x11f/0x150
Nov 26 21:36:54 localhost kernel:  [<c0176c00>] ext3_get_block+0x0/0xa0
Nov 26 21:36:54 localhost kernel:  [<c013a3a9>] read_pages+0x109/0x110
Nov 26 21:36:54 localhost kernel:  [<c0176c00>] ext3_get_block+0x0/0xa0
Nov 26 21:36:54 localhost kernel:  [<c0135aaa>] __alloc_pages+0x8a/0x270
Nov 26 21:36:54 localhost kernel:  [<c01e30a6>] ide_wait_stat+0xf6/0x120
Nov 26 21:36:54 localhost kernel:  [<c013a488>] 
do_page_cache_readahead+0xd8/0x150
Nov 26 21:36:54 localhost kernel:  [<c013a574>] 
page_cache_readahead+0x74/0x190
Nov 26 21:36:54 localhost kernel:  [<c012cc6a>] 
do_generic_mapping_read+0x9a/0x3d0
Nov 26 21:36:54 localhost kernel:  [<c012cfe0>] file_read_actor+0x0/0xe0
Nov 26 21:36:54 localhost kernel:  [<c012d289>] 
__generic_file_aio_read+0x1c9/0x210
Nov 26 21:36:54 localhost kernel:  [<c012cfe0>] file_read_actor+0x0/0xe0
Nov 26 21:36:54 localhost kernel:  [<c012c84c>] find_get_page+0x2c/0x60
Nov 26 21:36:54 localhost kernel:  [<c012d32a>] 
generic_file_aio_read+0x5a/0x80
Nov 26 21:36:54 localhost kernel:  [<c0140fcc>] do_sync_read+0x8c/0xc0
Nov 26 21:36:54 localhost kernel:  [<c01410e0>] vfs_read+0xe0/0x150
Nov 26 21:36:54 localhost kernel:  [<c014139e>] sys_read+0x3e/0x60
Nov 26 21:36:54 localhost kernel:  [<c01092af>] syscall_call+0x7/0xb
Nov 26 21:36:54 localhost kernel: 
Nov 26 21:36:54 localhost kernel: Code: 0f 0b 9e 07 ce 73 2d c0 eb b0 90 8d 74 
26 00 55 57 56 53 83 

[6.] A small shell script or example program which triggers the
     problem (if possible)
N/A

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux localhost.localdomain 2.5.49 #9 Tue Nov 26 20:21:25 EST 2002 i686 athlon 
i386 GNU/Linux
 
Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.18
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.6.2
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12

[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 4
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 1199.729
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 
mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 2359.29

[7.3.] Module information (from /proc/modules):
N/A.

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
/proc/ioports:
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
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, In VT82C686 [Apollo Sup
6000-607f : VIA Technologies, In VT82C686 [Apollo Sup
9000-9fff : PCI Bus #01
  9000-90ff : ATI Technologies Inc Radeon VE QY
a000-a003 : Advanced Micro Devic AMD-760 [IGD4-1P] Sy
a400-a40f : VIA Technologies, In VT82C586B PIPC Bus M
  a400-a407 : ide0
  a408-a40f : ide1
a800-a81f : VIA Technologies, In USB
ac00-ac1f : VIA Technologies, In USB (#2)
c000-c01f : Creative Labs SB Live! EMU10k1
  c000-c01f : EMU10K1
c400-c407 : Creative Labs SB Live! MIDI/Game P

iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-002b11fa : Kernel code
  002b11fb-00360943 : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-d7ffffff : Advanced Micro Devic AMD-760 [IGD4-1P] Sy
d8000000-dfffffff : PCI Bus #01
  d8000000-dfffffff : ATI Technologies Inc Radeon VE QY
e0000000-e1ffffff : PCI Bus #01
  e1000000-e100ffff : ATI Technologies Inc Radeon VE QY
e2000000-e2000fff : Advanced Micro Devic AMD-760 [IGD4-1P] Sy
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System 
Controller (rev 12)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at e2000000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at a000 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] AGP Bridge 
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: e0000000-e1ffffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE 
(rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at a400 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 
[UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at a800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 
[UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at ac00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 06)
	Subsystem: Creative Labs CT4832 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at c000 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 
06)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at c400 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 VGA compatible controller: ATI Technologies Inc Radeon VE QY (prog-if 
00 [VGA])
	Subsystem: Unknown device 1787:0202
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ 
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at e1000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2,x4
		Command: RQ=15 SBA+ AGP+ 64bit- FW- Rate=x1
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
None.

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[X.] Other notes, patches, fixes, workarounds:
/, /boot, /usr, /tmp, /var, /home on ext3. /usr, /tmp, /var, /home on Linux 
Software RAID 0.

That oops is the earliest one of the 3 identical oops, one after another.

Sorry if this is a known bug :). Please cc me on replies if you can. Thanks.
-- 
Hari
harisri@bigpond.com

