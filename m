Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263799AbUECRNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263799AbUECRNg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 13:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263803AbUECRNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 13:13:36 -0400
Received: from mail5-151.ewetel.de ([212.6.122.151]:49614 "EHLO
	mail5.ewetel.de") by vger.kernel.org with ESMTP id S263799AbUECRNV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 13:13:21 -0400
Date: Mon, 3 May 2004 19:13:18 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: linux-kernel@vger.kernel.org
Subject: [2.4.25 BUG] while playing DVD in mplayer
Message-ID: <Pine.LNX.4.58.0405031910330.826@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got the following out of a 2.4.25 kernel when playing a (possibly
damaged) DVD in mplayer. From the call chains, it doesn't look like
having to do with an error on the DVD, though.

I can't reproduce it, though.

ksymoops 2.4.9 on i686 2.4.26.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.26/ (default)
     -m /boot/System.map-2.4.25 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
kernel BUG at page_alloc.c:105!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0131083>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000000   ebx: c133d534   ecx: 00000000   edx: de254df4
esi: 00000000   edi: d2d92000   ebp: 000002e4   esp: e4bd9f28
ds: 0018   es: 0018   ss: 0018
Process wmmon (pid: 147, stackpage=e4bd9000)
Stack: 00000000 00000000 000b8ca0 00007d5e 00000000 00000010 00441894 0000011c
       e4bdb360 00000000 d2d92000 000002e4 c0157d72 40019000 d2d92000 0000011c
       00000400 e4bd9f7c 00000000 e7fec2c0 0000011c 00000001 d2d92000 00000000
Call Trace:    [<c0157d72>] [<c0138023>] [<c0108dbf>]
Code: 0f 0b 69 00 3b c4 30 c0 89 d8 2b 05 70 ca 3e c0 c1 f8 02 69


>>EIP; c0131083 <__free_pages_ok+43/290>   <=====

Trace; c0157d72 <proc_file_read+152/1c0>
Trace; c0138023 <sys_read+a3/130>
Trace; c0108dbf <system_call+33/38>

Code;  c0131083 <__free_pages_ok+43/290>
00000000 <_EIP>:
Code;  c0131083 <__free_pages_ok+43/290>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0131085 <__free_pages_ok+45/290>
   2:   69 00 3b c4 30 c0         imul   $0xc030c43b,(%eax),%eax
Code;  c013108b <__free_pages_ok+4b/290>
   8:   89 d8                     mov    %ebx,%eax
Code;  c013108d <__free_pages_ok+4d/290>
   a:   2b 05 70 ca 3e c0         sub    0xc03eca70,%eax
Code;  c0131093 <__free_pages_ok+53/290>
  10:   c1 f8 02                  sar    $0x2,%eax
Code;  c0131096 <__free_pages_ok+56/290>
  13:   69 00 00 00 00 00         imul   $0x0,(%eax),%eax

 kernel BUG at filemap.c:81!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01287a4>]    Not tainted
EFLAGS: 00210286
eax: d50e70c0   ebx: c133d508   ecx: 00000000   edx: c17835e0
esi: c133d508   edi: 000bb51e   ebp: c17835e0   esp: dc861ea0
ds: 0018   es: 0018   ss: 0018
Process mplayer (pid: 2018, stackpage=dc861000)
Stack: c036ae28 00000000 00000000 c01292a0 de254df4 000bb51e c17835e0 e05825c0
       c0129346 c133d508 de254df4 000bb51e c17835e0 c133d508 000bb51e 00000018
       e05825c0 000bb505 c01299d3 0000001f 00000020 0010bdd8 e05825c0 c135b464
Call Trace:    [<c01292a0>] [<c0129346>] [<c01299d3>] [<c0129dca>] [<c012a1f0>]
  [<c012a34d>] [<c012a1f0>] [<c0138023>] [<c0108dbf>]
Code: 0f 0b 51 00 40 c3 30 c0 89 1c 24 c7 44 24 04 01 00 00 00 e8


>>EIP; c01287a4 <add_page_to_hash_queue+24/50>   <=====

Trace; c01292a0 <add_to_page_cache_unique+a0/b0>
Trace; c0129346 <page_cache_read+96/d0>
Trace; c01299d3 <generic_file_readahead+c3/160>
Trace; c0129dca <do_generic_file_read+32a/480>
Trace; c012a1f0 <file_read_actor+0/a0>
Trace; c012a34d <generic_file_read+bd/1b0>
Trace; c012a1f0 <file_read_actor+0/a0>
Trace; c0138023 <sys_read+a3/130>
Trace; c0108dbf <system_call+33/38>

Code;  c01287a4 <add_page_to_hash_queue+24/50>
00000000 <_EIP>:
Code;  c01287a4 <add_page_to_hash_queue+24/50>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01287a6 <add_page_to_hash_queue+26/50>
   2:   51                        push   %ecx
Code;  c01287a7 <add_page_to_hash_queue+27/50>
   3:   00 40 c3                  add    %al,0xffffffc3(%eax)
Code;  c01287aa <add_page_to_hash_queue+2a/50>
   6:   30 c0                     xor    %al,%al
Code;  c01287ac <add_page_to_hash_queue+2c/50>
   8:   89 1c 24                  mov    %ebx,(%esp,1)
Code;  c01287af <add_page_to_hash_queue+2f/50>
   b:   c7 44 24 04 01 00 00      movl   $0x1,0x4(%esp,1)
Code;  c01287b6 <add_page_to_hash_queue+36/50>
  12:   00
Code;  c01287b7 <add_page_to_hash_queue+37/50>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18>


1 error issued.  Results may not be reliable.

-- 
Ciao,
Pascal
