Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266734AbRGFPgT>; Fri, 6 Jul 2001 11:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266731AbRGFPgK>; Fri, 6 Jul 2001 11:36:10 -0400
Received: from host210.digitalpulp.com ([209.176.7.210]:58884 "EHLO
	clapper.digitalpulp.com") by vger.kernel.org with ESMTP
	id <S266734AbRGFPgA>; Fri, 6 Jul 2001 11:36:00 -0400
Date: Thu, 5 Jul 2001 19:11:03 -0400 (EDT)
From: Chris Harwell <charwell@digitalpulp.com>
Reply-To: <charwell@digitalpulp.com>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: linux 2.4.6 SMP+i810_audio = oops&panic 
Message-ID: <Pine.LNX.4.33.0107051842520.1706-100000@clapper.digitalpulp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i get an oops w/ linux 2.4.x, SMP and i810_audio.
any suggestions?

details:


[1.] One line summary of the problem:
linux 2.4.6 SMP+i810_audio = oops&panic

[2.] Full description of the problem/report:

play an mp3 - get an oops. if not the first time then the second. the oops
comes at the end of the song (maybe when /dev/audio is closed or some
clean-up occurs?)

this only happens with an SMP kernel.

the only differences in my config files are:
61,62c61,62
< CONFIG_SMP=y
< CONFIG_HAVE_DEC_LOCK=y
---
> # CONFIG_SMP is not set
> # CONFIG_X86_UP_IOAPIC is not set
69,70d68
< CONFIG_X86_IO_APIC=y
< CONFIG_X86_LOCAL_APIC=y

audio is on-board i810_audio

i took the time to check all versions and use egcs this time w/ 2.4.6,
but i've seen the same behavior w/ all the 2.4.x kernels i've run -
some from kernel.org and the two from redhat.

[3.] Keywords (i.e., modules, networking, kernel):
sound
symmetric multi-processing
oops
i810_audio

[4.] Kernel version (from /proc/version):
see [5.]

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
(i have 3 more of these if anyone wants them under slightly different compiler or kernels
and i can make more... )

Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/specs
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)

ksymoops 2.4.0 on i686 2.4.6-2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.6-2/ (default)
     -m /boot/System.map-2.4.6-2 (default)

[snip]

Unable to handle kernel NULL pointer dereference at virtual address 00000104 printing eip: c8918d63
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c8918d63>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c3541f50   ebx: c06cccf0   ecx: 00000000   edx: c3541c00
esi: c06cccc0   edi: 0000dc80   ebp: 00000000   esp: c6605e90
ds: 0018   es: 0018   ss: 0018
Process esd (pid: 1571. stackpage=c6605000)
Stack: c3541c00 00000040 c3541c00 00000011 c3541f50 00000000 c6604000 c8918e6b
       c3541c00 c26bfa80 04000001 00000000 c0108486 00000011 c3541c00 c6605f0c
       00000220 c026ea20 00000011 c6605f04 c0108679 00000011 c6605f0c c26bfa80
Call Trace: [<c0108486>] [<c0108679>] [<c0106da4>] [<c0134065>] [<c0132f30>] [<c0132f97>] [<c0106d1b>]
Code: 03 b9 04 01 00 00 89 7c 24 18 83 c7 06 66 89 7c 24 16 89 fa

>>EIP; c8918d63 <END_OF_CODE+1e21c/????>   <=====
Trace; c0108486 <handle_IRQ_event+4e/78>
Trace; c0108679 <do_IRQ+99/e4>
Trace; c0106da4 <ret_from_intr+0/7>
Trace; c0134065 <fput+39/d4>
Trace; c0132f30 <filp_close+b0/bc>
Trace; c0132f97 <sys_close+5b/74>
Trace; c0106d1b <system_call+33/38>
Code;  c8918d63 <END_OF_CODE+1e21c/????>
00000000 <_EIP>:
Code;  c8918d63 <END_OF_CODE+1e21c/????>   <=====
   0:   03 b9 04 01 00 00         add    0x104(%ecx),%edi   <=====
Code;  c8918d69 <END_OF_CODE+1e222/????>
   6:   89 7c 24 18               mov    %edi,0x18(%esp,1)
Code;  c8918d6d <END_OF_CODE+1e226/????>
   a:   83 c7 06                  add    $0x6,%edi
