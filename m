Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUHAUBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUHAUBQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 16:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266158AbUHAUBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 16:01:16 -0400
Received: from mail.broadpark.no ([217.13.4.2]:64241 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S266155AbUHAUBK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 16:01:10 -0400
To: linux-kernel@vger.kernel.org
Subject: Oops in register_chrdev, what did I do?
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Date: Sun, 01 Aug 2004 22:01:10 +0200
Message-ID: <yw1xwu0i1vcp.fsf@kth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While experimenting a bit with a small kernel module, I got this
oops.  Digging further, I found that /proc/devices had an entry saying

248 <NULL>

which would indicate that I passed a NULL name to register_chrdev(),
only I didn't.  I used a string constant, so I can't see what changed
it to NULL along the way.

What am I missing here?

Unable to handle kernel NULL pointer dereference at virtual address 00000000
c014cad4
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c014cad4>]    Tainted: P  
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210282   (2.6.6) 
eax: e0f93414   ebx: e0f93410   ecx: 00000000   edx: 00000000
esi: 00000000   edi: e0f93414   ebp: de43357c   esp: d7487f64
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 e0f93414 fffffff4 000000f8 c0332c74 d7486000 e8969b80 d7487fa0 
       e896b023 000000f8 e89691c9 e8969b20 fffffffc c0332c74 d7486000 c0332c5c 
       c012ac2a 00000001 00000000 40152000 00000003 00000000 d7486000 c0103d29 
Call Trace:
 [<e896b023>] init_foo+0x23/0x40 [foo]
 [<c012ac2a>] sys_init_module+0x105/0x211
 [<c0103d29>] sysenter_past_esp+0x52/0x71
Code: ac aa 84 c0 75 fa ba 2f 00 00 00 8b 74 24 04 89 d0 88 c4 ac 


>>EIP; c014cad4 <register_chrdev+57/f8>   <=====

>>eax; e0f93414 <pg0+20ba9414/3fc14000>
>>ebx; e0f93410 <pg0+20ba9410/3fc14000>
>>edi; e0f93414 <pg0+20ba9414/3fc14000>
>>ebp; de43357c <pg0+1e04957c/3fc14000>
>>esp; d7487f64 <pg0+1709df64/3fc14000>

Trace; e896b023 <pg0+28581023/3fc14000>
Trace; c012ac2a <sys_init_module+105/211>
Trace; c0103d29 <sysenter_past_esp+52/71>

Code;  c014cad4 <register_chrdev+57/f8>
00000000 <_EIP>:
Code;  c014cad4 <register_chrdev+57/f8>   <=====
   0:   ac                        lods   %ds:(%esi),%al   <=====
Code;  c014cad5 <register_chrdev+58/f8>
   1:   aa                        stos   %al,%es:(%edi)
Code;  c014cad6 <register_chrdev+59/f8>
   2:   84 c0                     test   %al,%al
Code;  c014cad8 <register_chrdev+5b/f8>
   4:   75 fa                     jne    0 <_EIP>
Code;  c014cada <register_chrdev+5d/f8>
   6:   ba 2f 00 00 00            mov    $0x2f,%edx
Code;  c014cadf <register_chrdev+62/f8>
   b:   8b 74 24 04               mov    0x4(%esp,1),%esi
Code;  c014cae3 <register_chrdev+66/f8>
   f:   89 d0                     mov    %edx,%eax
Code;  c014cae5 <register_chrdev+68/f8>
  11:   88 c4                     mov    %al,%ah
Code;  c014cae7 <register_chrdev+6a/f8>
  13:   ac                        lods   %ds:(%esi),%al


-- 
Måns Rullgård
mru@kth.se
