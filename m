Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266528AbSKUKvy>; Thu, 21 Nov 2002 05:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266535AbSKUKvy>; Thu, 21 Nov 2002 05:51:54 -0500
Received: from flem.vwe.net ([194.72.80.151]:44294 "EHLO flem.vwe.net")
	by vger.kernel.org with ESMTP id <S266528AbSKUKvu>;
	Thu, 21 Nov 2002 05:51:50 -0500
Message-Id: <5.1.0.14.2.20021121095146.00b0ffd0@secure.vwe.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 21 Nov 2002 10:46:17 +0000
To: linux-kernel@vger.kernel.org
From: Mark Bryant <mark@vwe.org>
Subject: random kswapd crashes
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] One line summary of the problem:

random kswapd crashes

[2.] Full description of the problem/report:

kswapd crashes at random times without needing to do anything at all. Only 
rebooting the machine "fixes" it as I find no other mechanism for 
"resarting" kswapd after a crash. The kernel doesn't go into a panic, it 
simply hangs the machine a short while later.

[3.] Keywords (i.e., modules, networking, kernel):

kernel - kswapd

[4.] Kernel version (from /proc/version):

Linux version 2.4.19.vwe.net (root@udder.vwe.net) (gcc version 2.96 
20000731 (Red Hat Linux 7.3 2.96-112)) #4 Sun Nov 3 16:26:15 UTC 2002

[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)

