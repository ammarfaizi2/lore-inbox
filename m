Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266884AbRGYLEe>; Wed, 25 Jul 2001 07:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266911AbRGYLEP>; Wed, 25 Jul 2001 07:04:15 -0400
Received: from [202.141.79.10] ([202.141.79.10]:49937 "HELO mail.krec.ernet.in")
	by vger.kernel.org with SMTP id <S266884AbRGYLEA>;
	Wed, 25 Jul 2001 07:04:00 -0400
Date: Wed, 25 Jul 2001 05:43:18 +0530 (IST)
From: Mohanan P G <pgm@krec.ernet.in>
To: <linux-kernel@vger.kernel.org>
Subject: Panic on boot (Intel system )
Message-ID: <Pine.LNX.4.30.0107250542190.2447-100000@nanda.krec.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



To: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

The kernel (2.4.6 and 2.4.7) panics while booting.

[2.] Full description of the problem/report:
On this machine , kernel 2.4.6 compiled and used to boot cleanly when Redhat 7.0 was used. Now , after upgrading to a distribution based on Redhat 7.1 , it compiles, but panics while booting (Attempting to kill init!). I have tried it with kernel 2.4.6 and 2.4.7. The problem persists.
I compiled the kernel with egcs
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)

[3.] Keywords (i.e., modules, networking, kernel):
linux kernel 2.4.6 2.4.7 boot panic failure oops

[4.] Kernel version (from /proc/version):
Currently running:
Linux version 2.4.2-2 (root@porky.devel.redhat.com) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-79)) #1 Sun Apr 8 20:41:30 EDT 2001
Tried with 2.4.6 and 2.4.7

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

VFS: Mounted root (ext2 filesystem) readonly
Freeing unused kernel memory: 192k freed
Unable to handle kernel paging request at virtual address ffffff7b
printing eip:
c0119d9f
*pde=00001063
*pte=00000000
Oops=0002
CPU=0
EIP: 0010 [<c0119d9f>]
EFLAGS: 00010002
eax: ffffff7b	ebx: 00000004	ecx: ffffff7b	edx: c7ff5000
ese: c1255f38	edi: 00000004	ebp: c1254558	esp: c1255eb4
ds: 0018	es: 0018	ss: 0018
Process init (pid:1 stackpage=c1255000)
Stack: c1254000 00000286 00000004 00000000 c0119e6d 00000004 c1255f38 c1254558
       c1254000 00000286 00000004 c0119f1c 00000004 c1255f38 c1254000 c1254000
       00000286 00000000 00000004 c0119fb9 00000004 c1255f38 c1254000 c1254000
CallTrace: [<c0119e6d>] [<c0119f1c>] [<c0119fb9>] [<c0107244>] [<c01072a3>] [<c012026d>] [<c01202b1>]
[<c0106c4c>]
Code c7 01 00 00 00 00 8b 45 04 89 08 89 4d 04 85 f6 74 07 83 fe
Kernel panic: Attempted to kill init!
----
I used ksymoops
ksymoops -v ../linux/vmlinux  -K -L -S -o /lib/modules/2.4.7/ -m /boot/System.map-2.4.7 <oops >oops.out
It gave this output:

ksymoops 2.4.0 on i686 2.4.2-2.  Options used
     -v ../linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.7/ (specified)
     -m /boot/System.map-2.4.7 (specified)
     -S

