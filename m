Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265533AbUAGOY7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 09:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265539AbUAGOY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 09:24:59 -0500
Received: from odin.sis.hu ([212.92.23.29]:34698 "EHLO odin.sis.hu")
	by vger.kernel.org with ESMTP id S265533AbUAGOYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 09:24:48 -0500
Date: Wed, 7 Jan 2004 15:24:46 +0100
From: Gabor Burjan <buga@buvoshetes.hu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.24 ext3 oops
Message-ID: <20040107142446.GA12235@odin.sis.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[1.] One line summary of the problem:

Kernel oops related to ext3 journal handling (?)

The filesystem lies on a software raid mirror (RAID1), so it's unlikely
to be caused by media error.

[2.] Full description of the problem/report:

I got an oops message after the following filesystem errors:

EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing block in system zone - block = 33204
EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing block in system zone - block = 502
EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing blocks not in datazone - block = 1073381983, count = 1
EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing blocks not in datazone - block = 1073382020, count = 1
EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing blocks not in datazone - block = 1045139487, count = 1
EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing block in system zone - block = 65786 attempt to access beyond end of device 09:02: rw=0, want=663266300, limit=1465216
EXT3-fs error (device md(9,2)): ext3_free_branches: Read failure, inode=123067, block=1239558398
EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing blocks not in datazone - block = 759976007, count = 1
EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing block in system zone - block = 33188
EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing block in system zone - block = 9
EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing blocks not in datazone - block = 1071504112, count = 1
EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing blocks not in datazone - block = 1070875519, count = 1
EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing blocks not in datazone - block = 1070875519, count = 1

(see the oops below)

md(9,2) is the /var partition.  After the case files on /var became
unaccessable: after the opening attempt of any file on /var processes
were stuck.

After a hard reboot ext3 recovery was successful.

[3.] Keywords (i.e., modules, networking, kernel):

ext3, swraid, kernel

[4.] Kernel version (from /proc/version):

Linux version 2.4.24 (root@szorvor) (gcc version 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r3, propolice)) #1 Tue Jan 6 10:50:06 CET 2004

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

ksymoops 2.4.9 on i686 2.4.24.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.24/ (default)
     -m /boot/System.map-2.4.24 (specified)

kernel BUG at transaction.c:1255!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01735c6>]    Tainted: GF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000058   ebx: ef711aa0   ecx: ebd92000   edx: d78ed194
esi: c6f27430   edi: efd742f4   ebp: ebd93cd0   esp: ebd93ca8
ds: 0018   es: 0018   ss: 0018
Process rm (pid: 15940, stackpage=ebd93000)
Stack: c02a0ba0 c029db3e c029d9b6 000004e7 c029db4d efd74280 e91c8e60 00010000
       cce49c20 cce67960 ebd93d04 c0168f73 cce67960 ef711aa0 ebfbb8c0 ebd93d28
       c01729f8 cce67960 d2d13f10 00000902 00010000 ec0c7018 cce67960 ebd93d4c
Call Trace:    [<c0168f73>] [<c01729f8>] [<c016b2d8>] [<c0172d03>] [<c016b416>]
  [<c016b77e>] [<c013d7bf>] [<c013da90>] [<c016b5c1>] [<c013da90>] [<c016b5c1>]
  [<c01690fc>] [<c016bb17>] [<c0172250>] [<c01690fc>] [<c016929b>] [<c016eabd>]
  [<c0169190>] [<c01511ce>] [<c0147ad0>] [<c0147ce2>] [<c010930f>]
Code: 0f 0b e7 04 b6 d9 29 c0 e9 61 ff ff ff c7 44 24 10 63 db 29


>>EIP; c01735c6 <journal_forget+1a6/1f0>   <=====

>>ebx; ef711aa0 <_end+2f3b26c8/3050fc88>
>>ecx; ebd92000 <_end+2ba32c28/3050fc88>
>>edx; d78ed194 <_end+1758ddbc/3050fc88>
>>esi; c6f27430 <_end+6bc8058/3050fc88>
>>edi; efd742f4 <_end+2fa14f1c/3050fc88>
>>ebp; ebd93cd0 <_end+2ba348f8/3050fc88>
>>esp; ebd93ca8 <_end+2ba348d0/3050fc88>

Trace; c0168f73 <ext3_forget+63/120>
Trace; c01729f8 <do_get_write_access+2a8/560>
Trace; c016b2d8 <ext3_clear_blocks+f8/1a0>
Trace; c0172d03 <journal_get_write_access+53/70>
Trace; c016b416 <ext3_free_data+96/180>
Trace; c016b77e <ext3_free_branches+27e/2a0>
Trace; c013d7bf <getblk+4f/60>
Trace; c013da90 <bread+20/90>
Trace; c016b5c1 <ext3_free_branches+c1/2a0>
Trace; c013da90 <bread+20/90>
Trace; c016b5c1 <ext3_free_branches+c1/2a0>
Trace; c01690fc <start_transaction+8c/90>
Trace; c016bb17 <ext3_truncate+377/450>
Trace; c0172250 <journal_start+a0/c0>
Trace; c01690fc <start_transaction+8c/90>
Trace; c016929b <ext3_delete_inode+10b/160>
Trace; c016eabd <ext3_unlink+ed/1d0>
Trace; c0169190 <ext3_delete_inode+0/160>
Trace; c01511ce <iput+fe/220>
Trace; c0147ad0 <vfs_unlink+d0/1e0>
Trace; c0147ce2 <sys_unlink+102/110>
Trace; c010930f <system_call+33/38>

