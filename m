Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270314AbRIOPSr>; Sat, 15 Sep 2001 11:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270333AbRIOPSi>; Sat, 15 Sep 2001 11:18:38 -0400
Received: from pc-62-31-21-200-sh.blueyonder.co.uk ([62.31.21.200]:56920 "HELO
	bubbles.townsville") by vger.kernel.org with SMTP
	id <S270314AbRIOPSU>; Sat, 15 Sep 2001 11:18:20 -0400
Date: 15 Sep 2001 15:18:32 -0000
Message-ID: <20010915151832.4912.qmail@bubbles.townsville>
From: "Chris J/#6" <cej@nccnet.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.9 Oops: SMP problem?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hiya,

First bug report I've to linux-kernel so bear with me :)

Last night my machine Oops'd and after the oops any attempt to run a program
resulted in a hang of the command prompt - couldn't CTRL-C, CTRL-Z etc to
stop it. I'd assume this is one of the effects of an Oops, but it does mean
that before I could do any more state reporting, I've had to reboot my
machine.

I don't know what caused it, my machine was being used as I normally use
it, so had XMMS, licq, XFree 4.1, exmh running (distribution is Slackware 8).

Machine is a Dual Celeron (not over-clocked) with ABit BP6 mobo., 256MB RAM,
in excess of 512MB swap, Maxtor hard drives on standard IDE (rather than
the Highpoint controller). Machine was last rebooted Sep 2nd, so it was
running for about 2 weeks before the Oops. This is also the longest the
machine had been running, but previous reboots are config changes, not a
kernel issue).

Here's the gubbins that REPORTING-BUGS asks for...

-------------------------------------------------------------------------

The Oops, as passed through ksymoops:

ksymoops 2.4.2 on i686 2.4.9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.9/ (default)
     -m ../sys/linux/System.map (specified)

Unable to handle kernel paging request at virtual address 93c3785c
c012947f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[kmem_cache_alloc_batch+55/120]
EFLAGS: 00010002
eax: 3119c609   ebx: c145fa00   ecx: 3c03c97f   edx: cf5c6020
esi: 00000006   edi: c1445230   ebp: c145f000   esp: cc1c9e2c
ds: 0018   es: 0018   ss: 0018
Process bubblemon (pid: 282, stackpage=cc1c9000)
Stack: c1445230 00000246 000000f0 c01295dd c1445230 000000f0 00000000 cffcbd78
       cffcbd78 c0147064 c1445230 000000f0 00000000 cffcbd78 00001007 c145f000
       c0147399 c145f000 00001007 cffcbd78 00000000 00000000 c145b420 c38f1c20
Call Trace: [kmem_cache_alloc+57/156] [get_new_inode+28/380] [iget4+213/224] [proc_get_inode+65/280] [proc_lookup+112/148]
Code: 8b 44 82 18 89 42 14 83 f8 ff 75 05 8b 02 89 47 08 8b 03 89
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
0000000000000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 44 82 18               mov    0x18(%edx,%eax,4),%eax
Code;  00000004 Before first symbol
   4:   89 42 14                  mov    %eax,0x14(%edx)
Code;  00000006 Before first symbol
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  0000000a Before first symbol
   a:   75 05                     jne    11 <_EIP+0x11> 00000010 Before first symbol
Code;  0000000c Before first symbol
   c:   8b 02                     mov    (%edx),%eax
Code;  0000000e Before first symbol
   e:   89 47 08                  mov    %eax,0x8(%edi)
Code;  00000010 Before first symbol
  11:   8b 03                     mov    (%ebx),%eax
Code;  00000012 Before first symbol
  13:   89 00                     mov    %eax,(%eax)

--------------------------------------------------------------------------

Before the Oops itself, in syslog I also have the message:

	APIC error on CPU0: 02(02)

--------------------------------------------------------------------------
Kernel version is (/proc/version):
Linux version 2.4.9 (chris@bubbles) (gcc version 2.95.3 20010315 (release)) #1 SMP Sun Aug 19 13:05:40 BST 2001

--------------------------------------------------------------------------

Output from scripts/ver_linux:

[!%][bubbles][linux] >sh scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux bubbles 2.4.9 #1 SMP Sun Aug 19 13:05:40 BST 2001 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.19
util-linux             2.11f
mount                  2.11b
modutils               2.4.6
e2fsprogs              1.22
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         sb sb_lib uart401 sound ppp_deflate ppp_async
[!%][bubbles][linux] >

--------------------------------------------------------------------------
/proc/cpuinfo:

