Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSA0VuE>; Sun, 27 Jan 2002 16:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288767AbSA0Vtp>; Sun, 27 Jan 2002 16:49:45 -0500
Received: from cp66906-a.roemd1.lb.nl.home.com ([213.51.11.249]:39041 "EHLO
	lx01.intranet.invantive.com") by vger.kernel.org with ESMTP
	id <S288748AbSA0Vt2>; Sun, 27 Jan 2002 16:49:28 -0500
From: "Guido Leenders" <guido.leenders@invantive.com>
To: <linux-kernel@vger.kernel.org>
Cc: <guido.leenders@invantive.com>
Subject: PROBLEM: 2.4.17 crashes (VM bug?) after heavy system load
Date: Sun, 27 Jan 2002 22:49:17 +0100
Message-ID: <000001c1a77c$78abe8c0$6501a8c0@intranet.invantive.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    

Especially during times of heavy I/O, swapping and CPU processing, the
OS crashes with an Oops.

[2.] Full description of the problem/report:

See 1.

[3.] Keywords (i.e., modules, networking, kernel):

kernel, VM

[4.] Kernel version (from /proc/version):

2.4.17

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

<1>Unable to handle kernel paging request at virtual address 008209dc
Jan 26 02:15:03 lx01 kernel: c013e090 Jan 26 02:15:03 lx01 kernel: *pde
= 00000000 Jan 26 02:15:03 lx01 kernel: Oops: 0000
Jan 26 02:15:03 lx01 kernel: CPU:    0
Jan 26 02:15:03 lx01 kernel: EIP:    0010:[<c013e090>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 26 02:15:03 lx01 kernel: EFLAGS: 00010217
Jan 26 02:15:03 lx01 kernel: eax: 000024f7   ebx: 008209d8   ecx:
00000006   edx: 00000004
Jan 26 02:15:03 lx01 kernel: esi: 000001d2   edi: 00000006   ebp:
000024f7   esp: cf1a5e20
Jan 26 02:15:03 lx01 kernel: ds: 0018   es: 0018   ss: 0018
Jan 26 02:15:03 lx01 kernel: Process tar (pid: 32197,
stackpage=cf1a5000) Jan 26 02:15:03 lx01 kernel: Stack: c0128ac8
00000000 cf1a4000 ffffffff 000001d2 c0273f48 c5502cc0 010d6f80 
Jan 26 02:15:03 lx01 kernel:        00000001 000001d2 00000006 00000006
c013e435 000024f7 c0128c87 00000006 
Jan 26 02:15:03 lx01 kernel:        000001d2 c0273f48 00000006 000001d2
c0273f48 00000000 c0128ce0 00000020 
Jan 26 02:15:03 lx01 kernel: Call Trace: [<c0128ac8>] [<c013e435>]
[<c0128c87>] [<c0128ce0>] [<c0129537>] 
Jan 26 02:15:03 lx01 kernel:    [<c012979a>] [<c0122c8f>] [<c0123225>]
[<c0123484>] [<c012399c>] [<c01238c0>] 
Jan 26 02:15:03 lx01 kernel:    [<c012e0f6>] [<c0106f03>] 
Jan 26 02:15:03 lx01 kernel: Code: 8b 53 04 8b 03 89 50 04 89 02 89 1b
89 5b 04 8d 73 e8 8b 46 

>>EIP; c013e090 <prune_dcache+20/140>   <=====
Trace; c0128ac8 <shrink_cache+278/2f0>
Trace; c013e435 <shrink_dcache_memory+25/40>
Trace; c0128c87 <shrink_caches+67/90>
Trace; c0128ce0 <try_to_free_pages+30/50>
Trace; c0129537 <balance_classzone+57/1b0>
Trace; c012979a <__alloc_pages+10a/170>
Trace; c0122c8f <page_cache_read+5f/b0>
Trace; c0123225 <generic_file_readahead+105/140>
Trace; c0123484 <do_generic_file_read+1e4/440>
Trace; c012399c <generic_file_read+7c/130>
Trace; c01238c0 <file_read_actor+0/60>
Trace; c012e0f6 <sys_read+96/d0>
Trace; c0106f03 <system_call+33/40>
Code;  c013e090 <prune_dcache+20/140>
00000000 <_EIP>:
Code;  c013e090 <prune_dcache+20/140>   <=====
   0:   8b 53 04                  mov    0x4(%ebx),%edx   <=====
Code;  c013e093 <prune_dcache+23/140>
   3:   8b 03                     mov    (%ebx),%eax
Code;  c013e095 <prune_dcache+25/140>
   5:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c013e098 <prune_dcache+28/140>
   8:   89 02                     mov    %eax,(%edx)
Code;  c013e09a <prune_dcache+2a/140>
   a:   89 1b                     mov    %ebx,(%ebx)
Code;  c013e09c <prune_dcache+2c/140>
   c:   89 5b 04                  mov    %ebx,0x4(%ebx)
Code;  c013e09f <prune_dcache+2f/140>
   f:   8d 73 e8                  lea    0xffffffe8(%ebx),%esi
Code;  c013e0a2 <prune_dcache+32/140>
  12:   8b 46 00                  mov    0x0(%esi),%eax

[6.] A small shell script or example program which triggers the
     problem (if possible)

Schedule this job in cron every hour. Within 48 hours server crashes.

tar cf - /u00 | cat >/dev/null &
tar cf - /u01 | cat >/dev/null &
tar cf - /u00 | cat >/dev/null &
tar cf - /u01 | cat >/dev/null &
tar cf - /u00 | cat >/dev/null &
tar cf - /u01 | cat >/dev/null &

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux lx01.intranet.invantive.com 2.4.17 #1 Fri Dec 28 09:28:31 CET 2001
i686 unknown
 
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
Modules Loaded    

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 1
cpu MHz         : 350.805
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat r
bogomips        : 699.59

[7.3.] Module information (from /proc/modules):

<EMPTY OUTPUT>

[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
02f8-02ff : serial(auto)
0300-030f : eth0
0376-0376 : ide1
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-403f : Intel Corp. 82371AB PIIX4 ACPI
5000-501f : Intel Corp. 82371AB PIIX4 ACPI
6400-641f : Intel Corp. 82371AB PIIX4 USB
6800-687f : 3Com Corporation 3c905C-TX [Fast Etherlink]
  6800-687f : 00:09.0
6c00-6cff : Adaptec 7892A
  6c00-6cff : aic7xxx
e000-efff : PCI Bus #01
  e000-e0ff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
f000-f00f : Intel Corp. 82371AB PIIX4 IDE
  f008-f00f : ide1

iomem:
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000d13ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0fffffff : System RAM
  00100000-002314cb : Kernel code
  002314cc-0028705f : Kernel data
e0000000-e3ffffff : Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge
e4000000-e5ffffff : PCI Bus #01
  e5000000-e5000fff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
e6000000-e6ffffff : PCI Bus #01
  e6000000-e6ffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
e9000000-e9000fff : Adaptec 7892A
  e9000000-e9000fff : aic7xxx
e9001000-e900107f : 3Com Corporation 3c905C-TX [Fast Etherlink]
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: e4000000-e5ffffff
        Prefetchable memory behind bridge: e6000000-e6ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at 6400 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
(rev 74)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC
Management NIC
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 6800 [size=128]
        Region 1: Memory at e9001000 (32-bit, non-prefetchable)
[size=128]
        Expansion ROM at e7000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0a.0 SCSI storage controller: Adaptec 7892A (rev 02)
        Subsystem: Adaptec: Unknown device 62a0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        BIST result: 00
        Region 0: I/O ports at 6c00 [disabled] [size=256]
        Region 1: Memory at e9000000 (64-bit, non-prefetchable)
[size=4K]
        Expansion ROM at e8000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP
1X/2X (rev 5c) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0080
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at e6000000 (32-bit, prefetchable) [size=16M]
        Region 1: I/O ports at e000 [size=256]
        Region 2: Memory at e5000000 (32-bit, non-prefetchable)
[size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0
                Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDYS-T18350N     Rev: S93E
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: DDYS-T18350N     Rev: S93E
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: QUANTUM  Model: DLT7000          Rev: 3213
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: DDYS-T18350N     Rev: S93E
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 08 Lun: 00
  Vendor: IBM      Model: DDYS-T18350N     Rev: S93E
  Type:   Direct-Access                    ANSI SCSI revision: 03

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

None.

[X.] Other notes, patches, fixes, workarounds:

None.

--
Guido Leenders
Managing Consultant      Tel:    +31 (0)475 691 691
Invantive                Mob:    +31 (0)621 228 293
Wijershoflaan 51         Fax:    +31 (0)475 691 444
6042 NK Roermond         Mailto: gleenders@invantive.com
The Netherlands          Web:    http://www.invantive.com
 
Invantive Tact: providing you with tools for automating IT Processes

