Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129895AbQKSLOz>; Sun, 19 Nov 2000 06:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130463AbQKSLOp>; Sun, 19 Nov 2000 06:14:45 -0500
Received: from new-smtp1.ihug.com.au ([203.109.250.27]:7695 "EHLO
	new-smtp1.ihug.com.au") by vger.kernel.org with ESMTP
	id <S129895AbQKSLOe>; Sun, 19 Nov 2000 06:14:34 -0500
Message-ID: <3A17AEDC.F34F4AC9@ihug.com.au>
Date: Sun, 19 Nov 2000 21:43:40 +1100
From: Vincent <dtig@ihug.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: isofs crash on 2.4.0-test11-pre7 [1.] MAINTAINERS: ISO 
 FILESYSTEM
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[2.]  Full description of the problem/report:
using gnome-terminal, the default alias ls='/bin/ls $LS_OPTIONS'
#mount /mnt/cdrom
#cd /mnt/cdrom
#ls
Segmentation fault
#ls
<gnome-terminal freez>
root@darkstar:~# umount /mnt/cdrom
umount: /mnt/cdrom: device is busy
root@darkstar:~# umount -f /mnt/cdrom
umount2: Device or resource busy
umount: /mnt/cdrom: device is busy
#ps ax
...
  361 ?        D      0:00 /bin/ls --color=auto -F -b -T 0
...
#kill -9 361
#ps ax
...
  361 ?        D      0:00 /bin/ls --color=auto -F -b -T 0
...
CDROM is now unusable...

[3.] Keywords (i.e., modules, networking, kernel):
Module: isofs
Networking: ppp dialup
Kernel: 2.4.0-test11-pre7

[4.] Kernel version (from /proc/version):
t77@darkstar:~$ cat /proc/version
Linux version 2.4.0-test11 (t77@darkstar) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #1 Sat Nov 18 16:23:40 EST 2000

[5.] Output of Oops.. message
ksymoops 2.3.5 on i686 2.4.0-test11.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test11/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel paging request at virtual address dfdfdfc4
c486d5a7
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c486d5a7>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: dfdfdf00   ebx: c2976960   ecx: c1ddb800   edx: c23f5c00
esi: c1ddb800   edi: c1ddb821   ebp: c233fba0   esp: c15b9eb0
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 229, stackpage=c15b9000)
Stack: c2976960 c486a2bf c1ddb800 c2976960 c27f8000 c10a9df0 c1b3d140
c2976960 
       c1b3d140 00000001 c01e1818 00000022 00000022 00000000 0b976960
00000800 
       22994000 c486a3dd c2976960 c1b3d140 c27f8000 c27f8400 fffffff4
c1b3d140 
Call Trace: [<c486a2bf>] [<c486a3dd>] [<c013502b>] [<c0135788>]
[<c0134dc7>] [<c0135d90>] [<c0132a26>] 
       [<c0108daf>] 
Code: 8b 90 c4 00 00 00 80 b8 b4 00 00 00 00 74 1e 68 00 10 00 00 

>>EIP; c486d5a7 <[isofs]get_joliet_filename+13/87>   <=====
Trace; c486a2bf <[isofs]__module_using_checksums+bd/19e>
Trace; c486a3dd <[isofs]isofs_lookup+3d/88>
Trace; c013502b <real_lookup+4f/bc>
Trace; c0135788 <path_walk+5b4/810>
Trace; c0134dc7 <getname+5b/9c>
Trace; c0135d90 <__user_walk+3c/58>
Trace; c0132a26 <sys_newlstat+16/70>
Trace; c0108daf <system_call+33/38>
Code;  c486d5a7 <[isofs]get_joliet_filename+13/87>
00000000 <_EIP>:
Code;  c486d5a7 <[isofs]get_joliet_filename+13/87>   <=====
   0:   8b 90 c4 00 00 00         movl   0xc4(%eax),%edx   <=====
Code;  c486d5ad <[isofs]get_joliet_filename+19/87>
   6:   80 b8 b4 00 00 00 00      cmpb   $0x0,0xb4(%eax)
Code;  c486d5b4 <[isofs]get_joliet_filename+20/87>
   d:   74 1e                     je     2d <_EIP+0x2d> c486d5d4
<[isofs]get_joliet_filename+40/87>
Code;  c486d5b6 <[isofs]get_joliet_filename+22/87>
   f:   68 00 10 00 00            pushl  $0x1000

[6.] A small shell script or example program which triggers the problem
(if possible)
none...