Code;  c01735c6 <journal_forget+1a6/1f0>
00000000 <_EIP>:
Code;  c01735c6 <journal_forget+1a6/1f0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01735c8 <journal_forget+1a8/1f0>
   2:   e7 04                     out    %eax,$0x4
Code;  c01735ca <journal_forget+1aa/1f0>
   4:   b6 d9                     mov    $0xd9,%dh
Code;  c01735cc <journal_forget+1ac/1f0>
   6:   29 c0                     sub    %eax,%eax
Code;  c01735ce <journal_forget+1ae/1f0>
   8:   e9 61 ff ff ff            jmp    ffffff6e <_EIP+0xffffff6e>
Code;  c01735d3 <journal_forget+1b3/1f0>
   d:   c7 44 24 10 63 db 29      movl   $0x29db63,0x10(%esp,1)
Code;  c01735da <journal_forget+1ba/1f0>
  14:   00 

[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux szorvor 2.4.24 #1 Tue Jan 6 10:50:06 CET 2004 i686 Intel(R) Pentium(R) III CPU             1133MHz GenuineIntel GNU/Linux

Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.25
e2fsprogs              1.34
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.12
Net-tools              1.60
Kbd                    1.06
Sh-utils               5.0
Modules Loaded         ipt_multiport ipt_state ip_conntrack ipt_REJECT iptable_filter ip_tables usbcore

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Pentium(R) III CPU             1133MHz
stepping        : 1
cpu MHz         : 1138.475
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 2267.54

[7.3.] Module information (from /proc/modules):

ipt_multiport            696   2 (autoclean)
ipt_state                568   1 (autoclean)
ip_conntrack           20488   1 (autoclean) [ipt_state]
ipt_REJECT              3512   1 (autoclean)
iptable_filter          1740   1 (autoclean)
ip_tables              12352   4 [ipt_multiport ipt_state ipt_REJECT iptable_filter]
usbcore                62464   1

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

ioports:
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
0320-0323 :
0350-0353 :
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
a000-a0ff : Initio Corporation INI-A100U2W
  a000-a0ff : inia100
a400-a47f : Digital Equipment Corporation DECchip 21142/43
  a400-a47f : tulip
a800-a87f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
  a800-a87f : 00:06.0
b800-b80f : VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE
  b800-b807 : ide0
  b808-b80f : ide1
d000-dfff : PCI Bus #01
  d800-d8ff : ATI Technologies Inc Rage XL AGP 2X
e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]

iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cc7ff : Extension ROM
000d0000-000d3fff : Extension ROM
000f0000-000fffff : System ROM
00100000-2ffebfff : System RAM
  00100000-0028c48d : Kernel code
  0028c48e-00311203 : Kernel data
2ffec000-2ffeefff : ACPI Tables
2ffef000-2fffefff : reserved
2ffff000-2fffffff : ACPI Non-volatile Storage
f8000000-f8000fff : Initio Corporation INI-A100U2W
f8800000-f88003ff : Digital Equipment Corporation DECchip 21142/43
  f8800000-f88003ff : tulip
f9000000-f900007f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
f9800000-fbdfffff : PCI Bus #01
  f9800000-f9800fff : ATI Technologies Inc Rage XL AGP 2X
  fa000000-faffffff : ATI Technologies Inc Rage XL AGP 2X
fbf00000-fbffffff : PCI Bus #01
fc000000-fdffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
	Subsystem: Asustek Computer, Inc.: Unknown device 80e7
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: f9800000-fbdfffff
	Prefetchable memory behind bridge: fbf00000-fbffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: Asustek Computer, Inc.: Unknown device 80e7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at b800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at a800 [size=128]
	Region 1: Memory at f9000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:08.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: KTI: Unknown device 5100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at a400 [size=128]
	Region 1: Memory at f8800000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

00:0a.0 SCSI storage controller: Initio Corporation INI-A100U2W (rev 01)
	Subsystem: Initio Corporation INI-A100U2W
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at a000 [size=256]
	Region 1: Memory at f8000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP 2X (rev 27) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Xpert 98 RXL AGP 2X
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fa000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at f9800000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at fbfe0000 [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: QUANTUM  Model: ATLAS_V__9_WLS   Rev: 0230
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: QUANTUM  Model: ATLAS_V__9_WLS   Rev: 0230
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: IBM      Model: DNES-309170W     Rev: SAH0
  Type:   Direct-Access                    ANSI SCSI revision: 03


Gabor
