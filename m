Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262357AbSJRAaz>; Thu, 17 Oct 2002 20:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262358AbSJRAay>; Thu, 17 Oct 2002 20:30:54 -0400
Received: from 66-7-228-146.cust.telepacific.net ([66.7.228.146]:31992 "EHLO
	athena.persistcorp.local") by vger.kernel.org with ESMTP
	id <S262357AbSJRAax> convert rfc822-to-8bit; Thu, 17 Oct 2002 20:30:53 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
Subject: kernel BUG at page_alloc.c:220 - oops in 2.4.19
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Thu, 17 Oct 2002 17:39:08 -0700
Message-ID: <AAE2EF2556DA3045830D8DFFD01C4AD103C035@athena.persistcorp.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel BUG at page_alloc.c:220 - oops in 2.4.19
Thread-Index: AcJ2PnQ1LHgdiEbYTm24jJfPiPjqEg==
From: "Gadad, Vijay" <vgadad@persistcorp.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing an intermittent oops on a heavily loaded SMP system (Compaq DL360 G2).  I've read the messages suggesting this is related to the nvidia driver, but I don't have that loaded.

This is the vanilla 2.4.19 kernel, plus Intel's e1000.o driver and the ipvs patch.

Here's the ksymoops output:




kernel BUG at page_alloc.c:220!
invalid operand: 0000
CPU:    1
EIP:    0010:[rmqueue+509/592]    Not tainted
EIP:    0010:[<c013425d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000040   ebx: c118c2c0   ecx: 00001000   edx: 0000840e
esi: c027b174   edi: 0000eff0   ebp: c1000020   esp: cad79e3c
ds: 0018   es: 0018   ss: 0018
Process nagios (pid: 27141, stackpage=cad79000)
Stack: 00001000 0000740e 00000296 00000000 c027b174 c027b300
000001ff 00000000
       c119af00 c01344f1 c027b174 c027b2fc 000001d2 ffffffff
00000000 0819afd4
       00000001 c119af00 c0128fdb c012967c cf0490e0 0807a000
00000000 c3809b40
Call Trace:    [__alloc_pages+65/384] [do_wp_page+187/672]
[do_no_page+92/528] [handle_mm_fault+141/208] [do_no
Call Trace:    [<c01344f1>] [<c0128fdb>]
[<c012967c>] [<c01298bd>] [<c0123f36>]
  [<c0116532>] [<c011d8b0>] [<c011dc9b>]
[<c0139d34>] [<c0116380>] [<c0108c0c>]
Code: 0f 0b dc 00 33 e8 23 c0 8b 43 18 a9 80 00 00 00 74 08 0f
0b

>>EIP; c013425d <rmqueue+1fd/250>   <=====
Trace; c01344f1 <__alloc_pages+41/180>
Trace; c0128fdb <do_wp_page+bb/2a0>
Trace; c012967c <do_no_page+5c/210>
Trace; c01298bd <handle_mm_fault+8d/d0>
Trace; c0123f36 <do_notify_parent+a6/b0>
Trace; c0116532 <do_page_fault+1b2/4fb>
Trace; c011d8b0 <exit_notify+1f0/330>
Trace; c011dc9b <do_exit+2ab/2c0>
Trace; c0139d34 <filp_close+94/a0>
Trace; c0116380 <do_page_fault+0/4fb>
Trace; c0108c0c <error_code+34/3c>
Code;  c013425d <rmqueue+1fd/250>
00000000 <_EIP>:
Code;  c013425d <rmqueue+1fd/250>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013425f <rmqueue+1ff/250>
   2:   dc 00                     faddl  (%eax)
Code;  c0134261 <rmqueue+201/250>
   4:   33 e8                     xor    %eax,%ebp
Code;  c0134263 <rmqueue+203/250>
   6:   23 c0                     and    %eax,%eax
Code;  c0134265 <rmqueue+205/250>
   8:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c0134268 <rmqueue+208/250>
   b:   a9 80 00 00 00            test   $0x80,%eax
Code;  c013426d <rmqueue+20d/250>
  10:   74 08                     je     1a <_EIP+0x1a>
c0134277 <rmqueue+217/250>
Code;  c013426f <rmqueue+20f/250>
  12:   0f 0b                     ud2a

 kernel BUG at page_alloc.c:220!
invalid operand: 0000







Vijay Gadad