Code;  c8918d70 <END_OF_CODE+1e229/????>
   d:   66 89 7c 24 16            mov    %di,0x16(%esp,1)
Code;  c8918d75 <END_OF_CODE+1e22e/????>
  12:   89 fa                     mov    %edi,%edx

Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the
     problem (if possible)

mpg123 13\ The\ Flag.mp3

(not specific to bare naked ladies, happens with other groups too...;)

[7.] Environment
Dell Precision 220 Dual PIII
Redhat 7.1

free -m
             total       used       free     shared    buffers     cached
Mem:           123        107         16          0          2         56
-/+ buffers/cache:         47         76
Swap:          517          0        517

[7.1.] Software (add the output of the ver_linux script here)
Linux clapper.digitalpulp.com 2.4.6 #2 Thu Jul 5 13:20:26 EDT 2001 i686
unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10s
mount                  2.11b
modutils               2.4.6
e2fsprogs              1.19
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         nfsd lockd sunrpc 3c59x ipt_REJECT ipt_LOG
ipt_limit ipt_state iptable_filter ip_conntrack_ftp ip_conntrack ip_tables
nls_iso8859-1 isofs loop


(i actually used CC=egcs
egcs -v gives: Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/specs
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)
)

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 797.975
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1592.52

(above in uniprocessor mode)
[7.3.] Module information (from /proc/modules):

i810_audio             14160   1 (autoclean)
ac97_codec              8672   0 (autoclean) [i810_audio]
soundcore               3888   2 (autoclean) [i810_audio]
nfs                    74288   1 (autoclean)
nfsd                   69776   8 (autoclean)
lockd                  49824   1 (autoclean) [nfs nfsd]
sunrpc                 62288   1 (autoclean) [nfs nfsd lockd]
3c59x                  25408   1 (autoclean)
ipt_REJECT              3264   5 (autoclean)
ipt_LOG                 3696  13 (autoclean)
ipt_limit               1312  17 (autoclean)
ipt_state                960 630 (autoclean)
iptable_filter          2080   0 (autoclean) (unused)
ip_conntrack_ftp        4112   0 (unused)
ip_conntrack           21968   2 [ipt_state ip_conntrack_ftp]
ip_tables              13408   5 [ipt_REJECT ipt_LOG ipt_limit ipt_state
iptable_filter]
nls_iso8859-1           2880   7 (autoclean)
isofs                  18016   7 (autoclean)
loop                    8048  14 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 82820 820 (Camino) Chipset Host Bridge (MCH) (rev 04)
	Subsystem: Dell Computer Corporation: Unknown device 0095
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 82820 820 (Camino) Chipset PCI to AGP Bridge (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fc000000-fdffffff
	Prefetchable memory behind bridge: f4000000-f5ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corporation 82801AA PCI Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fa000000-fbffffff
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
	Region 4: I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corporation 82801AA USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation 82801AA USB
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at ff80 [size=32]

00:1f.3 SMBus: Intel Corporation 82801AA SMBus (rev 02)
	Subsystem: Intel Corporation 82801AA SMBus
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at dcd0 [size=16]

00:1f.5 Multimedia audio controller: Intel Corporation 82801AA AC'97 Audio (rev 02)
	Subsystem: Dell Computer Corporation: Unknown device 0095
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at d800 [size=256]
	Region 1: I/O ports at dc80 [size=64]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 Dual Head Max
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at f4000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at fcffc000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at fc000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at 80000000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1

02:07.0 SCSI storage controller: Adaptec 7892A (rev 02)
	Subsystem: Adaptec: Unknown device 62a0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	BIST result: 00
	Region 0: I/O ports at ec00 [disabled] [size=256]
	Region 1: Memory at fafff000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at fb000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 78)
	Subsystem: Dell Computer Corporation: Unknown device 0095
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at e880 [size=128]
	Region 1: Memory at faffec00 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at fb000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=2 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DDRS-39130W      Rev: S92A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: QUANTUM  Model: ATLAS10K2-TY092L Rev: DA40
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 09 Lun: 00
  Vendor: QUANTUM  Model: ATLAS V  9 WLS   Rev: 0201
  Type:   Direct-Access                    ANSI SCSI revision: 03


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

 [X.] Other notes, patches, fixes, workarounds:

to avoid:
if SMP, don't uses audio (alias modules to off in /etc/modules.conf )
or compile uniprocessor



-- 
chris
charwell@digitalpulp.com

