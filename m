Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317522AbSGZKOR>; Fri, 26 Jul 2002 06:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317498AbSGZKOR>; Fri, 26 Jul 2002 06:14:17 -0400
Received: from ganymede.tzv.fal.de ([192.108.34.3]:40163 "EHLO
	ganymede.tzv.fal.de") by vger.kernel.org with ESMTP
	id <S317522AbSGZKOF>; Fri, 26 Jul 2002 06:14:05 -0400
Message-Id: <200207261017.g6QAHBP28599@rauma.tzv.fal.de>
Content-Type: text/plain; charset=US-ASCII
X-KMail-Redirect-From: Helmut Lichtenberg <heli@tzv.fal.de>
Subject: PROPLEM: kernel BUG at slab.c 1263
From: Helmut Lichtenberg <heli@tzv.fal.de> (by way of Monika Strack
	<most@tzv.fal.de>)
Date: Fri, 26 Jul 2002 12:17:11 +0200
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have severe problems with one of my servers over a long time. The
maschine often hangs and I must do a hard-reset. This happened about 10
times during the last month.
Sometimes it writes out a kernel oops and sometimes the machine is dead
and no messages appears on the monitor.

Here's a short overview of the system configuration, for details see
below:
   2 Intel CPU PIII 1GHz, 4 GB RAM, hardware RAID attached with XFS
   filesystem, 2 root harddisks mirrored with RAID1, all SCSI Ultra160,
   network card on board plus Gigabit NIC attached

Sometimes the problems start if users run statistical programs that
need 100 % of one CPU and lots of memory. These programms run hours or
even days.

I sent some previous kernel-oopses to the vendor-support of the server
but they always tell me to install a new kernel.

With the last kernel I have enabled the debug option for slab and now I
get a kernel bug at slab.  The new kernel (2.4.19-rc1-xfs) crashed faster
than the old 2.4.18.

The server is a production machine. I hope somebody can find what kind
of problem it is and how to fix it.

Please send a CC to me.

Thanks in advance
Monika


=============================================================================
=

System:
SMP, GB-Ethernet, Kernel 2.4.19-rc1-xfs, SCSI-160Ultra, Softwareraid, modules
, XFS-filesystem (weekly-patch linux-2.4.18-xfs-2002-06-30)

cat /proc/version:
Linux version 2.4.1-rc1-xfs (root@rauma.tzv.fal.de) (gcc version 2.96
20000731 (Red Hat Linux 7.1 2.96-85)) #2 SMP Wed Jul 05 11:49:55 CET 2002

Kernel-oops :ksymoos -K

ksymoops 2.4.5 on i686 2.4.18-xfs.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-rc1-xfs/ (specified)
     -m /boot/System.map-2.4.19-rc1-xfs (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
kernel BUG at slab.c:1263!
CPU: 1
EIP: 0010 [<c01326d6>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010097
eax: debd6fff  ebx: debd6800  ecx: 00000800  edx: debd6800
esi: 0001280   edi: debd682a  ebp: c3f11db0  esp: dca67dc8
ds: 0018  es: 9918  ss: 0018
Stack: debd6800 00000800 debd682a 00000016 c3f11db0 00000202 000001f0
 c3f11db0 c0132c42 c3f11db0 c3f24bbc 000001f0 c3f12ecc 00000020 00000202
 dc4bcc38 00000246 dc4bcc38 c0265ccf dc4bcce4 001b4b4a dd5f0a04 00000202
 000001f0
Call Trace: [<c0132c42>] [<c0265ccf>] [<c024203f>] [<c025a88f>] [<c026b35b>]
            [<c011697e>] [<c0277665>] [<c023eccc>] [<c014ab94>] [<c023eee7>]
                          [<c013b876>] [<c011dc7b>] [<c0108b1b>]
Code: 0f 0b ef 04 c0 66 29 c0 81 e6 00 04 00 00 74 37 b8 a5 c2 0f

>>EIP; c01326d6 <kmem_cache_alloc_batch+f6/1a0>   <=====
>>
>>eax; debd6fff <END_OF_CODE+1e7df443/????>
>>ebx; debd6800 <END_OF_CODE+1e7dec44/????>
>>ecx; 00000800 Before first symbol
>>edx; debd6800 <END_OF_CODE+1e7dec44/????>
>>esi; 00001280 Before first symbol
>>edi; debd682a <END_OF_CODE+1e7dec6e/????>
>>ebp; c3f11db0 <END_OF_CODE+3b1a1f4/????>
>>esp; dca67dc8 <END_OF_CODE+1c67020c/????>

Trace; c0132c42 <kmalloc+b2/250>
Trace; c0265ccf <tcp_write_xmit+1df/290>
Trace; c024203f <alloc_skb+ef/1c0>
Trace; c025a88f <tcp_sendmsg+24f/1230>
Trace; c026b35b <tcp_v4_do_rcv+3b/130>
Trace; c011697e <schedule+47e/540>
Trace; c0277665 <inet_sendmsg+35/40>
Trace; c023eccc <sock_sendmsg+6c/90>
Trace; c014ab94 <poll_freewait+44/50>
Trace; c023eee7 <sock_write+a7/c0>
Trace; c013b876 <sys_write+96/110>
Trace; c011dc7b <sys_gettimeofday+1b/a0>
Trace; c0108b1b <system_call+33/38>

Code;  c01326d6 <kmem_cache_alloc_batch+f6/1a0>
00000000 <_EIP>:
Code;  c01326d6 <kmem_cache_alloc_batch+f6/1a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01326d8 <kmem_cache_alloc_batch+f8/1a0>
   2:   ef                        out    %eax,(%dx)
Code;  c01326d9 <kmem_cache_alloc_batch+f9/1a0>
   3:   04 c0                     add    $0xc0,%al
Code;  c01326db <kmem_cache_alloc_batch+fb/1a0>
   5:   66 29 c0                  sub    %ax,%ax
Code;  c01326de <kmem_cache_alloc_batch+fe/1a0>
   8:   81 e6 00 04 00 00         and    $0x400,%esi
Code;  c01326e4 <kmem_cache_alloc_batch+104/1a0>
   e:   74 37                     je     47 <_EIP+0x47> c013271d
<kmem_cache_alloc_batch+13d/1a0>
Code;  c01326e6 <kmem_cache_alloc_batch+106/1a0>
  10:   b8 a5 c2 0f 00            mov    $0xfc2a5,%eax

Software:

sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux rauma.tzv.fal.de 2.4.18-xfs #2 SMP Wed Mar 27 07:29:55 CET 2002 i686
unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.11f
mount                  2.11b
modutils               2.4.13
e2fsprogs              1.26
PPP                    2.4.0
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         sk98lin eepro100 serial isa-pnp rtc

cat cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 999.784
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
cmov
pat pse36 mmx fxsr sse
bogomips        : 1992.29

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 999.784
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
cmov
pat pse36 mmx fxsr sse
bogomips        : 1998.84


cat /proc/modules
sk98lin               131232   1 (autoclean)
eepro100               19952   0 (autoclean) (unused)
serial                 49824   0 (autoclean)
isa-pnp                38600   0 (autoclean) [serial]
rtc                     7992   0 (autoclean)

cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ServerWorks OSB4 IDE Controller
02f8-02ff : serial(auto)
0376-0376 : ServerWorks OSB4 IDE Controller
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-50ff : ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC]
5400-543f : Intel Corp. 82557 [Ethernet Pro 100]
  5400-543f : eepro100
5440-544f : ServerWorks OSB4 IDE Controller
5800-58ff : Adaptec 7899P
  5800-58ff : aic7xxx
6000-60ff : Adaptec 7899P (#2)
  6000-60ff : aic7xxx
6400-64ff : Adaptec 7899A
  6400-64ff : aic7xxx
6800-68ff : Adaptec 7899A (#2)
  6800-68ff : aic7xxx
7000-70ff : Syskonnect (Schneider & Koch) Gigabit Ethernet

cat /proc/iomem
00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c97ff : Extension ROM
000c9800-000cf7ff : Extension ROM
000cf800-000d61ff : Extension ROM
000f0000-000fffff : System ROM
00100000-f9feffff : System RAM
  00100000-00284d0c : Kernel code
  00284d0d-0036a99f : Kernel data
f9ff0000-f9fffbff : ACPI Tables
f9fffc00-f9ffffff : ACPI Non-volatile Storage
fb000000-fb0fffff : Intel Corp. 82557 [Ethernet Pro 100]
fb100000-fb100fff : ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC]
fb101000-fb101fff : Intel Corp. 82557 [Ethernet Pro 100]
  fb101000-fb101fff : eepro100
fc000000-fcffffff : ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC]
fd000000-fd003fff : Syskonnect (Schneider & Koch) Gigabit Ethernet
fd004000-fd004fff : Adaptec 7899P
  fd004000-fd004fff : aic7xxx
fd005000-fd005fff : Adaptec 7899P (#2)
  fd005000-fd005fff : aic7xxx
fd006000-fd006fff : Adaptec 7899A
  fd006000-fd006fff : aic7xxx
fd007000-fd007fff : Adaptec 7899A (#2)
  fd007000-fd007fff : aic7xxx
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
fff00000-ffffffff : reserved

lspci -vvv
00:00.0 Host bridge: ServerWorks CNB20LE (rev 06)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64, cache line size 08

00:00.1 Host bridge: ServerWorks CNB20LE (rev 06)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08

00:02.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC 215IIC
[Mach64 GT IIC] (rev 7a) (prog-if 00 [VGA])
        Subsystem: Intel Corporation: Unknown device 4756
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at fc000000 (32-bit, prefetchable) [size=16M]
        Region 1: I/O ports at 5000 [size=256]
        Region 2: Memory at fb100000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:03.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev
08)        Subsystem: Intel Corporation 82557 [Ethernet Pro 100]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at fb101000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 5400 [size=64]
        Region 2: Memory at fb000000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0f.0 ISA bridge: ServerWorks OSB4 (rev 50)
        Subsystem: ServerWorks OSB4
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:0f.1 IDE interface: ServerWorks: Unknown device 0211 (prog-if 8e [Master
SecP SecO PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 2: I/O ports at 0170 [size=8]
        Region 3: I/O ports at 0374
        Region 4: I/O ports at 5440 [size=16]

01:04.0 SCSI storage controller: Adaptec 7899P (rev 01)
        Subsystem: Intel Corporation: Unknown device 00cf
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 16
        BIST result: 00
        Region 0: I/O ports at 5800 [disabled] [size=256]
        Region 1: Memory at fd004000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:04.1 SCSI storage controller: Adaptec 7899P (rev 01)
        Subsystem: Intel Corporation: Unknown device 00cf
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin B routed to IRQ 17
        BIST result: 00
        Region 0: I/O ports at 6000 [disabled] [size=256]
        Region 1: Memory at fd005000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0a.0 SCSI storage controller: Adaptec 7899A (rev 01)
        Subsystem: Adaptec: Unknown device f620
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 20
        BIST result: 00
        Region 0: I/O ports at 6400 [disabled] [size=256]
        Region 1: Memory at fd006000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0a.1 SCSI storage controller: Adaptec 7899A (rev 01)
        Subsystem: Adaptec: Unknown device f620
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin B routed to IRQ 27
        BIST result: 00
        Region 0: I/O ports at 6800 [disabled] [size=256]
        Region 1: Memory at fd007000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0b.0 Ethernet controller: Syskonnect (Schneider & Koch) Gigabit Ethernet
(rev 12)
        Subsystem: Allied Telesyn International: Unknown device 2970
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B+
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 189 (5750ns min, 7750ns max), cache line size 08
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16K]
        Region 1: I/O ports at 7000 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [48] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data

cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDYS-T09170M     Rev: S80D
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DDYS-T09170M     Rev: S93E
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST336704LC       Rev: 0004
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: ESG-SHV  Model: SCA HSBP M14     Rev: 0.01
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: PIONEER  Model: DVD-ROM DVD-305  Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 03 Lun: 00
  Vendor: YAMAHA   Model: CRW8824S         Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi3 Channel: 00 Id: 01 Lun: 00
  Vendor: CNSi     Model: JSS122(B)        Rev: L423
  Type:   Direct-Access                    ANSI SCSI revision: 03


cat mdstat
Personalities : [raid1]
read_ahead 1024 sectors
md1 : active raid1 sdb1[0] sda1[1]
      40064 blocks [2/2] [UU]

md5 : active raid1 sdb5[0] sda5[1]
      2096384 blocks [2/2] [UU]

md6 : active raid1 sdb6[0] sda6[1]
      2096384 blocks [2/2] [UU]

md7 : active raid1 sdb7[0] sda7[1]
      4723008 blocks [2/2] [UU]

unused devices: <none>

cat meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  4125220864 661131264 3464089600        0  8138752 355274752
Swap: 4293378048        0 4293378048
MemTotal:      4028536 kB
MemFree:       3382900 kB
MemShared:           0 kB
Buffers:          7948 kB
Cached:         346948 kB
SwapCached:          0 kB
Active:         128932 kB
Inactive:       462728 kB
HighTotal:     3178432 kB
HighFree:      2593936 kB
LowTotal:       850104 kB
LowFree:        788964 kB
SwapTotal:     4192752 kB
SwapFree:      4192752 kB

_____________________________________________________________________________
___ Monika Strack
Institut fuer Tierzucht und Tierverhalten
Bundesforschungsanstalt fuer Landwirschaft

31535 Neustadt               e-mail: most@tzv.fal.de
Germany                      Tel: +49 5034 /871 154
                             Fax: +49 5034 /92579
_____________________________________________________________________________