[!%][bubbles][linux] >cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 400.916
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr
bogomips        : 799.53

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 400.916
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr
bogomips        : 801.17

--------------------------------------------------------------------------
/proc/modules:

sb                      7504   2 (autoclean)
sb_lib                 34592   0 (autoclean) [sb]
uart401                 6448   0 (autoclean) [sb_lib]
sound                  58640   2 (autoclean) [sb_lib uart401]
ppp_deflate            39216   0 (unused)
ppp_async               6720   0 (unused)

--------------------------------------------------------------------------
/proc/ioports:

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0213-0213 : isapnp read
0220-022f : soundblaster
02f8-02ff : serial(auto)
0330-0333 : MPU-401 UART
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0778-077a : parport0
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
9000-9fff : PCI Bus #01
  9000-90ff : 3Dfx Interactive, Inc. Voodoo Banshee
a000-a01f : Intel Corporation 82371AB PIIX4 USB
a400-a41f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  a400-a41f : ne2k-pci
a800-a8ff : Adaptec AIC-7861
ac00-ac07 : HighPoint Technologies, Inc. HPT366/370 UltraDMA 66/100 IDE Controll
er
b000-b003 : HighPoint Technologies, Inc. HPT366/370 UltraDMA 66/100 IDE Controll
er
b400-b4ff : HighPoint Technologies, Inc. HPT366/370 UltraDMA 66/100 IDE Controll
er
  b400-b407 : ide2
  b410-b4ff : HPT366
b800-b807 : HighPoint Technologies, Inc. HPT366/370 UltraDMA 66/100 IDE Controll
er (#2)
bc00-bc03 : HighPoint Technologies, Inc. HPT366/370 UltraDMA 66/100 IDE Controll
er (#2)
c000-c0ff : HighPoint Technologies, Inc. HPT366/370 UltraDMA 66/100 IDE Controll
er (#2)
  c000-c007 : ide3
  c010-c0ff : HPT366
f000-f00f : Intel Corporation 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

--------------------------------------------------------------------------
/proc/iomem:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c9000-000c97ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-002926a6 : Kernel code
  002926a7-00329e9f : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d0000000-d3ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
d4000000-d7ffffff : PCI Bus #01
  d4000000-d5ffffff : 3Dfx Interactive, Inc. Voodoo Banshee
d8000000-d9ffffff : PCI Bus #01
  d8000000-d9ffffff : 3Dfx Interactive, Inc. Voodoo Banshee
db000000-db000fff : Adaptec AIC-7861
  db000000-db000fff : aic7xxx
db001000-db001fff : Brooktree Corporation Bt849A Video capture
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

--------------------------------------------------------------------------
Output of lspci -vvv:

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: d4000000-d7ffffff
        Prefetchable memory behind bridge: d8000000-d9ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 19
        Region 4: I/O ports at a000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:0b.0 Multimedia video controller: Brooktree Corporation Bt849A Video capture (rev 12)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at db001000 (32-bit, prefetchable) [size=4K]

00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at a400 [size=32]

00:0f.0 SCSI storage controller: Adaptec AIC-7861 (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at a800 [disabled] [size=256]
        Region 1: Memory at db000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev 01)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at ac00 [size=8]
        Region 1: I/O ports at b000 [size=4]
        Region 4: I/O ports at b400 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]

00:13.1 Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 18
        Region 0: I/O ports at b800 [size=8]
        Region 1: I/O ports at bc00 [size=4]
        Region 4: I/O ports at c000 [size=256]

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo Banshee (rev 03) (prog-if 00 [VGA])
        Subsystem: Creative Labs: Unknown device 1018
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at d4000000 (32-bit, non-prefetchable) [size=32M]
        Region 1: Memory at d8000000 (32-bit, prefetchable) [size=32M]
        Region 2: I/O ports at 9000 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [54] AGP version 1.0
                Status: RQ=7 SBA+ 64bit+ FW- Rate=x1
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--------------------------------------------------------------------------
/proc/scsi/scsi:

Attached devices: 
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-40TS   Rev: 1.10
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: DEC      Model: RRD42   (C) DEC  Rev: 4.5d
  Type:   CD-ROM                           ANSI SCSI revision: 02


Chris...

-- 
\ Chris Johnson           \  "If not for me then, do it for yourself. If not
 \ cej@nccnet.co.uk        \  for then do it for the world." -- Stevie Nicks
  \ www.nccnet.co.uk/~cej/  ~-----------------------------------------+
   \ Redclaw chat - http://redclaw.org.uk - telnet redclaw.org.uk 2000 \____
