Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265310AbTLNAWZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 19:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265316AbTLNAWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 19:22:24 -0500
Received: from vsmtp1.tin.it ([212.216.176.221]:50587 "EHLO vsmtp1alice.tin.it")
	by vger.kernel.org with ESMTP id S265310AbTLNAWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 19:22:14 -0500
Subject: another oops, maybe I'll downgrade to 2.4.22.. :(
From: Cristiano De Michele <demichel@na.infn.it>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, torvalds@transmeta.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Department of Physics
Message-Id: <1071361330.1551.2.camel@cripat.acasa-tr.it>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 14 Dec 2003 01:22:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
another oops got using kernel 2.4.23 caused to gkrellm
I'm on debian unstable up to date 

c012c2ae
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012c2ae>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210282
eax: 5a7fbd58   ebx: c6b0bf90   ecx: c158e0c0   edx: d67fbd7c
esi: 00001000   edi: dc7f1614   ebp: cf9b7c3c   esp: cf9b7c1c
ds: 0018   es: 0018   ss: 0018
Process gkrellm (pid: 18516, stackpage=cf9b7000)
Stack: c6b0bf90 c6b0b9ec 00009000 408c3000 c6b0b6f4 dc7f1614 cf9b6000 dc7f1614 
       cf9b7c50 c011a0a8 dc7f1614 00000080 de8af0c4 cf9b7c74 c0143883 dc7f1614 
       cf9b7ed0 00000000 dc7f1614 00000000 cf9b6000 dd1bb580 cf9b7c98 c014394b 
Call Trace:    [<c011a0a8>] [<c0143883>] [<c014394b>] [<c0158872>] [<c016650a>]
  [<c016cde3>] [<c0135672>] [<c0158560>] [<c0143f97>] [<c014339b>] [<c0144162>]
  [<c01079bf>] [<c010900f>]
Code: 89 10 89 1c 24 e8 b8 ec ff ff 8b 45 ec 89 74 24 08 89 3c 24


>>EIP; c012c2ae <exit_mmap+9e/140>   <=====

>>ebx; c6b0bf90 <_end+677a6bc/2051d7ac>
>>ecx; c158e0c0 <_end+11fc7ec/2051d7ac>
>>edx; d67fbd7c <_end+1646a4a8/2051d7ac>
>>edi; dc7f1614 <_end+1c45fd40/2051d7ac>
>>ebp; cf9b7c3c <_end+f626368/2051d7ac>
>>esp; cf9b7c1c <_end+f626348/2051d7ac>

Trace; c011a0a8 <mmput+48/a0>
Trace; c0143883 <exec_mmap+c3/f0>
Trace; c014394b <flush_old_exec+9b/290>
Trace; c0158872 <load_elf_binary+312/d50>
Trace; c016650a <ext3_do_update_inode+17a/3f0>
Trace; c016cde3 <journal_get_write_access+53/70>
Trace; c0135672 <__alloc_pages+62/240>
Trace; c0158560 <load_elf_binary+0/d50>
Trace; c0143f97 <search_binary_handler+107/190>
Trace; c014339b <copy_strings+17b/1f0>
Trace; c0144162 <do_execve+142/1d0>
Trace; c01079bf <sys_execve+3f/70>
Trace; c010900f <system_call+33/38>

Code;  c012c2ae <exit_mmap+9e/140>
00000000 <_EIP>:
Code;  c012c2ae <exit_mmap+9e/140>   <=====
   0:   89 10                     mov    %edx,(%eax)   <=====
Code;  c012c2b0 <exit_mmap+a0/140>
   2:   89 1c 24                  mov    %ebx,(%esp,1)
Code;  c012c2b3 <exit_mmap+a3/140>
   5:   e8 b8 ec ff ff            call   ffffecc2 <_EIP+0xffffecc2>
Code;  c012c2b8 <exit_mmap+a8/140>
   a:   8b 45 ec                  mov    0xffffffec(%ebp),%eax
Code;  c012c2bb <exit_mmap+ab/140>
   d:   89 74 24 08               mov    %esi,0x8(%esp,1)
Code;  c012c2bf <exit_mmap+af/140>
  11:   89 3c 24                  mov    %edi,(%esp,1)

and cat /proc/cpuinfo:
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) XP 1700+
stepping	: 2
cpu MHz		: 1470.019
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 2936.01

cat /proc/version:
Linux version 2.4.23 (root@cripat) (gcc version 3.3.2 (Debian)) #1 Sat
Nov 29 13:39:54 CET 2003

cat /proc/modules:

