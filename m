Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281166AbRKEOeK>; Mon, 5 Nov 2001 09:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281167AbRKEOeB>; Mon, 5 Nov 2001 09:34:01 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:53893 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S281166AbRKEOd4>; Mon, 5 Nov 2001 09:33:56 -0500
Date: Mon, 5 Nov 2001 09:49:45 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Oops about once a day with 2.4.13-ac5
Message-ID: <Pine.LNX.4.40.0111050942360.91-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ever since upgrading to the 2.4.13-ac5 release I've been seeing my machine
totally lock up about once a day.  Magic SysRq-B won't even reboot it,
although it reports Restarting...  So it is the big red button.

The oops below did make it to the syslog.  Was paritally decoded by
syslog, so I'm not totally sure it is correct, but I use pretty much a
standard layout with my System.map, so I think it got the right one.

Anyway oops follows:

Nov  5 09:12:37 lightning kernel: invalid operand: 0000
Nov  5 09:12:37 lightning kernel: CPU:    1
Nov  5 09:12:37 lightning kernel: EIP:    0010:[__kmem_cache_shrink+48/136]    Not tainted
Nov  5 09:12:37 lightning kernel: EFLAGS: 00010082
Nov  5 09:12:37 lightning kernel: eax: 00000000   ebx: c1eed288   ecx: e8a56040   edx: 00000020
Nov  5 09:12:37 lightning kernel: esi: c1eed298   edi: f7dfa331   ebp: 0008e000   esp: f7dfbf90
Nov  5 09:12:37 lightning kernel: ds: 0018   es: 0018   ss: 0018
Nov  5 09:12:37 lightning kernel: Process kswapd (pid: 5, stackpage=f7dfb000)
Nov  5 09:12:37 lightning kernel: Stack: 000055fa 000000c0 c012a68d c1eed288 c014b7db c1eed288 0000007b c012ce5b
Nov  5 09:12:37 lightning kernel:        00000006 000000c0 00000000 000000c0 00000000 000000c0 00000080 00000000
Nov  5 09:12:37 lightning kernel:        f7dfa000 c023ee17 c012cedf 000000c0 00000000 00010f00 c1ef1fb8 00000000
Nov  5 09:12:37 lightning kernel: Call Trace: [kmem_cache_shrink+45/52] [shrink_dqcache_memory+35/40] [do_try_to_free_pages+43/80] [kswapd+95/200] [kernel_thread+40/56]
Nov  5 09:12:37 lightning kernel: Code: 0f 0b 8b 51 04 8b 01 89 50 04 89 02 c6 43 24 01 fb 51 53 e8
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  00000004 Before first symbol
   5:   8b 01                     mov    (%ecx),%eax
Code;  00000006 Before first symbol
   7:   89 50 04                  mov    %edx,0x4(%eax)
Code;  0000000a Before first symbol
   a:   89 02                     mov    %eax,(%edx)
Code;  0000000c Before first symbol
   c:   c6 43 24 01               movb   $0x1,0x24(%ebx)
Code;  00000010 Before first symbol
  10:   fb                        sti
Code;  00000010 Before first symbol
  11:   51                        push   %ecx
Code;  00000012 Before first symbol
  12:   53                        push   %ebx
Code;  00000012 Before first symbol
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> 00000018 Before first symbol

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

