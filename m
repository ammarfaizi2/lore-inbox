Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318276AbSGRQtB>; Thu, 18 Jul 2002 12:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318277AbSGRQtB>; Thu, 18 Jul 2002 12:49:01 -0400
Received: from [212.19.79.24] ([212.19.79.24]:20747 "EHLO
	bach.internetintelligence.co.uk") by vger.kernel.org with ESMTP
	id <S318276AbSGRQs4>; Thu, 18 Jul 2002 12:48:56 -0400
Message-ID: <3D36F148.E5EDA1A5@eyeeye.com>
Date: Thu, 18 Jul 2002 17:48:08 +0100
From: Simon Bazley <simon@eyeeye.com>
X-Mailer: Mozilla 4.79 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug report (involving ide and ide-cd)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
A server was in production, then hung with an Oops.  Seems to be to do
with ide-cd's IRQ's
[2.] Full description of the problem/report:
I left the server running cdparanoia, lifting wavs from a CD, while
running lame to convert a previous album to mp3, in a separate pts. I
had gone home.  Others were also using the server for file serving,
proxying shell accounts etc.  The server hung suddenly, console showed
an Oops.  Server was completely non-responsive so the Oops was written
down by hand.  I'm really not sure why this happened, but I guess it was
something to do with the CD (although lame wasn't using the CD so i'm
confused).
Server was totally unresponsive so other than the Oops on the console I
couldn't get any pertinent information.  However the server was reset
and rebooted with an almost identical setup, except for apache which had
to be started by hand.  All information below (except for the output
from ksymoops) was obtained from the current session (uptime 1 day, 1:21
hours since the oops at the time of writing this).
[3.] Keywords (i.e., modules, networking, kernel):
lame, kernel, ide-cd, ide, IRQ, lock
[4.] Kernel version (from /proc/version):
Linux version 2.4.18-3smp (bhcompile@daffy.perf.redhat.com) (gcc version
2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 SMP Thu Apr 18 07:27:31
EDT 2002
[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/aic7xxx.o) for aic7xxx
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
ksymoops: No such file or directory
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base
says c01cdaa0, System.map says c0168540.  Ignoring ksyms_base entry
Warning (map_ksym_to_module): cannot match loaded module ext3 to a
unique module object.  Trace may not be reliable.
Oops: 0000
CPU:    1
EIP:    0010:[<c0195db3>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 0001002
eax: 00003291   ebx: dd3fb7e0   ecx: 0000ca45   edx: 00000001
esi: dfec9e80   edi: 00000286   ebp: 00000003   esp: c5a19f18
ds: 0018   es: 0018   ss: 0018
Process lame (pid: 26866, stackpage=c5a19000)
Stack: dd3fb7e0 c01a023f dd3fb7e0 013fb8a0 00000930 c03cc0a8 dd3fb8a0
e08da3a7
       00000001 dfec9e80 00001000 c0130ace dd5e9540 00000050 dfec9e80
c03cc0a8
       00000282 c03cc064 c01a1ef8 c03cc0a8 e08da2f0 c170e9e0 00000001
04000001
Call Trace: [<c01a023f>] ide_end_request [kernel] 0x8f
            [<e08da3a7>] cdrom_pc_init [ide-cd] 0xb7
            [<c0130ace>] generic_file_read [kernel] 0x7e
            [<c01a1ef8>] ide_init [kernel] 0xe8
            [<e08da2f0>] cdrom_pc_intr [ide-cd] 0x0
            [<c010a53e>] handle_IRQ_event [kernel] 0x5e
            [<c010a745>] do_IRQ [kernel] 0xa5
Code: 8b 41 04 8d 51 04 89 58 04 89 03 89 53 04 8b 81 89 59 04 40

>>EIP; c0195db3 <blkdev_release_request+23/70>   <=====
Trace; c01a023f <ide_end_request+8f/a0>
Trace; e08da3a7 <[ide-cd]cdrom_pc_intr+b7/1c0>
Trace; c0130ace <generic_file_read+7e/130>
Trace; c01a1ef8 <ide_intr+e8/160>
Trace; e08da2f0 <[ide-cd]cdrom_pc_intr+0/1c0>
Trace; c010a53e <handle_IRQ_event+5e/90>
Trace; c010a745 <do_IRQ+a5/f0>
Code;  c0195db3 <blkdev_release_request+23/70>
00000000 <_EIP>:
Code;  c0195db3 <blkdev_release_request+23/70>   <=====
   0:   8b 41 04                  mov    0x4(%ecx),%eax   <=====
Code;  c0195db6 <blkdev_release_request+26/70>
   3:   8d 51 04                  lea    0x4(%ecx),%edx
Code;  c0195db9 <blkdev_release_request+29/70>
   6:   89 58 04                  mov    %ebx,0x4(%eax)
Code;  c0195dbc <blkdev_release_request+2c/70>
   9:   89 03                     mov    %eax,(%ebx)
Code;  c0195dbe <blkdev_release_request+2e/70>
   b:   89 53 04                  mov    %edx,0x4(%ebx)
Code;  c0195dc1 <blkdev_release_request+31/70>
   e:   8b 81 89 59 04 40         mov    0x40045989(%ecx),%eax


3 warnings and 5 errors issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the
     problem (if possible)
LAME version 3.92  (compiled locally)
[7.] Environment
All access to the server is via sshd, X was not running.
[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux strauss.internetintelligence.co.uk 2.4.18-3smp #1 SMP Thu Apr 18
07:27:31 EDT 2002 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.14
e2fsprogs              1.27
reiserfsprogs          3.x.0j
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         es1371 gameport ac97_codec soundcore ip_nat_irc
ip_conntrack_irc ip_nat_ftp ip_conntrack_ftp binfmt_misc autofs eepro100
ipt_REJECT ipt_LOG ipt_state iptable_nat ip_conntrack iptable_filter
ip_tables ide-cd cdrom usb-uhci usbcore ext3 jbd aic7xxx sd_mod scsi_mod

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 747.259
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1490.94

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 747.259
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1494.22

[7.3.] Module information (from /proc/modules):
es1371                 33216   0 (autoclean)
gameport                3632   0 (autoclean) [es1371]
ac97_codec             12064   0 (autoclean) [es1371]
soundcore               7236   4 (autoclean) [es1371]
ip_nat_irc              3872   0 (unused)
ip_conntrack_irc        3904   0 [ip_nat_irc]
ip_nat_ftp              4544   0 (unused)
ip_conntrack_ftp        5216   0 [ip_nat_ftp]
binfmt_misc             7780   1
autofs                 12804   0 (autoclean) (unused)
eepro100               20816   2
ipt_REJECT              4128   2 (autoclean)
ipt_LOG                 4800   5 (autoclean)
ipt_state               1536   3 (autoclean)
iptable_nat            22196   3 (autoclean) [ip_nat_irc ip_nat_ftp]
ip_conntrack           22924   4 (autoclean) [ip_nat_irc
ip_conntrack_irc ip_nat_ftp ip_conntrack_ftp ipt_state iptable_nat]
iptable_filter          2752   1 (autoclean)
ip_tables              14624   7 [ipt_REJECT ipt_LOG ipt_state
iptable_nat iptable_filter]
ide-cd                 30368   0 (autoclean)
cdrom                  32608   0 (autoclean) [ide-cd]
usb-uhci               25604   0 (unused)
usbcore                77024   1 [usb-uhci]
ext3                   70752   6
jbd                    53632   6 [ext3]
aic7xxx               125440   1
sd_mod                 12896   2
scsi_mod              112272   2 [aic7xxx sd_mod]

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
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0400-040f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0800-08ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0c00-0c7f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0cf8-0cff : PCI conf1
8000-9fff : PCI Bus #01
  9800-98ff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
c800-c81f : VIA Technologies, Inc. UHCI USB
  c800-c81f : usb-uhci
cc00-cc1f : VIA Technologies, Inc. UHCI USB (#2)
  cc00-cc1f : usb-uhci
d000-d03f : Intel Corp. 82557 [Ethernet Pro 100]
  d000-d03f : eepro100
d400-d43f : Intel Corp. 82557 [Ethernet Pro 100] (#2)
  d400-d43f : eepro100
d800-d83f : Ensoniq ES1371 [AudioPCI-97]
  d800-d83f : es1371
dc00-dcff : Adaptec 7892A
ffa0-ffaf : VIA Technologies, Inc. Bus Master IDE
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1


00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-002342b0 : Kernel code
  002342b1-00306b3f : Kernel data
1fff0000-1fff7fff : ACPI Tables
1fff8000-1fffffff : ACPI Non-volatile Storage
dd400000-dd4fffff : PCI Bus #01
dd600000-df6fffff : PCI Bus #01
  de000000-deffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
  df6ff000-df6fffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
dfc00000-dfcfffff : Intel Corp. 82557 [Ethernet Pro 100]
dfe00000-dfefffff : Intel Corp. 82557 [Ethernet Pro 100] (#2)
dfffd000-dfffdfff : Intel Corp. 82557 [Ethernet Pro 100]
  dfffd000-dfffdfff : eepro100
dfffe000-dfffefff : Intel Corp. 82557 [Ethernet Pro 100] (#2)
  dfffe000-dfffefff : eepro100
dffff000-dfffffff : Adaptec 7892A
  dffff000-dfffffff : aic7xxx
e0000000-e3ffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x] (rev c4)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00008000-00009fff
        Memory behind bridge: dd600000-df6fffff
        Prefetchable memory behind bridge: dd400000-dd4fffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 22)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at ffa0 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID): Unknown device
1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at c800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID): Unknown device
1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at cc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
        Subsystem: Adaptec 29160 Ultra160 SCSI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        BIST result: 00
        Region 0: I/O ports at dc00 [disabled] [size=256]
        Region 1: Memory at dffff000 (64-bit, non-prefetchable)
[size=4K]
        Expansion ROM at dffc0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Server Adapter
(PILA8470B)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at dfffd000 (32-bit, non-prefetchable)
[size=4K]
        Region 1: I/O ports at d000 [size=64]
        Region 2: Memory at dfc00000 (32-bit, non-prefetchable)
[size=1M]
        Expansion ROM at dfb00000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
        Region 0: Memory at dfffd000 (32-bit, non-prefetchable)
[size=4K]
        Region 1: I/O ports at d000 [size=64]
        Region 2: Memory at dfc00000 (32-bit, non-prefetchable)
[size=1M]
        Expansion ROM at dfb00000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0b.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
with Alert On LAN*
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at dfffe000 (32-bit, non-prefetchable)
[size=4K]
        Region 1: I/O ports at d400 [size=64]
        Region 2: Memory at dfe00000 (32-bit, non-prefetchable)
[size=1M]
        Expansion ROM at dfd00000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0e.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev
07)
        Subsystem: Giga-byte Technology: Unknown device 2060
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at d800 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP
1X/2X (rev 5c) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage Pro Turbo AGP 2X
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at de000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: I/O ports at 9800 [size=256]
        Region 2: Memory at df6ff000 (32-bit, non-prefetchable)
[size=4K]
        Expansion ROM at df6c0000 [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0
                Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DDYS-T09170M     Rev: S9DD
  Type:   Direct-Access                    ANSI SCSI revision: 03

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
/proc/interrupts:
           CPU0       CPU1
  0:    4037242    5067903    IO-APIC-edge  timer
  1:          3         11    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  5:      46638      45258   IO-APIC-level  usb-uhci, usb-uhci, eth0
  8:          1          0    IO-APIC-edge  rtc
  9:    5593710    5595966   IO-APIC-level  eth1, es1371
 10:       8035       7769   IO-APIC-level  aic7xxx
 12:          8         29    IO-APIC-edge  PS/2 Mouse
 14:      49161      44622    IO-APIC-edge  ide0
 15:     103600     144438    IO-APIC-edge  ide1
NMI:          0          0
LOC:    9106104    9106083
ERR:          0
MIS:          0


Simon Bazley

