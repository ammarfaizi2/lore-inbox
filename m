Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315925AbSILOMq>; Thu, 12 Sep 2002 10:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315928AbSILOMq>; Thu, 12 Sep 2002 10:12:46 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:6024 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S315925AbSILOMp>; Thu, 12 Sep 2002 10:12:45 -0400
Subject: 2.5.34-mm2 kernel BUG at sched.c:944! only with CONFIG_PREEMPT=y
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 12 Sep 2002 08:14:01 -0600
Message-Id: <1031840041.1990.378.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following BUG at sched.c:944! with 2.5.34-mm2 and PREEMPT on.
This was repeatable. 

With no PREEMPT, 2.5.34-mm2 booted and is running fine.  Some other
options used: SMP, HUGETLB_PAGE, HIGHPTE, HIGHMEM4G. 

System is dual p3, scsi, 1GB.

Steven

ksymoops 2.4.4 on i686 2.5.34.  Options used
     -v vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map (specified)

kernel BUG at sched.c:944!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c01176ff>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c02d4000   ebx: c02d4000     ecx: 00000000       edx: 00000000
esi: 0009b800   edi: c0105000     ebp: c02d5c8        esp: c02d5fa8
ds: 068         es: 0068       ss: 0068
Stack:  c01072c4 00000060 00000286 00000000 00000000 c02d4000 0009b800 c0105000
        c02d5fd4 c0117ad6 00000000 0008e000 c010504b c02d68c2 c02ba3a0 00000000
        c027e980 0003fff0 0003fff0 c033e660 00000002 c01001b1
Call Trace: [<c01072c4>] [<c0105000>] [<c0117ad6>] [<c010504b>]
Code: 0f 0b b0 03 5f 52 28 c0 b9 00 e0 ff ff 21 e1 ff 41 10 9b 01

>>EIP; c01176ff <schedule+1f/3c0>   <=====
Trace; c01072c4 <kernel_thread_helper+0/c>
Trace; c0105000 <_stext+0/0>
Trace; c0117ad6 <preempt_schedule+36/50>
Trace; c010504b <rest_init+4b/50>
Code;  c01176ff <schedule+1f/3c0>
00000000 <_EIP>:
Code;  c01176ff <schedule+1f/3c0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0117701 <schedule+21/3c0>
   2:   b0 03                     mov    $0x3,%al
Code;  c0117703 <schedule+23/3c0>
   4:   5f                        pop    %edi
Code;  c0117704 <schedule+24/3c0>
   5:   52                        push   %edx
Code;  c0117705 <schedule+25/3c0>
   6:   28 c0                     sub    %al,%al
Code;  c0117707 <schedule+27/3c0>
   8:   b9 00 e0 ff ff            mov    $0xffffe000,%ecx
Code;  c011770c <schedule+2c/3c0>
   d:   21 e1                     and    %esp,%ecx
Code;  c011770e <schedule+2e/3c0>
   f:   ff 41 10                  incl   0x10(%ecx)
Code;  c0117711 <schedule+31/3c0>
  12:   9b                        fwait
Code;  c0117712 <schedule+32/3c0>
  13:   01 00                     add    %eax,(%eax)

 <0>Kernel panic: Attempted to kill the idle task!


