Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274631AbRJAGpZ>; Mon, 1 Oct 2001 02:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274633AbRJAGpP>; Mon, 1 Oct 2001 02:45:15 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:49058 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S274631AbRJAGo7>; Mon, 1 Oct 2001 02:44:59 -0400
Date: Mon, 1 Oct 2001 07:45:26 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: <linux-kernel@vger.kernel.org>
Subject: Re: (VM?) oops in 2.4.9-ac10
In-Reply-To: <Pine.GSO.4.33.0109300952580.24574-100000@scorpio.gold.ac.uk>
Message-ID: <Pine.LNX.4.33.0110010742490.24399-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 30 Matt Bernstein wrote:

>Hi, this occurred on our main fileserver overnight.
>
>SMP PIII Coppermine; Debian "potato" + bunk 2.4 debs; 2.4.9-ac10 + ext3
>0.9.9 + ext3 speedup + ext3 "experimental VM patch" + jfs-1.0.4; gdth;
>acenic; everything modular; gcc 2.96-85

Oh no, this occurred on our student fileserver *last* night (same kernel,
but compiled for PII). System stability is not looking good. I forgot to
mention I have HIGHMEM = 4GB.

In the absence of any better suggestion, I'll try 2.4.9-ac18.

ksymoops 2.4.1 on i686 2.4.9-ac10-jfs.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.9-ac10-jfs/ (default)
     -m /boot/System.map-2.4.9-ac10-jfs (default)

No modules in ksyms, skipping objects
kernel BUG at slab.c:1419!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c013662e>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 0000001b   ebx: 00fac080   ecx: c022af80   edx: 0000712d
esi: f7b90000   edi: f7a87140   ebp: f7b90994   esp: f7ee1f7c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=f7ee1000)
Stack: c01fe9cd 0000058b c0231a80 00000006 f7eec600 f7eec400 00000006 00000000
       00000000 00000000 c221b0c0 000000c0 0000000f c0231a80 0008e000 c01391d1
       000000c0 f7ee0000 ffffffff c013924e 000000c0 00000000 c0105000 0008e000
Call Trace: [<c01391d1>] [<c013924e>] [<c0105000>] [<c0105000>] [<c0105926>]
   [<c01391e0>]
Code: 0f 0b 5f 58 8b 44 24 20 89 ea 8b 58 18 b8 71 f0 2c 5a 01 da

>>EIP; c013662e <kmem_cache_reap+be/600>   <=====
Trace; c01391d1 <inactive_shortage+1/a0>
Trace; c013924e <inactive_shortage+7e/a0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0105926 <kernel_thread+26/30>
Trace; c01391e0 <inactive_shortage+10/a0>
Code;  c013662e <kmem_cache_reap+be/600>
00000000 <_EIP>:
Code;  c013662e <kmem_cache_reap+be/600>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0136630 <kmem_cache_reap+c0/600>
   2:   5f                        pop    %edi
Code;  c0136631 <kmem_cache_reap+c1/600>
   3:   58                        pop    %eax
Code;  c0136632 <kmem_cache_reap+c2/600>
   4:   8b 44 24 20               mov    0x20(%esp,1),%eax
Code;  c0136636 <kmem_cache_reap+c6/600>
   8:   89 ea                     mov    %ebp,%edx
Code;  c0136638 <kmem_cache_reap+c8/600>
   a:   8b 58 18                  mov    0x18(%eax),%ebx
Code;  c013663b <kmem_cache_reap+cb/600>
   d:   b8 71 f0 2c 5a            mov    $0x5a2cf071,%eax
Code;  c0136640 <kmem_cache_reap+d0/600>
  12:   01 da                     add    %ebx,%edx

