Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbSL0RT5>; Fri, 27 Dec 2002 12:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265066AbSL0RT4>; Fri, 27 Dec 2002 12:19:56 -0500
Received: from lapd.cj.edu.ro ([193.231.142.101]:22913 "HELO lapd.cj.edu.ro")
	by vger.kernel.org with SMTP id <S265051AbSL0RTz>;
	Fri, 27 Dec 2002 12:19:55 -0500
Date: Fri, 27 Dec 2002 19:28:06 +0200 (EET)
From: "Lists (lst)" <linux@lapd.cj.edu.ro>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] Kernel 2.4.20 ...
In-Reply-To: <Pine.LNX.3.95.1021221204450.25703A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.43L0.0212271923100.3287-100000@lapd.cj.edu.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Dec 2002, Richard B. Johnson wrote:

> > I receive this oops from the begining of 2.4.19. Now I'm running a 2.4.20 
> > in SMP mode. Is there anyone who can tell me what is the problem of my 
> > kernel?
> You are using some module that the linux-2.4.20 developers don't
> want you to use. Either it's not been converted to current conventions
> or it's proprietary an therefore can't be converted.
> 
> To wit:
> 
> > EIP:    0010:[<c011f86b>]  Tainted: P
> > kernel BUG at /usr/src/linux-2.4.20-SMP/include/asm/spinlock.h:86!

Hi again,

I eliminated almost all modules and after 6 days of uptime I recived 
another OOPS.

Output of ksymoops:
ksymoops 2.4.8 on i686 2.4.20-SMP.  Options used
     -V (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-SMP/ (default)
     -m /usr/src/linux/System.map (default)

kernel BUG at slab.c:1218!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013d8cb>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: c221e640   ebx: 022e5c34   ecx: 0000006c   edx: 0000004c
esi: fc060000   edi: e794e000   ebp: e794e63c   esp: f7bf1f10
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 7, stackpage=f7bf1000)
Stack: 0076bea0 e794e000 f4c740c0 e794e63c c013ec67 c221e640 e794e000 e794e63c
00000c80 0000007f f7bfad08 f7bfac00 00000000 00000003 00000000 00000000
00000000 c221e640 00000020 000001d0 c02f8b28 00000000 c0140d70 0000003c
Call Trace:   [<c013ec67>]  (0xf7bf1f20))
[<c0140d70>]  (0xf7bf1f68))
[<c0140e41>]  (0xf7bf1f78))
[<c0140ff9>]  (0xf7bf1f9c))
[<c0141066>]  (0xf7bf1fb0))
[<c01411b1>]  (0xf7bf1fc0))
[<c0141110>]  (0xf7bf1fc8))
[<c0105000>]  (0xf7bf1fec))
[<c0107386>]  (0xf7bf1ff0))
[<c0141110>]  (0xf7bf1ff8))
Code: 0f 0b c2 04 78 04 2c c0 89 d8 0f af c1 8d 04 30 39 c5 74 08


>>EIP; c013d8cb <kmem_extra_free_checks+2b/70>   <=====

>>eax; c221e640 <_end+1e510a8/33572ac8>
>>edi; e794e000 <_end+27580a68/33572ac8>
>>ebp; e794e63c <_end+275810a4/33572ac8>

Trace; c013ec67 <kmem_cache_reap+277/650>
Trace; c0140d70 <shrink_caches+10/80>
Trace; c0140e41 <try_to_free_pages_zone+61/f0>
Trace; c0140ff9 <kswapd_balance_pgdat+59/a0>
Trace; c0141066 <kswapd_balance+26/40>
Trace; c01411b1 <kswapd+a1/ba>
Trace; c0141110 <kswapd+0/ba>
Trace; c0105000 <_stext+0/0>
Trace; c0107386 <kernel_thread+26/30>
Trace; c0141110 <kswapd+0/ba>

Code;  c013d8cb <kmem_extra_free_checks+2b/70>
00000000 <_EIP>:
Code;  c013d8cb <kmem_extra_free_checks+2b/70>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013d8cd <kmem_extra_free_checks+2d/70>
   2:   c2 04 78                  ret    $0x7804
Code;  c013d8d0 <kmem_extra_free_checks+30/70>
   5:   04 2c                     add    $0x2c,%al
Code;  c013d8d2 <kmem_extra_free_checks+32/70>
   7:   c0 89 d8 0f af c1 8d      rorb   $0x8d,0xc1af0fd8(%ecx)
Code;  c013d8d9 <kmem_extra_free_checks+39/70>
   e:   04 30                     add    $0x30,%al
Code;  c013d8db <kmem_extra_free_checks+3b/70>
  10:   39 c5                     cmp    %eax,%ebp
Code;  c013d8dd <kmem_extra_free_checks+3d/70>
  12:   74 08                     je     1c <_EIP+0x1c>

What is the problem now?

Thank You,
Cosmin

