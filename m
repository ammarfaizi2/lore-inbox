Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291869AbSBNUVP>; Thu, 14 Feb 2002 15:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291863AbSBNUVG>; Thu, 14 Feb 2002 15:21:06 -0500
Received: from 64-30-107-48.ftth.sac.winfirst.net ([64.30.107.48]:30980 "EHLO
	leng.internal") by vger.kernel.org with ESMTP id <S291869AbSBNUUr>;
	Thu, 14 Feb 2002 15:20:47 -0500
Message-ID: <006601c1b595$baa16b20$7e93a8c0@sac.unify.com>
From: "Manuel McLure" <manuel@mclure.org>
To: <markus.schaber@student.uni-ulm.de>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20020214143358.301201f9.markus.schaber@student.uni-ulm.de>
Subject: Re: Opses
Date: Thu, 14 Feb 2002 12:24:59 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Schaber said:
> After some days of uptime, I always get an Oops in the kswapd. After that,
there are some other Oopses (mostly "cannot handle Kernel page request", but
also some other oopses). But as far as I can see, the kswapd is always the
first Oops after the reboot.
>
> This is what ksymoops tells me:
>
> ***
> multimedia:/var/log# ksymoops <messages
> ksymoops 2.4.3 on i686 2.4.17.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.17/ (default)
>      -m /boot/System.map-2.4.17 (default)
>
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
>
> Feb 14 09:08:04 multimedia kernel: c0140a17
> Feb 14 09:08:04 multimedia kernel: Oops: 0002
> Feb 14 09:08:04 multimedia kernel: CPU:    0
> Feb 14 09:08:04 multimedia kernel: EIP:    0010:[prune_icache+103/208]
Not tainted
> Feb 14 09:08:04 multimedia kernel: EFLAGS: 00010246
> Feb 14 09:08:04 multimedia kernel: eax: fd22c080   ebx: c3129648   ecx:
00000000   edx: cd0207cf
> Feb 14 09:08:04 multimedia kernel: esi: c3129640   edi: c3129848   ebp:
c1435f64   esp: c1435f4c
> Feb 14 09:08:04 multimedia kernel: ds: 0018   es: 0018   ss: 0018
> Feb 14 09:08:04 multimedia kernel: Process kswapd (pid: 5,
stackpage=c1435000)
> Feb 14 09:08:04 multimedia kernel: Stack: 0000000f 000001d0 00000020
00001757 c3129448 c78dfcc8 00000006 c0140a9b
> Feb 14 09:08:04 multimedia kernel:        00001559 c012968d 00000006
000001d0 00000006 000001d0 00000006 000001d0
> Feb 14 09:08:04 multimedia kernel:        c021b5c8 00000000 c021b5c8
c01296dc 00000020 c021b5c8 00000001 c1434000
> Feb 14 09:08:04 multimedia kernel: Call Trace:
[shrink_icache_memory+27/64] [shrink_caches+109/128]
[try_to_free_pages+60/96] [kswapd_balance_pgdat+67/144]
[kswapd_balance+22/48]
> Feb 14 09:08:04 multimedia kernel: Code: 89 50 04 89 02 89 73 f8 89 73 fc
8b 45 f8 89 58 04 89 03 8d
> Using defaults from ksymoops -t elf32-i386 -a i386
>
> Code;  00000000 Before first symbol
> 00000000 <_EIP>:
> Code;  00000000 Before first symbol
>    0:   89 50 04                  mov    %edx,0x4(%eax)
> Code;  00000002 Before first symbol
>    3:   89 02                     mov    %eax,(%edx)
> Code;  00000004 Before first symbol
>    5:   89 73 f8                  mov    %esi,0xfffffff8(%ebx)
> Code;  00000008 Before first symbol
>    8:   89 73 fc                  mov    %esi,0xfffffffc(%ebx)
> Code;  0000000a Before first symbol
>    b:   8b 45 f8                  mov    0xfffffff8(%ebp),%eax
> Code;  0000000e Before first symbol
>    e:   89 58 04                  mov    %ebx,0x4(%eax)
> Code;  00000010 Before first symbol
>   11:   89 03                     mov    %eax,(%ebx)
> Code;  00000012 Before first symbol
>   13:   8d 00                     lea    (%eax),%eax
>
>
> 1 warning issued.  Results may not be reliable.
> ***
>
> It happened using 2.4.14, 2.4.27 and one or two 2.4 versions I don't
remember now.
>
> Does anybody know what this means?
>
> If you need more diagnostics, tell me, and I'll try my best.


Very interesting - last night I got a very similar Oops on 2.4.17:

Feb 14 04:03:06 leng kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000004
Feb 14 04:03:06 leng kernel:  printing eip:
Feb 14 04:03:06 leng kernel: c01434e2
Feb 14 04:03:06 leng kernel: *pde = 00000000
Feb 14 04:03:06 leng kernel: Oops: 0000
Feb 14 04:03:06 leng kernel: CPU:    0
Feb 14 04:03:07 leng kernel: EIP:    0010:[prune_icache+50/240]    Not
tainted
Feb 14 04:03:07 leng kernel: EIP:    0010:[<c01434e2>]    Not tainted
Feb 14 04:03:07 leng kernel: EFLAGS: 00010207
Feb 14 04:03:07 leng kernel: eax: 6e657272   ebx: 00000000   ecx: 00000000
edx: c2a03280
Feb 14 04:03:07 leng kernel: esi: c72cee00   edi: 00000000   ebp: c1257f54
esp: c1257f3c
Feb 14 04:03:07 leng kernel: ds: 0018   es: 0018   ss: 0018
Feb 14 04:03:07 leng kernel: Process kswapd (pid: 5, stackpage=c1257000)
Feb 14 04:03:07 leng kernel: Stack: 00000d3b c72cea28 c57a07e8 00000003
000001d0 00000005 00000005 c01435c5
Feb 14 04:03:07 leng kernel:        000003c8 c012b04e 00000005 000001d0
00000005 000001d0 c023ab68 00000005
Feb 14 04:03:08 leng kernel:        000001d0 c023ab68 00000000 c012b0a0
00000003 c023ab68 00000001 c1256000
Feb 14 04:03:08 leng kernel: Call Trace: [shrink_icache_memory+37/64]
[shrink_caches+110/144] [try_to_free_pages+48/80]
[kswapd_balance_pgdat+68/144] [kswapd_balance+22/48]
Feb 14 04:03:08 leng kernel: Call Trace: [<c01435c5>] [<c012b04e>]
[<c012b0a0>] [<c012b134>] [<c012b196>]
Feb 14 04:03:08 leng kernel:    [kswapd+161/192] [kswapd+0/192]
[rest_init+0/48] [kernel_thread+38/48] [kswapd+0/192]
Feb 14 04:03:08 leng kernel:    [<c012b2b1>] [<c012b210>] [<c0105000>]
[<c0105726>] [<c012b210>]
Feb 14 04:03:08 leng kernel:
Feb 14 04:03:08 leng kernel: Code: 8b 7f 04 8d 73 f8 8b 86 08 01 00 00 a9 38
00 00 00 75 61 0b

This was the first of many Oops in my log - after the Oops happened multiple
processes started segfaulting.

--
Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
<manuel@mclure.org>     | and significant law, no man may kill a cat.
<http://www.mclure.org> |             -- H.P. Lovecraft


