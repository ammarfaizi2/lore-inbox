Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbTAEX5d>; Sun, 5 Jan 2003 18:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbTAEX5c>; Sun, 5 Jan 2003 18:57:32 -0500
Received: from www.petersen-arne.com ([64.65.177.82]:65040 "EHLO
	uranus.petersen-arne.com") by vger.kernel.org with ESMTP
	id <S265470AbTAEX5R>; Sun, 5 Jan 2003 18:57:17 -0500
Message-ID: <21484.64.65.177.243.1041811557.squirrel@www.petersen-arne.com>
Date: Sun, 5 Jan 2003 16:05:57 -0800 (PST)
Subject: PROBLEM: 2.4.19 system crashes with BUG at vmscan.c:355
From: "Cory Petkovsek" <coryp@petersen-arne.com>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.9)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. 2.4.19 system crashes with BUG at vmscan.c:355

2. A server running debian woody and standard kernel 2.4.19 system crashes
with BUG at vmscan.c:355.  It has done so twice after 30-45 days of
uptime.

3. vm, virtual memory, stack dump

4.  cat /proc/version
Linux version 2.4.19 (root@neptune) (gcc version 2.95.4 20011002 (Debian
prerelease)) #1 Sat Sep 14 14:38:02 PDT 2002

5. no oops

6. occurs after 30-45 or so days of uptime

7.1   . ./scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux neptune 2.4.19 #1 Sat Sep 14 14:38:02 PDT 2002 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.5.so*
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         nls_cp437 nls_iso8859-1 smbfs 3c59x rtc

7.2  cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) processor
stepping        : 2
cpu MHz         : 1300.085
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2595.22

7.3  cat /proc/modules
nls_cp437               4384   0 (autoclean)
nls_iso8859-1           2848   0 (autoclean)
smbfs                  32512   0 (autoclean)
3c59x                  25096   1
rtc                     6012   0 (autoclean)

7.4 # cat /proc/ioports /proc/iomem
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0213-0213 : isapnp read
02f8-02ff : serial(auto)
03c0-03df : vga+
03e8-03ef : serial(auto)
03f8-03ff : serial(auto)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
dc00-dc7f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
  dc00-dc7f : 00:0b.0
e000-e0ff : Adaptec AHA-2940U/UW/D / AIC-7881U
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cc7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-00225617 : Kernel code
  00225618-0027867f : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-d7ffffff : Distributed Processing Technology SmartRAID V Controller
d8000000-dbffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
dc000000-dfffffff : S3 Inc. 86c775/86c785 [Trio 64V2/DX or /GX]
e1000000-e1000fff : Adaptec AHA-2940U/UW/D / AIC-7881U
  e1000000-e1000fff : aic7xxx
e1001000-e100107f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
ffff0000-ffffffff : reserved

7.5 lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev
03)
        Subsystem: ABIT Computer Corp.: Unknown device a401
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
        Subsystem: ABIT Computer Corp.: Unknown device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 14
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
(rev 78)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC
Management NIC
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at dc00 [size=128]
        Region 1: Memory at e1001000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0d.0 PCI bridge: Distributed Processing Technology PCI Bridge (rev 02)
(prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: 00100000-000fffff
        Prefetchable memory behind bridge: 00100000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.1 I2O: Distributed Processing Technology SmartRAID V Controller (rev
02) (prog-if 01)
        Subsystem: Distributed Processing Technology: Unknown device c03c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (250ns min, 250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 15
        BIST result: 00
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=32K]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 SCSI storage controller: Adaptec AIC-7881U (rev 01)
        Subsystem: Adaptec AHA-2940UW SCSI Host Adapter
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 15
        Region 0: I/O ports at e000 [disabled] [size=256]
        Region 1: Memory at e1000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 VGA compatible controller: S3 Inc. Trio 64V2/DX or /GX (rev 16)
(prog-if 00 [VGA])
        Subsystem: S3 Inc. 86C775 Trio64V2/DX, 86C785 Trio64V2/GX
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at dc000000 (32-bit, non-prefetchable) [size=64M]
        Expansion ROM at <unassigned> [disabled] [size=64K]

7.6  cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ADAPTEC  Model: RAID-5           Rev: 370F
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: QUANTUM  Model: ATLAS 10K 9WLS   Rev: UC81
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: QUANTUM  Model: ATLAS 10K 9WLS   Rev: UC81
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 02 Lun: 00
  Vendor: WDIGTL   Model: WD91 ULTRA2      Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor: TOSHIBA  Model: CD-ROM XM-6401TA Rev: 1001
  Type:   CD-ROM                           ANSI SCSI revision: 02


7.7 Log file and dmesg (may have duplicates):

Dec 22 05:43:55 neptune kernel: kernel BUG at vmscan.c:355!
Dec 22 05:43:55 neptune kernel: invalid operand: 0000
Dec 22 05:43:55 neptune kernel: CPU:    0
Dec 22 05:43:55 neptune kernel: EIP:    0010:[shrink_cache+154/768]    Not
tainted
Dec 22 05:43:55 neptune kernel: EFLAGS: 00010246
Dec 22 05:43:55 neptune kernel: eax: 00000000   ebx: 00000000   ecx:
c50ae618   edx:c1288498
Dec 22 05:43:55 neptune kernel: esi: c50ae5fc   edi: 00000006   ebp:
00000200   esp:c15bbf54
Dec 22 05:43:55 neptune kernel: ds: 0018   es: 0018   ss: 0018
Dec 22 05:43:55 neptune kernel: Process kswapd (pid: 4, stackpage=c15bb000)
Dec 22 05:43:55 neptune kernel: Stack: 00000020 000001d0 00000020 00000006
00000006
c15ba000 00002db1 000001d0
Dec 22 05:43:55 neptune kernel:        c02668f4 c012ae86 00000006 00000001
00000006
000001d0 c02668f4 00000000
Dec 22 05:43:55 neptune kernel:        c02668f4 c012aefc 00000020 c02668f4
00000001
c15ba000 c012af93 c0266840
Dec 22 05:43:55 neptune kernel: Call Trace:    [shrink_caches+86/144]
[try_to_free_pages+60/96] [kswapd_balance_pgdat+67/144]
[kswapd_balance+22/48]
[kswapd+157/192]
Dec 22 05:43:55 neptune kernel:   [kernel_thread+40/64]
Dec 22 05:43:55 neptune kernel:
Dec 22 05:43:55 neptune kernel: Code: 0f 0b 63 01 67 cd 22 c0 8b 41 fc a8
80 74 08
0f 0b 64 01 67
Dec 22 05:43:55 neptune kernel: kernel BUG at vmscan.c:355!
Dec 22 05:43:55 neptune kernel: invalid operand: 0000
Dec 22 05:43:55 neptune kernel: CPU:    0
Dec 22 05:43:55 neptune kernel: EIP:    0010:[shrink_cache+154/768]    Not
tainted
Dec 22 05:43:55 neptune kernel: EFLAGS: 00010246
Dec 22 05:43:55 neptune kernel: eax: 00000000   ebx: 00000000   ecx:
c50ae618   edx:
c1288498
Dec 22 05:43:55 neptune kernel: esi: c50ae5fc   edi: 00000006   ebp:
00000200   esp:
c15bbf54
Dec 22 05:43:55 neptune kernel: ds: 0018   es: 0018   ss: 0018
Dec 22 05:43:55 neptune kernel: Process kswapd (pid: 4, stackpage=c15bb000)
Dec 22 05:43:55 neptune kernel: Stack: 00000020 000001d0 00000020 00000006
00000006
c15ba000 00002db1 000001d0
Dec 22 05:43:55 neptune kernel:        c02668f4 c012ae86 00000006 00000001
00000006
000001d0 c02668f4 00000000
Dec 22 05:43:55 neptune kernel:        c02668f4 c012aefc 00000020 c02668f4
00000001
c15ba000 c012af93 c0266840
Dec 22 05:43:55 neptune kernel: Call Trace:    [shrink_caches+86/144]
[try_to_free_pages+60/96] [kswapd_balance_pgdat+67/144]
[kswapd_balance+22/48]
[kswapd+157/192]
Dec 22 05:43:55 neptune kernel:   [kernel_thread+40/64]
Dec 22 05:43:55 neptune kernel:
Dec 22 05:43:55 neptune kernel: Code: 0f 0b 63 01 67 cd 22 c0 8b 41 fc a8
80 74 08
0f 0b 64 01 67
Dec 22 05:43:55 neptune kernel: kernel BUG at vmscan.c:355!
Dec 22 05:43:55 neptune kernel: invalid operand: 0000
Dec 22 05:43:55 neptune kernel: CPU:    0
Dec 22 05:43:55 neptune kernel: EIP:    0010:[shrink_cache+154/768]    Not
tainted
Dec 22 05:43:55 neptune kernel: EFLAGS: 00010246
Dec 22 05:43:55 neptune kernel: eax: 00000000   ebx: 00000000   ecx:
c50ae618   edx:
c1288498
Dec 22 05:43:55 neptune kernel: esi: c50ae5fc   edi: 00000006   ebp:
00000200   esp:
c15bbf54
Dec 22 05:43:55 neptune kernel: ds: 0018   es: 0018   ss: 0018
Dec 22 05:43:55 neptune kernel: Process kswapd (pid: 4, stackpage=c15bb000)
Dec 22 05:43:55 neptune kernel: Stack: 00000020 000001d0 00000020 00000006
00000006
c15ba000 00002db1 000001d0
Dec 22 05:43:55 neptune kernel:        c02668f4 c012ae86 00000006 00000001
00000006
000001d0 c02668f4 00000000
Dec 22 05:43:55 neptune kernel:        c02668f4 c012aefc 00000020 c02668f4
00000001
c15ba000 c012af93 c0266840
Dec 22 05:43:55 neptune kernel: Call Trace:    [shrink_caches+86/144]
[try_to_free_pages+60/96] [kswapd_balance_pgdat+67/144]
[kswapd_balance+22/48]
[kswapd+157/192]
Dec 22 05:43:55 neptune kernel:   [kernel_thread+40/64]
Dec 22 05:43:55 neptune kernel:
Dec 22 05:43:55 neptune kernel: Code: 0f 0b 63 01 67 cd 22 c0 8b 41 fc a8
80 74 08
0f 0b 64 01 67
Dec 22 05:43:56 neptune kernel:  kernel BUG at vmscan.c:355!
Dec 22 05:43:56 neptune kernel: invalid operand: 0000
Dec 22 05:43:56 neptune kernel: CPU:    0
Dec 22 05:43:56 neptune kernel: EIP:    0010:[shrink_cache+154/768]    Not
tainted
Dec 22 05:43:56 neptune kernel: EFLAGS: 00010246
Dec 22 05:43:56 neptune kernel: eax: 00000000   ebx: 00000000   ecx:
c50ae618   edx:
0000049d
Dec 22 05:43:56 neptune kernel: esi: c50ae5fc   edi: 00000020   ebp:
00000200   esp:
dcee3e50
Dec 22 05:43:56 neptune kernel: ds: 0018   es: 0018   ss: 0018
Dec 22 05:43:56 neptune kernel: Process smbd (pid: 8638, stackpage=dcee3000)
Dec 22 05:43:56 neptune kernel: Stack: 00000020 000001d2 00000020 00000006
00000006
dcee2000 00002e24 000001d2
Dec 22 05:43:56 neptune kernel:        c02668f4 c012ae86 00000006 00000000
00000006
000001d2 c02668f4 c02668f4
Dec 22 05:43:56 neptune kernel:        c02668f4 c012aefc 00000020 dcee2000
00000000
00000010 c012b844 c0266a88
Dec 22 05:43:56 neptune kernel: Call Trace:    [shrink_caches+86/144]
[try_to_free_pages+60/96] [balance_classzone+84/432] [__alloc_pages+274/368]
[reiserfs_get_block+0/3648]
Dec 22 05:43:56 neptune kernel:   [_alloc_pages+22/32]
[page_cache_read+106/192]
[generic_file_readahead+261/320] [do_generic_file_read+418/1024]
[generic_file_read+133/320] [file_read_actor+0/144]
Dec 22 05:43:56 neptune kernel:   [sys_read+150/240] [system_call+51/56]
Dec 22 05:43:56 neptune kernel:
Dec 22 05:43:56 neptune kernel: Code: 0f 0b 63 01 67 cd 22 c0 8b 41 fc a8
80 74 08
0f 0b 64 01 67
Dec 22 05:43:56 neptune smbd[17355]: make_connection: cory logged in as
admin user
(root privileges)
Dec 22 05:43:56 neptune kernel:  kernel BUG at vmscan.c:355!
Dec 22 05:43:56 neptune kernel: invalid operand: 0000
Dec 22 05:43:56 neptune kernel: CPU:    0
Dec 22 05:43:56 neptune kernel: EIP:    0010:[shrink_cache+154/768]    Not
tainted
Dec 22 05:43:56 neptune kernel: EFLAGS: 00010246
Dec 22 05:43:56 neptune kernel: eax: 00000000   ebx: 00000000   ecx:
c50ae618   edx:
0000049d
Dec 22 05:43:56 neptune kernel: esi: c50ae5fc   edi: 00000020   ebp:
00000200   esp:
dcee3e50
Dec 22 05:43:56 neptune kernel: ds: 0018   es: 0018   ss: 0018
Dec 22 05:43:56 neptune kernel: Process smbd (pid: 8638, stackpage=dcee3000)
Dec 22 05:43:56 neptune kernel: Stack: 00000020 000001d2 00000020 00000006
00000006
dcee2000 00002e24 000001d2
Dec 22 05:43:56 neptune kernel:        c02668f4 c012ae86 00000006 00000000
00000006
000001d2 c02668f4 c02668f4
Dec 22 05:43:56 neptune kernel:        c02668f4 c012aefc 00000020 dcee2000
00000000
00000010 c012b844 c0266a88
Dec 22 05:43:56 neptune kernel: Call Trace:    [shrink_caches+86/144]
[try_to_free_pages+60/96] [balance_classzone+84/432] [__alloc_pages+274/368]
[reiserfs_get_block+0/3648]
Dec 22 05:43:56 neptune kernel:   [_alloc_pages+22/32]
[page_cache_read+106/192]
[generic_file_readahead+261/320] [do_generic_file_read+418/1024]
[generic_file_read+133/320] [file_read_actor+0/144]
Dec 22 05:43:56 neptune kernel:   [sys_read+150/240] [system_call+51/56]
Dec 22 05:43:56 neptune kernel:
Dec 22 05:43:56 neptune kernel: Code: 0f 0b 63 01 67 cd 22 c0 8b 41 fc a8
80 74 08
0f 0b 64 01 67
Dec 22 05:43:56 neptune kernel:  kernel BUG at vmscan.c:355!
Dec 22 05:43:56 neptune kernel: invalid operand: 0000
Dec 22 05:43:56 neptune kernel: CPU:    0
Dec 22 05:43:56 neptune kernel: EIP:    0010:[shrink_cache+154/768]    Not
tainted
Dec 22 05:43:56 neptune kernel: EFLAGS: 00010246
Dec 22 05:43:56 neptune kernel: eax: 00000000   ebx: 00000000   ecx:
c50ae618   edx:
0000049d
Dec 22 05:43:56 neptune kernel: esi: c50ae5fc   edi: 00000020   ebp:
00000200   esp:
dcee3e50
Dec 22 05:43:56 neptune kernel: ds: 0018   es: 0018   ss: 0018
Dec 22 05:43:56 neptune kernel: Process smbd (pid: 8638, stackpage=dcee3000)
Dec 22 05:43:56 neptune kernel: Stack: 00000020 000001d2 00000020 00000006
00000006
dcee2000 00002e24 000001d2
Dec 22 05:43:56 neptune kernel:        c02668f4 c012ae86 00000006 00000000
00000006
000001d2 c02668f4 c02668f4
Dec 22 05:43:56 neptune kernel:        c02668f4 c012aefc 00000020 dcee2000
00000000
00000010 c012b844 c0266a88
Dec 22 05:43:56 neptune kernel: Call Trace:    [shrink_caches+86/144]
[try_to_free_pages+60/96] [balance_classzone+84/432] [__alloc_pages+274/368]
[reiserfs_get_block+0/3648]
Dec 22 05:43:56 neptune kernel:   [_alloc_pages+22/32]
[page_cache_read+106/192]
[generic_file_readahead+261/320] [do_generic_file_read+418/1024]
[generic_file_read+133/320] [file_read_actor+0/144]
Dec 22 05:43:56 neptune kernel:   [sys_read+150/240] [system_call+51/56]
Dec 22 05:43:56 neptune kernel:
Dec 22 05:43:56 neptune kernel: Code: 0f 0b 63 01 67 cd 22 c0 8b 41 fc a8
80 74 08
0f 0b 64 01 67
Dec 22 05:43:58 neptune kernel:  kernel BUG at vmscan.c:355!
Dec 22 05:43:58 neptune kernel: invalid operand: 0000
Dec 22 05:43:58 neptune kernel: CPU:    0
Dec 22 05:43:58 neptune kernel: EIP:    0010:[shrink_cache+154/768]    Not
tainted
Dec 22 05:43:58 neptune kernel: EFLAGS: 00010246
Dec 22 05:43:58 neptune kernel: eax: 00000000   ebx: 00000000   ecx:
c50ae618   edx:
0000049b
Dec 22 05:43:58 neptune kernel: esi: c50ae5fc   edi: 00000020   ebp:
00000200   esp:
dcee3e50
Dec 22 05:43:58 neptune kernel: ds: 0018   es: 0018   ss: 0018
Dec 22 05:43:58 neptune kernel: Process smbd (pid: 17355, stackpage=dcee3000)
Dec 22 05:43:58 neptune kernel: Stack: 00000020 000001d2 00000020 00000006
00000006
dcee2000 00002e12 000001d2
Dec 22 05:43:58 neptune kernel:        c02668f4 c012ae86 00000006 00000001
00000006
000001d2 c02668f4 c02668f4
Dec 22 05:43:58 neptune kernel:        c02668f4 c012aefc 00000020 dcee2000
00000000
00000010 c012b844 c0266a88
Dec 22 05:43:58 neptune kernel: Call Trace:    [shrink_caches+86/144]
[try_to_free_pages+60/96] [balance_classzone+84/432] [__alloc_pages+274/368]
[reiserfs_get_block+0/3648]
Dec 22 05:43:58 neptune kernel:   [_alloc_pages+22/32]
[page_cache_read+106/192]
[generic_file_readahead+261/320] [do_generic_file_read+418/1024]
[generic_file_read+133/320] [file_read_actor+0/144]
Dec 22 05:43:58 neptune kernel:   [sys_read+150/240] [system_call+51/56]
Dec 22 05:43:58 neptune kernel:
Dec 22 05:43:58 neptune kernel: Code: 0f 0b 63 01 67 cd 22 c0 8b 41 fc a8
80 74 08
0f 0b 64 01 67
Dec 22 05:43:58 neptune kernel:  kernel BUG at vmscan.c:355!
Dec 22 05:43:58 neptune kernel: invalid operand: 0000
Dec 22 05:43:58 neptune kernel: CPU:    0
Dec 22 05:43:58 neptune kernel: EIP:    0010:[shrink_cache+154/768]    Not
tainted
Dec 22 05:43:58 neptune kernel: EFLAGS: 00010246
Dec 22 05:43:58 neptune kernel: eax: 00000000   ebx: 00000000   ecx:
c50ae618   edx:
0000049b
Dec 22 05:43:58 neptune kernel: esi: c50ae5fc   edi: 00000020   ebp:
00000200   esp:
dcee3e50
Dec 22 05:43:58 neptune kernel: ds: 0018   es: 0018   ss: 0018
Dec 22 05:43:58 neptune kernel: Process smbd (pid: 17355, stackpage=dcee3000)
Dec 22 05:43:58 neptune kernel: Stack: 00000020 000001d2 00000020 00000006
00000006
dcee2000 00002e12 000001d2
Dec 22 05:43:58 neptune kernel:        c02668f4 c012ae86 00000006 00000001
00000006
000001d2 c02668f4 c02668f4
Dec 22 05:43:58 neptune kernel:        c02668f4 c012aefc 00000020 dcee2000
00000000
00000010 c012b844 c0266a88
Dec 22 05:43:58 neptune kernel: Call Trace:    [shrink_caches+86/144]
[try_to_free_pages+60/96] [balance_classzone+84/432] [__alloc_pages+274/368]
[reiserfs_get_block+0/3648]
Dec 22 05:43:58 neptune kernel:   [_alloc_pages+22/32]
[page_cache_read+106/192]
[generic_file_readahead+261/320] [do_generic_file_read+418/1024]
[generic_file_read+133/320] [file_read_actor+0/144]
Dec 22 05:43:58 neptune kernel:   [sys_read+150/240] [system_call+51/56]
Dec 22 05:43:58 neptune kernel:
Dec 22 05:43:58 neptune kernel: Code: 0f 0b 63 01 67 cd 22 c0 8b 41 fc a8
80 74 08
0f 0b 64 01 67
Dec 22 05:43:58 neptune kernel:  kernel BUG at vmscan.c:355!
Dec 22 05:43:58 neptune kernel: invalid operand: 0000
Dec 22 05:43:58 neptune kernel: CPU:    0
Dec 22 05:43:58 neptune kernel: EIP:    0010:[shrink_cache+154/768]    Not
tainted
Dec 22 05:43:58 neptune kernel: EFLAGS: 00010246
Dec 22 05:43:58 neptune kernel: eax: 00000000   ebx: 00000000   ecx:
c50ae618   edx:
0000049b
Dec 22 05:43:58 neptune kernel: esi: c50ae5fc   edi: 00000020   ebp:
00000200   esp:
dcee3e50
Dec 22 05:43:58 neptune kernel: ds: 0018   es: 0018   ss: 0018
Dec 22 05:43:58 neptune kernel: Process smbd (pid: 17355, stackpage=dcee3000)
Dec 22 05:43:58 neptune kernel: Stack: 00000020 000001d2 00000020 00000006
00000006
dcee2000 00002e12 000001d2
Dec 22 05:43:58 neptune kernel:        c02668f4 c012ae86 00000006 00000001
00000006
000001d2 c02668f4 c02668f4
Dec 22 05:43:58 neptune kernel:        c02668f4 c012aefc 00000020 dcee2000
00000000
00000010 c012b844 c0266a88
Dec 22 05:43:58 neptune kernel: Call Trace:    [shrink_caches+86/144]
[try_to_free_pages+60/96] [balance_classzone+84/432] [__alloc_pages+274/368]
[reiserfs_get_block+0/3648]
Dec 22 05:43:58 neptune kernel:   [_alloc_pages+22/32]
[page_cache_read+106/192]
[generic_file_readahead+261/320] [do_generic_file_read+418/1024]
[generic_file_read+133/320] [file_read_actor+0/144]
Dec 22 05:43:58 neptune kernel:   [sys_read+150/240] [system_call+51/56]
Dec 22 05:43:58 neptune kernel:
Dec 22 05:43:58 neptune kernel: Code: 0f 0b 63 01 67 cd 22 c0 8b 41 fc a8
80 74 08
0f 0b 64 01 67
Dec 22 05:44:01 neptune kernel:  kernel BUG at vmscan.c:355!
Dec 22 05:44:01 neptune kernel: invalid operand: 0000
Dec 22 05:44:01 neptune kernel: CPU:    0
Dec 22 05:44:01 neptune kernel: EIP:    0010:[shrink_cache+154/768]    Not
tainted
Dec 22 05:44:01 neptune kernel: EFLAGS: 00010246
Dec 22 05:44:01 neptune kernel: eax: 00000000   ebx: 00000000   ecx:
c50ae618   edx:
0000049b
Dec 22 05:44:01 neptune kernel: esi: c50ae5fc   edi: 00000020   ebp:
00000200   esp:
dbdd5df8
Dec 22 05:44:01 neptune kernel: ds: 0018   es: 0018   ss: 0018
Dec 22 05:44:01 neptune kernel: Process line_monitor.pl (pid: 17358,
stackpage=dbdd5000)
Dec 22 05:44:01 neptune kernel: Stack: 00000020 000001d2 00000020 00000006
00000006
dbdd4000 00002e11 000001d2
Dec 22 05:44:01 neptune kernel:        c02668f4 c012ae86 00000006 00000001
00000006
000001d2 c02668f4 c02668f4
Dec 22 05:44:01 neptune kernel:        c02668f4 c012aefc 00000020 dbdd4000
00000000
00000010 c012b844 c0266a88
Dec 22 05:44:01 neptune kernel: Call Trace:    [shrink_caches+86/144]
[try_to_free_pages+60/96] [balance_classzone+84/432] [__alloc_pages+274/368]
[_alloc_pages+22/32]
Dec 22 05:44:01 neptune kernel:   [do_anonymous_page+52/224]
[do_no_page+47/368]
[handle_mm_fault+82/176] [do_page_fault+355/1172] [do_page_fault+0/1172]
[link_path_walk+2127/2144]
Dec 22 05:44:01 neptune kernel:   [__user_walk+67/80] [sys_stat64+25/112]
[error_code+52/60]
Dec 22 05:44:01 neptune kernel:
Dec 22 05:44:01 neptune kernel: Code: 0f 0b 63 01 67 cd 22 c0 8b 41 fc a8
80 74 08
0f 0b 64 01 67
Dec 22 05:44:01 neptune kernel:  kernel BUG at vmscan.c:355!
Dec 22 05:44:01 neptune kernel: invalid operand: 0000
Dec 22 05:44:01 neptune kernel: CPU:    0
Dec 22 05:44:01 neptune kernel: EIP:    0010:[shrink_cache+154/768]    Not
tainted
Dec 22 05:44:01 neptune kernel: EFLAGS: 00010246
Dec 22 05:44:01 neptune kernel: eax: 00000000   ebx: 00000000   ecx:
c50ae618   edx:
0000049b
Dec 22 05:44:01 neptune kernel: esi: c50ae5fc   edi: 00000020   ebp:
00000200   esp:
dbdd5df8
Dec 22 05:44:01 neptune kernel: ds: 0018   es: 0018   ss: 0018
Dec 22 05:44:01 neptune kernel: Process line_monitor.pl (pid: 17358,
stackpage=dbdd5000)
Dec 22 05:44:01 neptune kernel: Stack: 00000020 000001d2 00000020 00000006
00000006
dbdd4000 00002e11 000001d2
Dec 22 05:44:01 neptune kernel:        c02668f4 c012ae86 00000006 00000001
00000006
000001d2 c02668f4 c02668f4
Dec 22 05:44:01 neptune kernel:        c02668f4 c012aefc 00000020 dbdd4000
00000000
00000010 c012b844 c0266a88
Dec 22 05:44:01 neptune kernel: Call Trace:    [shrink_caches+86/144]
[try_to_free_pages+60/96] [balance_classzone+84/432] [__alloc_pages+274/368]
[_alloc_pages+22/32]
Dec 22 05:44:01 neptune kernel:   [do_anonymous_page+52/224]
[do_no_page+47/368]
[handle_mm_fault+82/176] [do_page_fault+355/1172] [do_page_fault+0/1172]
[link_path_walk+2127/2144]
Dec 22 05:44:01 neptune kernel:   [__user_walk+67/80] [sys_stat64+25/112]
[error_code+52/60]
Dec 22 05:44:01 neptune kernel:
Dec 22 05:44:01 neptune kernel: Code: 0f 0b 63 01 67 cd 22 c0 8b 41 fc a8
80 74 08
0f 0b 64 01 67
Dec 22 05:44:01 neptune kernel:  kernel BUG at vmscan.c:355!
Dec 22 05:44:01 neptune kernel: invalid operand: 0000
Dec 22 05:44:01 neptune kernel: CPU:    0
Dec 22 05:44:01 neptune kernel: EIP:    0010:[shrink_cache+154/768]    Not
tainted
Dec 22 05:44:01 neptune kernel: EFLAGS: 00010246
Dec 22 05:44:01 neptune kernel: eax: 00000000   ebx: 00000000   ecx:
c50ae618   edx:
0000049b
Dec 22 05:44:01 neptune kernel: esi: c50ae5fc   edi: 00000020   ebp:
00000200   esp:
dbdd5df8
Dec 22 05:44:01 neptune kernel: ds: 0018   es: 0018   ss: 0018
Dec 22 05:44:01 neptune kernel: Process line_monitor.pl (pid: 17358,
stackpage=dbdd5000)
Dec 22 05:44:01 neptune kernel: Stack: 00000020 000001d2 00000020 00000006
00000006
dbdd4000 00002e11 000001d2
Dec 22 05:44:01 neptune kernel:        c02668f4 c012ae86 00000006 00000001
00000006
000001d2 c02668f4 c02668f4
Dec 22 05:44:01 neptune kernel:        c02668f4 c012aefc 00000020 dbdd4000
00000000
00000010 c012b844 c0266a88
Dec 22 05:44:01 neptune kernel: Call Trace:    [shrink_caches+86/144]
[try_to_free_pages+60/96] [balance_classzone+84/432] [__alloc_pages+274/368]
[_alloc_pages+22/32]
Dec 22 05:44:01 neptune kernel:   [do_anonymous_page+52/224]
[do_no_page+47/368]
[handle_mm_fault+82/176] [do_page_fault+355/1172] [do_page_fault+0/1172]
[link_path_walk+2127/2144]
Dec 22 05:44:01 neptune kernel:   [__user_walk+67/80] [sys_stat64+25/112]
[error_code+52/60]
Dec 22 05:44:01 neptune kernel:
Dec 22 05:44:01 neptune kernel: Code: 0f 0b 63 01 67 cd 22 c0 8b 41 fc a8
80 74 08
0f 0b 64 01 67
Dec 22 05:44:03 neptune smbd[17359]: make_connection: cory logged in as
admin user
(root privileges)
Dec 22 05:44:03 neptune kernel:  kernel BUG at vmscan.c:355!
Dec 22 05:44:03 neptune kernel: invalid operand: 0000
Dec 22 05:44:03 neptune kernel: CPU:    0
Dec 22 05:44:03 neptune kernel: EIP:    0010:[shrink_cache+154/768]    Not
tainted
Dec 22 05:44:03 neptune kernel: EFLAGS: 00010246
Dec 22 05:44:03 neptune kernel: eax: 00000000   ebx: 00000000   ecx:
c50ae618   edx:
0000049b
Dec 22 05:44:03 neptune kernel: esi: c50ae5fc   edi: 00000020   ebp:
00000200   esp:
dcee3e50
Dec 22 05:44:03 neptune kernel: ds: 0018   es: 0018   ss: 0018
Dec 22 05:44:03 neptune kernel: Process smbd (pid: 17359, stackpage=dcee3000)
Dec 22 05:44:03 neptune kernel: Stack: 00000020 000001f0 00000020 00000006
00000006
dcee2000 00002e10 000001f0
Dec 22 05:44:03 neptune kernel:        c02668f4 c012ae86 00000006 00000001
00000006
000001f0 c02668f4 c02668f4
Dec 22 05:44:03 neptune kernel:        c02668f4 c012aefc 00000020 dcee2000
00000000
00000010 c012b844 c0266a68
Dec 22 05:44:03 neptune kernel: Call Trace:    [shrink_caches+86/144]
[try_to_free_pages+60/96] [balance_classzone+84/432] [__alloc_pages+274/368]
[_alloc_pages+22/32]
Dec 22 05:44:03 neptune smbd[17360]: make_connection: cory logged in as
admin user
(root privileges)
Dec 22 05:44:03 neptune smbd[17359]: make_connection: cory logged in as
admin user
(root privileges)
Dec 22 05:44:03 neptune smbd[17360]: make_connection: cory logged in as
admin user
(root privileges)
Dec 22 05:44:03 neptune kernel:  kernel BUG at vmscan.c:355!
Dec 22 05:44:03 neptune kernel: invalid operand: 0000
Dec 22 05:44:03 neptune kernel: CPU:    0
Dec 22 05:44:03 neptune kernel: EIP:    0010:[shrink_cache+154/768]    Not
tainted
Dec 22 05:44:03 neptune kernel: EFLAGS: 00010246
Dec 22 05:44:03 neptune kernel: eax: 00000000   ebx: 00000000   ecx:
c50ae618   edx:
0000049b
Dec 22 05:44:03 neptune kernel: esi: c50ae5fc   edi: 00000020   ebp:
00000200   esp:
dcee3e50
Dec 22 05:44:03 neptune kernel: ds: 0018   es: 0018   ss: 0018
Dec 22 05:44:03 neptune kernel: Process smbd (pid: 17359, stackpage=dcee3000)
Dec 22 05:44:03 neptune kernel: Stack: 00000020 000001f0 00000020 00000006
00000006
dcee2000 00002e10 000001f0
Dec 22 05:44:03 neptune kernel:        c02668f4 c012ae86 00000006 00000001
00000006
000001f0 c02668f4 c02668f4
Dec 22 05:44:03 neptune kernel:        c02668f4 c012aefc 00000020 dcee2000
00000000
00000010 c012b844 c0266a68
Dec 22 05:44:03 neptune kernel: Call Trace:    [shrink_caches+86/144]
[try_to_free_pages+60/96] [balance_classzone+84/432] [__alloc_pages+274/368]
[_alloc_pages+22/32]
Dec 22 05:44:03 neptune kernel:  kernel BUG at vmscan.c:355!
Dec 22 05:44:03 neptune kernel: invalid operand: 0000
Dec 22 05:44:03 neptune kernel: CPU:    0
Dec 22 05:44:03 neptune kernel: EIP:    0010:[shrink_cache+154/768]    Not
tainted
Dec 22 05:44:03 neptune kernel: EFLAGS: 00010246
Dec 22 05:44:03 neptune kernel: eax: 00000000   ebx: 00000000   ecx:
c50ae618   edx:
0000049b
Dec 22 05:44:03 neptune kernel: esi: c50ae5fc   edi: 00000020   ebp:
00000200   esp:
dcee3e50
Dec 22 05:44:03 neptune kernel: ds: 0018   es: 0018   ss: 0018
Dec 22 05:44:03 neptune kernel: Process smbd (pid: 17359, stackpage=dcee3000)
Dec 22 05:44:03 neptune kernel: Stack: 00000020 000001f0 00000020 00000006
00000006
dcee2000 00002e10 000001f0
Dec 22 05:44:03 neptune kernel:        c02668f4 c012ae86 00000006 00000001
00000006
000001f0 c02668f4 c02668f4
Dec 22 05:44:03 neptune kernel:        c02668f4 c012aefc 00000020 dcee2000
00000000
00000010 c012b844 c0266a68
Dec 22 05:44:03 neptune kernel: Call Trace:    [shrink_caches+86/144]
[try_to_free_pages+60/96] [balance_classzone+84/432] [__alloc_pages+274/368]
[_alloc_pages+22/32]
Dec 22 05:44:08 neptune smbd[17361]: make_connection: cory logged in as
admin user
(root privileges)
Dec 22 05:44:08 neptune smbd[17362]: make_connection: cory logged in as
admin user
(root privileges)
Dec 22 05:44:08 neptune smbd[17363]: make_connection: cory logged in as
admin user
(root privileges)
Dec 22 05:44:08 neptune smbd[17364]: make_connection: cory logged in as
admin user
(root privileges)
Dec 22 05:44:08 neptune smbd[17365]: make_connection: cory logged in as
admin user
(root privileges)
Dec 22 05:44:08 neptune smbd[17366]: make_connection: cory logged in as
admin user
(root privileges)
Dec 22 05:44:08 neptune smbd[17361]: make_connection: cory logged in as
admin user
(root privileges)
Dec 22 05:44:08 neptune smbd[17362]: make_connection: cory logged in as
admin user
(root privileges)
Dec 22 05:44:08 neptune smbd[17363]: make_connection: cory logged in as
admin user
(root privileges)
Dec 22 05:44:08 neptune smbd[17364]: make_connection: cory logged in as
admin user
(root privileges)
Dec 22 05:44:08 neptune smbd[17365]: make_connection: cory logged in as
admin user
(root privileges)
Dec 22 05:44:08 neptune smbd[17366]: make_connection: cory logged in as
admin user
(root privileges)
Dec 22 08:47:50 neptune kernel: klogd 1.4.1#10, log source = /proc/kmsg
started.
Dec 22 08:47:50 neptune kernel: Inspecting /boot/System.map-2.4.19
Dec 22 08:47:50 neptune kernel: Loaded 15068 symbols from
/boot/System.map-2.4.19.
Dec 22 08:47:50 neptune kernel: Symbols match kernel version 2.4.19.
Dec 22 08:47:50 neptune kernel: Loaded 10 symbols from 2 modules.
Dec 22 08:47:50 neptune kernel: Linux version 2.4.19 (root@neptune) (gcc
version
2.95.4 20011002 (Debian prerelease)) #1 Sat Sep 14 14:38:02 PDT 2002
Dec 22 08:47:50 neptune kernel: BIOS-provided physical RAM map:
Dec 22 08:47:50 neptune kernel:  BIOS-e820: 0000000000000000 -
000000000009fc00
(usable)
Dec 22 08:47:50 neptune kernel:  BIOS-e820: 000000000009fc00 -
00000000000a0000
(reserved)
Dec 22 08:47:50 neptune kernel:  BIOS-e820: 00000000000f0000 -
0000000000100000
(reserved)
Dec 22 08:47:50 neptune kernel:  BIOS-e820: 0000000000100000 -
000000001fff0000
(usable)
Dec 22 08:47:50 neptune kernel:  BIOS-e820: 000000001fff0000 -
000000001fff3000
(ACPI NVS)
Dec 22 08:47:50 neptune kernel:  BIOS-e820: 000000001fff3000 -
0000000020000000
(ACPI data)
Dec 22 08:47:50 neptune kernel:  BIOS-e820: 00000000ffff0000 -
0000000100000000
(reserved)
Dec 22 08:47:50 neptune kernel: 511MB LOWMEM available.
Dec 22 08:47:50 neptune kernel: Advanced speculative caching feature not
present
Dec 22 08:47:50 neptune kernel: On node 0 totalpages: 131056
Dec 22 08:47:50 neptune kernel: zone(0): 4096 pages.
Dec 22 08:47:50 neptune kernel: zone(1): 126960 pages.
Dec 22 08:47:50 neptune kernel: zone(2): 0 pages.
Dec 22 08:47:50 neptune kernel: Kernel command line: auto BOOT_IMAGE=Linux
ro root=901
Dec 22 08:47:50 neptune kernel: Local APIC disabled by BIOS -- reenabling.
Dec 22 08:47:50 neptune kernel: Found and enabled local APIC!
Dec 22 08:47:50 neptune kernel: Initializing CPU#0
Dec 22 08:47:50 neptune kernel: Detected 1300.059 MHz processor.
Dec 22 08:47:50 neptune kernel: Console: colour VGA+ 80x30
Dec 22 08:47:50 neptune kernel: Calibrating delay loop... 2595.22 BogoMIPS
Dec 22 08:47:50 neptune kernel: Memory: 516216k/524224k available (1173k
kernel
code, 7620k reserved, 332k data, 224k init, 0k highmem)
Dec 22 08:47:50 neptune kernel: Dentry cache hash table entries: 65536
(order: 7,
524288 bytes)
Dec 22 08:47:50 neptune kernel: Inode cache hash table entries: 32768
(order: 6,
262144 bytes)
Dec 22 08:47:50 neptune kernel: Mount-cache hash table entries: 8192
(order: 4,
65536 bytes)
Dec 22 08:47:50 neptune kernel: Buffer-cache hash table entries: 32768
(order: 5,
131072 bytes)
Dec 22 08:47:50 neptune kernel: Page-cache hash table entries: 131072
(order: 7,
524288 bytes)
Dec 22 08:47:50 neptune kernel: CPU: Before vendor init, caps: 0183fbff
c1c7fbff
00000000, vendor = 2
Dec 22 08:47:50 neptune kernel: CPU: L1 I Cache: 64K (64 bytes/line), D
cache 64K
(64 bytes/line)
Dec 22 08:47:50 neptune kernel: CPU: L2 Cache: 256K (64 bytes/line)
Dec 22 08:47:50 neptune kernel: CPU: After vendor init, caps: 0183fbff
c1c7fbff
00000000 00000000
Dec 22 08:47:50 neptune kernel: Intel machine check architecture supported.
Dec 22 08:47:50 neptune kernel: Intel machine check reporting enabled on
CPU#0.
Dec 22 08:47:50 neptune kernel: CPU:     After generic, caps: 0183fbff
c1c7fbff
00000000 00000000
Dec 22 08:47:50 neptune kernel: CPU:             Common caps: 0183fbff
c1c7fbff
00000000 00000000
Dec 22 08:47:50 neptune kernel: CPU: AMD Athlon(tm) processor stepping 02
Dec 22 08:47:50 neptune kernel: Enabling fast FPU save and restore... done.
Dec 22 08:47:50 neptune kernel: Checking 'hlt' instruction... OK.
Dec 22 08:47:50 neptune kernel: POSIX conformance testing by UNIFIX
Dec 22 08:47:50 neptune kernel: enabled ExtINT on CPU#0
Dec 22 08:47:50 neptune kernel: ESR value before enabling vector: 00000000
Dec 22 08:47:50 neptune kernel: ESR value after enabling vector: 00000000
Dec 22 08:47:50 neptune kernel: Using local APIC timer interrupts.
Dec 22 08:47:50 neptune kernel: calibrating APIC timer ...
Dec 22 08:47:50 neptune kernel: ..... CPU clock speed is 1300.0392 MHz.
Dec 22 08:47:50 neptune kernel: ..... host bus clock speed is 200.0060 MHz.
Dec 22 08:47:50 neptune kernel: cpu: 0, clocks: 2000060, slice: 1000030
Dec 22 08:47:50 neptune kernel:
CPU0<T0:2000048,T1:1000016,D:2,S:1000030,C:2000060>
Dec 22 08:47:50 neptune kernel: mtrr: v1.40 (20010327) Richard Gooch
(rgooch@atnf.csiro.au)
Dec 22 08:47:50 neptune kernel: mtrr: detected mtrr type: Intel
Dec 22 08:47:50 neptune kernel: PCI: PCI BIOS revision 2.10 entry at
0xfb4e0, last
bus=2
Dec 22 08:47:50 neptune kernel: PCI: Using configuration type 1
Dec 22 08:47:50 neptune kernel: PCI: Probing PCI hardware
Dec 22 08:47:50 neptune kernel: Disabling VIA memory write queue (PCI ID
0305, rev
03): [55] 89 & 1f -> 09
Dec 22 08:47:50 neptune kernel: Unknown bridge resource 0: assuming
transparent
Dec 22 08:47:50 neptune kernel: Unknown bridge resource 1: assuming
transparent
Dec 22 08:47:50 neptune kernel: Unknown bridge resource 2: assuming
transparent
Dec 22 08:47:50 neptune kernel: Unknown bridge resource 0: assuming
transparent
Dec 22 08:47:50 neptune kernel: Unknown bridge resource 1: assuming
transparent
Dec 22 08:47:50 neptune kernel: Unknown bridge resource 2: assuming
transparent
Dec 22 08:47:50 neptune kernel: PCI: Using IRQ router VIA [1106/0686] at
00:07.0
Dec 22 08:47:50 neptune kernel: Applying VIA southbridge workaround.
Dec 22 08:47:50 neptune kernel: isapnp: Scanning for PnP cards...
Dec 22 08:47:50 neptune kernel: isapnp: Card 'U.S.Robotics Inc. Sportster
56000
Voice Interna'
Dec 22 08:47:50 neptune kernel: isapnp: 1 Plug & Play card detected total
Dec 22 08:47:50 neptune kernel: Linux NET4.0 for Linux 2.4
Dec 22 08:47:50 neptune kernel: Based upon Swansea University Computer
Society NET3.039
Dec 22 08:47:50 neptune kernel: Initializing RT netlink socket
Dec 22 08:47:50 neptune kernel: Starting kswapd
Dec 22 08:47:50 neptune kernel: VFS: Diskquotas version dquot_6.4.0
initialized
Dec 22 08:47:50 neptune kernel: pty: 256 Unix98 ptys configured
Dec 22 08:47:50 neptune kernel: Serial driver version 5.05c (2001-07-08) with
MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Dec 22 08:47:50 neptune kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Dec 22 08:47:50 neptune kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Dec 22 08:47:50 neptune kernel: ttyS02 at port 0x03e8 (irq = 5) is a 16550A
Dec 22 08:47:50 neptune kernel: Floppy drive(s): fd0 is 1.44M
Dec 22 08:47:50 neptune kernel: FDC 0 is a post-1991 82077
Dec 22 08:47:50 neptune kernel: SCSI subsystem driver Revision: 1.00
Dec 22 08:47:50 neptune kernel: Loading Adaptec I2O RAID: Version 2.4 Build 5
Dec 22 08:47:50 neptune kernel: Detecting Adaptec I2O RAID controllers...
Dec 22 08:47:50 neptune kernel: PCI: Found IRQ 15 for device 00:0d.1
Dec 22 08:47:50 neptune kernel: PCI: Sharing IRQ 15 with 00:0f.0
Dec 22 08:47:50 neptune kernel: Adaptec I2O RAID controller 0 at e0800000
size=100000 irq=15
Dec 22 08:47:50 neptune kernel: spurious 8259A interrupt: IRQ7.
Dec 22 08:47:50 neptune kernel: dpti: If you have a lot of devices this
could take a
few minutes.
Dec 22 08:47:50 neptune kernel: dpti0: Reading the hardware resource table.
Dec 22 08:47:50 neptune kernel: TID 008  Vendor: ADAPTEC      Device:
AIC-7899
Rev: 00000001
Dec 22 08:47:50 neptune kernel: TID 521  Vendor: ADAPTEC      Device: RAID-5
Rev: 370F
Dec 22 08:47:50 neptune kernel: scsi0 : Vendor: Adaptec  Model: 2100S
FW:370F
Dec 22 08:47:50 neptune kernel:   Vendor: ADAPTEC   Model: RAID-5         
  Rev: 370F
Dec 22 08:47:50 neptune kernel:   Type:   Direct-Access                   
  ANSI
SCSI revision: 02
Dec 22 08:47:50 neptune kernel: PCI: Found IRQ 15 for device 00:0f.0
Dec 22 08:47:50 neptune kernel: PCI: Sharing IRQ 15 with 00:0d.1
Dec 22 08:47:50 neptune kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA
DRIVER, Rev 6.2.8
Dec 22 08:47:50 neptune kernel:         <Adaptec 2940 Ultra SCSI adapter>
Dec 22 08:47:50 neptune kernel:         aic7880: Ultra Wide Channel A,
SCSI Id=7,
16/253 SCBs
Dec 22 08:47:50 neptune kernel:
Dec 22 08:47:50 neptune kernel:   Vendor: QUANTUM   Model: ATLAS 10K 9WLS 
  Rev: UC81
Dec 22 08:47:50 neptune kernel:   Type:   Direct-Access                   
  ANSI
SCSI revision: 03
Dec 22 08:47:50 neptune kernel: (scsi1:A:0): 40.000MB/s transfers
(20.000MHz, offset
8, 16bit)
Dec 22 08:47:50 neptune kernel:   Vendor: QUANTUM   Model: ATLAS 10K 9WLS 
  Rev: UC81
Dec 22 08:47:50 neptune kernel:   Type:   Direct-Access                   
  ANSI
SCSI revision: 03
Dec 22 08:47:50 neptune kernel: (scsi1:A:1): 40.000MB/s transfers
(20.000MHz, offset
8, 16bit)
Dec 22 08:47:50 neptune kernel:   Vendor: WDIGTL    Model: WD91 ULTRA2    
  Rev: 1.00
Dec 22 08:47:50 neptune kernel:   Type:   Direct-Access                   
  ANSI
SCSI revision: 02
Dec 22 08:47:50 neptune kernel: (scsi1:A:2): 40.000MB/s transfers
(20.000MHz, offset
8, 16bit)
Dec 22 08:47:50 neptune kernel:   Vendor: TOSHIBA   Model: CD-ROM
XM-6401TA  Rev: 1001
Dec 22 08:47:50 neptune kernel:   Type:   CD-ROM                          
  ANSI
SCSI revision: 02
Dec 22 08:47:50 neptune kernel: (scsi1:A:5): 10.000MB/s transfers
(10.000MHz, offset
15)
Dec 22 08:47:50 neptune kernel: scsi1:A:0:0: Tagged Queuing enabled.  Depth 8
Dec 22 08:47:50 neptune kernel: scsi1:A:1:0: Tagged Queuing enabled.  Depth 8
Dec 22 08:47:50 neptune kernel: scsi1:A:2:0: Tagged Queuing enabled.  Depth 8
Dec 22 08:47:50 neptune kernel: Attached scsi disk sda at scsi0, channel
0, id 0, lun 0
Dec 22 08:47:50 neptune kernel: Attached scsi disk sdb at scsi1, channel
0, id 0, lun 0
Dec 22 08:47:50 neptune kernel: Attached scsi disk sdc at scsi1, channel
0, id 1, lun 0
Dec 22 08:47:50 neptune kernel: Attached scsi disk sdd at scsi1, channel
0, id 2, lun 0
Dec 22 08:47:50 neptune kernel: SCSI device sda: 215055360 512-byte hdwr
sectors
(110108 MB)
Dec 22 08:47:50 neptune kernel: Partition check:
Dec 22 08:47:50 neptune kernel:  sda: sda1
Dec 22 08:47:50 neptune kernel: SCSI device sdb: 17938986 512-byte hdwr
sectors
(9185 MB)
Dec 22 08:47:50 neptune kernel:  sdb: sdb1 sdb2 sdb3
Dec 22 08:47:50 neptune kernel: SCSI device sdc: 17938986 512-byte hdwr
sectors
(9185 MB)
Dec 22 08:47:50 neptune kernel:  sdc: sdc1 sdc2 sdc3
Dec 22 08:47:50 neptune kernel: SCSI device sdd: 17873040 512-byte hdwr
sectors
(9151 MB)
Dec 22 08:47:50 neptune kernel:  sdd: sdd1 sdd2
Dec 22 08:47:50 neptune kernel: Attached scsi CD-ROM sr0 at scsi1, channel
0, id 5,
lun 0
Dec 22 08:47:50 neptune kernel: sr0: scsi-1 drive
Dec 22 08:47:50 neptune kernel: Uniform CD-ROM driver Revision: 3.12
Dec 22 08:47:50 neptune kernel: md: raid1 personality registered as nr 3
Dec 22 08:47:50 neptune kernel: md: raid5 personality registered as nr 4
Dec 22 08:47:50 neptune kernel:    8regs     :  1986.800 MB/sec
Dec 22 08:47:50 neptune kernel:    32regs    :  1757.200 MB/sec
Dec 22 08:47:50 neptune kernel:    pII_mmx   :  3036.800 MB/sec
Dec 22 08:47:50 neptune kernel:    p5_mmx    :  3889.600 MB/sec
Dec 22 08:47:50 neptune kernel: md: md driver 0.90.0 MAX_MD_DEVS=256,
MD_SB_DISKS=27
Dec 22 08:47:50 neptune kernel: md: Autodetecting RAID arrays.
Dec 22 08:47:50 neptune kernel:  [events: 000000cf]
Dec 22 08:47:50 neptune kernel:  [events: 000000db]
Dec 22 08:47:50 neptune kernel:  [events: 000000cf]
Dec 22 08:47:50 neptune kernel:  [events: 000000db]
Dec 22 08:47:50 neptune kernel: md: autorun ...
Dec 22 08:47:50 neptune kernel: md: considering sdd2 ...
Dec 22 08:47:50 neptune kernel: md:  adding sdd2 ...
Dec 22 08:47:50 neptune kernel: md:  adding sdc3 ...
Dec 22 08:47:50 neptune kernel: md:  adding sdb3 ...
Dec 22 08:47:50 neptune kernel: md: created md1
Dec 22 08:47:50 neptune kernel: md: bind<sdb3,1>
Dec 22 08:47:50 neptune kernel: md: bind<sdc3,2>
Dec 22 08:47:50 neptune kernel: md: bind<sdd2,3>
Dec 22 08:47:50 neptune kernel: md: running: <sdd2><sdc3><sdb3>
Dec 22 08:47:50 neptune kernel: RAID5 conf printout:
Dec 22 08:47:50 neptune kernel:  --- rd:3 wd:3 fd:0
Dec 22 08:47:50 neptune kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:sdb3
Dec 22 08:47:50 neptune kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:sdc3
Dec 22 08:47:50 neptune kernel:  disk 2, s:0, o:1, n:2 rd:2 us:1 dev:sdd2
Dec 22 08:47:50 neptune kernel: RAID5 conf printout:
Dec 22 08:47:50 neptune kernel:  --- rd:3 wd:3 fd:0
Dec 22 08:47:50 neptune kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:sdb3
Dec 22 08:47:50 neptune kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:sdc3
Dec 22 08:47:50 neptune kernel:  disk 2, s:0, o:1, n:2 rd:2 us:1 dev:sdd2
Dec 22 08:47:50 neptune kernel: md: updating md1 RAID superblock on device
Dec 22 08:47:50 neptune kernel: md: considering sdc1 ...
Dec 22 08:47:50 neptune kernel: md:  adding sdc1 ...
Dec 22 08:47:50 neptune kernel: md:  adding sdb1 ...
Dec 22 08:47:50 neptune kernel: md: created md0
Dec 22 08:47:50 neptune kernel: md: bind<sdb1,1>
Dec 22 08:47:50 neptune kernel: md: bind<sdc1,2>
Dec 22 08:47:50 neptune kernel: md: running: <sdc1><sdb1>
Dec 22 08:47:50 neptune kernel: raid1: raid set md0 active with 2 out of 2
mirrors
Dec 22 08:47:50 neptune kernel: md: updating md0 RAID superblock on device
Dec 22 08:47:50 neptune kernel: md: ... autorun DONE.
Dec 22 08:47:50 neptune kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Dec 22 08:47:50 neptune kernel: IP Protocols: ICMP, UDP, TCP
Dec 22 08:47:50 neptune kernel: IP: routing cache hash table of 4096
buckets, 32Kbytes
Dec 22 08:47:50 neptune kernel: TCP: Hash tables configured (established
32768 bind
32768)
Dec 22 08:47:50 neptune kernel: NET4: Unix domain sockets 1.0/SMP for
Linux NET4.0.
Dec 22 08:47:50 neptune kernel: raid5: switching cache buffer size, 4096
--> 1024
Dec 22 08:47:50 neptune kernel: raid5: switching cache buffer size, 1024
--> 4096
Dec 22 08:47:50 neptune kernel: VFS: Mounted root (ext2 filesystem) readonly.
Dec 22 08:47:50 neptune kernel: Freeing unused kernel memory: 224k freed
Dec 22 08:47:50 neptune kernel: Adding Swap: 128516k swap-space (priority -1)
Dec 22 08:47:50 neptune kernel: Adding Swap: 104380k swap-space (priority -2)
Dec 22 08:47:50 neptune kernel: Real Time Clock Driver v1.10e
Dec 22 08:47:50 neptune kernel: PCI: Found IRQ 11 for device 00:0b.0
Dec 22 08:47:50 neptune kernel: 3c59x: Donald Becker and others.
www.scyld.com/network/vortex.html
Dec 22 08:47:50 neptune kernel: 00:0b.0: 3Com PCI 3c905C Tornado at
0xdc00. Vers
LK1.1.16
Dec 22 08:47:50 neptune kernel: reiserfs: checking transaction log (device
08:01) ...
Dec 22 08:47:50 neptune kernel: reiserfs: replayed 1 transactions in 1
seconds
Dec 22 08:47:50 neptune kernel: Using r5 hash to sort names
Dec 22 08:47:50 neptune kernel: Removing [140095 304357 0x0 SD]..done
Dec 22 08:47:50 neptune kernel: Removing [140112 140095 0x0 SD]..done
Dec 22 08:47:50 neptune kernel: There were 2 uncompleted
unlinks/truncates. Completed
Dec 22 08:47:50 neptune kernel: ReiserFS version 3.6.25
Dec 22 08:47:50 neptune lpd[232]: restarted





