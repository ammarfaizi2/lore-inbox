Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264218AbTFKIMW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 04:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264219AbTFKIMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 04:12:22 -0400
Received: from [212.55.216.106] ([212.55.216.106]:13316 "EHLO
	buffalo.u-blox.ch") by vger.kernel.org with ESMTP id S264218AbTFKIL5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 04:11:57 -0400
Date: Wed, 11 Jun 2003 10:25:28 +0200 (CEST)
From: Etienne Favey <eflr@u-blox.com>
To: linux-kernel@vger.kernel.org
cc: efkl@u-blox.com
Subject: Kernel 2.4.18 oops, NULL pointer in fs/buffer.c
Message-ID: <Pine.LNX.4.21.0306111014090.18186-100000@skunk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.]
Kernel 2.4.18 oops, NULL pointer in fs/buffer.c

[2.]
Please CC efkl@u-blox.com with answer as I am not subscribed to the list.

The host is completely frozen after the Oops, and it seems to
happen while we do backup onto a SCSI tape.
The machine was under heavy load.
Yet there is no apparent indication as to what caused the Oops.
It is used mainly as File server (samba), backup (SCSI tape), and
number cruncher (heavy scientific calculations).

[3.]
kswapd, fs/buffer.c, try_to_free_buffers

[4.] cat /proc/version
Linux version 2.4.18 (root@newwhale) (gcc version 2.95.4 20011002 (Debian prerelease)) #4 SMP Mon Nov 18 15:42:20 CET 2002

[5.]
ksymoops 2.4.5 on i686 2.4.18.  Options used
     -V (default)
     -k /var/log/ksymoops/20030610062600.ksyms (specified)
     -L (specified)
     -o /lib/modules/2.4.18/ (default)
     -m /System.map (specified)

No modules in ksyms, skipping objects
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c02430f0, System.map says c0154270.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000018
c0137640
*pde = 00000000
Oops: 0000
CPU:    2
EIP:    0010:[<c0137640>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010207
eax: 00000000   ebx: c030af60     ecx: 000001d0       edx: 00000000
esi: 00000000   edi: f1757c60     ebp: c1768340       esp: f7ec9f24
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 7, stackpage=f7ec9000)
Stack: c1768340 000001d0 0000001b 00000200 c0135d8c c1768340 000001d0 f1757c60
       c1768340 c012ce52 c1768340 000001d0 00000020 000001d0 00000020 00000006
       f7ec8000 f7ec8000 000053b6 000001d0 c030a888 c012d102 00000006 00000001
Call Trace: [<c0135d8c>] [<c012ce52>] [<c012d102>] [<c012d15f>] [<c012d1f3>]
   [<c012d24e>] [<c012d35d>] [<c01055a4>]
Code: 8b 56 18 8b 46 10 83 e2 06 09 d0 0f 85 97 00 00 00 8b 76 28


>>EIP; c0137640 <try_to_free_buffers+34/13c>   <=====

>>ebx; c030af60 <hash_table_lock+0/4>
>>edi; f1757c60 <END_OF_CODE+3139c784/????>
>>ebp; c1768340 <END_OF_CODE+13ace64/????>
>>esp; f7ec9f24 <END_OF_CODE+37b0ea48/????>

Trace; c0135d8c <try_to_release_page+3c/44>
Trace; c012ce52 <shrink_cache+20e/38c>
Trace; c012d102 <shrink_caches+56/7c>
Trace; c012d15f <try_to_free_pages+37/58>
Trace; c012d1f3 <kswapd_balance_pgdat+43/8c>
Trace; c012d24e <kswapd_balance+12/28>
Trace; c012d35d <kswapd+99/b4>
Trace; c01055a4 <kernel_thread+28/38>

Code;  c0137640 <try_to_free_buffers+34/13c>
00000000 <_EIP>:
Code;  c0137640 <try_to_free_buffers+34/13c>   <=====
   0:   8b 56 18                  mov    0x18(%esi),%edx   <=====
Code;  c0137643 <try_to_free_buffers+37/13c>
   3:   8b 46 10                  mov    0x10(%esi),%eax
Code;  c0137646 <try_to_free_buffers+3a/13c>
   6:   83 e2 06                  and    $0x6,%edx
Code;  c0137649 <try_to_free_buffers+3d/13c>
   9:   09 d0                     or     %edx,%eax
Code;  c013764b <try_to_free_buffers+3f/13c>
   b:   0f 85 97 00 00 00         jne    a8 <_EIP+0xa8> c01376e8 <try_to_free_buffers+dc/13c>
Code;  c0137651 <try_to_free_buffers+45/13c>
  11:   8b 76 28                  mov    0x28(%esi),%esi


1 warning issued.  Results may not be reliable.

[6.]
None

[7.]
[7.1] sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux whale 2.4.18 #4 SMP Mon Nov 18 15:42:20 CET 2002 i686 unknown
 
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
Modules Loaded         

