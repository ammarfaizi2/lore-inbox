Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261782AbSI1PIg>; Sat, 28 Sep 2002 11:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261783AbSI1PIg>; Sat, 28 Sep 2002 11:08:36 -0400
Received: from techunix.technion.ac.il ([132.68.1.28]:42407 "EHLO
	techunix.technion.ac.il") by vger.kernel.org with ESMTP
	id <S261782AbSI1PI3> convert rfc822-to-8bit; Sat, 28 Sep 2002 11:08:29 -0400
Date: Sat, 28 Sep 2002 18:13:45 +0300 (IDT)
From: Tzafrir Cohen <tzafrir@technion.ac.il>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.4.20-pre5: occasional lock-ups
Message-ID: <Pine.GSO.4.44_heb2.09.0209280507200.11594-100000@techunix.technion.ac.il>
X-Echelon: bomb Arafat Intifada bus kach drugs mafia boss heroin spy Semtex
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-8-i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.20-pre5: occasional lock-ups

The relevant system recently is generally "unstable": and locks up about
once a week.

The system is Mandrake 8.1. It originally had kernel 2.4.18-6mdk (from
mandrake 8.2). After some unexplained incidents I decided to move to
2.4.20-pre5 .

In the mandrake kernel I got no oops messages in my logs. I did get one
occasion where the system hanged due to memory allocation problems, e.g:

  kernel: ENOMEM in journal_start_R6facca98, retrying.

(which kept appearing)

What follows refers to the 2.4.20-pre5 kernel:
I am not sure exactly how to reproduce the bug. running 'memtest' seems to
help creating instabilities, but I think it takes some extra load.

The system generally becomes unstable: segfaulting many processes. After I
pressed 'alt-sysrq-M' (show memory) on one occasion it hanged the system
hard.

It seems that running two 'memtest' instances' at the same time hangs the
system immidiately and freezes all the processes: only a alt-sysreq reboot
helps. memtester-2.93.1-3mdk from mandrake 8.1 . Is this expected? This
was the only easily-reproducable way I could find to hang the system, but
it did not produce any oops report, so I'm not sure it is exactly the same
problem.

I tried testing the system with memtest86 (version memtest86-2.7-1mdk). in
some 3 hours of testing I once got a series of errors in test #5, but
could not reproduce it. Any indication of what can I make from that?

(memtester has not yet found any error. It seems it only managed to lock
128MB of memory for its tests)

Does this look like a hardware issue? Any indication of what hardware it
may be?

Please CC me any replies.


Rest of the details follow:


Kernel Version:
Linux version 2.4.20-pre5 (root@yarden.gadot.org.il) (gcc version 2.96
20000731 (Mandrake Linux 8.1 2.96-0.63.1mdk)) #1 Mon Sep 9 01:50:30 IDT
2002

Memory: 256MB ram, 256MB swap.


Sample errors:

Both of those are were the first oopses, and seem to got the system into
an unstablestate. Though processes only stated bailing out a couple of
hours later in each case:

Sep 27 02:25:12 yarden kernel: kernel BUG at page_alloc.c:231!
Sep 27 02:25:12 yarden kernel: invalid operand: 0000
Sep 27 02:25:12 yarden kernel: CPU:    0
Sep 27 02:25:12 yarden kernel: EIP:    0010:[rmqueue+507/576]    Not tainted
Sep 27 02:25:12 yarden kernel: EIP:    0010:[<c012e81b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Sep 27 02:25:12 yarden kernel: EFLAGS: 00010202
Sep 27 02:25:12 yarden kernel: eax: 00000040   ebx: c1221190   ecx: 00001000   edx: 0000c637
Sep 27 02:25:12 yarden kernel: esi: c0239470   edi: 0000ef00   ebp: c100001c   esp: cbb75ec0
Sep 27 02:25:12 yarden kernel: ds: 0018   es: 0018   ss: 0018
Sep 27 02:25:12 yarden kernel: Process gzip (pid: 22541, stackpage=cbb75000)
Sep 27 02:25:12 yarden kernel: Stack: 00001000 0000b637 00000286 00000000 c0239470 c02395f4 000001ff 00000000
Sep 27 02:25:12 yarden kernel:        00000000 c012ea90 c0239470 c02395f0 000001d2 00000008 00000000 cfe77dbc
Sep 27 02:25:12 yarden kernel:        00000008 00000000 c012a286 cbb75f34 c681c000 00000000 00001000 fffffff4
Sep 27 02:25:12 yarden kernel: Call Trace:    [__alloc_pages+64/368] [generic_file_write+1062/1824] [update_process_times+32/144] [process_timeout+0/80] [af_packet:__insmod_af_packet_O/lib/modules/2.4.20-pre5/kernel/net/pac+-83454/96]
Sep 27 02:25:12 yarden kernel: Call Trace:    [<c012ea90>] [<c012a286>] [<c011f0c0>] [<c0115080>] [<d0834a02>]
Sep 27 02:25:12 yarden kernel:   [<c01345f6>] [<c010893b>]
Sep 27 02:25:12 yarden kernel: Code: 0f 0b e7 00 7c df 20 c0 8b 43 18 a9 80 00 00 00 74 08 0f 0b

>>EIP; c012e81b <rmqueue+1fb/240>   <=====
Trace; c012ea90 <__alloc_pages+40/170>
Trace; c012a286 <generic_file_write+426/720>
Trace; c011f0c0 <update_process_times+20/90>
Trace; c0115080 <process_timeout+0/50>
Trace; d0834a02 <[ext3]ext3_file_write+22/b0>
Trace; c01345f6 <sys_write+96/f0>
Trace; c010893b <system_call+33/38>
Code;  c012e81b <rmqueue+1fb/240>
00000000 <_EIP>:
Code;  c012e81b <rmqueue+1fb/240>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012e81d <rmqueue+1fd/240>
   2:   e7 00                     out    %eax,$0x0
Code;  c012e81f <rmqueue+1ff/240>
   4:   7c df                     jl     ffffffe5 <_EIP+0xffffffe5> c012e800 <rmqueue+1e0/240>
Code;  c012e821 <rmqueue+201/240>
   6:   20 c0                     and    %al,%al
Code;  c012e823 <rmqueue+203/240>
   8:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c012e826 <rmqueue+206/240>
   b:   a9 80 00 00 00            test   $0x80,%eax
Code;  c012e82b <rmqueue+20b/240>
  10:   74 08                     je     1a <_EIP+0x1a> c012e835 <rmqueue+215/240>
Code;  c012e82d <rmqueue+20d/240>
  12:   0f 0b                     ud2a

Sep 27 22:16:47 yarden kernel: kernel BUG at page_alloc.c:102!
Sep 27 22:16:47 yarden kernel: invalid operand: 0000
Sep 27 22:16:47 yarden kernel: CPU:    0
Sep 27 22:16:47 yarden kernel: EIP:    0010:[__free_pages_ok+73/656]    Not tainted
Sep 27 22:16:47 yarden kernel: EIP:    0010:[<c012e3d9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Sep 27 22:16:47 yarden kernel: EFLAGS: 00010286
Sep 27 22:16:47 yarden kernel: eax: c1000c40   ebx: c11cf018   ecx: c9cd27e4   edx: c02392d8
Sep 27 22:16:47 yarden kernel: esi: 00000000   edi: 00000000   ebp: 00000000   esp: cfea7f04
Sep 27 22:16:47 yarden kernel: ds: 0018   es: 0018   ss: 0018
Sep 27 22:16:47 yarden kernel: Process kswapd (pid: 5, stackpage=cfea7000)
Sep 27 22:16:47 yarden kernel: Stack: c0138128 cfe8b960 c11cf018 000001d0 c013651f 000001d0 c11cf018 000001d0
Sep 27 22:16:47 yarden kernel:        c11cf018 00000001 000009ea c012dc9e 00000202 cfea6000 000000fd 000001d0
Sep 27 22:16:47 yarden kernel:        c0239470 c12c30c0 c4b416c0 c12c3564 00000002 00000020 000001d0 00000006
Sep 27 22:16:47 yarden kernel: Call Trace:    [try_to_free_buffers+152/240] [try_to_release_page+47/80] [shrink_cache+558/768] [shrink_caches+82/144] [try_to_free_pages+60/96]
Sep 27 22:16:47 yarden kernel: Call Trace:    [<c0138128>] [<c013651f>] [<c012dc9e>] [<c012deb2>] [<c012df2c>]
Sep 27 22:16:47 yarden kernel:   [<c012dfd1>] [<c012e046>] [<c012e181>] [<c012e0e0>] [<c0105000>] [<c0107186>]
Sep 27 22:16:47 yarden kernel:   [<c012e0e0>]
Sep 27 22:16:47 yarden kernel: Code: 0f 0b 66 00 7c df 20 c0 8b 15 f0 45 29 c0 89 d8 29 d0 69 c0

>>EIP; c012e3d9 <__free_pages_ok+49/290>   <=====
Trace; c0138128 <try_to_free_buffers+98/f0>
Trace; c013651f <try_to_release_page+2f/50>
Trace; c012dc9e <shrink_cache+22e/300>
Trace; c012deb2 <shrink_caches+52/90>
Trace; c012df2c <try_to_free_pages+3c/60>
Trace; c012dfd1 <kswapd_balance_pgdat+51/a0>
Trace; c012e046 <kswapd_balance+26/40>
Trace; c012e181 <kswapd+a1/c0>
Trace; c012e0e0 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0107186 <kernel_thread+26/30>
Trace; c012e0e0 <kswapd+0/c0>
Code;  c012e3d9 <__free_pages_ok+49/290>
00000000 <_EIP>:
Code;  c012e3d9 <__free_pages_ok+49/290>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012e3db <__free_pages_ok+4b/290>
   2:   66                        data16
Code;  c012e3dc <__free_pages_ok+4c/290>
   3:   00 7c df 20               add    %bh,0x20(%edi,%ebx,8)
Code;  c012e3e0 <__free_pages_ok+50/290>
   7:   c0 8b 15 f0 45 29 c0      rorb   $0xc0,0x2945f015(%ebx)
Code;  c012e3e7 <__free_pages_ok+57/290>
   e:   89 d8                     mov    %ebx,%eax
Code;  c012e3e9 <__free_pages_ok+59/290>
  10:   29 d0                     sub    %edx,%eax
Code;  c012e3eb <__free_pages_ok+5b/290>
  12:   69 c0 00 00 00 00         imul   $0x0,%eax,%eax


Software:

Linux yarden.gadot.org.il 2.4.20-pre5 #1 ב' ספט 9 01:50:30 IDT 2002 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11h
mount                  2.11h
modutils               2.4.11
e2fsprogs              1.24a
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         af_packet ne2k-pci 8390 ext3 jbd rtc

CPU:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 6
model name	: Celeron (Mendocino)
stepping	: 5
cpu MHz		: 467.739
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 933.88


PCI Bus:
00:00.0 Host bridge: Intel Corporation 82810-DC100 GMCH [Graphics Memory Controller Hub] (rev 03)
	Subsystem: Intel Corporation 82810-DC100 GMCH [Graphics Memory Controller Hub]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0

00:01.0 VGA compatible controller: Intel Corporation 82810-DC100 CGC [Chipset Graphics Controller] (rev 03) (prog-if 00 [VGA])
	Subsystem: Intel Corporation 82810-DC100 CGC [Chipset Graphics Controller]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at dc000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corporation 82801AA PCI Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fff00000-000fffff
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
	Region 4: I/O ports at f000 [size=16]

00:1f.2 USB Controller: Intel Corporation 82801AA USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation 82801AA USB
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 12
	Region 4: I/O ports at d000 [size=32]

01:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at c000 [size=32]


(No SCSI)



-- 
Tzafrir Cohen
mailto:tzafrir@technion.ac.il
http://www.technion.ac.il/~tzafrir






