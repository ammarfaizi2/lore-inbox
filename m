Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263418AbTFGTpB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 15:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263449AbTFGTpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 15:45:01 -0400
Received: from uldns1.unil.ch ([130.223.8.20]:31618 "EHLO uldns1.unil.ch")
	by vger.kernel.org with ESMTP id S263418AbTFGTo6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 15:44:58 -0400
Date: Sat, 7 Jun 2003 21:58:32 +0200
From: Gregoire Favre <greg@magma.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.70-bk12 Oops at boot
Message-ID: <20030607195832.GA30170@magma.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have just compiled 2.5.70-bk12 with following applied:

http://fy.chalmers.se/~appro/linux/DVD+RW/ide-cd-2.5.69.+patch
cvs -q -z3 -d :pserver:anonymous@linuxtv.org:/cvs/linuxtv co dvb-kernel

And I got:

ksymoops -v /usr/src/linux-2.5.70-bk12/vmlinux -l /lib/modules/2.5.70-bk12/ -m /usr/src/linux-2.5.70-bk12/System.map -K -O /tmp/2570bk12 
ksymoops 2.4.8 on i686 2.4.21-rc7-ac1.  Options used
     -v /usr/src/linux-2.5.70-bk12/vmlinux (specified)
     -K (specified)
     -l /lib/modules/2.5.70-bk12/ (specified)
     -O (specified)
     -m /usr/src/linux-2.5.70-bk12/System.map (specified)

No ksyms, skipping lsmod
kernel BUG at mm/slab.c:985!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c013a6e5>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 000001a8   ebx: 00000000   ecx: c018e452   edx: 00000200
esi: c03afe5e   edi: 00000000   ebp: 00000000   esp: f7f9df68
ds: 007b   es: 007b   ss: 0068
Stack: c011d6da 00001d30 00001d5c c04a8d49 00000246 00000029 00000000 c011d5a0 
       c049bfb8 00000001 00000000 00000000 c018e4a6 c03afe5e 000001a8 00000000 
       00000001 c018e452 00000000 c048df6c c03b3820 c049bfb8 c0480716 00000000 
Call Trace:
 [<c011d6da>] release_console_sem+0xcc/0xce
 [<c011d5a0>] printk+0x140/0x17a
 [<c018e4a6>] init_inodecache+0x37/0x48
 [<c018e452>] init_once+0x0/0x1d
 [<c048df6c>] init_efs_fs+0x15/0x3c
 [<c0480716>] do_initcalls+0x21/0x95
 [<c012b6b8>] init_workqueues+0xf/0x27
 [<c0105099>] init+0x37/0x1ae
 [<c0105062>] init+0x0/0x1ae
 [<c0107039>] kernel_thread_helper+0x5/0xb
Code: 0f 0b d9 03 09 e1 3a c0 c7 44 24 04 d0 00 00 00 c7 04 24 20 


>>EIP; c013a6e5 <kmem_cache_create+35/4e2>   <=====

>>ecx; c018e452 <init_once+0/1d>
>>esi; c03afe5e <crc32table_be+a29e/3cdcc>
>>esp; f7f9df68 <_end+37ad0f60/3fb30ff8>

Trace; c011d6da <release_console_sem+cc/ce>
Trace; c011d5a0 <printk+140/17a>
Trace; c018e4a6 <init_inodecache+37/48>
Trace; c018e452 <init_once+0/1d>
Trace; c048df6c <init_efs_fs+15/3c>
Trace; c0480716 <do_initcalls+21/95>
Trace; c012b6b8 <init_workqueues+f/27>
Trace; c0105099 <init+37/1ae>
Trace; c0105062 <init+0/1ae>
Trace; c0107039 <kernel_thread_helper+5/b>

Code;  c013a6e5 <kmem_cache_create+35/4e2>
00000000 <_EIP>:
Code;  c013a6e5 <kmem_cache_create+35/4e2>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013a6e7 <kmem_cache_create+37/4e2>
   2:   d9 03                     flds   (%ebx)
Code;  c013a6e9 <kmem_cache_create+39/4e2>
   4:   09 e1                     or     %esp,%ecx
Code;  c013a6eb <kmem_cache_create+3b/4e2>
   6:   3a c0                     cmp    %al,%al
Code;  c013a6ed <kmem_cache_create+3d/4e2>
   8:   c7 44 24 04 d0 00 00      movl   $0xd0,0x4(%esp,1)
Code;  c013a6f4 <kmem_cache_create+44/4e2>
   f:   00 
Code;  c013a6f5 <kmem_cache_create+45/4e2>
  10:   c7 04 24 20 00 00 00      movl   $0x20,(%esp,1)

 <0>Kernel panic: Attempted to kill init!

Please let me know if I need to send other infos (and CC to me as I only
read the list through newsgroup) ;-)

	Grégoire
__________________________________________________________________
http://www-ima.unil.ch/greg ICQ:16624071 mailto:greg@magma.unil.ch
