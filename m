Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132407AbRBRBqr>; Sat, 17 Feb 2001 20:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132452AbRBRBqh>; Sat, 17 Feb 2001 20:46:37 -0500
Received: from slamp.tomt.net ([195.139.204.145]:22744 "HELO slamp.tomt.net")
	by vger.kernel.org with SMTP id <S132407AbRBRBqY>;
	Sat, 17 Feb 2001 20:46:24 -0500
From: "Andre Tomt" <andre@tomt.net>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: 2.4.1 crashing every other day
Date: Sun, 18 Feb 2001 02:46:30 +0100
Message-ID: <OPECLOJPBIHLFIBNOMGBOEGFDBAA.andre@tomt.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Very recently I installed a new mailserver for my company, based around
qmail, linux 2.4.1, and software raid 1.
It works very nicely untill it spews out oops's after a few days, leaving
hundreds of qmail-popup processes hanging, unkillable. THe server is very
lightly loaded for now, doing only a few hundreds smtp + pop's a day.

It's a Pentium III 733 based system, with 256MB RAM (one stick, we have
already tried another stick), and every partition except swap on software
RAID 1. Both IDE disks (IBM-DTLA-307030, 30GB each) are connected to a HPT
ATA100 IDE controller (see the lscpi-output). I've attached some info, and
one decoded oops. Longer down you'll find info from lspci and the like.

As a side note, we have one other _identical_ hardware setup, running the
same kernel, same base software, same partitioning, same RAID setup, just as
a webserver. And it works grrrreat, no hickups whatsoever. Also, the oops's
seems to happen only with qmail-popup, at least thats how the few crashes I
had the chance to investigate did.


Output from ksymops (yes, it's ksymops-2.4.0):
--------------------
root@mail:~/ksymoops-2.4.0# ./ksymoops -m /boot/System.map < input
ksymoops 2.3.7 on i686 2.4.1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1/ (default)
     -m /boot/System.map (specified)

kernel BUG at page_alloc.c:203!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012a6f2>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292
eax: 00000020   ebx: c1419da8   ecx: cf343f00   edx: 00000008
esi: 00000002   edi: c0201558   ebp: 00000001   esp: c1863ef8
ds: 0018   es: 0018   ss: 0018
Process qmail-popup (pid: 6795, stackpage=c1863000)
Stack: c01d4145 c01d42d3 000000cb c0201558 c0201758 00000007 c1863fbc
c020158c
       0000e706 0000e706 00000286 00000001 c0201558 c012a8bb c1862000
c1863f94
       c1862000 c1863fbc 00000001 c1963840 00000007 00000000 c0201754
c012aad4
Call Trace: [<c012a8bb>] [<c012aad4>] [<c0114480>] [<c01077dc>] [<c0108dc3>]
Code: 0f 0b 83 c4 0c 90 89 d8 eb 14 45 83 c6 0c 83 fd 09 0f 86 db

>>EIP; c012a6f2 <rmqueue+232/258>   <=====
Trace; c012a8bb <__alloc_pages+eb/2f0>
Trace; c012aad4 <__get_free_pages+14/20>
Trace; c0114480 <do_fork+94/6d0>
Trace; c01077dc <sys_fork+14/1c>
Trace; c0108dc3 <system_call+33/38>
Code;  c012a6f2 <rmqueue+232/258>
00000000 <_EIP>:
Code;  c012a6f2 <rmqueue+232/258>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012a6f4 <rmqueue+234/258>
   2:   83 c4 0c                  addl   $0xc,%esp
Code;  c012a6f7 <rmqueue+237/258>
   5:   90                        nop
Code;  c012a6f8 <rmqueue+238/258>
   6:   89 d8                     movl   %ebx,%eax
Code;  c012a6fa <rmqueue+23a/258>
   8:   eb 14                     jmp    1e <_EIP+0x1e> c012a710
<rmqueue+250/258>
Code;  c012a6fc <rmqueue+23c/258>
   a:   45                        incl   %ebp
Code;  c012a6fd <rmqueue+23d/258>
   b:   83 c6 0c                  addl   $0xc,%esi
Code;  c012a700 <rmqueue+240/258>
   e:   83 fd 09                  cmpl   $0x9,%ebp
Code;  c012a703 <rmqueue+243/258>
  11:   0f 86 db 00 00 00         jbe    f2 <_EIP+0xf2> c012a7e4
<__alloc_pages+14/2f0>


lspci:
------
root@mail:~/ksymoops-2.4.0# lspci -vvv
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev
03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: d4000000-d5ffffff
        Prefetchable memory behind bridge: d6000000-d7ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if
80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at d000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:0f.0 Ethernet controller: Accton Technology Corporation SMC2-1211TX (rev
10)
        Subsystem: Accton Technology Corporation EN-1207D Fast Ethernet
Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d400 [size=256]
        Region 1: Memory at d9000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366
(rev 03)
        Subsystem: Triones Technologies, Inc.: Unknown device 0001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d800 [size=8]
        Region 1: I/O ports at dc00 [size=4]
        Region 2: I/O ports at e000 [size=8]
        Region 3: I/O ports at e400 [size=4]
        Region 4: I/O ports at e800 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15)
(prog-if 00 [VGA])
        Subsystem: CardExpert Technology: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: Memory at d4000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d6000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


RAID 1 setup (raidtab):
## /
raiddev                 /dev/md0
raid-level              1
nr-raid-disks           2
chunk-size              32
nr-spare-disks          0
persistent-superblock   1
device                  /dev/hde1
raid-disk               0
device                  /dev/hdg1
raid-disk             1

## /usr/local
raiddev                 /dev/md1
raid-level              1
nr-raid-disks           2
chunk-size              32
nr-spare-disks          0
persistent-superblock   1
device                  /dev/hde6
raid-disk               0
device                  /dev/hdg6
raid-disk             1

## /tmp
raiddev                 /dev/md2
raid-level              1
nr-raid-disks           2
chunk-size              32
nr-spare-disks          0
persistent-superblock   1
device                  /dev/hde7
raid-disk               0
device                  /dev/hdg7
raid-disk             1

## /var
raiddev                 /dev/md3
raid-level              1
nr-raid-disks           2
chunk-size              32
nr-spare-disks          0
persistent-superblock   1
device                  /dev/hde8
raid-disk               0
device                  /dev/hdg8
raid-disk             1

## /home
raiddev                 /dev/md4
raid-level              1
nr-raid-disks           2
chunk-size              32
nr-spare-disks          0
persistent-superblock   1
device                  /dev/hde9
raid-disk               0
device                  /dev/hdg9
raid-disk             1


disk usage:
Filesystem            Size  Used Avail Use% Mounted on
/dev/md0              1.4G  711M  636M  53% /
/dev/md1              1.9G   50M  1.7G   3% /usr/local
/dev/md2              472M   15M  433M   3% /tmp
/dev/md3              961M   14M  898M   2% /var
/dev/md4               23G  1.2G   21G   6% /home



