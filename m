Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263723AbTKAGCH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 01:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbTKAGCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 01:02:07 -0500
Received: from gw-ca43-e0.camline.com ([193.149.60.13]:20750 "EHLO
	imap.camline.com") by vger.kernel.org with ESMTP id S263723AbTKAGBn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 01:01:43 -0500
Date: Sat, 1 Nov 2003 07:01:38 +0100 (MET)
From: <matze@camline.com>
To: Andi Kleen <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Oops in __is_prefetch with 2.6.0-test9-bk4 at boot time
 with Athlon XP 1800+
Message-ID: <Pine.LNX.4.33.0311010655490.29382-200000@homer2.camline.com>
Organization: camLine Datensysteme fuer die Mikroelektronik
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463780607-1126821851-1067666498=:29382"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463780607-1126821851-1067666498=:29382
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi!

Andi, it seems that you are the right person for this. It looks like my athlon
dies in the __get_user call in __is_prefetch at boot up when bash is used as
init process (look in [2.] for more details).

Just ask for any additional information.

Thanks,

	Matze

[1.] One line summary of the problem:

Oops in __is_prefetch with 2.6.0-test9-bk4 at boot time with AMD Athlon XP
1800+.


[2.] Full description of the problem/report:

I didn't try any 2.5/2.6 kernels for a long time (around 2.5.70). Meanwhile I
upgraded to Suse 8.2.
When I compiled and booted the 2.6.0-test9-bk4 kernel first time, I got the
following:

INIT: version 1.82 booting
INIT: cannot execute "/etc/init.d/boot"
Kernel panic: Attempted to kill init

Then, I booted again with "init=/bin/bash" appended. Then the Oops in
__is_prefetch occurs.


[3.] Keywords (i.e., modules, networking, kernel):

kernel, boot, athlon xp, prefetch workaround


[4.] Kernel version (from /proc/version):

2.6.0-test9-bk4


[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

Original written from screen and verified with the eyes:
--------------------------------------------------------------------------------------------
c011c19f
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c011c19f>]    Not tainted
EFLAGS: 00010246
EIP is at __is_prefetch+0x9f/0x290
eax: 00000000   ebx: 00000000   ecx: c0000000   edx: 00000001
esi: cfcc1bfc   edi: cfcdf52c   ebp: c1293f04   esp: c1293ed0
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 1, threadinfo=c1292000, task=c12af540
Stack: cfcc1bdc cfcc1920 c0000000 00000000 00000000 c0302180 00000073 00000073
       00000000 c0000000 cfcc1bdc cfcc1bfc cfcdf52c c1293fb4 c011c86e cfcc1bdc
       00000000 00000011 0000000c 00000000 00000000 c12af540 00000011 bffff760
Call trace:
 [<c011c86e>] do_page_fault+0x47e/0x583
 [<c0133b3f>] sigprocmask+0xef/0x290
 [<c0120faa>] schedule+0x26a/0x730
 [<c0133de1>] sys_rt_sigprocmask+0x101/0x300
 [<c011c3f0>] do_page_fault+0x0/0x583
 [<c010981d>] error_code+0x2d/0x38

Code: 8a 13 85 c0 75 5b 89 d0 bf 0f 00 00 00 43 25 f0 00 00 00 21
 <0>Kernel panic: Attempted to kill init!
--------------------------------------------------------------------------------------------

Passed through ksymoops:
--------------------------------------------------------------------------------------------
ksymoops 2.4.8 on i686 2.4.20-4GB-athlon.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /local/src/linux/System.map (specified)

c011c19f
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c011c19f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: c0000000   edx: 00000001
esi: cfcc1bfc   edi: cfcdf52c   ebp: c1293f04   esp: c1293ed0
ds: 007b   es: 007b   ss: 0068
Stack: cfcc1bdc cfcc1920 c0000000 00000000 00000000 c0302180 00000073 00000073
       00000000 c0000000 cfcc1bdc cfcc1bfc cfcdf52c c1293fb4 c011c86e cfcc1bdc
       00000000 00000011 0000000c 00000000 00000000 c12af540 00000011 bffff760
Call trace:
 [<c011c86e>] do_page_fault+0x47e/0x583
 [<c0133b3f>] sigprocmask+0xef/0x290
 [<c0120faa>] schedule+0x26a/0x730
 [<c0133de1>] sys_rt_sigprocmask+0x101/0x300
 [<c011c3f0>] do_page_fault+0x0/0x583
 [<c010981d>] error_code+0x2d/0x38
Code: 8a 13 85 c0 75 5b 89 d0 bf 0f 00 00 00 43 25 f0 00 00 00 21


>>EIP; c011c19f <__is_prefetch+9f/290>   <=====

>>esi; cfcc1bfc <_end+f91488c/3fc50c90>
>>edi; cfcdf52c <_end+f9321bc/3fc50c90>
>>ebp; c1293f04 <_end+ee6b94/3fc50c90>
>>esp; c1293ed0 <_end+ee6b60/3fc50c90>

Trace; c011c86e <do_page_fault+47e/583>
Trace; c0133b3f <sigprocmask+ef/290>
Trace; c0120faa <schedule+26a/730>
Trace; c0133de1 <sys_rt_sigprocmask+101/300>
Trace; c011c3f0 <do_page_fault+0/583>
Trace; c010981d <error_code+2d/38>

Code;  c011c19f <__is_prefetch+9f/290>
00000000 <_EIP>:
Code;  c011c19f <__is_prefetch+9f/290>   <=====
   0:   8a 13                     mov    (%ebx),%dl   <=====
Code;  c011c1a1 <__is_prefetch+a1/290>
   2:   85 c0                     test   %eax,%eax
Code;  c011c1a3 <__is_prefetch+a3/290>
   4:   75 5b                     jne    61 <_EIP+0x61>
Code;  c011c1a5 <__is_prefetch+a5/290>
   6:   89 d0                     mov    %edx,%eax
Code;  c011c1a7 <__is_prefetch+a7/290>
   8:   bf 0f 00 00 00            mov    $0xf,%edi
Code;  c011c1ac <__is_prefetch+ac/290>
   d:   43                        inc    %ebx
Code;  c011c1ad <__is_prefetch+ad/290>
   e:   25 f0 00 00 00            and    $0xf0,%eax
Code;  c011c1b2 <__is_prefetch+b2/290>
  13:   21 00                     and    %eax,(%eax)

 <0>Kernel panic: Attempted to kill init!
--------------------------------------------------------------------------------------------


[6.] A small shell script or example program which triggers the
     problem (if possible)

Happens at boot time, when the init process is started. bash as init seems to
trigger it immediately.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

ver_linux executed on Suse's 2.4.20

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux pinga 2.4.20-4GB-athlon #1 Mon Mar 17 17:56:47 UTC 2003 i686 unknown
unknown GNU/Linux

Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      0.9.8
e2fsprogs              1.28
jfsutils               1.1.1
xfsprogs               2.3.9
PPP                    2.4.1
nfs-utils              1.0.1
Linux C Library        14 00:33 /lib/libc.so.6
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.5
Procps                 3.1.6
Net-tools              1.60
Kbd                    1.06
Sh-utils               4.5.8


[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) XP1800+
stepping        : 2
cpu MHz         : 1544.511
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3080.19


[7.3.] Module information (from /proc/modules):

Not possible to get the information. Oops at init.


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

Not possible to get the information. Oops at init. From 2.4:

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
02f8-02ff : serial(auto)
0330-0331 : MPU401 UART
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
0388-0389 : OPL2/3 (left)
038a-038b : OPL2/3 (right)
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
b400-b41f : VIA Technologies, Inc. USB (#2)
  b400-b41f : usb-uhci
b800-b81f : VIA Technologies, Inc. USB
  b800-b81f : usb-uhci
d000-d00f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  d000-d007 : ide0
  d008-d00f : ide1
d400-d43f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  d400-d43f : e100
d800-d8ff : C-Media Electronics Inc CM8738
  d800-d8ff : CMI8738-MC6


[7.5.] PCI information ('lspci -vvv' as root)

Not possible to get the information. Oops at init. From 2.4:

00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
	Subsystem: Asustek Computer, Inc. A7V266-E Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW-
AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: f7800000-f87fffff
	Prefetchable memory behind bridge: f9f00000-fbffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: Asustek Computer, Inc. CMI8738 6ch-MX
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at d800 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0c)
	Subsystem: Intel Corp. EtherExpress PRO/100 S Desktop Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f7000000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at d400 [size=64]
	Region 2: Memory at f6800000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0f.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture
(rev 11)
	Subsystem: Hauppauge computer works Inc. WinTV Series
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at f9000000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev
11)
	Subsystem: Hauppauge computer works Inc. WinTV Series
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at f8800000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
	Subsystem: Asustek Computer, Inc.: Unknown device 8052
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc. VT8233A Bus Master ATA100/66/33 IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at d000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00
[UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at b800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00
[UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at b400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 01)
(prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G550 Dual Head DDR 32Mb
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fa000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at f8000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at f7800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at f9fe0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW-
AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1


[7.6.] SCSI information (from /proc/scsi/scsi)

Not possible to get the information. Oops at init. From 2.4:

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W4012A Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02

This one uses ide-scsi.


[7.7.] Other information that might be relevant to the problem

My kernel command line:

root=/dev/hda10 hdd=ide-scsi hddlun=0 video=matroxfb:vesa:0x1bb init=/bin/bash

[X.] Other notes, patches, fixes, workarounds:

Nothing, plain kernel. Happened also with vanilla 2.6.0-test9.
.config is attached.

Thank you

---1463780607-1126821851-1067666498=:29382
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=config
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0311010701380.29382@homer2.camline.com>
Content-Description: 
Content-Disposition: attachment; filename=config

Q09ORklHX1g4Nj15DQpDT05GSUdfTU1VPXkNCkNPTkZJR19VSUQxNj15DQpD
T05GSUdfR0VORVJJQ19JU0FfRE1BPXkNCkNPTkZJR19FWFBFUklNRU5UQUw9
eQ0KQ09ORklHX0JST0tFTj15DQpDT05GSUdfQlJPS0VOX09OX1NNUD15DQpD
T05GSUdfU1dBUD15DQpDT05GSUdfU1lTVklQQz15DQpDT05GSUdfQlNEX1BS
T0NFU1NfQUNDVD15DQpDT05GSUdfU1lTQ1RMPXkNCkNPTkZJR19MT0dfQlVG
X1NISUZUPTE0DQpDT05GSUdfSUtDT05GSUc9eQ0KQ09ORklHX0lLQ09ORklH
X1BST0M9eQ0KQ09ORklHX0tBTExTWU1TPXkNCkNPTkZJR19GVVRFWD15DQpD
T05GSUdfRVBPTEw9eQ0KQ09ORklHX0lPU0NIRURfTk9PUD15DQpDT05GSUdf
SU9TQ0hFRF9BUz15DQpDT05GSUdfSU9TQ0hFRF9ERUFETElORT15DQpDT05G
SUdfTU9EVUxFUz15DQpDT05GSUdfTU9EVUxFX1VOTE9BRD15DQpDT05GSUdf
TU9EVUxFX0ZPUkNFX1VOTE9BRD15DQpDT05GSUdfT0JTT0xFVEVfTU9EUEFS
TT15DQpDT05GSUdfS01PRD15DQpDT05GSUdfWDg2X1BDPXkNCkNPTkZJR19N
Szc9eQ0KQ09ORklHX1g4Nl9DTVBYQ0hHPXkNCkNPTkZJR19YODZfWEFERD15
DQpDT05GSUdfWDg2X0wxX0NBQ0hFX1NISUZUPTYNCkNPTkZJR19SV1NFTV9Y
Q0hHQUREX0FMR09SSVRITT15DQpDT05GSUdfWDg2X1dQX1dPUktTX09LPXkN
CkNPTkZJR19YODZfSU5WTFBHPXkNCkNPTkZJR19YODZfQlNXQVA9eQ0KQ09O
RklHX1g4Nl9QT1BBRF9PSz15DQpDT05GSUdfWDg2X0dPT0RfQVBJQz15DQpD
T05GSUdfWDg2X0lOVEVMX1VTRVJDT1BZPXkNCkNPTkZJR19YODZfVVNFX1BQ
Uk9fQ0hFQ0tTVU09eQ0KQ09ORklHX1g4Nl9VU0VfM0ROT1c9eQ0KQ09ORklH
X1g4Nl9VUF9BUElDPXkNCkNPTkZJR19YODZfVVBfSU9BUElDPXkNCkNPTkZJ
R19YODZfTE9DQUxfQVBJQz15DQpDT05GSUdfWDg2X0lPX0FQSUM9eQ0KQ09O
RklHX1g4Nl9UU0M9eQ0KQ09ORklHX1g4Nl9NQ0U9eQ0KQ09ORklHX1g4Nl9N
Q0VfTk9ORkFUQUw9eQ0KQ09ORklHX1g4Nl9NQ0VfUDRUSEVSTUFMPXkNCkNP
TkZJR19NSUNST0NPREU9bQ0KQ09ORklHX1g4Nl9NU1I9bQ0KQ09ORklHX1g4
Nl9DUFVJRD1tDQpDT05GSUdfTk9ISUdITUVNPXkNCkNPTkZJR19NVFJSPXkN
CkNPTkZJR19QTT15DQpDT05GSUdfQVBNPXkNCkNPTkZJR19BUE1fRE9fRU5B
QkxFPXkNCkNPTkZJR19BUE1fQ1BVX0lETEU9eQ0KQ09ORklHX0FQTV9ESVNQ
TEFZX0JMQU5LPXkNCkNPTkZJR19BUE1fQUxMT1dfSU5UUz15DQpDT05GSUdf
UENJPXkNCkNPTkZJR19QQ0lfR09BTlk9eQ0KQ09ORklHX1BDSV9CSU9TPXkN
CkNPTkZJR19QQ0lfRElSRUNUPXkNCkNPTkZJR19QQ0lfTEVHQUNZX1BST0M9
eQ0KQ09ORklHX1BDSV9OQU1FUz15DQpDT05GSUdfSVNBPXkNCkNPTkZJR19I
T1RQTFVHPXkNCkNPTkZJR19QQ01DSUFfUFJPQkU9eQ0KQ09ORklHX0JJTkZN
VF9FTEY9eQ0KQ09ORklHX0JJTkZNVF9BT1VUPW0NCkNPTkZJR19CSU5GTVRf
TUlTQz1tDQpDT05GSUdfUEFSUE9SVD1tDQpDT05GSUdfUEFSUE9SVF9QQz1t
DQpDT05GSUdfUEFSUE9SVF9QQ19DTUwxPW0NCkNPTkZJR19QQVJQT1JUX1NF
UklBTD1tDQpDT05GSUdfUEFSUE9SVF9QQ19GSUZPPXkNCkNPTkZJR19QQVJQ
T1JUX1BDX1NVUEVSSU89eQ0KQ09ORklHX1BBUlBPUlRfMTI4ND15DQpDT05G
SUdfUE5QPXkNCkNPTkZJR19QTlBfREVCVUc9eQ0KQ09ORklHX0lTQVBOUD15
DQpDT05GSUdfQkxLX0RFVl9GRD1tDQpDT05GSUdfQkxLX0RFVl9MT09QPW0N
CkNPTkZJR19CTEtfREVWX0NSWVBUT0xPT1A9bQ0KQ09ORklHX0JMS19ERVZf
TkJEPW0NCkNPTkZJR19CTEtfREVWX1JBTT1tDQpDT05GSUdfQkxLX0RFVl9S
QU1fU0laRT0xNjAwMA0KQ09ORklHX0xCRD15DQpDT05GSUdfSURFPXkNCkNP
TkZJR19CTEtfREVWX0lERT15DQpDT05GSUdfQkxLX0RFVl9JREVESVNLPXkN
CkNPTkZJR19JREVESVNLX01VTFRJX01PREU9eQ0KQ09ORklHX0lERURJU0tf
U1RST0tFPXkNCkNPTkZJR19CTEtfREVWX0lERVNDU0k9bQ0KQ09ORklHX0lE
RV9UQVNLRklMRV9JTz15DQpDT05GSUdfQkxLX0RFVl9JREVQQ0k9eQ0KQ09O
RklHX0lERVBDSV9TSEFSRV9JUlE9eQ0KQ09ORklHX0JMS19ERVZfT0ZGQk9B
UkQ9eQ0KQ09ORklHX0JMS19ERVZfR0VORVJJQz15DQpDT05GSUdfQkxLX0RF
Vl9JREVETUFfUENJPXkNCkNPTkZJR19JREVETUFfUENJX0FVVE89eQ0KQ09O
RklHX0lERURNQV9PTkxZRElTSz15DQpDT05GSUdfQkxLX0RFVl9BRE1BPXkN
CkNPTkZJR19CTEtfREVWX1ZJQTgyQ1hYWD15DQpDT05GSUdfQkxLX0RFVl9J
REVETUE9eQ0KQ09ORklHX0lERURNQV9BVVRPPXkNCkNPTkZJR19TQ1NJPW0N
CkNPTkZJR19CTEtfREVWX1NSPW0NCkNPTkZJR19DSFJfREVWX1NHPW0NCkNP
TkZJR19TQ1NJX01VTFRJX0xVTj15DQpDT05GSUdfTkVUPXkNCkNPTkZJR19Q
QUNLRVQ9bQ0KQ09ORklHX1BBQ0tFVF9NTUFQPXkNCkNPTkZJR19ORVRMSU5L
X0RFVj1tDQpDT05GSUdfVU5JWD15DQpDT05GSUdfTkVUX0tFWT1tDQpDT05G
SUdfSU5FVD15DQpDT05GSUdfSVBfTVVMVElDQVNUPXkNCkNPTkZJR19JUF9B
RFZBTkNFRF9ST1VURVI9eQ0KQ09ORklHX0lQX01VTFRJUExFX1RBQkxFUz15
DQpDT05GSUdfSVBfUk9VVEVfRldNQVJLPXkNCkNPTkZJR19JUF9ST1VURV9O
QVQ9eQ0KQ09ORklHX0lQX1JPVVRFX01VTFRJUEFUSD15DQpDT05GSUdfSVBf
Uk9VVEVfVE9TPXkNCkNPTkZJR19JUF9ST1VURV9WRVJCT1NFPXkNCkNPTkZJ
R19JUF9QTlA9eQ0KQ09ORklHX0lQX1BOUF9ESENQPXkNCkNPTkZJR19JUF9Q
TlBfQk9PVFA9eQ0KQ09ORklHX0lQX1BOUF9SQVJQPXkNCkNPTkZJR19ORVRf
SVBJUD1tDQpDT05GSUdfTkVUX0lQR1JFPW0NCkNPTkZJR19ORVRfSVBHUkVf
QlJPQURDQVNUPXkNCkNPTkZJR19JUF9NUk9VVEU9eQ0KQ09ORklHX0lQX1BJ
TVNNX1YxPXkNCkNPTkZJR19JUF9QSU1TTV9WMj15DQpDT05GSUdfSU5FVF9F
Q049eQ0KQ09ORklHX1NZTl9DT09LSUVTPXkNCkNPTkZJR19ORVRGSUxURVI9
eQ0KQ09ORklHX0lQX05GX0NPTk5UUkFDSz1tDQpDT05GSUdfSVBfTkZfSVBU
QUJMRVM9bQ0KQ09ORklHX0lQX05GX01BVENIX0xJTUlUPW0NCkNPTkZJR19J
UF9ORl9NQVRDSF9NQUM9bQ0KQ09ORklHX0lQX05GX01BVENIX1BLVFRZUEU9
bQ0KQ09ORklHX0lQX05GX01BVENIX01BUks9bQ0KQ09ORklHX0lQX05GX01B
VENIX01VTFRJUE9SVD1tDQpDT05GSUdfSVBfTkZfTUFUQ0hfVE9TPW0NCkNP
TkZJR19JUF9ORl9NQVRDSF9SRUNFTlQ9bQ0KQ09ORklHX0lQX05GX01BVENI
X0VDTj1tDQpDT05GSUdfSVBfTkZfTUFUQ0hfRFNDUD1tDQpDT05GSUdfSVBf
TkZfTUFUQ0hfQUhfRVNQPW0NCkNPTkZJR19JUF9ORl9NQVRDSF9MRU5HVEg9
bQ0KQ09ORklHX0lQX05GX01BVENIX1RUTD1tDQpDT05GSUdfSVBfTkZfTUFU
Q0hfVENQTVNTPW0NCkNPTkZJR19JUF9ORl9NQVRDSF9IRUxQRVI9bQ0KQ09O
RklHX0lQX05GX01BVENIX1NUQVRFPW0NCkNPTkZJR19JUF9ORl9NQVRDSF9D
T05OVFJBQ0s9bQ0KQ09ORklHX0lQX05GX01BVENIX09XTkVSPW0NCkNPTkZJ
R19JUF9ORl9GSUxURVI9bQ0KQ09ORklHX0lQX05GX1RBUkdFVF9SRUpFQ1Q9
bQ0KQ09ORklHX0lQX05GX05BVD1tDQpDT05GSUdfSVBfTkZfTkFUX05FRURF
RD15DQpDT05GSUdfSVBfTkZfVEFSR0VUX01BU1FVRVJBREU9bQ0KQ09ORklH
X0lQX05GX1RBUkdFVF9SRURJUkVDVD1tDQpDT05GSUdfSVBfTkZfTkFUX1NO
TVBfQkFTSUM9bQ0KQ09ORklHX0lQX05GX01BTkdMRT1tDQpDT05GSUdfSVBf
TkZfVEFSR0VUX1RPUz1tDQpDT05GSUdfSVBfTkZfVEFSR0VUX0VDTj1tDQpD
T05GSUdfSVBfTkZfVEFSR0VUX0RTQ1A9bQ0KQ09ORklHX0lQX05GX1RBUkdF
VF9NQVJLPW0NCkNPTkZJR19JUF9ORl9UQVJHRVRfTE9HPW0NCkNPTkZJR19J
UF9ORl9UQVJHRVRfVUxPRz1tDQpDT05GSUdfSVBfTkZfVEFSR0VUX1RDUE1T
Uz1tDQpDT05GSUdfSVBfTkZfQ09NUEFUX0lQQ0hBSU5TPW0NCkNPTkZJR19J
UF9ORl9DT01QQVRfSVBGV0FETT1tDQpDT05GSUdfWEZSTT15DQpDT05GSUdf
SVBWNl9TQ1RQX189eQ0KQ09ORklHX1ZMQU5fODAyMVE9bQ0KQ09ORklHX05F
VF9TQ0hFRD15DQpDT05GSUdfTkVUX1NDSF9DQlE9bQ0KQ09ORklHX05FVF9T
Q0hfSFRCPW0NCkNPTkZJR19ORVRfU0NIX0NTWj1tDQpDT05GSUdfTkVUX1ND
SF9QUklPPW0NCkNPTkZJR19ORVRfU0NIX1JFRD1tDQpDT05GSUdfTkVUX1ND
SF9TRlE9bQ0KQ09ORklHX05FVF9TQ0hfVEVRTD1tDQpDT05GSUdfTkVUX1ND
SF9UQkY9bQ0KQ09ORklHX05FVF9TQ0hfR1JFRD1tDQpDT05GSUdfTkVUX1ND
SF9EU01BUks9bQ0KQ09ORklHX05FVF9TQ0hfSU5HUkVTUz1tDQpDT05GSUdf
TkVUX1FPUz15DQpDT05GSUdfTkVUX0VTVElNQVRPUj15DQpDT05GSUdfTkVU
X0NMUz15DQpDT05GSUdfTkVUX0NMU19UQ0lOREVYPW0NCkNPTkZJR19ORVRf
Q0xTX1JPVVRFND1tDQpDT05GSUdfTkVUX0NMU19ST1VURT15DQpDT05GSUdf
TkVUX0NMU19GVz1tDQpDT05GSUdfTkVUX0NMU19VMzI9bQ0KQ09ORklHX05F
VF9DTFNfUlNWUD1tDQpDT05GSUdfTkVUX0NMU19SU1ZQNj1tDQpDT05GSUdf
TkVUX0NMU19QT0xJQ0U9eQ0KQ09ORklHX05FVERFVklDRVM9eQ0KQ09ORklH
X0RVTU1ZPW0NCkNPTkZJR19ORVRfRVRIRVJORVQ9eQ0KQ09ORklHX05FVF9Q
Q0k9eQ0KQ09ORklHX0UxMDA9eQ0KQ09ORklHX1BQUD1tDQpDT05GSUdfUFBQ
X0ZJTFRFUj15DQpDT05GSUdfUFBQX0FTWU5DPW0NCkNPTkZJR19QUFBfREVG
TEFURT1tDQpDT05GSUdfUFBQX0JTRENPTVA9bQ0KQ09ORklHX1NIQVBFUj1t
DQpDT05GSUdfSU5QVVQ9eQ0KQ09ORklHX0lOUFVUX01PVVNFREVWPXkNCkNP
TkZJR19JTlBVVF9NT1VTRURFVl9QU0FVWD15DQpDT05GSUdfSU5QVVRfTU9V
U0VERVZfU0NSRUVOX1g9MTAyNA0KQ09ORklHX0lOUFVUX01PVVNFREVWX1ND
UkVFTl9ZPTc2OA0KQ09ORklHX1NPVU5EX0dBTUVQT1JUPXkNCkNPTkZJR19T
RVJJTz15DQpDT05GSUdfU0VSSU9fSTgwNDI9eQ0KQ09ORklHX1NFUklPX1NF
UlBPUlQ9eQ0KQ09ORklHX0lOUFVUX0tFWUJPQVJEPXkNCkNPTkZJR19LRVlC
T0FSRF9BVEtCRD15DQpDT05GSUdfSU5QVVRfTU9VU0U9eQ0KQ09ORklHX01P
VVNFX1BTMj15DQpDT05GSUdfSU5QVVRfTUlTQz15DQpDT05GSUdfSU5QVVRf
UENTUEtSPXkNCkNPTkZJR19WVD15DQpDT05GSUdfVlRfQ09OU09MRT15DQpD
T05GSUdfSFdfQ09OU09MRT15DQpDT05GSUdfU0VSSUFMXzgyNTA9eQ0KQ09O
RklHX1NFUklBTF84MjUwX05SX1VBUlRTPTQNCkNPTkZJR19TRVJJQUxfQ09S
RT15DQpDT05GSUdfVU5JWDk4X1BUWVM9eQ0KQ09ORklHX1VOSVg5OF9QVFlf
Q09VTlQ9MjU2DQpDT05GSUdfUFJJTlRFUj1tDQpDT05GSUdfSTJDPXkNCkNP
TkZJR19JMkNfQ0hBUkRFVj1tDQpDT05GSUdfSTJDX0FMR09CSVQ9bQ0KQ09O
RklHX0kyQ19WSUFQUk89bQ0KQ09ORklHX0kyQ19TRU5TT1I9bQ0KQ09ORklH
X1NFTlNPUlNfRUVQUk9NPW0NCkNPTkZJR19TRU5TT1JTX1c4Mzc4MUQ9bQ0K
Q09ORklHX1dBVENIRE9HPXkNCkNPTkZJR19XQVRDSERPR19OT1dBWU9VVD15
DQpDT05GSUdfU09GVF9XQVRDSERPRz1tDQpDT05GSUdfTlZSQU09bQ0KQ09O
RklHX1JUQz15DQpDT05GSUdfQUdQPW0NCkNPTkZJR19BR1BfQUxJPW0NCkNP
TkZJR19BR1BfQU1EPW0NCkNPTkZJR19BR1BfSU5URUw9bQ0KQ09ORklHX0FH
UF9TSVM9bQ0KQ09ORklHX0FHUF9TV09SS1M9bQ0KQ09ORklHX0FHUF9WSUE9
bQ0KQ09ORklHX0RSTT15DQpDT05GSUdfRFJNX01HQT1tDQpDT05GSUdfUkFX
X0RSSVZFUj1tDQpDT05GSUdfTUFYX1JBV19ERVZTPTI1Ng0KQ09ORklHX0hB
TkdDSEVDS19USU1FUj1tDQpDT05GSUdfVklERU9fREVWPW0NCkNPTkZJR19W
SURFT19CVDg0OD1tDQpDT05GSUdfVklERU9fU0FBNTI0OT1tDQpDT05GSUdf
VklERU9fVFVORVI9bQ0KQ09ORklHX1ZJREVPX0JVRj1tDQpDT05GSUdfVklE
RU9fQlRDWD1tDQpDT05GSUdfVkdBX0NPTlNPTEU9eQ0KQ09ORklHX0RVTU1Z
X0NPTlNPTEU9eQ0KQ09ORklHX1NPVU5EPW0NCkNPTkZJR19TTkQ9bQ0KQ09O
RklHX1NORF9TRVFVRU5DRVI9bQ0KQ09ORklHX1NORF9TRVFfRFVNTVk9bQ0K
Q09ORklHX1NORF9PU1NFTVVMPXkNCkNPTkZJR19TTkRfTUlYRVJfT1NTPW0N
CkNPTkZJR19TTkRfUENNX09TUz1tDQpDT05GSUdfU05EX1NFUVVFTkNFUl9P
U1M9eQ0KQ09ORklHX1NORF9SVENUSU1FUj1tDQpDT05GSUdfU05EX1ZFUkJP
U0VfUFJJTlRLPXkNCkNPTkZJR19TTkRfRFVNTVk9bQ0KQ09ORklHX1NORF9W
SVJNSURJPW0NCkNPTkZJR19TTkRfTVRQQVY9bQ0KQ09ORklHX1NORF9TRVJJ
QUxfVTE2NTUwPW0NCkNPTkZJR19TTkRfTVBVNDAxPW0NCkNPTkZJR19TTkRf
Q01JUENJPW0NCkNPTkZJR19VU0I9bQ0KQ09ORklHX1VTQl9ERUJVRz15DQpD
T05GSUdfVVNCX0RFVklDRUZTPXkNCkNPTkZJR19VU0JfVUhDSV9IQ0Q9bQ0K
Q09ORklHX1VTQl9TVE9SQUdFPW0NCkNPTkZJR19VU0JfU1RPUkFHRV9ERUJV
Rz15DQpDT05GSUdfRVhUMl9GUz1tDQpDT05GSUdfRVhUM19GUz1tDQpDT05G
SUdfSkJEPW0NCkNPTkZJR19SRUlTRVJGU19GUz15DQpDT05GSUdfWEZTX0ZT
PW0NCkNPTkZJR19ST01GU19GUz1tDQpDT05GSUdfQVVUT0ZTNF9GUz1tDQpD
T05GSUdfSVNPOTY2MF9GUz1tDQpDT05GSUdfSk9MSUVUPXkNCkNPTkZJR19a
SVNPRlM9eQ0KQ09ORklHX1pJU09GU19GUz1tDQpDT05GSUdfRkFUX0ZTPW0N
CkNPTkZJR19NU0RPU19GUz1tDQpDT05GSUdfVkZBVF9GUz1tDQpDT05GSUdf
TlRGU19GUz1tDQpDT05GSUdfUFJPQ19GUz15DQpDT05GSUdfUFJPQ19LQ09S
RT15DQpDT05GSUdfREVWUFRTX0ZTPXkNCkNPTkZJR19UTVBGUz15DQpDT05G
SUdfSFVHRVRMQkZTPXkNCkNPTkZJR19IVUdFVExCX1BBR0U9eQ0KQ09ORklH
X1JBTUZTPXkNCkNPTkZJR19DUkFNRlM9bQ0KQ09ORklHX05GU0Q9bQ0KQ09O
RklHX05GU0RfVjM9eQ0KQ09ORklHX0xPQ0tEPW0NCkNPTkZJR19MT0NLRF9W
ND15DQpDT05GSUdfRVhQT1JURlM9bQ0KQ09ORklHX1NVTlJQQz1tDQpDT05G
SUdfU1VOUlBDX0dTUz1tDQpDT05GSUdfU01CX0ZTPW0NCkNPTkZJR19TTUJf
TkxTX0RFRkFVTFQ9eQ0KQ09ORklHX1NNQl9OTFNfUkVNT1RFPSJjcDQzNyIN
CkNPTkZJR19DSUZTPW0NCkNPTkZJR19DT0RBX0ZTPW0NCkNPTkZJR19NU0RP
U19QQVJUSVRJT049eQ0KQ09ORklHX1NNQl9OTFM9eQ0KQ09ORklHX05MUz15
DQpDT05GSUdfTkxTX0RFRkFVTFQ9Imlzbzg4NTktMSINCkNPTkZJR19OTFNf
Q09ERVBBR0VfNDM3PW0NCkNPTkZJR19OTFNfQ09ERVBBR0VfNzM3PW0NCkNP
TkZJR19OTFNfQ09ERVBBR0VfNzc1PW0NCkNPTkZJR19OTFNfQ09ERVBBR0Vf
ODUwPW0NCkNPTkZJR19OTFNfQ09ERVBBR0VfODUyPW0NCkNPTkZJR19OTFNf
Q09ERVBBR0VfODU1PW0NCkNPTkZJR19OTFNfQ09ERVBBR0VfODU3PW0NCkNP
TkZJR19OTFNfQ09ERVBBR0VfODYwPW0NCkNPTkZJR19OTFNfQ09ERVBBR0Vf
ODYxPW0NCkNPTkZJR19OTFNfQ09ERVBBR0VfODYyPW0NCkNPTkZJR19OTFNf
Q09ERVBBR0VfODYzPW0NCkNPTkZJR19OTFNfQ09ERVBBR0VfODY0PW0NCkNP
TkZJR19OTFNfQ09ERVBBR0VfODY1PW0NCkNPTkZJR19OTFNfQ09ERVBBR0Vf
ODY2PW0NCkNPTkZJR19OTFNfQ09ERVBBR0VfODY5PW0NCkNPTkZJR19OTFNf
Q09ERVBBR0VfOTM2PW0NCkNPTkZJR19OTFNfQ09ERVBBR0VfOTUwPW0NCkNP
TkZJR19OTFNfQ09ERVBBR0VfOTMyPW0NCkNPTkZJR19OTFNfQ09ERVBBR0Vf
OTQ5PW0NCkNPTkZJR19OTFNfQ09ERVBBR0VfODc0PW0NCkNPTkZJR19OTFNf
SVNPODg1OV84PW0NCkNPTkZJR19OTFNfQ09ERVBBR0VfMTI1MD1tDQpDT05G
SUdfTkxTX0NPREVQQUdFXzEyNTE9bQ0KQ09ORklHX05MU19JU084ODU5XzE9
bQ0KQ09ORklHX05MU19JU084ODU5XzI9bQ0KQ09ORklHX05MU19JU084ODU5
XzM9bQ0KQ09ORklHX05MU19JU084ODU5XzQ9bQ0KQ09ORklHX05MU19JU084
ODU5XzU9bQ0KQ09ORklHX05MU19JU084ODU5XzY9bQ0KQ09ORklHX05MU19J
U084ODU5Xzc9bQ0KQ09ORklHX05MU19JU084ODU5Xzk9bQ0KQ09ORklHX05M
U19JU084ODU5XzEzPW0NCkNPTkZJR19OTFNfSVNPODg1OV8xND1tDQpDT05G
SUdfTkxTX0lTTzg4NTlfMTU9bQ0KQ09ORklHX05MU19LT0k4X1I9bQ0KQ09O
RklHX05MU19LT0k4X1U9bQ0KQ09ORklHX05MU19VVEY4PW0NCkNPTkZJR19E
RUJVR19LRVJORUw9eQ0KQ09ORklHX0RFQlVHX1NUQUNLT1ZFUkZMT1c9eQ0K
Q09ORklHX0RFQlVHX1NMQUI9eQ0KQ09ORklHX0RFQlVHX0lPVklSVD15DQpD
T05GSUdfTUFHSUNfU1lTUlE9eQ0KQ09ORklHX0RFQlVHX1NQSU5MT0NLPXkN
CkNPTkZJR19ERUJVR19TUElOTE9DS19TTEVFUD15DQpDT05GSUdfRlJBTUVf
UE9JTlRFUj15DQpDT05GSUdfWDg2X0VYVFJBX0lSUVM9eQ0KQ09ORklHX1g4
Nl9GSU5EX1NNUF9DT05GSUc9eQ0KQ09ORklHX1g4Nl9NUFBBUlNFPXkNCkNP
TkZJR19DUllQVE89eQ0KQ09ORklHX0NSWVBUT19ITUFDPXkNCkNPTkZJR19D
UllQVE9fTlVMTD1tDQpDT05GSUdfQ1JZUFRPX01END1tDQpDT05GSUdfQ1JZ
UFRPX01ENT1tDQpDT05GSUdfQ1JZUFRPX1NIQTE9bQ0KQ09ORklHX0NSWVBU
T19TSEEyNTY9bQ0KQ09ORklHX0NSWVBUT19TSEE1MTI9bQ0KQ09ORklHX0NS
WVBUT19ERVM9bQ0KQ09ORklHX0NSWVBUT19CTE9XRklTSD1tDQpDT05GSUdf
Q1JZUFRPX1RXT0ZJU0g9bQ0KQ09ORklHX0NSWVBUT19TRVJQRU5UPW0NCkNP
TkZJR19DUllQVE9fQUVTPW0NCkNPTkZJR19DUllQVE9fREVGTEFURT1tDQpD
T05GSUdfQ1JZUFRPX1RFU1Q9bQ0KQ09ORklHX1pMSUJfSU5GTEFURT1tDQpD
T05GSUdfWkxJQl9ERUZMQVRFPW0NCkNPTkZJR19YODZfQklPU19SRUJPT1Q9
eQ0KQ09ORklHX1BDPXkNCg==
---1463780607-1126821851-1067666498=:29382--
