Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261513AbSIXBDX>; Mon, 23 Sep 2002 21:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261533AbSIXBDX>; Mon, 23 Sep 2002 21:03:23 -0400
Received: from tantale.fifi.org ([216.27.190.146]:4482 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id <S261513AbSIXBDM>;
	Mon, 23 Sep 2002 21:03:12 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.19: oops in ide-scsi
From: Philippe Troin <phil@fifi.org>
Date: 23 Sep 2002 18:08:23 -0700
Message-ID: <87n0q8tcs8.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    

Reading on /dev/cdrom crashes the kernel.

[2.] Full description of the problem/report:

When dd'ing from /dev/cdrom (managed) by ide-scsi, the kernel
reboots. Ooops was caught by kmsgdump.

[3.] Keywords (i.e., modules, networking, kernel):

ide-scsi cdrom ide oops

[4.] Kernel version (from /proc/version):

Linux version 2.4.19 (root@ceramic) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Wed Aug 14 17:42:02 PDT 2002

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

ksymoops 2.4.5 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

<1>Unable to handle kernel paging request at virtual address f6e8db63
<6>c68204e0
<1>*pde = 00000000
<6>Oops: 0002
<6>CPU:    0
<6>EIP:    0010:[<c68204e0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
<6>EFLAGS: 00013202
<6>eax: 00000051   ebx: c089c000   ecx: c0305744   edx: 00000177
<6>esi: c11c3ac0   edi: f6e8db4b   ebp: c03058d4   esp: c02a3f04
<6>ds: 0018   es: 0018   ss: 0018
<6>Process swapper (pid: 0, stackpage=c02a3000)
<6>Stack: c03058d4 c11fcd60 00003282 c0305744 00003002 c0305851 c01b002c c03058d4 
<6>       c117aa40 04000001 00000000 0000000f c682046c c010a394 0000000f c11fcd60 
<6>       c02a3f84 c02e7640 c02bc9e0 0000000f c02a3f7c c010a586 0000000f c02a3f84 
<6>Call Trace:    [<c01b002c>] [<c682046c>] [<c010a394>] [<c010a586>] [<c010caf8>]
<6>  [<c0106c7c>] [<c68c8415>] [<c68c830c>] [<c0106c50>] [<c0106ce2>] [<c0105000>]
<6>  [<c010504f>]
<6>Code: ff 47 18 8b 85 f0 00 00 00 8b 40 04 50 6a 01 e8 24 fd ff ff 


>>EIP; c68204e0 <[ide-scsi]idescsi_pc_intr+74/23c>   <=====

>>ebx; c089c000 <_end+587294/64ed294>
>>ecx; c0305744 <ide_hwifs+364/21e8>
>>esi; c11c3ac0 <_end+eaed54/64ed294>
>>edi; f6e8db4b <END_OF_CODE+30541cac/????>
>>ebp; c03058d4 <ide_hwifs+4f4/21e8>
>>esp; c02a3f04 <init_task_union+1f04/2000>

Trace; c01b002c <ide_intr+f8/164>
Trace; c682046c <[ide-scsi]idescsi_pc_intr+0/23c>
Trace; c010a394 <handle_IRQ_event+50/7c>
Trace; c010a586 <do_IRQ+a6/ec>
Trace; c010caf8 <call_do_IRQ+5/d>
Trace; c0106c7c <default_idle+2c/34>
Trace; c68c8415 <[apm]apm_cpu_idle+109/13c>
Trace; c68c830c <[apm]apm_cpu_idle+0/13c>
Trace; c0106c50 <default_idle+0/34>
Trace; c0106ce2 <cpu_idle+3e/54>
Trace; c0105000 <_stext+0/0>
Trace; c010504f <rest_init+4f/50>

Code;  c68204e0 <[ide-scsi]idescsi_pc_intr+74/23c>
00000000 <_EIP>:
Code;  c68204e0 <[ide-scsi]idescsi_pc_intr+74/23c>   <=====
   0:   ff 47 18                  incl   0x18(%edi)   <=====
Code;  c68204e3 <[ide-scsi]idescsi_pc_intr+77/23c>
   3:   8b 85 f0 00 00 00         mov    0xf0(%ebp),%eax
Code;  c68204e9 <[ide-scsi]idescsi_pc_intr+7d/23c>
   9:   8b 40 04                  mov    0x4(%eax),%eax
Code;  c68204ec <[ide-scsi]idescsi_pc_intr+80/23c>
   c:   50                        push   %eax
Code;  c68204ed <[ide-scsi]idescsi_pc_intr+81/23c>
   d:   6a 01                     push   $0x1
Code;  c68204ef <[ide-scsi]idescsi_pc_intr+83/23c>
   f:   e8 24 fd ff ff            call   fffffd38 <_EIP+0xfffffd38> c6820218 <[ide-scsi]idescsi_end_request+0/254>

<6> <0>Kernel panic: Aiee, killing interrupt handler!
1+0 records in
1+0 records out

1 warning issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the
     problem (if possible)

dd bs=1k count=650000 < /dev/cdrom > /dev/null

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Debian GNU/Linux 3.0

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux electrolyt 2.4.19 #1 SMP Wed Aug 14 17:42:02 PDT 2002 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         microcode mousedev input usb-uhci usbcore lvm-mod apm opl3 sb sb_lib uart401 isa-pnp sound soundcore nfsd nfs lockd sunrpc vfat msdos fat isofs sg sr_mod cdrom ide-scsi loop floppy 3c59x af_packet

[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Celeron (Covington)
stepping	: 0
cpu MHz		: 267.275
cache size	: 32 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 532.48

[7.3.] Module information (from /proc/modules):

microcode               3744   0 (autoclean)
mousedev                3904   1
input                   3232   0 [mousedev]
usb-uhci               21860   0 (unused)
usbcore                56544   1 [usb-uhci]
lvm-mod                61152   9
apm                     9536   1
opl3                   11080   0 (unused)
sb                      7392   0 (unused)
sb_lib                 33184   0 [sb]
uart401                 6112   0 [sb_lib]
isa-pnp                27580   0 [sb]
sound                  54124   0 [opl3 sb_lib uart401]
soundcore               3460   5 [sb_lib sound]
nfsd                   66336   8
nfs                    73564   5
lockd                  47104   1 [nfsd nfs]
sunrpc                 61428   1 [nfsd nfs lockd]
vfat                    9276   0 (unused)
msdos                   4796   0 (unused)
fat                    29656   0 [vfat msdos]
isofs                  17376   0 (unused)
sg                     25252   0 (unused)
sr_mod                 11576   0 (unused)
cdrom                  28672   0 [sr_mod]
ide-scsi                7520   0
loop                    8560   0
floppy                 45952   0
3c59x                  25544   1
af_packet              13128   0 (unused)

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
0213-0213 : isapnp read
0220-022f : soundblaster
02f8-02ff : serial(set)
0330-0333 : MPU-401 UART
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
4000-403f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
5000-501f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
6400-641f : Intel Corp. 82371AB/EB/MB PIIX4 USB
  6400-641f : usb-uhci
6800-687f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
  6800-687f : 00:09.0
e000-efff : PCI Bus #01
f000-f00f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c87ff : Extension ROM
000f0000-000fffff : System ROM
00100000-05ffffff : System RAM
  00100000-0022ba21 : Kernel code
  0022ba22-002a02bf : Kernel data
a8000000-afffffff : PCI Bus #01
d8000000-dfffffff : PCI Bus #01
e0000000-e3ffffff : Intel Corp. 440LX/EX - 82443LX/EX Host bridge
e4000000-e7ffffff : S3 Inc. ViRGE/DX or /GX
e8000000-e800007f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp. 440LX/EX - 82443LX/EX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440LX/EX - 82443LX/EX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: d8000000-dfffffff
	Prefetchable memory behind bridge: a8000000-afffffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 6400 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 01)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 6800 [size=128]
	Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0b.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01) (prog-if 00 [VGA])
	Subsystem: S3 Inc. ViRGE/DX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=64K]

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor:          Model: ATAPI CDROM      Rev: 1.20
  Type:   CD-ROM                           ANSI SCSI revision: 0

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

N/A

[X.] Other notes, patches, fixes, workarounds:

Vanilla 2.4.19 plus kmsgdump patches.
