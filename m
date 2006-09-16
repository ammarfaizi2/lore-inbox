Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWIPXYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWIPXYK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 19:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWIPXYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 19:24:10 -0400
Received: from smtp-1.smtp.ucla.edu ([169.232.46.136]:32956 "EHLO
	smtp-1.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S964841AbWIPXYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 19:24:07 -0400
Date: Sat, 16 Sep 2006 16:24:02 -0700
From: Chris Frost <chris@frostnet.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.4 oops: proc_pid_stat()
Message-ID: <20060916232402.GW13465@pooh.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KlAEzMkarCnErv5Q"
Content-Disposition: inline
X-PGP-Key: Send email with subject 'retrieve pgp key'
X-PGP-Fingerprint: Send email with subject 'retrieve pgp fingerprint'
User-Agent: Mutt/1.5.10i
X-Probable-Spam: no
X-Spam-Hits: 0.05
X-Spam-Report: FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[1.] One line summary of the problem:
2.4.32 proc_pid_stat() repeatedly segfaults.

[2.] Full description of the problem/report:
2.4.32 kernel, after being up for a few days to a few weeks, repeatedly
segfaults in proc_pid_stat(), triggered by w, ps, and other programs.

[3.] Keywords (i.e., modules, networking, kernel):
kernel proc_pid_stat()

[4.] Kernel version (from /proc/version):
$ cat /proc/version
Linux version 2.4.32 (root@tiger) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #1 Wed Dec 21 10:57:37 CST 2005

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
See attached oops.w.log (triggered by w) and oops.ps.log (triggered by ps).

[6.] A small shell script or example program which triggers the
     problem (if possible)
Once it starts oopsing, "w" and "ps aux" trigger an oops every time.

[7.] Environment
i386 Debian sarge on a network server in a closet.

[7.1.] Software (add the output of the ver_linux script here)
$ sh /usr/src/linux-2.4.32/scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux tiger 2.4.32 #1 Wed Dec 21 10:57:37 CST 2005 i686 GNU/Linux
 
Gnu C                  3.3.5
Gnu make               3.80
util-linux             2.12p
mount                  2.12p
modutils               2.4.26
e2fsprogs              1.37
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         sg

[7.2.] Processor information (from /proc/cpuinfo):
$ cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 902.069
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3

[7.3.] Module information (from /proc/modules):
$ cat /proc/modules 
sg                     26460   0 (unused)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
$ cat /proc/ioports 
0000-001f : dma1
0020-003f : pic1
0040-0043 : timer0
0050-0053 : timer1
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
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0400-040f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0800-08ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0c00-0c7f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0cf8-0cff : PCI conf1
9000-9fff : PCI Bus #01
b800-b8ff : Lite-On Communications Inc LNE100TX (#2)
  b800-b8ff : tulip
bc00-bcff : Lite-On Communications Inc LNE100TX
  bc00-bcff : tulip
c000-c01f : VIA Technologies, Inc. USB
  c000-c01f : usb-uhci
c400-c41f : VIA Technologies, Inc. USB (#2)
  c400-c41f : usb-uhci
c800-c803 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
  c800-c803 : via82cxxx_audio
cc00-cc03 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
  cc00-cc03 : via82cxxx_audio
d000-d0ff : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
  d000-d0ff : via82cxxx_audio
ffa0-ffaf : VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE

$ cat /proc/iomem   
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-27feffff : System RAM
  00100000-0036fe16 : Kernel code
  0036fe17-004443c3 : Kernel data
27ff0000-27ff7fff : ACPI Tables
27ff8000-27ffffff : ACPI Non-volatile Storage
d9b00000-ddbfffff : PCI Bus #01
  da000000-dbffffff : nVidia Corporation NV5M64 [RIVA TNT2 Model 64/Model 64 Pro]
ddd00000-dfdfffff : PCI Bus #01
  de000000-deffffff : nVidia Corporation NV5M64 [RIVA TNT2 Model 64/Model 64 Pro]
dffffe00-dffffeff : Lite-On Communications Inc LNE100TX (#2)
  dffffe00-dffffeff : tulip
dfffff00-dfffffff : Lite-On Communications Inc LNE100TX
  dfffff00-dfffffff : tulip
e0000000-e3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
# lspci -vvv
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: ddd00000-dfdfffff
	Prefetchable memory behind bridge: d9b00000-ddbfffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at ffa0 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 10) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at c000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 10) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at c400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 20)
	Subsystem: Giga-byte Technology Onboard Audio
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at d000 [size=256]
	Region 1: I/O ports at cc00 [size=4]
	Region 2: I/O ports at c800 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0a.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
	Subsystem: Netgear FA310TX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at bc00 [size=256]
	Region 1: Memory at dfffff00 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at dff80000 [disabled] [size=256K]

0000:00:0f.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
	Subsystem: Netgear FA310TX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at b800 [size=256]
	Region 1: Memory at dffffe00 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at dff40000 [disabled] [size=256K]

0000:01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2 Model 64/Model 64 Pro] (rev 11) (prog-if 00 [VGA])
	Subsystem: Creative Labs: Unknown device 103a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at da000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at dfdf0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

