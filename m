Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310498AbSCCCKc>; Sat, 2 Mar 2002 21:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310499AbSCCCKO>; Sat, 2 Mar 2002 21:10:14 -0500
Received: from p50847719.dip.t-dialin.net ([80.132.119.25]:18913 "EHLO
	sol.fo.et.local") by vger.kernel.org with ESMTP id <S310498AbSCCCKB>;
	Sat, 2 Mar 2002 21:10:01 -0500
To: linux-kernel@vger.kernel.org
Cc: support@sistina.com
Subject: PROBLEM: Oops during iozone over NFS against 2.4.18-rc4 + Trond's
 NFS Patches + Sistina's LVM2
From: Joachim Breuer <jmbreuer@gmx.net>
Date: Sun, 03 Mar 2002 03:09:53 +0100
Message-ID: <m3zo1q8kr2.fsf@venus.fo.et.local>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley,
 i386-redhat-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sistina: I'm NOT a support customer; consider me a voluntary beta
tester of LVM2. You might be interested in this...

[1.] One line summary of the problem:

  During performance test (using iozone) against nfs server with
  kernel 2.4.18-rc4 + linux-2.4.18-NFS_ALL.dif (provided against
  2.4.18-rc2, went in cleanly) from nfs.sourceforge.net + Sistina's
  LVM2 beta1.1, Oops occurs.

[2.] Full description of the problem/report:

  Client and Server running same aforementioned kernel, NFS parameters
  set to rsize==wsize==4096; udp. Exported FS is an ext3 on a LV on
  two PVs (linear/segmented, not striped), one is a complete SCSI disk
  (sda), the other is a partition of an IDE disk (hda5). "./iozone -ac
  -R -n 256m" showed results for write/rewrite/read/reread; showed
  "Error writing block at 219414528", "write: Input/output error",
  "iozone: interrupted" before random read result. Result "never"
  comes up (not in 15+ minutes), iozone appears hung (Ctrl-C won't
  break it, kill -9 does).

  Checking at the server shows oops detailed below, and high load
  (around 8, stays up even after iozone was killed). No processes on
  server show responsible for the load average in "top".

  Same iozone against other NFS server works (more than one iteration,
  this NFS server will be called "reference server" from here on). The
  reference server is different hardware (see next paragraph and
  [7.7]), esp. different ethernet controller. Reference server does
  *NOT* employ LVM; but *does* also use ext3.

  All boxen X86, server is a Celeron 900 (PIII-Core-based); client is
  a Pentium III 850; running identical kernels. Reference server is a
  dual Pentium Pro 200 SMP, using the same kernel modulo SMP turned
  on. More info on hardware available on request.

[3.] Keywords (i.e., modules, networking, kernel):

  NFS (Trond's NFS Patches), LVM, ext3

[4.] Kernel version (from /proc/version):

  Linux version 2.4.18-rc4 (jmbreuer@venus.fo.et.local) (gcc version
  2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 Tue Feb 26 18:11:31
  CET 2002

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

Assertion failure in journal_dirty_data_R79f5b221() at transaction.c:975: "jh->b_transaction == journal->j_committing_transaction"

ksymoops 2.4.3 on i686 2.4.18-rc4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-rc4/ (default)
     -m /boot/kernel/System.map-2.4.18-rc4 (specified)
     -i

invalid operand: 0000
CPU:    0
EIP:    0010:[tulip:__insmod_tulip_O/lib/modules/2.4.18-rc4/kernel/drivers/net/+-896957/96]    Not tainted
EIP:    0010:[<d083c043>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013296
eax: 00000086   ebx: c8741e3c   ecx: 00000009   edx: ce8c1f64
esi: 00000001   edi: cf774c00   ebp: c8e098c0   esp: cdbfdd0c
ds: 0018   es: 0018   ss: 0018
Process nfsd (pid: 1041, stackpage=cdbfd000)
Stack: d0841b20 d08414d5 d08413d0 000003cf d0841d40 00000000 c8e098c0 cb4344f0 
       00000000 00000000 c2be9860 c8e098c0 00000000 00001000 d0848bf6 c8e098c0 
       c2be9860 00000000 00007883 cf774a00 c0143da5 00003246 cdbfddac 00003246 
Call Trace: [tulip:__insmod_tulip_O/lib/modules/2.4.18-rc4/kernel/drivers/net/+-873696/96] [tulip:__insmod_tulip_O/lib/modules/2.4.18-rc4/kernel/drivers/net
Call Trace: [<d0841b20>] [<d08414d5>] [<d08413d0>] [<d0841d40>] [<d0848bf6>] 
   [<c0143da5>] [<d0840ec7>] [<d0848a2a>] [<d0848e31>] [<d0848be0>] [<d08486a0>] 
   [<c0127f93>] [<c019a5fa>] [<d095904c>] [<c010842c>] [<c010a468>] [<d0852ae0>] 
   [<d095e140>] [<d0964a60>] [<d0955577>] [<d0964a60>] [<d092c8d6>] [<d09643d8>] 
   [<d09643f8>] [<d0955387>] [<c0105726>] [<d09551b0>] 
Code: 0f 0b 83 c4 14 83 7b 08 02 0f 87 ac 00 00 00 8b 4c 24 30 85 

>>EIP; d083c042 <[jbd]journal_dirty_data+82/170>   <=====
Trace; d0841b20 <[jbd].LC4+20/40>
Trace; d08414d4 <[jbd].LC37+a/14>
Trace; d08413d0 <[jbd].LC10+c/1a>
Trace; d0841d40 <[jbd].LC15+0/40>
Trace; d0848bf6 <[ext3]journal_dirty_sync_data+16/60>
Trace; c0143da4 <iget4+44/d0>
Trace; d0840ec6 <[jbd]__jbd_kmalloc+26/80>
Trace; d0848a2a <[ext3]walk_page_buffers+5a/80>
Trace; d0848e30 <[ext3]ext3_commit_write+120/1d0>
Trace; d0848be0 <[ext3]journal_dirty_sync_data+0/60>
Trace; d08486a0 <[ext3]ext3_get_block+0/60>
Trace; c0127f92 <generic_file_write+4c2/6d0>
Trace; c019a5fa <net_rx_action+1ca/2a0>
Trace; d095904c <[nfsd]nfsd_write+14c/2d0>
Trace; c010842c <do_IRQ+9c/b0>
Trace; c010a468 <call_do_IRQ+6/e>
Trace; d0852ae0 <[ext3]ext3_file_operations+0/60>
Trace; d095e140 <[nfsd]nfsd3_proc_write+f0/110>
Trace; d0964a60 <[nfsd]nfsd_procedures3+e0/2c0>
Trace; d0955576 <[nfsd]nfsd_dispatch+b6/190>
Trace; d0964a60 <[nfsd]nfsd_procedures3+e0/2c0>
Trace; d092c8d6 <[sunrpc]svc_process+306/4c0>
Trace; d09643d8 <[nfsd]nfsd_version3+0/10>
Trace; d09643f8 <[nfsd]nfsd_program+0/1c>
Trace; d0955386 <[nfsd]nfsd+1d6/310>
Trace; c0105726 <kernel_thread+26/30>
Trace; d09551b0 <[nfsd]nfsd+0/310>
Code;  d083c042 <[jbd]journal_dirty_data+82/170>
00000000 <_EIP>:
Code;  d083c042 <[jbd]journal_dirty_data+82/170>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  d083c044 <[jbd]journal_dirty_data+84/170>
   2:   83 c4 14                  add    $0x14,%esp
Code;  d083c046 <[jbd]journal_dirty_data+86/170>
   5:   83 7b 08 02               cmpl   $0x2,0x8(%ebx)
Code;  d083c04a <[jbd]journal_dirty_data+8a/170>
   9:   0f 87 ac 00 00 00         ja     bb <_EIP+0xbb> d083c0fc <[jbd]journal_dirty_data+13c/170>
Code;  d083c050 <[jbd]journal_dirty_data+90/170>
   f:   8b 4c 24 30               mov    0x30(%esp,1),%ecx
Code;  d083c054 <[jbd]journal_dirty_data+94/170>
  13:   85 00                     test   %eax,(%eax)


[6.] A small shell script or example program which triggers the
     problem (if possible)

  ./iozone -ac -R -n 256m

  against an ext3 filesystem on an LVM2 beta1.1 through NFS (both
  client and server using Trond's Patches)

[7.] Environment

  If not seperately indicated, only information of the oopsing server
  is shown. Further info also on the other machines on request.

[7.1.] Software (add the output of the ver_linux script here)

Linux terra.fo.et.local 2.4.18-rc4 #1 Tue Feb 26 18:11:31 CET 2002 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.6
e2fsprogs              1.23
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         es1370 gameport soundcore nfs mga agpgart nfsd lockd sunrpc autofs tulip af_packet md ospm_thermal ospm_processor ospm_button ospm_system ospm_busmgr lvm-mod dm-mod sr_mod cdrom sd_mod aic7xxx scsi_mod usb-uhci usbcore rtc unix ext3 jbd ide-disk ide-probe-mod ide-mod

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Celeron (Coppermine)
stepping        : 10
cpu MHz         : 896.854
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1789.13

[7.3.] Module information (from /proc/modules):

es1370                 25008   0 (autoclean)
gameport                1552   0 (autoclean) [es1370]
soundcore               3664   4 (autoclean) [es1370]
nfs                    74944   1 (autoclean)
mga                    98528   0
agpgart                31072   1
nfsd                   66656   8 (autoclean)
lockd                  47344   1 (autoclean) [nfs nfsd]
sunrpc                 62240   1 (autoclean) [nfs nfsd lockd]
autofs                  9120   3 (autoclean)
tulip                  37456   1
af_packet              11968   0 (autoclean)
md                     44000   0 (unused)
ospm_thermal            5808   0 (unused)
ospm_processor          5616   0 (unused)
ospm_button             3264   0 (unused)
ospm_system             5936   0 (unused)
ospm_busmgr            11616   0 [ospm_thermal ospm_processor ospm_button ospm_system]
lvm-mod                45536   0 (unused)
dm-mod                 24048   3
sr_mod                 12560   0
cdrom                  27872   0 [sr_mod]
sd_mod                 10800   4
aic7xxx               112640   2
scsi_mod               90432   3 [sr_mod sd_mod aic7xxx]
usb-uhci               21344   0 (unused)
usbcore                50112   1 [usb-uhci]
rtc                     5664   0 (autoclean)
unix                   13552  31
ext3                   57776   2
jbd                    36096   2 [ext3]
ide-disk                6736   3
ide-probe-mod           7712   0
ide-mod               148960   3 [ide-disk ide-probe-mod]

[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
5000-500f : Intel Corp. 82820 820 (Camino 2) Chipset SMBus
c000-cfff : PCI Bus #02
  c000-c03f : Ensoniq ES1370 [AudioPCI]
    c000-c03f : es1370
  c400-c4ff : Lite-On Communications Inc LNE100TX
    c400-c4ff : tulip
  c800-c8ff : Adaptec AHA-294x / AIC-7871
    c800-c8ff : aic7xxx
d000-d01f : Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub A)
  d000-d01f : usb-uhci
d800-d81f : Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub B)
  d800-d81f : usb-uhci
f000-f00f : Intel Corp. 82820 820 (Camino 2) Chipset IDE U100
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d27ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-001df582 : Kernel code
  001df583-00215c4b : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d0000000-d3ffffff : Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub
d4000000-d7ffffff : PCI Bus #01
  d4000000-d4003fff : Matrox Graphics, Inc. MGA G400 AGP
  d5000000-d57fffff : Matrox Graphics, Inc. MGA G400 AGP
d8000000-d9ffffff : PCI Bus #01
  d8000000-d9ffffff : Matrox Graphics, Inc. MGA G400 AGP
da000000-dbffffff : PCI Bus #02
  db000000-db0000ff : Lite-On Communications Inc LNE100TX
    db000000-db0000ff : tulip
  db001000-db001fff : Adaptec AHA-294x / AIC-7871
    db001000-db001fff : aic7xxx
ffb00000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 02)
        Subsystem: Intel Corporation 82815 815 Chipset Host Bridge and Memory Controller Hub
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [88] #09 [e104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: Intel Corporation: Unknown device 1131 (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: d4000000-d7ffffff
        Prefetchable memory behind bridge: d8000000-d9ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corporation 82801BAM PCI (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: da000000-dbffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (ICH2) (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 02) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at f000 [size=16]

00:1f.2 USB Controller: Intel Corporation 82801BA(M) USB (Hub A) (rev 02) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at d000 [size=32]

00:1f.3 SMBus: Intel Corporation 82801BA(M) SMBus (rev 02)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 9
        Region 4: I/O ports at 5000 [size=16]

00:1f.4 USB Controller: Intel Corporation 82801BA(M) USB (Hub B) (rev 02) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 9
        Region 4: I/O ports at d800 [size=32]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 82) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc.: Unknown device 0542
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at d4000000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at d5000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1

02:01.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
        Subsystem: Unknown device 4942:4c4c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at c000 [size=64]

02:03.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
        Subsystem: Netgear FA310TX
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at c400 [size=256]
        Region 1: Memory at db000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=256K]

02:04.0 SCSI storage controller: Adaptec AHA-294x / AIC-7871
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at c800 [disabled] [size=256]
        Region 1: Memory at db001000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=32K]

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DORS-32160       Rev: S82C
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-32CS   Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Server (the oopsed one):
eth0: Lite-On 82c168 PNIC rev 32 at 0xd0965000, 00:A0:CC:D2:C7:52, IRQ 10.
(NetGear FA-310TX)

Reference server (against which iozone works; doesn't use LVM):
eth0: NatSemi DP8381[56] at 0xd09e8000, 00:02:e3:13:e3:18, IRQ 5.
(Presumably NetGear FA-311TX)

Client (running iozone):
eth0: Lite-On 82c168 PNIC rev 32 at 0xd0a2a000, 00:A0:CC:5A:09:30, IRQ 11.
(Presumably NetGear FA-310TX)


[X.] Other notes, patches, fixes, workarounds:

  My limited understanding and tentative evidence point in the
  direction of LVM being not completely innocent (maybe in conjunction
  with the direct_io patches contained in Trond's NFS), but this is
  pure conjecture. I'll CC: the report to Sistina, anyway.


-- 
"I use emacs, which might be thought of as a thermonuclear
 word processor."
-- Neal Stephenson, "In the beginning... was the command line"