ksymoops 2.4.4 on i686 2.4.19.vwe.net.  Options used
      -V (specified)
      -k /proc/ksyms (specified)
      -l /proc/modules (specified)
      -o /lib/modules/2.4.19.vwe.net/ (specified)
      -m /boot/System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
  Unable to handle kernel NULL pointer dereference at virtual address 00000019
  c0159b0e
  *pde = 00000000
  Oops: 0000
  CPU:    0
  EIP:    0010:[<c0159b0e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
  EFLAGS: 00010207
  eax: 00000001   ebx: 00000000   ecx: c60ccf70   edx: 00000000
  esi: c60ccf70   edi: 00000001   ebp: 00001006   esp: c12d5ef4
  ds: 0018   es: 0018   ss: 0018
  Process kswapd (pid: 4, stackpage=c12d5000)
  Stack: 00000000 c1187978 000001d0 0000001d c0151840 c13ec200 c1187978 
000001d0
         c01311af c1187978 000001d0 00000000 c1187978 c0129c10 c1187978 
000001d0
         00000202 c12d4000 0000019a 000001d0 c02163f4 c12170b0 c5d0b240 
c1217890
  Call Trace:    [<c0151840>] [<c01311af>] [<c0129c10>] [<c0129e32>] 
[<c0129e94>]
    [<c0129f25>] [<c0129f82>] [<c012a08d>] [<c0129ffc>] [<c0105000>] 
[<c0106d72>]
    [<c0129ffc>]
  Code: f6 42 19 02 8b 5b 28 74 15 89 e0 50 52 e8 08 ff ff ff 5a 31

 >>EIP; c0159b0e <journal_try_to_free_buffers+4e/90>   <=====
Trace; c0151840 <ext3_releasepage+20/24>
Trace; c01311af <try_to_release_page+2f/48>
Trace; c0129c10 <shrink_cache+1f4/2f0>
Trace; c0129e32 <shrink_caches+4e/80>
Trace; c0129e94 <try_to_free_pages+30/4c>
Trace; c0129f25 <kswapd_balance_pgdat+49/94>
Trace; c0129f82 <kswapd_balance+12/28>
Trace; c012a08d <kswapd+91/ac>
Trace; c0129ffc <kswapd+0/ac>
Trace; c0105000 <_stext+0/0>
Trace; c0106d72 <kernel_thread+26/30>
Trace; c0129ffc <kswapd+0/ac>
Code;  c0159b0e <journal_try_to_free_buffers+4e/90>
00000000 <_EIP>:
Code;  c0159b0e <journal_try_to_free_buffers+4e/90>   <=====
    0:   f6 42 19 02               testb  $0x2,0x19(%edx)   <=====
Code;  c0159b12 <journal_try_to_free_buffers+52/90>
    4:   8b 5b 28                  mov    0x28(%ebx),%ebx
Code;  c0159b15 <journal_try_to_free_buffers+55/90>
    7:   74 15                     je     1e <_EIP+0x1e> c0159b2c 
<journal_try_to_free_buffers+6c/90>
Code;  c0159b17 <journal_try_to_free_buffers+57/90>
    9:   89 e0                     mov    %esp,%eax
Code;  c0159b19 <journal_try_to_free_buffers+59/90>
    b:   50                        push   %eax
Code;  c0159b1a <journal_try_to_free_buffers+5a/90>
    c:   52                        push   %edx
Code;  c0159b1b <journal_try_to_free_buffers+5b/90>
    d:   e8 08 ff ff ff            call   ffffff1a <_EIP+0xffffff1a> 
c0159a28 <__journal_try_to_free_buffer+0/98>
Code;  c0159b20 <journal_try_to_free_buffers+60/90>
   12:   5a                        pop    %edx
Code;  c0159b21 <journal_try_to_free_buffers+61/90>
   13:   31 00                     xor    %eax,(%eax)

[6.] A small shell script or example program which triggers the
      problem (if possible)

sorry there's none available as I don't know how to reproduce the problem 
and there seems to be no pattern to when it happens.

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

Linux udder.vwe.net 2.4.19.vwe.net #4 Sun Nov 3 16:26:15 UTC 2002 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.14
e2fsprogs              1.27
pcmcia-cs              3.0.9
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : CyrixInstead
cpu family      : 6
model           : 2
model name      : M II 3.5x Core/Bus Clock
stepping        : 8
cpu MHz         : 233.871
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de tsc msr cx8 pge cmov mmx cyrix_arr
bogomips        : 466.94

[7.3.] Module information (from /proc/modules):

no kernel modules loaded as I compile in only what I need.

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

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
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
5000-50ff : VIA Technologies, Inc. VT82C586B ACPI
d000-dfff : PCI Bus #01
e000-e00f : VIA Technologies, Inc. Bus Master IDE
   e000-e007 : ide0
   e008-e00f : ide1
e800-e87f : VIA Technologies, Inc. VT3043 [Rhine]
   e800-e87f : via-rhine


00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0bffffff : System RAM
   00100000-001e5065 : Kernel code
   001e5066-0022155f : Kernel data
e0000000-e3ffffff : VIA Technologies, Inc. VT82C597 [Apollo VP3]
e5000000-e5ffffff : Matrox Graphics, Inc. MGA 2164W [Millennium II]
e6000000-e6003fff : Matrox Graphics, Inc. MGA 2164W [Millennium II]
e7000000-e77fffff : Matrox Graphics, Inc. MGA 2164W [Millennium II]
e9000000-e900007f : VIA Technologies, Inc. VT3043 [Rhine]
   e9000000-e900007f : via-rhine
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
         Latency: 16
         Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [a0] AGP version 1.0
                 Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo 
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: fff00000-000fffff
         Prefetchable memory behind bridge: fff00000-000fffff
         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo 
VP] (rev 41)
         Subsystem: VIA Technologies, Inc. MVP3 ISA Bridge
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Region 4: I/O ports at e000 [size=16]

00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:0a.0 Ethernet controller: VIA Technologies, Inc. VT3043 [Rhine] (rev 06)
         Subsystem: D-Link System Inc DFE-530TX rev A
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (29500ns min, 38000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at e800 [size=128]
         Region 1: Memory at e9000000 (32-bit, non-prefetchable) [size=128]
         Expansion ROM at e4000000 [disabled] [size=64K]

00:0b.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W 
[Millennium II] (prog-if 00 [VGA])
         Subsystem: Matrox Graphics, Inc.: Unknown device 0100
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at e5000000 (32-bit, prefetchable) [size=16M]
         Region 1: Memory at e6000000 (32-bit, non-prefetchable) [size=16K]
         Region 2: Memory at e7000000 (32-bit, non-prefetchable) [size=8M]
         Expansion ROM at e8000000 [disabled] [size=64K]

[7.6.] SCSI information (from /proc/scsi/scsi)

no scsi devices

[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):

couldn't think of anything else that you might need, am happy to supply 
anything you request though :o)

[X.] Other notes, patches, fixes, workarounds:

only a reboot solves this


