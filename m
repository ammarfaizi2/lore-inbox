Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315628AbSGANeM>; Mon, 1 Jul 2002 09:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315630AbSGANeL>; Mon, 1 Jul 2002 09:34:11 -0400
Received: from cibs9.sns.it ([192.167.206.29]:781 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S315628AbSGANds>;
	Mon, 1 Jul 2002 09:33:48 -0400
Date: Mon, 1 Jul 2002 15:36:03 +0200 (CEST)
From: venom@sns.it
To: Ken Witherow <ken@krwtech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Tyan 2460/Dual Athlon MP hangs
In-Reply-To: <Pine.LNX.4.44.0206301441230.340-200000@death>
Message-ID: <Pine.LNX.4.43.0207011533050.24435-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had similar behaviour because of excessive heat on a DUAL Athlon
2000MP+, same MB; the case had a bad air flow.

This is easy to check, just try with the case open and see if the oops are
repeatable.

Luigi

On Sun, 30 Jun 2002, Ken Witherow wrote:

> Date: Sun, 30 Jun 2002 14:55:18 -0400 (EDT)
> From: Ken Witherow <phantoml@rochester.rr.com>
> Reply-To: Ken Witherow <ken@krwtech.com>
> To: linux-kernel@vger.kernel.org
> Subject: Tyan 2460/Dual Athlon MP hangs
>
> [1.] One line summary of the problem:
> Random hangs occur on dual athlon system
>
> [2.] Full description of the problem/report:
> Sometimes the system hangs during boot, sometimes at the console and
> other times while I'm in X. Happens whether or not I use the mem=nopentium
> and noapic options. Frequently, I can't catch the OOPS because I'm in X
> and everything freezes.
>
> [3.] Keywords (i.e., modules, networking, kernel):
> [4.] Kernel version (from /proc/version):
> Linux version 2.4.19-rc1 (ken@death.krwtech.com) (gcc version 3.1) #18 SMP
> Sat Jun 29 13:50:03 EDT 2002
>
> [5.] Output of Oops.. message (if applicable) with symbolic information
>      resolved (see Documentation/oops-tracing.txt)
> here are the two most recent OOPS I've caught. The first was when the
> system was recovering ext3 journals and the second after about 45 minutes
> of normal system use. Happens regardless of NVidia's driver being loaded
>
> invalid operand: 0000
> CPU: 1
> EIP: 0010:[<c033abf0>]  Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010286
> eax: c033abe4 ebx: 0000002d ecx: c033abf0 edx: c003abf0
> esi: c1597ec4 edi: 00000040 ebp: 00000001 esp: c1597ebc
> ds: 0018 es: 0018 ss: 0018
> stack: c0123741 c033abf0 c0339420 c0339520 00000001 c03d0d40 c012731f
> c0339520
>        c0123664 c03d0d54 c0123503 00000001 00000001 c03a9240 fffffffe
> 00000001
>        c01232ce c03a9240 00000046 c03a2800 00000000 c0337650 00000000
> c010acec
> Call Trace: [<c0123741>] [<c012731f>] [<c0123664>] [<c0123503>]
> [<c01232ce>]
>             [<c010acec>] [<c010d318>] [<c01c1940>] [<c01c17e0>]
> [<c0106ec2>] [c011e04b>]
>             [<c011e2b7>]
> Code: f0 ab c0 f0 ab 33 c0 01 00 00 00 d8 c8 59 c1 d8 cc 59 c1
>
>
> >>EIP; c033abf0 <blocked_list+0/8>   <=====
>
> >>eax; c033abe4 <lease_break_time+0/4>
> >>ecx; c033abf0 <blocked_list+0/8>
> >>edx; c003abf0 Before first symbol
> >>esi; c1597ec4 <_end+1189610/2047274c>
> >>esp; c1597ebc <_end+1189608/2047274c>
>
> Trace; c0123741 <__run_task_queue+61/70>
> Trace; c012731f <tqueue_bh+1f/30>
> Trace; c0123664 <bh_action+54/80>
> Trace; c0123503 <tasklet_hi_action+63/a0>
> Trace; c01232ce <do_softirq+ce/d0>
> Trace; c010acec <do_IRQ+dc/e0>
> Trace; c010d318 <call_do_IRQ+5/d>
> Trace; c01c1940 <pr_power_idle+160/310>
> Trace; c01c17e0 <pr_power_idle+0/310>
> Trace; c0106ec2 <cpu_idle+42/60>
> Trace; c011e2b7 <printk+137/180>
>
> Code;  c033abf0 <blocked_list+0/8>
> 00000000 <_EIP>:
> Code;  c033abf0 <blocked_list+0/8>   <=====
>    0:   f0 ab                     lock stos %eax,%es:(%edi)   <=====
> Code;  c033abf2 <blocked_list+2/8>
>    2:   c0                        (bad)
> Code;  c033abf3 <blocked_list+3/8>
>    3:   f0 ab                     lock stos %eax,%es:(%edi)
> Code;  c033abf5 <blocked_list+5/8>
>    5:   33 c0                     xor    %eax,%eax
> Code;  c033abf7 <blocked_list+7/8>
>    7:   01 00                     add    %eax,(%eax)
> Code;  c033abf9 <__compound_literal.0+1/4>
>    9:   00 00                     add    %al,(%eax)
> Code;  c033abfb <__compound_literal.0+3/4>
>    b:   d8 c8                     fmul   %st(0),%st
> Code;  c033abfd <dentry_unused+1/8>
>    d:   59                        pop    %ecx
> Code;  c033abfe <dentry_unused+2/8>
>    e:   c1 d8 cc                  rcr    $0xcc,%eax
> Code;  c033ac01 <dentry_unused+5/8>
>   11:   59                        pop    %ecx
> Code;  c033ac02 <dentry_unused+6/8>
>   12:   c1 00 00                  roll   $0x0,(%eax)
>
>
> kernel BUG in header file at line 51
> kernel BUG at panic.c: 141!
> invalid operand: 0000
> CPU: 1
> EIP: 0010:[<c011dab7>]  Tainted: P
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010282
> eax: 00000025 ebx: 00000001 ecx: 00000086 edx: dfb0df7c
> esi: d451d980 edi: c1596000 ebp: c1597f6c esp: c1597f48
> ds: 0018 es: 0018 ss: 0018
> Process swapper (pid: 0, stackpage=c1597000)
> Stack: c02df320 00000033 c011b9bc 00000033 00000000 00000018 dadc8000
> d4519800
>        c1596000 c1597fac c011a520 d451d980 d451d980 dadc8000 00000001
> dadc803c
>        dadc8000 d451d980 00000002 00000026 00000001 c03a7a40 c01c17e0
> c1596000
> Call Trace: [<c011b9bc>] [<c011a520>] [<c01c17e0>] [<c0106ece>]
> [<c011e04b>]
>             [<c011e2b7>]
> Code: 0f 0b 8d 00 61 00 2e c0 90 eb fe 90 90 90 90 90 90 90 90 90
>
>
> >>EIP; c011dab7 <__out_of_line_bug+17/60>   <=====
>
> >>edx; dfb0df7c <_end+1f6ff6c8/2047274c>
> >>esi; d451d980 <_end+1410f0cc/2047274c>
> >>edi; c1596000 <_end+118774c/2047274c>
> >>ebp; c1597f6c <_end+11896b8/2047274c>
> >>esp; c1597f48 <_end+1189694/2047274c>
>
> Trace; c011b9bc <switch_mm+12c/130>
> Trace; c011a520 <schedule+1f0/3e0>
> Trace; c01c17e0 <pr_power_idle+0/310>
> Trace; c0106ece <cpu_idle+4e/60>
> Trace; c011e04b <call_console_drivers+5b/120>
> Trace; c011e2b7 <printk+137/180>
>
> Code;  c011dab7 <__out_of_line_bug+17/60>
> 00000000 <_EIP>:
> Code;  c011dab7 <__out_of_line_bug+17/60>   <=====
>    0:   0f 0b                     ud2a      <=====
> Code;  c011dab9 <__out_of_line_bug+19/60>
>    2:   8d 00                     lea    (%eax),%eax
> Code;  c011dabb <__out_of_line_bug+1b/60>
>    4:   61                        popa
> Code;  c011dabc <__out_of_line_bug+1c/60>
>    5:   00 2e                     add    %ch,(%esi)
> Code;  c011dabe <__out_of_line_bug+1e/60>
>    7:   c0 90 eb fe 90 90 90      rclb   $0x90,0x9090feeb(%eax)
> Code;  c011dac5 <__out_of_line_bug+25/60>
>    e:   90                        nop
> Code;  c011dac6 <__out_of_line_bug+26/60>
>    f:   90                        nop
> Code;  c011dac7 <__out_of_line_bug+27/60>
>   10:   90                        nop
> Code;  c011dac8 <__out_of_line_bug+28/60>
>   11:   90                        nop
> Code;  c011dac9 <__out_of_line_bug+29/60>
>   12:   90                        nop
> Code;  c011daca <__out_of_line_bug+2a/60>
>   13:   90                        nop
>
>
> [6.] A small shell script or example program which triggers the
>      problem (if possible)
> [7.] Environment
> [7.1.] Software (add the output of the ver_linux script here)
> Linux death.krwtech.com 2.4.19-rc1 #18 SMP Sat Jun 29 13:50:03 EDT 2002
> i686 unknown
>
> Gnu C                  gcc (GCC) 3.1 Copyright (C) 2002 Free Software
> Foundation, Inc. This is free software; see the source for copying
> conditions. There is NO warranty; not even for MERCHANTABILITY or FITNESS
> FOR A PARTICULAR PURPOSE.
> Gnu make               3.79
> util-linux             2.11r
> mount                  2.11r
> modutils               2.4.16
> e2fsprogs              1.22
> Linux C Library        2.2.5
> Dynamic linker (ldd)   2.2.5
> Linux C++ Library      4.0.0
> Procps                 2.0.7
> Net-tools              1.60
> Kbd                    1.06
> Sh-utils               2.0
> Modules Loaded         NVdriver w83781d i2c-amd756
>
> [7.2.] Processor information (from /proc/cpuinfo):
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 6
> model name      : AMD Athlon(tm) MP 1800+
> stepping        : 2
> cpu MHz         : 1533.393
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
> bogomips        : 3060.53
>
> processor       : 1
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 6
> model name      : AMD Athlon(tm) Processor
> stepping        : 2
> cpu MHz         : 1533.393
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
> bogomips        : 3060.53
>
> [7.3.] Module information (from /proc/modules):
> NVdriver              989408  10 (autoclean)
> w83781d                19392   0
> i2c-amd756              3236   0 (unused)
>
> [7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
> /proc/ioports
> 0000-001f : dma1
> 0020-003f : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0070-007f : rtc
> 0080-008f : dma page reg
> 00a0-00bf : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 02f8-02ff : serial(auto)
> 0378-037a : parport0
> 037b-037f : parport0
> 03c0-03df : vga+
> 03f8-03ff : serial(auto)
> 0cf8-0cff : PCI conf1
> 1000-10ff : D-Link System Inc RTL8139 Ethernet
>   1000-10ff : 8139too
> 1400-143f : Advanced System Products, Inc ABP940-U / ABP960-U
>   1400-140f : advansys
> 1440-145f : Creative Labs SB Live! EMU10k1
>   1440-145f : EMU10K1
> 1470-1473 : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System
> Controller
> 1478-147f : Creative Labs SB Live! MIDI/Game Port
>   1478-147f : emu10k1-gp
> 80e0-80ef : amd756-smbus
> f000-f00f : Advanced Micro Devices [AMD] AMD-766 [ViperPlus] IDE
>   f000-f007 : ide0
>   f008-f00f : ide1
>
> /proc/iomem
> 00000000-0009f3ff : System RAM
> 0009f400-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000cb800-000ce7ff : Extension ROM
> 000dc000-000dcfff : Advanced Micro Devices [AMD] AMD-766 [ViperPlus] USB
> 000e0000-000effff : Extension ROM
> 000f0000-000fffff : System ROM
> 00100000-1ffeffff : System RAM
>   00100000-002cd878 : Kernel code
>   002cd879-00359dbf : Kernel data
> 1fff0000-1ffffbff : ACPI Tables
> 1ffffc00-1fffffff : ACPI Non-volatile Storage
> e8001000-e80010ff : D-Link System Inc RTL8139 Ethernet
>   e8001000-e80010ff : 8139too
> e8002000-e8002fff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P]
> System Controller
> e9000000-e9ffffff : PCI Bus #01
>   e9000000-e9ffffff : nVidia Corporation NV11 (GeForce2 MX)
> ec000000-efffffff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P]
> System Controller
> f0000000-f7ffffff : PCI Bus #01
>   f0000000-f7ffffff : nVidia Corporation NV11 (GeForce2 MX)
> fec00000-fec0ffff : reserved
> fee00000-fee00fff : reserved
> fff80000-ffffffff : reserved
>
>
> [7.5.] PCI information ('lspci -vvv' as root)
> PCI devices found:
>   Bus  0, device   0, function  0:
>     Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System
> Controller (rev 17).
>       Master Capable.  Latency=64.
>       Prefetchable 32 bit memory at 0xec000000 [0xefffffff].
>       Prefetchable 32 bit memory at 0xe8002000 [0xe8002fff].
>       I/O at 0x1470 [0x1473].
>   Bus  0, device   1, function  0:
>     PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP
> Bridge (rev 0).
>       Master Capable.  Latency=99.  Min Gnt=12.
>   Bus  0, device   7, function  0:
>     ISA bridge: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] ISA (rev
> 2).
>   Bus  0, device   7, function  1:
>     IDE interface: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] IDE
> (rev 1).
>       Master Capable.  Latency=64.
>       I/O at 0xf000 [0xf00f].
>   Bus  0, device   7, function  3:
>     Bridge: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] ACPI (rev 1).
>       Master Capable.  Latency=64.
>   Bus  0, device   7, function  4:
>     USB Controller: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] USB
> (rev 7).
>       IRQ 19.
>       Master Capable.  Latency=16.  Max Lat=80.
>       Non-prefetchable 32 bit memory at 0xdc000 [0xdcfff].
>   Bus  0, device  10, function  0:
>     SCSI storage controller: Advanced System Products, Inc ABP940-U /
> ABP960-U (rev 2).
>       IRQ 18.
>       Master Capable.  Latency=64.  Min Gnt=4.Max Lat=4.
>       I/O at 0x1400 [0x143f].
>   Bus  0, device  11, function  0:
>     Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 10).
>       IRQ 19.
>       Master Capable.  Latency=64.  Min Gnt=2.Max Lat=20.
>       I/O at 0x1440 [0x145f].
>   Bus  0, device  11, function  1:
>     Input device controller: Creative Labs SB Live! MIDI/Game Port (rev
> 10).
>       Master Capable.  Latency=64.
>       I/O at 0x1478 [0x147f].
>   Bus  0, device  13, function  0:
>     Ethernet controller: D-Link System Inc RTL8139 Ethernet (rev 16).
>       IRQ 17.
>       Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
>       I/O at 0x1000 [0x10ff].
>       Non-prefetchable 32 bit memory at 0xe8001000 [0xe80010ff].
>   Bus  1, device   5, function  0:
>     VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX) (rev
> 178).
>       IRQ 18.
>       Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
>       Non-prefetchable 32 bit memory at 0xe9000000 [0xe9ffffff].
>       Prefetchable 32 bit memory at 0xf0000000 [0xf7ffffff].
>
> [7.6.] SCSI information (from /proc/scsi/scsi)
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: IBM      Model: DNES-309170      Rev: SAH0
>   Type:   Direct-Access                    ANSI SCSI revision: 03
> Host: scsi0 Channel: 00 Id: 01 Lun: 00
>   Vendor: WDIGTL   Model: WD183 ULTRA2     Rev: 1.00
>   Type:   Direct-Access                    ANSI SCSI revision: 02
> Host: scsi0 Channel: 00 Id: 02 Lun: 00
>   Vendor: MATSHITA Model: CD-R   CW-7502   Rev: 4.05
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> Host: scsi0 Channel: 00 Id: 05 Lun: 00
>   Vendor: SEAGATE  Model: SX410800N        Rev: 7117
>   Type:   Direct-Access                    ANSI SCSI revision: 02
> Host: scsi0 Channel: 00 Id: 06 Lun: 00
>   Vendor: CyberDrv Model:  CD-ROM TW240S   Rev: 1.20
>   Type:   CD-ROM                           ANSI SCSI revision: 02
>
>
> [7.7.] Other information that might be relevant to the problem
>        (please look in /proc and include all information that you
>        think to be relevant):
> [ken@death linux]$ cat /proc/interrupts
>            CPU0       CPU1
>   0:      88598      86200    IO-APIC-edge  timer
>   1:       2798       2740    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   8:          0          0    IO-APIC-edge  rtc
>   9:          0          0    IO-APIC-edge  acpi
>  12:      26342      29117    IO-APIC-edge  PS/2 Mouse
>  17:        815        831   IO-APIC-level  eth0
>  18:      58428      64043   IO-APIC-level  advansys, nvidia
>  19:       1235       1182   IO-APIC-level  EMU10K1
> NMI:          0          0
> LOC:     174708     174662
> ERR:          0
> MIS:          0
>
>
> [X.] Other notes, patches, fixes, workarounds:
> .config attached
>
> --
>  Ken Witherow <phantoml AT rochester.rr.com> ICQ: 21840670
>          KRW Technologies http://www.krwtech.com
>     Linux 2.4.18 - because I'd like to get there today
> to remain free, we must remain free of intrusive government
>
>
>