[7.6.] SCSI information (from /proc/scsi/scsi)
$ cat /proc/scsi/scsi 
Attached devices: none

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
ls -lR /proc does not trigger an oops.

[X.] Other notes, patches, fixes, workarounds:
I am not familiar with this aspect of linux, but 2.4.33.3's proc_pid_stat()
appears to be identical. It also appears there have been several bug fixes
in 2.6 (including race condition corrections); perhaps there are issues
fixed in 2.6 but whose patches not been backported to 2.4?

The machine in question become unstable, about a year ago, when an additional
harddrive and ram were added and the kernel upgraded from 2.2.19 (with ext3)
to 2.4.31. There, there may certainly be a hardware issue playing a role
here. However, since the problem is completely reliable once it starts within
a given boot and occurs, given time, across reboots, it seems likely
that a software bug may be involved.

-- 
Chris Frost  |  <http://www.frostnet.net/chris/>
-------------+----------------------------------
Public PGP Key:
   Email chris@frostnet.net with the subject "retrieve pgp key"
   or visit <http://www.frostnet.net/chris/about/pgp_key.phtml>

--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.w.log"

ksymoops 2.4.9 on i686 2.4.32.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.32/ (default)
     -m /boot/System.map-2.4.32 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000174
c015b300
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c015b300>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000170   ebx: c432df44   ecx: 00000001   edx: 00000174
esi: c432df3c   edi: 001a7000   ebp: c014839c   esp: c432de70
ds: 0018   es: 0018   ss: 0018
Process w (pid: 432, stackpage=c432d000)
Stack: e465f6c0 e17d0000 c015b898 e17d0000 c432df3c c432df44 0000000a c03f3f30 
       c014e097 bffffef0 bffff000 c012967d e465f780 bffff000 d9ca9100 c0159fd0 
       d8003640 d9ca9100 bffffef0 00000000 e7e77960 01c5a71f c0127818 e175200a 
Call Trace:    [<c015b898>] [<c014e097>] [<c012967d>] [<c0159fd0>] [<c0127818>]
  [<c01432cb>] [<c0143c0e>] [<c0159418>] [<c01396d7>] [<c0106eff>]
Code: 8b 02 83 f8 01 74 17 85 c0 74 06 8d 41 ff 0f ab 03 41 83 c2 


>>EIP; c015b300 <collect_sigign_sigcatch+40/70>   <=====

>>ebx; c432df44 <_end+3e8364c/284ba788>
>>esi; c432df3c <_end+3e83644/284ba788>
>>ebp; c014839c <do_select+ec/200>
>>esp; c432de70 <_end+3e83578/284ba788>

Trace; c015b898 <proc_pid_stat+118/350>
Trace; c014e097 <new_inode+17/60>
Trace; c012967d <find_extend_vma+2d/120>
Trace; c0159fd0 <proc_base_lookup+100/230>
Trace; c0127818 <get_user_pages+a8/1d0>
Trace; c01432cb <cached_lookup+1b/70>
Trace; c0143c0e <link_path_walk+6de/970>
Trace; c0159418 <proc_info_read+68/110>
Trace; c01396d7 <sys_read+97/100>
Trace; c0106eff <system_call+33/38>

Code;  c015b300 <collect_sigign_sigcatch+40/70>
00000000 <_EIP>:
Code;  c015b300 <collect_sigign_sigcatch+40/70>   <=====
   0:   8b 02                     mov    (%edx),%eax   <=====