No modules in ksyms, skipping objects
Unable to handle kernel paging request at virtual address ffffff7b
c0119d9f
EIP: 0010 [<c0119d9f>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: ffffff7b   ebx: 00000004     ecx: ffffff7b       edx: c7ff5000
ds: 0018        es: 0018       ss: 0018
Process init (pid:1 stackpage=c1255000)
Stack: c1254000 00000286 00000004 00000000 c0119e6d 00000004 c1255f38 c1254558
       c1254000 00000286 00000004 c0119f1c 00000004 c1255f38 c1254000 c1254000
       00000286 00000000 00000004 c0119fb9 00000004 c1255f38 c1254000 c1254000
[<c0106c4c>]
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; c0119d9f <send_signal+3f/f0>   <=====

1 warning issued.  Results may not be reliable.
-----
[6.] A small shell script or example program which triggers the
     problem (if possible)
panic on boot. Output given above.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux vyasa.ccc.krec.ernet.in 2.4.2-2 #1 Sun Apr 8 20:41:30 EDT 2001 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10s
mount                  2.11b
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0f
pcmcia-cs              3.1.22
PPP                    2.4.0
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         8139too autofs nls_iso8859-1 nls_cp437 vfat fat
[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 863.873
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 3
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1723.59

[7.3.] Module information (from /proc/modules):

8139too                16480   1
autofs                 11264   1 (autoclean)
nls_iso8859-1           2880   1 (autoclean)
nls_cp437               4384   1 (autoclean)
vfat                    9392   1 (autoclean)
fat                    32672   0 (autoclean) [vfat]
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

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
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  c000-c0ff : PCI device 1186:1300 (D-Link System Inc)
    c000-c0ff : eth0
d800-d8ff : Intel Corporation 82801AA AC'97 Audio
dc00-dc3f : Intel Corporation 82801AA AC'97 Audio
f000-f00f : Intel Corporation 82801AA IDE
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07eeffff : System RAM
  00100000-002557df : Kernel code
  002557e0-0026c80b : Kernel data
07ef0000-07ef2fff : ACPI Non-volatile Storage
07ef3000-07efffff : ACPI Tables
d0000000-d3ffffff : Intel Corporation 82810E CGC [Chipset Graphics Controller]
d4000000-d5ffffff : PCI Bus #01
  d5000000-d50000ff : PCI device 1186:1300 (D-Link System Inc)
    d5000000-d50000ff : eth0
d6000000-d607ffff : Intel Corporation 82810E CGC [Chipset Graphics Controller]
ffb00000-ffffffff : reserved
[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 82810E GMCH [Graphics Memory Controller Hub] (rev 03)
	Subsystem: Intel Corporation 82810E GMCH [Graphics Memory Controller Hub]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0

00:01.0 VGA compatible controller: Intel Corporation 82810E CGC [Chipset Graphics Controller] (rev 03) (prog-if 00 [VGA])
	Subsystem: Intel Corporation 82810E CGC [Chipset Graphics Controller]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at d6000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: <available only to root>

00:1e.0 PCI bridge: Intel Corporation 82801AA PCI Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: d4000000-d5ffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801AA ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if 80 [Master])
	Subsystem: Intel Corporation 82801AA IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at f000 [size=16]

00:1f.5 Multimedia audio controller: Intel Corporation 82801AA AC'97 Audio (rev 02)
	Subsystem: Analog Devices SoundMAX Integrated Digital Audio
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at d800 [size=256]
	Region 1: I/O ports at dc00 [size=64]

01:05.0 Ethernet controller: D-Link System Inc DFE-538TX (rev 10)
	Subsystem: D-Link System Inc DFE-538TX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at c000 [size=256]
	Region 1: Memory at d5000000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>

[7.6.] SCSI information (from /proc/scsi/scsi)
Not applicable

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
None
[X.] Other notes, patches, fixes, workarounds:
None

Thank you
My Machine: Wipro SuperGenius 9100ME (from Wipro, India)
Total Processors: 1
i686            : Processor
vendor_id	: GenuineIntel
model name	: Pentium III (Coppermine)
cpu MHz		: 863.873
cache size	: 256 KB
Main Memory Size: 125640 Kbytes
Host:ide0 Channel:hda
ST320413A
Host:ide Channel:hdd
CD-ROM 52X/AKH
Serial Ports: 2
Keyboard Detected: 1
    VGA compatible controller: Intel Corporation 82810E CGC [Chipset Graphics Controller] (rev 3).
    Multimedia audio controller: Intel Corporation 82801AA AC'97 Audio (rev 2).
    Ethernet controller: PCI device 1186:1300 (D-Link System Inc) (rev 16).
			 (D-Link DFE-538TX)
 I am using a linux distribution based on Redhat Linux 7.1 given by the
 PCQuest magazine (www.pcquest.com) , India

Submitted by

P G Mohanan, Systems Manager, CCC
KREC Surathkal , Srinivasnagar PO
DK,Karnataka , India  PIN 574 157

Email: pgm@krec.ernet.in


