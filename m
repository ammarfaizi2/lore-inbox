Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbTIATim (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 15:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbTIATim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 15:38:42 -0400
Received: from rammstein.mweb.co.za ([196.2.53.175]:10654 "EHLO
	rammstein.mweb.co.za") by vger.kernel.org with ESMTP
	id S263203AbTIATih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 15:38:37 -0400
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
From: Bongani Hlope <bonganilinux@mweb.co.za>
Subject: [OOPS][RESEND] 2.6.0-test4-mm4
Date: Mon, 1 Sep 2003 19:38:31 GMT
X-Posting-IP: 196.2.45.69 via 196.30.125.175
X-Mailer: Endymion MailMan Standard Edition v3.2.19
Message-Id: <E19tuSv-00059A-00@rammstein.mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hope this reaches the list because all the mail I sent on the weekend seems to have been
lost.

Hi

I got the following oops when I was trying to load alsa drivers on the 2.6.0-test4-mm4
kernel.

ksymoops 2.4.9 on i686 2.6.0-test4-mm3-1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test4-mm4 (specified)
     -m /boot/System.map-2.6.0-test4-mm4 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
kernel BUG at mm/slab.c:1623!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0147b8b>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 00000031   ebx: 000ab6b6   ecx: c04cde64   edx: c0406338
esi: c0408920   edi: c04077f8   ebp: 6b6b6b6b   esp: cfc4def8
ds: 007b   es: 007b   ss: 0068
Stack: c03b8700 6b6b6b6b 0000006b cffe39f0 c0210f86 ce119b64 cffead14 00000202
       ce119b68 c0408920 c04077f8 00000000 c0210f77 6b6b6b6b c40348e8 00000080
       c016796a ce119b68 00000000 00000100 00000008 d38adb2f 00000074 d38adec7
Call Trace:
 [<c0210f86>] kobject_cleanup+0x56/0x60
 [<c0210f77>] kobject_cleanup+0x47/0x60
 [<c016796a>] unregister_chrdev+0x8a/0xa0
 [<d38adb2f>] alsa_sound_exit+0x7f/0xb0 [snd]
 [<c0138328>] sys_delete_module+0x158/0x1d0
 [<c01511a3>] do_munmap+0x163/0x1f0
 [<c03a02bb>] syscall_call+0x7/0xb
Code: 4c aa fd ff 0f 0b 5c 06 2e 7a 3b c0 8b 15 38 64 4d c0 e9 5b fd ff ff c7 04 24 00 87
3b c0 8b 44 24 34 89 44 24 04 e8 25 aa fd ff <0f> 0b 57 06 2e 7a 3b c0 e9 1a fd ff ff 0f
0b 87 06 2e 7a 3b c0


>>EIP; c0147b8b <kfree+30b/360>   <=====

>>ecx; c04cde64 <per_cpu__runqueues+24/928>
>>edx; c0406338 <log_wait+0/8>
>>esi; c0408920 <kset_dynamic+0/48>
>>edi; c04077f8 <module_mutex+0/10>
>>ebp; 6b6b6b6b <__crc_zlib_inflate+a7c75/2f3847>
>>esp; cfc4def8 <__crc_isapnp_read_dword+56cb1/126482>

Trace; c0210f86 <kobject_cleanup+56/60>
Trace; c0210f77 <kobject_cleanup+47/60>
Trace; c016796a <unregister_chrdev+8a/a0>
Trace; d38adb2f <__crc_agp_generic_insert_memory+125106/47a460>
Trace; c0138328 <sys_delete_module+158/1d0>
Trace; c01511a3 <do_munmap+163/1f0>
Trace; c03a02bb <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c0147b60 <kfree+2e0/360>
00000000 <_EIP>:
Code;  c0147b60 <kfree+2e0/360>
   0:   4c                        dec    %esp
Code;  c0147b61 <kfree+2e1/360>
   1:   aa                        stos   %al,%es:(%edi)
Code;  c0147b62 <kfree+2e2/360>
   2:   fd                        std    
Code;  c0147b63 <kfree+2e3/360>
   3:   ff 0f                     decl   (%edi)
Code;  c0147b65 <kfree+2e5/360>
   5:   0b 5c 06 2e               or     0x2e(%esi,%eax,1),%ebx
Code;  c0147b69 <kfree+2e9/360>
   9:   7a 3b                     jp     46 <_EIP+0x46>
Code;  c0147b6b <kfree+2eb/360>
   b:   c0 8b 15 38 64 4d c0      rorb   $0xc0,0x4d643815(%ebx)
Code;  c0147b72 <kfree+2f2/360>
  12:   e9 5b fd ff ff            jmp    fffffd72 <_EIP+0xfffffd72>
Code;  c0147b77 <kfree+2f7/360>
  17:   c7 04 24 00 87 3b c0      movl   $0xc03b8700,(%esp,1)
Code;  c0147b7e <kfree+2fe/360>
  1e:   8b 44 24 34               mov    0x34(%esp,1),%eax
Code;  c0147b82 <kfree+302/360>
  22:   89 44 24 04               mov    %eax,0x4(%esp,1)
Code;  c0147b86 <kfree+306/360>
  26:   e8 25 aa fd ff            call   fffdaa50 <_EIP+0xfffdaa50>

This decode from eip onwards should be reliable

Code;  c0147b8b <kfree+30b/360>
00000000 <_EIP>:
Code;  c0147b8b <kfree+30b/360>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0147b8d <kfree+30d/360>
   2:   57                        push   %edi
Code;  c0147b8e <kfree+30e/360>
   3:   06                        push   %es
Code;  c0147b8f <kfree+30f/360>
   4:   2e 7a 3b                  jp,pn  42 <_EIP+0x42>
Code;  c0147b92 <kfree+312/360>
   7:   c0 e9 1a                  shr    $0x1a,%cl
Code;  c0147b95 <kfree+315/360>
   a:   fd                        std    
Code;  c0147b96 <kfree+316/360>
   b:   ff                        (bad)  
Code;  c0147b97 <kfree+317/360>
   c:   ff 0f                     decl   (%edi)
Code;  c0147b99 <kfree+319/360>
   e:   0b 87 06 2e 7a 3b         or     0x3b7a2e06(%edi),%eax
Code;  c0147b9f <kfree+31f/360>
  14:   c0                        .byte 0xc0


1 error issued.  Results may not be
reliable.

---------------------------------------------
This message was sent using M-Web Airmail - JUST LIKE THAT
M-Web: S.A.'s most trusted and reliable Internet Service Provider.
http://airmail.mweb.co.za/


