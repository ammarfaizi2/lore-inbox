Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287149AbSCWBCG>; Fri, 22 Mar 2002 20:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287862AbSCWBB5>; Fri, 22 Mar 2002 20:01:57 -0500
Received: from soapstone.yuri.org.uk ([62.140.197.186]:35500 "EHLO
	soapstone.yuri.org.uk") by vger.kernel.org with ESMTP
	id <S287149AbSCWBBk>; Fri, 22 Mar 2002 20:01:40 -0500
Date: Sat, 23 Mar 2002 01:01:30 +0000
From: murble <murble-atmbits@yuri.org.uk>
To: linux-kernel@vger.kernel.org
Cc: linux-atm-general@lists.sourceforge.net
Subject: Oops: Linux ATM Interphase card.
Message-ID: <20020323010130.GA20579@yuri.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.7 i686
X-Date: Today is Boomtime, the 9th day of Discord in the YOLD 3168
X-Scanner: exiscan *16oZuU-0005R8-00*8w3cy67/cKk* (The Yuri Organisation, London, United Kingdom of Great Britian and Northern Ireland)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

[1.] One line summary of the problem:    
Interphase x531 driver oopses when sonetdiag is run.

[2.] Full description of the problem/report:
suni.o oops when ioctl(4, SONET_GETSTAT) is called
from drivers/atm/suni.c

suni_ioctl(struct atm_dev *dev,unsigned int cmd,void *arg)

...
                case SONET_GETSTATZ:
                case SONET_GETSTAT:
                        return fetch_stats(dev,(struct sonet_stats *) arg,
                            cmd == SONET_GETSTATZ);

When the sonetdiag program from the atm-0.79
[3.] Keywords (i.e., modules, networking, kernel):
modules, atm, networking, sonetdiag
[4.] Kernel version (from /proc/version):
Linux version 2.4.19-pre2-ac2 (root@sansys4) (gcc version 2.95.4 (Debian prerelease)) #1 Tue Mar 5 12:52:36 GMT 2002

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)


ksymoops 2.4.3 on i686 2.4.19-pre2-ac2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre2-ac2/ (default)
     -m /boot/System.map-2.4.19-pre2-ac2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000004
c8842bee
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c8842bee>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292
eax: 00000000   ebx: bffffd3c   ecx: c7fd2b60   edx: 80246110
esi: bffffd3c   edi: c5453e04   ebp: c7fd2b60   esp: c54fd6f0
ds: 0018   es: 0018   ss: 0018
Process sonetdiag (pid: 481, stackpage=c54fd000)
Stack: bffffd3c 00000024 c5453e04 c7fd2b60 40169444 4016943c 40169434 4016942c 
       40169424 4016941c 40169414 4016940c 40169404 40169466 40169464 40169462 
       40169460 4016945e 4016945c 4016945a 40169458 40169456 40169454 00000030 
Call Trace: [<c0199327>] [<c0198632>] [<c0199327>] [<c019c936>] [<c0192fd7>] 
   [<c0193037>] [<c0193397>] [<c01119b9>] [<c01230f9>] [<c012acae>] [<c012edde>] 
   [<c0120d63>] [<c0120e4e>] [<c0110c0f>] [<c0110af8>] [<c0200a81>] [<c01212e5>] 
   [<c0121852>] [<c0106ca4>] [<c01ff6ce>] [<c0106ca4>] [<c01ff6ce>] [<c01469bc>] 
   [<c01479d2>] [<c01470a4>] [<c0122fc3>] [<c01242f4>] [<c012edde>] [<c0120d63>] 
   [<c0120e4e>] [<c0110c0f>] [<c01fc580>] [<c0122019>] [<c01b8825>] [<c013cb89>] 
   [<c0106ca4>] [<c0106bb3>] 
Code: 83 78 04 00 75 0c b8 ea ff ff ff e9 e6 04 00 00 89 f6 56 52 

