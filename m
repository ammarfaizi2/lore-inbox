Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266243AbTAYJqk>; Sat, 25 Jan 2003 04:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266228AbTAYJqk>; Sat, 25 Jan 2003 04:46:40 -0500
Received: from webhosting.rdsbv.ro ([213.157.185.164]:30672 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id <S266224AbTAYJqh>;
	Sat, 25 Jan 2003 04:46:37 -0500
Date: Sat, 25 Jan 2003 11:55:50 +0200 (EET)
From: Catalin BOIE <util@ns2.deuroconsult.ro>
X-X-Sender: <util@hosting.rdsbv.ro>
To: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
Subject: [OOPS] K2.4.20: "Kernel bug at slab.c:1128" - sch related
Message-ID: <Pine.LNX.4.33.0301251142400.20538-100000@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I use a custom script to generate qdiscs/classes/filters that triggers a
kernel oops.

Kernel 2.4.20
Pentium IV 1.2 GHz

Kernel bug at slab.c:1128
Invalid operand: 0000
CPU:    0
EIP:    0010:[<c0127ab4>]  not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
EAX: ffffffff   EBX: c12c52c0     ECX: 000001f0       EDX: 00000000
ESI: 000001f0   EDI: c12c52c0     EBP: 000001f0       ESP: ceab1c60
DS: 0018        ES: 0018       SS: 0018
Process autohash (pid: 109, stackpage=ceab1000)
Stack: [<c12c5200>] [<c12c52c8>] [<00000246>] [<000001f0>] [<cf8bb000>]
[<c0127e0f>] [<c12c52c0>] [<000001f0>] [<00000064>] [<c0256640>]
[<ce59ac00>]
[<cfed8c00>] [<c01d3cac>] [<00000064>] [<000001f0>] [<cfed4400>]
[<cf115034>]
[<ce59ac00>] [<ce59b060>] [<ce59b060>] [<d081ecc7>] [<cfed8c00>]
[<c0256640>]
[<fffffffe>]
Call trace: [<c0127e0f>] [<c01d3cac>] [<d081ecc7>] [<c01d5265>]
[<d0820600>]
            [<c01d27e4>] [<c01d0605>] [<c01d7cd4>] [<c01d7730>]
[<c01d7b73>]
            [<c01c79d5>] [<c01c8b48>] [<c0120010>] [<c0120d8e>]
[<c0111394>]
            [<c0123543>] [<c0123743>] [<c0123a74>] [<c012396c>]
[<c01c8fcc>]
            [<c0106bc7>]
Code: 0f 0b 68 04 c0 50 21 c0 c7 44 24 10 01 00 00 00 b8 03 00 00


>>EIP; c0127ab4 <kmem_cache_grow+44/1d8>   <=====

>>EAX; ffffffff <END_OF_CODE+3fd31247/????>
>>EBX; c12c52c0 <END_OF_CODE+ff6508/????>
>>EDI; c12c52c0 <END_OF_CODE+ff6508/????>
>>ESP; ceab1c60 <END_OF_CODE+e7e2ea8/????>

Trace; c0127e0f <kmalloc+eb/110>
Trace; c01d3cac <qdisc_create_dflt+20/bc>
Trace; d081ecc7 <END_OF_CODE+1054ff0f/????>
Trace; c01d5265 <tc_ctl_tclass+1cd/214>
Trace; d0820600 <END_OF_CODE+10551848/????>
Trace; c01d27e4 <rtnetlink_rcv+298/3bc>
Trace; c01d0605 <__neigh_event_send+89/1b4>
Trace; c01d7cd4 <netlink_data_ready+1c/60>
Trace; c01d7730 <netlink_unicast+230/278>
Trace; c01d7b73 <netlink_sendmsg+1fb/20c>
Trace; c01c79d5 <sock_sendmsg+69/88>
Trace; c01c8b48 <sys_sendmsg+18c/1e8>
Trace; c0120010 <map_user_kiobuf+8/f8>
Trace; c0120d8e <handle_mm_fault+52/b0>
Trace; c0111394 <do_page_fault+160/480>
Trace; c0123543 <do_generic_file_read+1f7/404>
Trace; c0123743 <do_generic_file_read+3f7/404>
Trace; c0123a74 <generic_file_read+7c/110>
Trace; c012396c <file_read_actor+0/8c>
Trace; c01c8fcc <sys_socketcall+1e4/200>
Trace; c0106bc7 <system_call+33/38>

Code;  c0127ab4 <kmem_cache_grow+44/1d8>
00000000 <_EIP>:
Code;  c0127ab4 <kmem_cache_grow+44/1d8>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0127ab6 <kmem_cache_grow+46/1d8>
   2:   68 04 c0 50 21            push   $0x2150c004
Code;  c0127abb <kmem_cache_grow+4b/1d8>
   7:   c0 c7 44                  rol    $0x44,%bh
Code;  c0127abe <kmem_cache_grow+4e/1d8>
   a:   24 10                     and    $0x10,%al
Code;  c0127ac0 <kmem_cache_grow+50/1d8>
   c:   01 00                     add    %eax,(%eax)
Code;  c0127ac2 <kmem_cache_grow+52/1d8>
   e:   00 00                     add    %al,(%eax)
Code;  c0127ac4 <kmem_cache_grow+54/1d8>
  10:   b8 03 00 00 00            mov    $0x3,%eax


Thanks!


---
Catalin(ux) BOIE
catab@deuroconsult.ro

