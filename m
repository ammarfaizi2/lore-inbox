Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274102AbSITALB>; Thu, 19 Sep 2002 20:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274117AbSITALB>; Thu, 19 Sep 2002 20:11:01 -0400
Received: from holomorphy.com ([66.224.33.161]:4997 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S274102AbSITALA>;
	Thu, 19 Sep 2002 20:11:00 -0400
Date: Thu, 19 Sep 2002 17:10:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] x86_udelay_tsc not honoring notsc
Message-ID: <20020920001001.GQ28202@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Even though I booted with notsc, rdtsc happens here and appears to
generate #GP or some such nonsense:

Restoring NMI vector
Booting processor 14/52 eip 2000
Initializing CPU#14
masked ExtINT on CPU#14
Leaving ESR disabled.
Calibrating delay loop...
Program received signal SIGEMT, Emulation trap.
__rdtsc_delay (loops=69700) at delay.c:40
40      delay.c: No such file or directory.
        in delay.c
(gdb) bt
#0  __rdtsc_delay (loops=69700) at delay.c:40
#1  0xc019f31d in __delay (loops=69700) at delay.c:63
#2  0xc019f384 in __const_udelay (xloops=429400) at delay.c:74
#3  0xc02c1709 in do_boot_cpu (apicid=52) at smpboot.c:865
#4  0xc02c1a4e in smp_boot_cpus (max_cpus=4294967295) at smpboot.c:1095
#5  0xc02c1c70 in smp_prepare_cpus (max_cpus=4294967295) at smpboot.c:1199
#6  0xc01050d7 in init (unused=0x0) at main.c:547
(gdb) p $eip       
$3 = (void *) 0xc019f2d4
(gdb) disassemble $eip
Dump of assembler code for function __rdtsc_delay:
0xc019f2c0 <__rdtsc_delay>:     push   %ebp
0xc019f2c1 <__rdtsc_delay+1>:   mov    %esp,%ebp
0xc019f2c3 <__rdtsc_delay+3>:   push   %ebx
0xc019f2c4 <__rdtsc_delay+4>:   mov    0x8(%ebp),%ebx
0xc019f2c7 <__rdtsc_delay+7>:   rdtsc  
0xc019f2c9 <__rdtsc_delay+9>:   mov    %eax,%ecx
0xc019f2cb <__rdtsc_delay+11>:  nop    
0xc019f2cc <__rdtsc_delay+12>:  lea    0x0(%esi,1),%esi
0xc019f2d0 <__rdtsc_delay+16>:  repz nop 
0xc019f2d2 <__rdtsc_delay+18>:  rdtsc  
0xc019f2d4 <__rdtsc_delay+20>:  sub    %ecx,%eax
0xc019f2d6 <__rdtsc_delay+22>:  cmp    %ebx,%eax
0xc019f2d8 <__rdtsc_delay+24>:  jb     0xc019f2d0 <__rdtsc_delay+16>
0xc019f2da <__rdtsc_delay+26>:  pop    %ebx
0xc019f2db <__rdtsc_delay+27>:  mov    %ebp,%esp
0xc019f2dd <__rdtsc_delay+29>:  pop    %ebp
0xc019f2de <__rdtsc_delay+30>:  ret    
End of assembler dump.