[7.2] cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) CPU 2.40GHz
stepping        : 4
cpu MHz         : 2395.987
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4784.12

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) CPU 2.40GHz
stepping        : 4
cpu MHz         : 2395.987
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4784.12

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) CPU 2.40GHz
stepping        : 4
cpu MHz         : 2395.987
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4784.12

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) CPU 2.40GHz
stepping        : 4
cpu MHz         : 2395.987
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4784.12

[7.3] cat /proc/modules
None

[7.4] cat /proc/ioports ; cat /proc/iomem
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
1100-111f : PCI device 8086:2483 (Intel Corp.)
2000-201f : PCI device 8086:2482 (Intel Corp.)
2020-203f : PCI device 8086:2484 (Intel Corp.)
2040-205f : PCI device 8086:2487 (Intel Corp.)
2060-206f : PCI device 8086:248b (Intel Corp.)
  2060-2067 : ide0
  2068-206f : ide1
3000-3fff : PCI Bus #04
  3000-3fff : PCI Bus #06
    3000-30ff : Adaptec 7899P
      3000-30ff : aic7xxx
    3400-34ff : Adaptec 7899P (#2)
      3400-34ff : aic7xxx
4000-4fff : PCI Bus #07
  4000-40ff : ATI Technologies Inc Rage XL
  4400-443f : Intel Corp. 82557 [Ethernet Pro 100]
    4400-443f : eepro100
  4440-447f : Intel Corp. 82557 [Ethernet Pro 100] (#2)
    4440-447f : eepro100
00000000-0009f3ff : System RAM
0009f400-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Extension ROM
000c9000-000ce5ff : Extension ROM
000d8000-000dffff : reserved
000f0000-000fffff : System ROM
00100000-3feeffff : System RAM
  00100000-002983f8 : Kernel code
  002983f9-00323c3f : Kernel data
3fef0000-3fefbfff : ACPI Tables
3fefc000-3fefffff : ACPI Non-volatile Storage
3ff00000-3ff7ffff : System RAM
3ff80000-3fffffff : reserved
40000000-400003ff : PCI device 8086:248b (Intel Corp.)
fc100000-fc1fffff : PCI Bus #01
  fc100000-fc100fff : PCI device 8086:1461 (Intel Corp.)
  fc101000-fc101fff : PCI device 8086:1461 (Intel Corp.)
fc200000-fc3fffff : PCI Bus #04
  fc200000-fc200fff : PCI device 8086:1461 (Intel Corp.)
  fc201000-fc201fff : PCI device 8086:1461 (Intel Corp.)
  fc300000-fc3fffff : PCI Bus #06
    fc300000-fc300fff : Adaptec 7899P
      fc300000-fc300fff : aic7xxx
    fc301000-fc301fff : Adaptec 7899P (#2)
      fc301000-fc301fff : aic7xxx
fc400000-fdffffff : PCI Bus #07
  fc400000-fc400fff : ATI Technologies Inc Rage XL
  fc401000-fc401fff : Intel Corp. 82557 [Ethernet Pro 100]
    fc401000-fc401fff : eepro100
  fc402000-fc402fff : Intel Corp. 82557 [Ethernet Pro 100] (#2)
    fc402000-fc402fff : eepro100
  fc420000-fc43ffff : Intel Corp. 82557 [Ethernet Pro 100]
  fc440000-fc45ffff : Intel Corp. 82557 [Ethernet Pro 100] (#2)
  fd000000-fdffffff : ATI Technologies Inc Rage XL
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
ff800000-ffbfffff : reserved
fff00000-ffffffff : reserved

[7.5] lspci -vvv
00:00.0 Host bridge: Intel Corp.: Unknown device 2540 (rev 03)
        Subsystem: Super Micro Computer Inc: Unknown device 3480
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:00.1 Class ff00: Intel Corp.: Unknown device 2541 (rev 03)
        Subsystem: Super Micro Computer Inc: Unknown device 3480
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:02.0 PCI bridge: Intel Corp.: Unknown device 2543 (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=03, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fc100000-fc1fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:03.0 PCI bridge: Intel Corp.: Unknown device 2545 (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=04, subordinate=06, sec-latency=0
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: fc200000-fc3fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp.: Unknown device 2482 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Super Micro Computer Inc: Unknown device 3480
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at 2000 [size=32]

00:1d.1 USB Controller: Intel Corp.: Unknown device 2484 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Super Micro Computer Inc: Unknown device 3480
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at 2020 [size=32]

00:1d.2 USB Controller: Intel Corp.: Unknown device 2487 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Super Micro Computer Inc: Unknown device 3480
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 4: I/O ports at 2040 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev 42) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=07, subordinate=07, sec-latency=64
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: fc400000-fdffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp.: Unknown device 2480 (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp.: Unknown device 248b (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Super Micro Computer Inc: Unknown device 3480
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at <unassigned> [size=8]
        Region 1: I/O ports at <unassigned> [size=4]
        Region 2: I/O ports at <unassigned> [size=8]
        Region 3: I/O ports at <unassigned> [size=4]
        Region 4: I/O ports at 2060 [size=16]
        Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp.: Unknown device 2483 (rev 02)
        Subsystem: Super Micro Computer Inc: Unknown device 3480
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 0
        Region 4: I/O ports at 1100 [size=32]

01:1c.0 PIC: Intel Corp.: Unknown device 1461 (rev 03) (prog-if 20 [IO(X)-APIC])
        Subsystem: Super Micro Computer Inc: Unknown device 3480
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fc100000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] #07 [0000]

01:1d.0 PCI bridge: Intel Corp.: Unknown device 1460 (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 10
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
        Capabilities: [50] #07 [0083]

01:1e.0 PIC: Intel Corp.: Unknown device 1461 (rev 03) (prog-if 20 [IO(X)-APIC])
        Subsystem: Super Micro Computer Inc: Unknown device 3480
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fc101000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] #07 [0000]

01:1f.0 PCI bridge: Intel Corp.: Unknown device 1460 (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 10
        Bus: primary=01, secondary=03, subordinate=03, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
        Capabilities: [50] #07 [0083]

04:1c.0 PIC: Intel Corp.: Unknown device 1461 (rev 03) (prog-if 20 [IO(X)-APIC])
        Subsystem: Super Micro Computer Inc: Unknown device 3480
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fc200000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] #07 [0000]

04:1d.0 PCI bridge: Intel Corp.: Unknown device 1460 (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 10
        Bus: primary=04, secondary=05, subordinate=05, sec-latency=48
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
        Capabilities: [50] #07 [0003]

04:1e.0 PIC: Intel Corp.: Unknown device 1461 (rev 03) (prog-if 20 [IO(X)-APIC])
        Subsystem: Super Micro Computer Inc: Unknown device 3480
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fc201000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] #07 [0000]

04:1f.0 PCI bridge: Intel Corp.: Unknown device 1460 (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 10
        Bus: primary=04, secondary=06, subordinate=06, sec-latency=48
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: fc300000-fc3fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
        Capabilities: [50] #07 [0003]

06:02.0 SCSI storage controller: Adaptec 7899P (rev 01)
        Subsystem: Super Micro Computer Inc: Unknown device 9005
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 76
        BIST result: 00
        Region 0: I/O ports at 3000 [disabled] [size=256]
        Region 1: Memory at fc300000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

06:02.1 SCSI storage controller: Adaptec 7899P (rev 01)
        Subsystem: Super Micro Computer Inc: Unknown device 9005
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin B routed to IRQ 77
        BIST result: 00
        Region 0: I/O ports at 3400 [disabled] [size=256]
        Region 1: Memory at fc301000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

07:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0008
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at 4000 [size=256]
        Region 2: Memory at fc400000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

07:02.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 0d)
        Subsystem: Intel Corp.: Unknown device 1050
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at fc401000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 4400 [size=64]
        Region 2: Memory at fc420000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

07:03.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 0d)
        Subsystem: Intel Corp.: Unknown device 1050
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at fc402000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 4440 [size=64]
        Region 2: Memory at fc440000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-


[7.6] cat /proc/scsi/scsi
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST336607LC       Rev: 0002
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST336607LC       Rev: 0002
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST373307LC       Rev: 0002
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 08 Lun: 00
  Vendor: SUPER    Model: GEM359 REV001    Rev: 1.09
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor: QUANTUM  Model: DLT7000          Rev: 2150
  Type:   Sequential-Access                ANSI SCSI revision: 02

[7.7]
There is a IDE-Atapi CDROM, but it is not used in normal operations.
A gdb disassembly of the file fs/buffers.c gives the following lines
which seem to match the result of ksymoops:
...
0x2e10 <try_to_free_buffers+52>:        mov    0x18(%esi),%edx
0x2e13 <try_to_free_buffers+55>:        mov    0x10(%esi),%eax
0x2e16 <try_to_free_buffers+58>:        and    $0x6,%edx
0x2e19 <try_to_free_buffers+61>:        or     %edx,%eax
0x2e1b <try_to_free_buffers+63>:        jne    0x2eb8 <try_to_free_buffers+220>
0x2e21 <try_to_free_buffers+69>:        mov    0x28(%esi),%esi
0x2e24 <try_to_free_buffers+72>:        cmp    %edi,%esi
...

[8.] Additional Info
[8.1] cat /proc/swaps
Filename                        Type            Size    Used    Priority
/dev/sdb1                       partition       2000052 10312   -1
/dev/sda1                       partition       2000052 0       -2

[8.2]
Request for FAQ entry:
Unfortunately, I was not able to figure out, if this particular problem
is already known or even fixed. I would appreciate if you could possibly
add to the linux-kernel mailing list FAQ a link to where one would
be able to find such information.
At least the fs/ChangeLog of subsequent kernel releases did not tell
me, Google did not find it, and I did not find a link yet.

I will try 2.4.20 and hope not to see this oops again, but if I do
you'll probably hear me again ;-)

If there is any more information needed to resolve the problem,
I will happily provide it to you upon request.

Cheers + thanks, Etienne