[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

t77@darkstar:~$ ver_linux
-- Versions installed: (if some fields are empty or looks
-- unusual then possibly you have very old versions)
Linux darkstar 2.4.0-test11 #1 Sat Nov 18 16:23:40 EST 2000 i686 unknown
Kernel modules         found
Gnu C                  egcs-2.91.66
Binutils               2.9.1.0.25
Linux C Library        ..
Dynamic Linker (ld.so) 1.9.9
ls: /usr/lib/libg++.so: No such file or directory
Procps                 2.0.6
Mount                  2.10l
Net-tools              (2000-05-21)
Kbd                    0.99
Sh-utils               2.0
Sh-utils               gJC
Sh-utils               
Sh-utils               Inc.
Sh-utils               NO
Sh-utils               PURPOSE.


[7.2.] Processor information (from /proc/cpuinfo):
t77@darkstar:~$ cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 3
model name	: Pentium II (Klamath)
stepping	: 4
cpu MHz		: 233.000866
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
features	: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov mmx
bogomips	: 466.94

[7.3.] Module information (from /proc/modules):
t77@darkstar:~$ cat /proc/modules
nls_cp950              98432   1 (autoclean)
sr_mod                 12000   1 (autoclean)
cdrom                  27360   0 (autoclean) [sr_mod]
isofs                  18384   1 (autoclean)
ppp_deflate            40672   1 (autoclean)
bsd_comp                4160   0 (autoclean)
ipchains               31392   0 (unused)
ide-scsi                7984   1
scsi_mod               56640   2 [sr_mod ide-scsi]
emu10k1                45184   0
soundcore               3888   4 [emu10k1]
ppp_async               6512   1
ppp_generic            13056   2 [ppp_deflate bsd_comp ppp_async]
slhc                    4688   1 [ppp_generic]

[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)
t77@darkstar:~$ cat /proc/ioports
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
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
c000-cfff : PCI Bus #01
d000-dfff : PCI Bus #02
  d000-d0ff : Advanced System Products, Inc ABP940-U / ABP960-U
e000-e01f : Intel Corporation 82371AB PIIX4 USB
e400-e41f : Creative Labs SB Live! EMU10000
  e400-e41f : EMU10K1
e800-e807 : Creative Labs SB Live!
f000-f00f : Intel Corporation 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1
t77@darkstar:~$ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cefff : Extension ROM
000f0000-000fffff : System ROM
00100000-03feffff : System RAM
  00100000-001de747 : Kernel code
  001de748-001eebbf : Kernel data
03ff0000-03ff2fff : ACPI Non-volatile Storage
03ff3000-03ffffff : ACPI Tables
d8000000-dbffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
dc000000-ddffffff : PCI Bus #01
  dc000000-dcffffff : nVidia Corporation Riva TnT 128 [NV04]
de000000-dfffffff : PCI Bus #02
  df000000-df0000ff : Advanced System Products, Inc ABP940-U / ABP960-U
  df001000-df001fff : Zoran Corporation ZR36057PQC Video cutting chipset
e0000000-e0ffffff : PCI Bus #01
  e0000000-e0ffffff : nVidia Corporation Riva TnT 128 [NV04]
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
root@darkstar:~# lspci -vvv
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: dc000000-ddffffff
	Prefetchable memory behind bridge: e0000000-e0ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at e000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:09.0 PCI bridge: PicoPower Technology: Unknown device 0004 (rev 01)
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 02
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: de000000-dfffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10000
(rev 05)
	Subsystem: Creative Labs CT4850 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at e400 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.1 Input device controller: Creative Labs SB Live! (rev 05)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at e800 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation Riva TnT 128
[NV04] (rev 04) (prog-if 00 [VGA])
	Subsystem: Diamond Multimedia Systems Viper V550
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e0000000 (32-bit, prefetchable) [size=16M]
	Expansion ROM at dd000000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 1.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

02:08.0 SCSI storage controller: Advanced System Products, Inc ABP940-U
/ ABP960-U (rev 03)
	Subsystem: Advanced System Products, Inc ASC1300 SCSI Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at d000 [size=256]
	Region 1: Memory at df000000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at de000000 [disabled] [size=64K]

02:09.0 Multimedia video controller: Zoran Corporation ZR36057PQC Video
cutting chipset (rev 02)
	Subsystem: Iomega Corporation JPEG/TV Card
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 4000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at df001000 (32-bit, non-prefetchable) [size=4K]

[7.6.] SCSI information (from /proc/scsi/scsi)
t77@darkstar:~$ cat /proc/scsi/scsi
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: E-IDE    Model: CD-ROM 48X/AKU   Rev: U22 
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: Traxdata Model:  CDRW2260+       Rev: 3.09
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
none...

[X.] Other notes, patches, fixes, workarounds:
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
