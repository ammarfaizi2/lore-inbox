Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289697AbSAWONk>; Wed, 23 Jan 2002 09:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289330AbSAWONb>; Wed, 23 Jan 2002 09:13:31 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:60663 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S289738AbSAWONP>; Wed, 23 Jan 2002 09:13:15 -0500
Date: Wed, 23 Jan 2002 09:16:43 -0500
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: Low latency for recent kernels
Message-ID: <20020123091643.A182@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> http://www.zip.com.au/~akpm/linux/2.4.18-pre6-low-latency.patch.gz

2.4.18-pre3 with 2.4.17-low-latency.patch worked fine on this system
2.4.18-pre6 with 2.4.18-pre6-low-latency.patch panics at boot time.
2.4.18-pre6 is fine also.

System has reiserfs root filesystem.  No modules.
/usr/src/linux/System.map was the System.map for 2.4.18pre6ll for
the ksymoops below.

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Kernel panic: can't allocate root vfsmount
 <1>Unable to handle kernel NULL pointer dereference at virtual address 0000002c
c01234d3
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01234d3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: 00000008   ecx: 00000000   edx: 00000073
esi: 00000000   edi: 00000018   ebp: 00000020   esp: c0215e78
ds: 0018   es: 0018   ss: 0018
Process  . (pid: -1072541344, stackpage=c0215000)
Stack: 00000018 00000001 00000018 c0214568 c0117e6c 00000000 00000020 c0214000
       00000018 00000018 00000000 c0117f4c 00000018 00000001 c0214568 00000086
       00000018 c0214000 c0117ff4 00000018 00000001 c0214000 01ebb409 c0214000
Call Trace: [<c0117e6c>] [<c0117f4c>] [<c0117ff4>] [<c0118253>] [<c0117208>]
   [<c0117291>] [<c011759f>] [<c010a889>] [<c0107d1c>] [<c0107e82>] [<c0105000>]
   [<c0109c18>] [<c0105000>] [<c0112020>]
Code: f6 46 2c 01 74 02 0f 0b 9c 5f fa 8b 4e 08 39 d9 75 22 8b 4e

>>EIP; c01234d2 <kmem_cache_alloc+2a/b8>   <=====
Trace; c0117e6c <send_signal+2c/f0>
Trace; c0117f4c <deliver_signal+1c/50>
Trace; c0117ff4 <send_sig_info+74/88>
Trace; c0118252 <send_sig+1a/20>
Trace; c0117208 <update_one_process+68/d4>
Trace; c0117290 <update_process_times+1c/88>
Trace; c011759e <do_timer+22/70>
Trace; c010a888 <timer_interrupt+60/10c>
Trace; c0107d1c <handle_IRQ_event+30/5c>
Trace; c0107e82 <do_IRQ+6a/a8>
Trace; c0105000 <_stext+0/0>
Trace; c0109c18 <call_do_IRQ+6/e>
Trace; c0105000 <_stext+0/0>
Trace; c0112020 <panic+c0/d0>
Code;  c01234d2 <kmem_cache_alloc+2a/b8>
00000000 <_EIP>:
Code;  c01234d2 <kmem_cache_alloc+2a/b8>   <=====
   0:   f6 46 2c 01               testb  $0x1,0x2c(%esi)   <=====
Code;  c01234d6 <kmem_cache_alloc+2e/b8>
   4:   74 02                     je     8 <_EIP+0x8> c01234da <kmem_cache_alloc+32/b8>
Code;  c01234d8 <kmem_cache_alloc+30/b8>
   6:   0f 0b                     ud2a
Code;  c01234da <kmem_cache_alloc+32/b8>
   8:   9c                        pushf
Code;  c01234da <kmem_cache_alloc+32/b8>
   9:   5f                        pop    %edi
Code;  c01234dc <kmem_cache_alloc+34/b8>
   a:   fa                        cli
Code;  c01234dc <kmem_cache_alloc+34/b8>
   b:   8b 4e 08                  mov    0x8(%esi),%ecx
Code;  c01234e0 <kmem_cache_alloc+38/b8>
   e:   39 d9                     cmp    %ebx,%ecx
Code;  c01234e2 <kmem_cache_alloc+3a/b8>
  10:   75 22                     jne    34 <_EIP+0x34> c0123506 <kmem_cache_alloc+5e/b8>
Code;  c01234e4 <kmem_cache_alloc+3c/b8>
  12:   8b 4e 00                  mov    0x0(%esi),%ecx

 <0>Kernel panic: Aiee, killing interrupt handler!

-- 
Randy Hron

