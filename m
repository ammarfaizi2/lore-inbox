Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266164AbUGESJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266164AbUGESJv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 14:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbUGESJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 14:09:51 -0400
Received: from sputnik.senvnet.fi ([80.83.5.69]:28429 "EHLO sputnik.senvnet.fi")
	by vger.kernel.org with ESMTP id S266156AbUGESJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 14:09:31 -0400
Date: Mon, 5 Jul 2004 21:09:28 +0300 (EEST)
From: Jussi Hamalainen <count@theblah.fi>
X-X-Sender: count@mir.senvnet.fi
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at journal.c:1849! (2.4.26)
Message-ID: <Pine.LNX.4.58.0407052104020.210@mir.senvnet.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this BUG on my console today:

ksymoops 2.4.9 on i686 2.4.26-cz1.  Options used
     -v /usr/src/linux-2.4.26-cz1/vmlinux (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.26-cz1/ (default)
     -m /boot/System.map-2.4.26-cz1 (specified)

kernel BUG at journal.c:1849!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01761ed>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000005f   ebx: c0035840   ecx: d3a3c000   edx: d3623f7c
esi: cce61ab0   edi: cce41a80   ebp: cdf2dcc0   esp: d3a3de54
ds: 0018   es: 0018   ss: 0018
Process kjournald (pid: 21, stackpage=d3a3d000)
Stack: c02742e0 c02729f4 c027284a 00000739 c0272a21 c0035840 cce41ab0 c01721ae
       c0035840 00000040 d3a3dea8 00000e4d 00000000 d3ed08f4 00000000 00000000
       00000000 0000001b c913c540 c43deb10 00000e4d ce607ec0 d207fc40 d3e55b40
Call Trace:    [<c01721ae>] [<c01744a6>] [<c0174340>] [<c010574e>] [<c0174360>]
Code: 0f 0b 39 07 4a 28 27 c0 e9 e3 fe ff ff 8d b6 00 00 00 00 83


>>EIP; c01761ed <__journal_remove_journal_head+12d/140>   <=====

>>ecx; d3a3c000 <_end+13701da8/14515e08>
>>edx; d3623f7c <_end+132e9d24/14515e08>
>>esi; cce61ab0 <_end+cb27858/14515e08>
>>edi; cce41a80 <_end+cb07828/14515e08>
>>ebp; cdf2dcc0 <_end+dbf3a68/14515e08>
>>esp; d3a3de54 <_end+13703bfc/14515e08>

Trace; c01721ae <journal_commit_transaction+105e/1190>
Trace; c01744a6 <kjournald+146/1d0>
Trace; c0174340 <commit_timeout+0/10>
Trace; c010574e <arch_kernel_thread+2e/40>
Trace; c0174360 <kjournald+0/1d0>

Code;  c01761ed <__journal_remove_journal_head+12d/140>
00000000 <_EIP>:
Code;  c01761ed <__journal_remove_journal_head+12d/140>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01761ef <__journal_remove_journal_head+12f/140>
   2:   39 07                     cmp    %eax,(%edi)
Code;  c01761f1 <__journal_remove_journal_head+131/140>
   4:   4a                        dec    %edx
Code;  c01761f2 <__journal_remove_journal_head+132/140>
   5:   28 27                     sub    %ah,(%edi)
Code;  c01761f4 <__journal_remove_journal_head+134/140>
   7:   c0 e9 e3                  shr    $0xe3,%cl
Code;  c01761f7 <__journal_remove_journal_head+137/140>
   a:   fe                        (bad)
Code;  c01761f8 <__journal_remove_journal_head+138/140>
   b:   ff                        (bad)
Code;  c01761f9 <__journal_remove_journal_head+139/140>
   c:   ff 8d b6 00 00 00         decl   0xb6(%ebp)
Code;  c01761ff <__journal_remove_journal_head+13f/140>
  12:   00 83 00 00 00 00         add    %al,0x0(%ebx)

The kernel is the bog standard 2.4.26 with i2c 2.8.4 patched in by
yours truly. The box is 500MHz K7 Athlon sitting on an Asus K7M mobo.

-- 
-=[ Count Zero / TBH - Jussi Hämäläinen - email count@theblah.fi ]=-