>>EIP; c8842bee <[iphase]ia_ioctl+2a/52c>   <=====
Trace; c0199326 <piix_dmaproc+22/2c>
Trace; c0198632 <ide_dmaproc+1b2/278>
Trace; c0199326 <piix_dmaproc+22/2c>
Trace; c019c936 <do_rw_disk+2de/530>
Trace; c0192fd6 <start_request+146/220>
Trace; c0193036 <start_request+1a6/220>
Trace; c0193396 <ide_do_request+286/2d4>
Trace; c01119b8 <schedule+1f8/20c>
Trace; c01230f8 <__lock_page+cc/d8>
Trace; c012acae <__alloc_pages+5e/2b0>
Trace; c012edde <page_add_rmap+2a/40>
Trace; c0120d62 <do_no_page+1d2/1f8>
Trace; c0120e4e <handle_mm_fault+c6/140>
Trace; c0110c0e <do_page_fault+116/42c>
Trace; c0110af8 <do_page_fault+0/42c>
Trace; c0200a80 <rb_insert_color+50/c4>
Trace; c01212e4 <__vma_link+60/b0>
Trace; c0121852 <do_mmap_pgoff+422/4f8>
Trace; c0106ca4 <error_code+34/3c>
Trace; c01ff6ce <clear_user+2e/3c>
Trace; c0106ca4 <error_code+34/3c>
Trace; c01ff6ce <clear_user+2e/3c>
Trace; c01469bc <padzero+1c/20>
Trace; c01479d2 <load_elf_binary+92e/a80>
Trace; c01470a4 <load_elf_binary+0/a80>
Trace; c0122fc2 <___wait_on_page+aa/b4>
Trace; c01242f4 <filemap_nopage+bc/248>
Trace; c012edde <page_add_rmap+2a/40>
Trace; c0120d62 <do_no_page+1d2/1f8>
Trace; c0120e4e <handle_mm_fault+c6/140>
Trace; c0110c0e <do_page_fault+116/42c>
Trace; c01fc580 <atm_ioctl+bc4/c40>
Trace; c0122018 <do_munmap+234/244>
Trace; c01b8824 <sock_ioctl+20/28>
Trace; c013cb88 <sys_ioctl+25c/274>
Trace; c0106ca4 <error_code+34/3c>
Trace; c0106bb2 <system_call+32/38>
Code;  c8842bee <[iphase]ia_ioctl+2a/52c>
00000000 <_EIP>:
Code;  c8842bee <[iphase]ia_ioctl+2a/52c>   <=====
   0:   83 78 04 00               cmpl   $0x0,0x4(%eax)   <=====
Code;  c8842bf2 <[iphase]ia_ioctl+2e/52c>
   4:   75 0c                     jne    12 <_EIP+0x12> c8842c00 <[iphase]ia_ioctl+3c/52c>
Code;  c8842bf4 <[iphase]ia_ioctl+30/52c>
   6:   b8 ea ff ff ff            mov    $0xffffffea,%eax
Code;  c8842bf8 <[iphase]ia_ioctl+34/52c>
   b:   e9 e6 04 00 00            jmp    4f6 <_EIP+0x4f6> c88430e4 <[iphase]ia_ioctl+520/52c>
Code;  c8842bfe <[iphase]ia_ioctl+3a/52c>
  10:   89 f6                     mov    %esi,%esi
Code;  c8842c00 <[iphase]ia_ioctl+3c/52c>
  12:   56                        push   %esi
Code;  c8842c00 <[iphase]ia_ioctl+3c/52c>
  13:   52                        push   %edx


1 warning issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the
     problem (if possible)

	just running sonetdiag works when the driver is loaded

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux sansys4 2.4.19-pre2-ac2 #1 Tue Mar 5 12:52:36 GMT 2002 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.13
e2fsprogs              1.26
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         nfs lockd sunrpc 3c59x rtc

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 498.478
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 992.87

[7.3.] Module information (from /proc/modules):
nfs                    69660   1 (autoclean)
lockd                  46656   1 (autoclean) [nfs]
sunrpc                 57428   1 (autoclean) [nfs lockd]
3c59x                  24840   1
rtc                     5528   0 (autoclean)

normally iphase and suni are loaded, but as explained above this
card has been removed and i can't access it for a few days.

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fc000000-feffffff
	Prefetchable memory behind bridge: f9000000-f9ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at dce0 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
	Subsystem: Dell Computer Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at dc00 [size=128]
	Region 1: Memory at ff000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at fb000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X (rev 5c) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation Optiplex GX1 Onboard Display Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at ec00 [size=256]
	Region 2: Memory at fcfff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


[7.6.] SCSI information (from /proc/scsi/scsi)
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

It seems to work
[X.] Other notes, patches, fixes, workarounds:

straces sonetdiag shows

socket(0x8 /* AF_ATMPVC? */, SOCK_DGRAM, 0) = 4
ioctl(4, SONET_GETSTAT <unfinished ...>
+++ killed by SIGSEGV +++
at this point the oops has occured.


The drivers work ok even after the kernel has oops and general
ATM with Classical IP / ATM seems to be working fine.

I have the same problem with misc other 2.4.recent > 17 
kernels on various PC hardware.


murble