Code;  c015b302 <collect_sigign_sigcatch+42/70>
   2:   83 f8 01                  cmp    $0x1,%eax
Code;  c015b305 <collect_sigign_sigcatch+45/70>
   5:   74 17                     je     1e <_EIP+0x1e>
Code;  c015b307 <collect_sigign_sigcatch+47/70>
   7:   85 c0                     test   %eax,%eax
Code;  c015b309 <collect_sigign_sigcatch+49/70>
   9:   74 06                     je     11 <_EIP+0x11>
Code;  c015b30b <collect_sigign_sigcatch+4b/70>
   b:   8d 41 ff                  lea    0xffffffff(%ecx),%eax
Code;  c015b30e <collect_sigign_sigcatch+4e/70>
   e:   0f ab 03                  bts    %eax,(%ebx)
Code;  c015b311 <collect_sigign_sigcatch+51/70>
  11:   41                        inc    %ecx
Code;  c015b312 <collect_sigign_sigcatch+52/70>
  12:   83 c2 00                  add    $0x0,%edx


1 warning issued.  Results may not be reliable.

--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.ps.log"

ksymoops 2.4.9 on i686 2.4.32.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.32/ (default)
     -m /boot/System.map-2.4.32 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000174
c015b300
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c015b300>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000170   ebx: da02df44   ecx: 00000001   edx: 00000174
esi: da02df3c   edi: 001a7000   ebp: c014839c   esp: da02de70
ds: 0018   es: 0018   ss: 0018
Process ps (pid: 674, stackpage=da02d000)
Stack: e465f6c0 e17d0000 c015b898 e17d0000 da02df3c da02df44 0000000a c03f3f30 
       00000050 00000050 c8dbf000 c8dbf000 db840000 00000001 da02def3 c020f2f3 
       db840000 da02def4 00000000 00000001 e7e77960 01c5a71f 00000001 e175200a 
Call Trace:    [<c015b898>] [<c020f2f3>] [<c01432cb>] [<c0143c0e>] [<c0159418>]
  [<c01396d7>] [<c0106eff>]
Code: 8b 02 83 f8 01 74 17 85 c0 74 06 8d 41 ff 0f ab 03 41 83 c2 


>>EIP; c015b300 <collect_sigign_sigcatch+40/70>   <=====

>>ebx; da02df44 <_end+19b8364c/284ba788>
>>esi; da02df3c <_end+19b83644/284ba788>
>>ebp; c014839c <do_select+ec/200>
>>esp; da02de70 <_end+19b83578/284ba788>

Trace; c015b898 <proc_pid_stat+118/350>
Trace; c020f2f3 <pty_write+143/150>
Trace; c01432cb <cached_lookup+1b/70>
Trace; c0143c0e <link_path_walk+6de/970>
Trace; c0159418 <proc_info_read+68/110>
Trace; c01396d7 <sys_read+97/100>
Trace; c0106eff <system_call+33/38>

Code;  c015b300 <collect_sigign_sigcatch+40/70>
00000000 <_EIP>:
Code;  c015b300 <collect_sigign_sigcatch+40/70>   <=====
   0:   8b 02                     mov    (%edx),%eax   <=====
Code;  c015b302 <collect_sigign_sigcatch+42/70>
   2:   83 f8 01                  cmp    $0x1,%eax
Code;  c015b305 <collect_sigign_sigcatch+45/70>
   5:   74 17                     je     1e <_EIP+0x1e>
Code;  c015b307 <collect_sigign_sigcatch+47/70>
   7:   85 c0                     test   %eax,%eax
Code;  c015b309 <collect_sigign_sigcatch+49/70>
   9:   74 06                     je     11 <_EIP+0x11>
Code;  c015b30b <collect_sigign_sigcatch+4b/70>
   b:   8d 41 ff                  lea    0xffffffff(%ecx),%eax
Code;  c015b30e <collect_sigign_sigcatch+4e/70>
   e:   0f ab 03                  bts    %eax,(%ebx)
Code;  c015b311 <collect_sigign_sigcatch+51/70>
  11:   41                        inc    %ecx
Code;  c015b312 <collect_sigign_sigcatch+52/70>
  12:   83 c2 00                  add    $0x0,%edx


1 warning issued.  Results may not be reliable.

--KlAEzMkarCnErv5Q--
