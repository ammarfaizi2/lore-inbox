Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316747AbSFUTPa>; Fri, 21 Jun 2002 15:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316756AbSFUTP3>; Fri, 21 Jun 2002 15:15:29 -0400
Received: from web14202.mail.yahoo.com ([216.136.172.144]:33336 "HELO
	web14202.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S316747AbSFUTP1>; Fri, 21 Jun 2002 15:15:27 -0400
Message-ID: <20020621191528.86025.qmail@web14202.mail.yahoo.com>
Date: Fri, 21 Jun 2002 12:15:28 -0700 (PDT)
From: Erik McKee <camhanaich99@yahoo.com>
Subject: [BUGREPORT] kernel BUG in page_alloc.c:141!
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Booted 2.5.24, and it ran fine for sometime, before it dead(live) locked,
causing a reboot.  Attempts to reboot were met with the following bug
immediatly after calibrating delay loop, which equates out to an
if(bad_range(buddy1,zone)) BUG; in __free_pages_ok:

ksymoops 2.3.7 on i586 2.4.19-pre10-ac2.  Options used
     -v /dosc/linux-2.5/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/Sys-2.5.24 (specified)

kernel BUG at page_alloc.c:141!
invalid operand: 0000
CPU:    0
EIP:    010:[<c012bddb>]   Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 00001000   ebx: f1c728d6     ecx: 00000000       edx: 00001000
esi: 00000000   edi: c101ce20     ebp: 00000cd7       esp: c0277f58
ds: 0018   es: 0018   ss: 0018
Stack: c101ce44 00800000 00000cd7 00007ff0 00001000 c1001008 c101ce44 c0264000
       c1000008 c0264018 00000213 ffffffff 0000066b c012c5b3 c027dba2 00000000
       c0276000 c0105000 0008e000 ffffffff c02e5000 00000000 00000a8d c02b9800
Call Trace: [<c012c5b3>] [<c0105000>] [<c0105000>] [<c0105000>]
Code: 0f 0b 8d 00 81 9e 22 c0 8b 44 24 18 2b 44 24 14 8b 5c 21 10

>>EIP; c012bddb <__free_pages_ok+18b/2b0>   <=====
Trace; c012c5b3 <__free_pages+1b/1c>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Code;  c012bddb <__free_pages_ok+18b/2b0>
00000000 <_EIP>:
Code;  c012bddb <__free_pages_ok+18b/2b0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012bddd <__free_pages_ok+18d/2b0>
   2:   8d 00                     lea    (%eax),%eax
Code;  c012bddf <__free_pages_ok+18f/2b0>
   4:   81 9e 22 c0 8b 44 24      sbbl   $0x442b1824,0x448bc022(%esi)
Code;  c012bde6 <__free_pages_ok+196/2b0>
   b:   18 2b 44 
Code;  c012bde9 <__free_pages_ok+199/2b0>
   e:   24 14                     and    $0x14,%al
Code;  c012bdeb <__free_pages_ok+19b/2b0>
  10:   8b 5c 21 10               mov    0x10(%ecx,1),%ebx

 <0>Kernel panic: Attempted to kill the idle task!



__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
