Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTDLHCD (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 03:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263180AbTDLHCD (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 03:02:03 -0400
Received: from asooo.irridia.com ([63.254.226.249]:35723 "EHLO irridia.com")
	by vger.kernel.org with ESMTP id S263179AbTDLHB7 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 03:01:59 -0400
Date: Sat, 12 Apr 2003 02:13:44 -0500
From: Ken Brownfield <brownfld@irridia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Oops: ptrace fix buggy
Message-ID: <20030412021344.A8047@asooo.flowerfire.com>
References: <200304071222.OAA06275@boskoop.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304071222.OAA06275@boskoop.iwr.uni-heidelberg.de>; from Michael.Lampe@iwr.uni-heidelberg.de on Mon, Apr 07, 2003 at 02:22:05PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm reproducing this as well when using gdb.  Two oopses attached.

This is with the ptrace patch applied to 2.4.20 (SMP/i386/P3).

Thanks,
--
Ken.
brownfld@irridia.com


Code: f6 40 7c 01 75 07 b8 ff ff ff ff c3 90 f6 42 18 01 74 1d b8
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f6 40 7c 01               testb  $0x1,0x7c(%eax)
Code;  00000004 Before first symbol
   4:   75 07                     jne    d <_EIP+0xd> 0000000d Before
first symbol
Code;  00000006 Before first symbol
   6:   b8 ff ff ff ff            mov    $0xffffffff,%eax
Code;  0000000b Before first symbol
   b:   c3                        ret
Code;  0000000c Before first symbol
   c:   90                        nop
Code;  0000000d Before first symbol
   d:   f6 42 18 01               testb  $0x1,0x18(%edx)
Code;  00000011 Before first symbol
  11:   74 1d                     je     30 <_EIP+0x30> 00000030 Before
first symbol
Code;  00000013 Before first symbol
  13:   b8 00 00 00 00            mov    $0x0,%eax

Unable to handle kernel NULL pointer dereference at virtual address
0000007c
c01211a3
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c01211a3>]    Not tainted
EFLAGS: 00010202
eax: 00000000   ebx: ffffffff   ecx: e75a0000   edx: d2746000
esi: 00000000   edi: d2746000   ebp: 40036110   esp: e75a1f8c
ds: 0018   es: 0018   ss: 0018
Process gdb (pid: 28490, stackpage=e75a1000)
Stack: c010c576 d2746000 00000000 e75a0000 00000000 00000005 bffff17c
00000004
       bfffeed8 e75a0000 00000000 e75a0000 e75a1fc4 c0108b97 00000005
0000469b
       40036110 00000000 00000005 bffff17c 0000001a 0000002b 0000002b
0000001a
Call Trace:    [<c010c576>] [<c0108b97>]
Code: f6 40 7c 01 75 07 b8 ff ff ff ff c3 90 f6 42 18 01 74 1d b8

>>EIP; c01211a3 <ptrace_check_attach+13/84>   <=====
Trace; c010c576 <sys_ptrace+10a/608>
Trace; c0108b97 <system_call+2f/34>
Code;  c01211a3 <ptrace_check_attach+13/84>
00000000 <_EIP>:
Code;  c01211a3 <ptrace_check_attach+13/84>   <=====
   0:   f6 40 7c 01               testb  $0x1,0x7c(%eax)   <=====
Code;  c01211a7 <ptrace_check_attach+17/84>
   4:   75 07                     jne    d <_EIP+0xd> c01211b0
<ptrace_check_attach+20/84>
Code;  c01211a9 <ptrace_check_attach+19/84>
   6:   b8 ff ff ff ff            mov    $0xffffffff,%eax
Code;  c01211ae <ptrace_check_attach+1e/84>
   b:   c3                        ret
Code;  c01211af <ptrace_check_attach+1f/84>
   c:   90                        nop
Code;  c01211b0 <ptrace_check_attach+20/84>
   d:   f6 42 18 01               testb  $0x1,0x18(%edx)
Code;  c01211b4 <ptrace_check_attach+24/84>
  11:   74 1d                     je     30 <_EIP+0x30> c01211d3
<ptrace_check_attach+43/84>
Code;  c01211b6 <ptrace_check_attach+26/84>
  13:   b8 00 00 00 00            mov    $0x0,%eax


On Mon, Apr 07, 2003 at 02:22:05PM +0200, Michael Lampe wrote:
| Since I upgraded from 2.4.20 to 2.4.21-pre6, totalview dies with a
| segfault right after reading symbol information. The interesting
| thing is that it also reproducibly triggers the following Oops.
| 
| -----------------
| 
| ksymoops 2.4.3 on i686 2.4.21-pre6.  Options used
|      -V (default)
|      -k /proc/ksyms (default)
|      -l /proc/modules (default)
|      -o /lib/modules/2.4.21-pre6/ (default)
|      -m /boot/System.map (default)
| 
| Warning: You did not tell me where to find symbol information.  I will
| assume that the log matches the kernel and modules that are running
| right now and I'll use the default options above for symbol resolution.
| If the current kernel and/or modules do not match the log, you can get
| more accurate output by telling me the kernel version and where to find
| map, modules, ksyms etc.  ksymoops -h explains the options.
| 
| Apr  6 00:28:18 sam kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000007c
| Apr  6 00:28:18 sam kernel: c0118c33
| Apr  6 00:28:18 sam kernel: *pde = 00000000
| Apr  6 00:28:18 sam kernel: Oops: 0000
| Apr  6 00:28:18 sam kernel: CPU:    0
| Apr  6 00:28:18 sam kernel: EIP:    0010:[<c0118c33>]    Not tainted
| Using defaults from ksymoops -t elf32-i386 -a i386
| Apr  6 00:28:18 sam kernel: EFLAGS: 00010202
| Apr  6 00:28:18 sam kernel: eax: 00000000   ebx: 00000001   ecx: 00000476   edx: cba1e000
| Apr  6 00:28:18 sam kernel: esi: 00000007   edi: cba1e000   ebp: ffffffff   esp: c44d3f98
| Apr  6 00:28:18 sam kernel: ds: 0018   es: 0018   ss: 0018
| Apr  6 00:28:18 sam kernel: Process tv6main (pid: 1137, stackpage=c44d3000)
| Apr  6 00:28:18 sam kernel: Stack: c0109bd3 cba1e000 00000000 c44d2000 00000009 00000007 bfffef64 00000000
| Apr  6 00:28:18 sam kernel:        c0106cc4 c44d3fc4 c0106bd3 00000007 00000476 00000001 00000009 00000007
| Apr  6 00:28:18 sam kernel:        bfffef64 0000001a 0000002b 0000002b 0000001a 400e92b6 00000023 00000202
| Apr  6 00:28:18 sam kernel: Call Trace:    [<c0109bd3>] [<c0106cc4>] [<c0106bd3>]
| Apr  6 00:28:18 sam kernel: Code: f6 40 7c 01 75 07 b8 ff ff ff ff c3 90 f6 42 18 01 75 0a b8
| 
| >>EIP; c0118c32 <ptrace_check_attach+12/50>   <=====
| Trace; c0109bd2 <sys_ptrace+b6/580>
| Trace; c0106cc4 <error_code+34/3c>
| Trace; c0106bd2 <system_call+32/38>
| Code;  c0118c32 <ptrace_check_attach+12/50>
| 00000000 <_EIP>:
| Code;  c0118c32 <ptrace_check_attach+12/50>   <=====
|    0:   f6 40 7c 01               testb  $0x1,0x7c(%eax)   <=====
| Code;  c0118c36 <ptrace_check_attach+16/50>
|    4:   75 07                     jne    d <_EIP+0xd> c0118c3e <ptrace_check_attach+1e/50>
| Code;  c0118c38 <ptrace_check_attach+18/50>
|    6:   b8 ff ff ff ff            mov    $0xffffffff,%eax
| Code;  c0118c3c <ptrace_check_attach+1c/50>
|    b:   c3                        ret    
| Code;  c0118c3e <ptrace_check_attach+1e/50>
|    c:   90                        nop    
| Code;  c0118c3e <ptrace_check_attach+1e/50>
|    d:   f6 42 18 01               testb  $0x1,0x18(%edx)
| Code;  c0118c42 <ptrace_check_attach+22/50>
|   11:   75 0a                     jne    1d <_EIP+0x1d> c0118c4e <ptrace_check_attach+2e/50>
| Code;  c0118c44 <ptrace_check_attach+24/50>
|   13:   b8 00 00 00 00            mov    $0x0,%eax
| 
| 
| 1 warning issued.  Results may not be reliable.
| 
| -----------------
| 
| /usr/src/linux# sh scripts/ver_linux 
| If some fields are empty or look unusual you may have an old version.
| Compare to the current minimal requirements in Documentation/Changes.
|  
| Linux sam 2.4.21-pre6 #2 Tue Mar 4 04:19:42 CET 2003 i686 unknown
|  
| Gnu C                  2.95.3
| Gnu make               3.79.1
| util-linux             2.11q
| mount                  2.11q
| modutils               2.4.18
| e2fsprogs              1.32
| reiserfsprogs          3.6.5
| Linux C Library        x    1 root     root      1371591 Nov 10 19:17 /lib/libc.so.6
| Dynamic linker (ldd)   2.2.5
| Procps                 2.0.7
| Net-tools              1.60
| Kbd                    0.99
| Sh-utils               2.0
| Modules Loaded         mga agpgart
| 
| -----------------
| 
| /usr/src/linux# cat /proc/cpuinfo
| processor       : 0
| vendor_id       : GenuineIntel
| cpu family      : 6
| model           : 6
| model name      : Celeron (Mendocino)
| stepping        : 5
| cpu MHz         : 434.323
| cache size      : 128 KB
| fdiv_bug        : no
| hlt_bug         : no
| f00f_bug        : no
| coma_bug        : no
| fpu             : yes
| fpu_exception   : yes
| cpuid level     : 2
| wp              : yes
| flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
| bogomips        : 865.07
| 
| -----------------
| 
| -Michael
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