printer                 7264   0 (unused)
input                   3424   0 (autoclean)
audio                  41976   0 (unused)
agpgart                14000   3 (autoclean)
nvidia               1630112  11 (autoclean)
ip_nat_irc              2160   0 (unused)
ip_conntrack_irc        3120   1
ip_conntrack_ftp        3952   1 (autoclean)
ip_nat_ftp              2800   0 (unused)
ipt_unclean             6968   0 (unused)
ipt_state                568  10
ipt_REJECT              3512   0 (unused)
ipt_REDIRECT             760   0 (unused)
ipt_multiport            696   5
ipt_MIRROR              1304   0 (unused)
ipt_MASQUERADE          1368   1
ipt_LOG                 3512   0 (unused)
ipt_limit                920   0 (unused)
iptable_nat            15726   3 [ip_nat_irc ip_nat_ftp ipt_REDIRECT
ipt_MASQUERADE]
iptable_mangle          2168   0 (unused)
iptable_filter          1740   1
ip_queue                5712   0 (unused)
ip_tables              12032  14 [ipt_unclean ipt_state ipt_REJECT
ipt_REDIRECT ipt_multiport ipt_MIRROR ipt_MASQUERADE ipt_LOG ipt_limit
iptable_nat iptable_mangle iptable_filter]
parport_pc             15556   1 (autoclean)
lp                      6592   0 (autoclean)
parport                25608   1 (autoclean) [parport_pc lp]
ppp_deflate             3480   0 (autoclean)
zlib_inflate           18436   0 (autoclean) [ppp_deflate]
zlib_deflate           18040   0 (autoclean) [ppp_deflate]
bsd_comp                4120   0 (autoclean)
ppp_async               7488   1 (autoclean)
snd-seq-oss            28896   0 (unused)
snd-seq-midi-event      3296   0 [snd-seq-oss]
snd-seq                36368   2 [snd-seq-oss snd-seq-midi-event]
snd-pcm-oss            37572   1
snd-mixer-oss          12976   1 [snd-pcm-oss]
snd-via82xx            13600   3
snd-pcm                59812   0 [snd-pcm-oss snd-via82xx]
snd-timer              14404   0 [snd-seq snd-pcm]
snd-ac97-codec         42296   0 [snd-via82xx]
snd-page-alloc          6228   0 [snd-via82xx snd-pcm]
gameport                1644   0 [snd-via82xx]
snd-mpu401-uart         3376   0 [snd-via82xx]
snd-rawmidi            13568   0 [snd-mpu401-uart]
snd-seq-device          4240   0 [snd-seq-oss snd-seq snd-rawmidi]
snd                    32644   1 [snd-seq-oss snd-seq-midi-event snd-seq
snd-pcm-oss snd-mixer-oss snd-via82xx snd-pcm snd-timer snd-ac97-codec
snd-mpu401-uart snd-rawmidi snd-seq-device]
uhci                   25340   0 (unused)
tun                     4224   0 (unused)
8139too                16168   1
mii                     2464   0 [8139too]
crc32                   2880   0 [8139too]
3c59x                  26128   1
nls_cp437               4380   0 (unused)
thermal                 6372   0 (unused)
ac                      1856   0 (unused)
fan                     1664   0 (unused)
processor               8504   0 [thermal]
quickcam              115104   0
usbcore                62092   1 [printer audio uhci quickcam]
videodev                6496   1 [quickcam]
rtc                     6824   0 (autoclean)

cat /proc/ioports:

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
02f8-02ff : serial(set)
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
d000-d0ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  d000-d0ff : 8139too
d400-d43f : 3Com Corporation 3c900 Combo [Boomerang]
  d400-d43f : 00:0b.0
d800-d80f : VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C
PIPC Bus Master IDE
  d800-d807 : ide0
  d808-d80f : ide1
dc00-dc1f : VIA Technologies, Inc. USB
  dc00-dc1f : usb-uhci
e000-e01f : VIA Technologies, Inc. USB (#2)
  e000-e01f : usb-uhci
e800-e8ff : VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller
  e800-e8ff : VIA8233

cat /proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-002a7c2b : Kernel code
  002a7c2c-0033c49f : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : nVidia Corporation NV10 [GeForce 256 SDR]
e8000000-e9ffffff : PCI Bus #01
  e8000000-e8ffffff : nVidia Corporation NV10 [GeForce 256 SDR]
ea000000-eaffffff : VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333]
ec000000-ec0000ff : Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+
  ec000000-ec0000ff : 8139too
ffff0000-ffffffff : reserved

lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at ea000000 (32-bit, prefetchable) [size=16M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit-
FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e8000000-e9ffffff
	Prefetchable memory behind bridge: e0000000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Unex Technology Corp. ND010
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at d000 [size=256]
	Region 1: Memory at ec000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: 3Com Corporation 3c900 Combo [Boomerang]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at d400 [size=64]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Subsystem: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
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
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc.
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00
[UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at dc00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00
[UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at e000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235 AC97 Audio Controller (rev 30)
	Subsystem: Avance Logic Inc.: Unknown device 4710
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 5
	Region 0: I/O ports at e800 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV10 [GeForce 256
SDR] (rev 10) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit-
FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4
-- 
  Cristiano De Michele,
  Department of Physics,
  University "Federico II" of Naples
