Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264714AbSJUDY2>; Sun, 20 Oct 2002 23:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbSJUDY2>; Sun, 20 Oct 2002 23:24:28 -0400
Received: from mnh-1-14.mv.com ([207.22.10.46]:43781 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S264714AbSJUDYY>;
	Sun, 20 Oct 2002 23:24:24 -0400
Message-Id: <200210210435.XAA04668@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org
cc: wstearns@pobox.com, Jereme Corrodo <jereme@restorative-management.com>
Subject: 2.4.20-pre7-ac2 - kernel BUG at spinlock.h:186!
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 20 Oct 2002 23:35:10 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We had a process die on a UML server with the oops in $SUBJECT.  

uname -a says

	Linux zaphod.stearns.org 2.4.20-pre7-ac2 #1 SMP Wed Sep 18 18:06:15 EDT 2002 i686 unknown

ksymoops says

Oct 19 15:31:01 zaphod kernel: kernel BUG at /usr/src/linux-2.4.20/include/asm/spinlock.h:186!
Oct 19 15:31:01 zaphod kernel: invalid operand: 0000
Oct 19 15:31:01 zaphod kernel: CPU:    0
Oct 19 15:31:02 zaphod kernel: EIP:    0010:[<c0324e00>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Oct 19 15:31:02 zaphod kernel: EFLAGS: 00010217
Oct 19 15:31:02 zaphod kernel: eax: ecae9348   ebx: eca69f04   ecx: ecae9040   edx: 00000000
Oct 19 15:31:02 zaphod kernel: esi: eca69f4c   edi: 00000000   ebp: eca69edc   esp: eca69ea0
Oct 19 15:31:02 zaphod kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 15:31:02 zaphod kernel: Process jcorrodo (pid: 17283, stackpage=eca69000)
Oct 19 15:31:02 zaphod kernel: Stack: eca69ed8 c0108941 a024fc70 a024fcc8 00000000 00000000 ecae9040 ffffff95
Oct 19 15:31:02 zaphod kernel:        eca69fc4 f1183148 0000000e f1183148 eca69f04 eca69f4c 00000000 eca69f30
Oct 19 15:31:02 zaphod kernel:        c02b36c7 ec84cd00 eca69f4c 00000001 eca69f04 eca68000 40000000 eca68000
Oct 19 15:31:02 zaphod kernel: Call Trace:    [<c0108941>] [<c02b36c7>] [<c02b38b5>] [<c01488c6>] [<c01092cb>]
Oct 19 15:31:02 zaphod kernel: Code: 0f 0b ba 00 e0 6b 33 c0 f0 83 28 01 0f 88 60 12 00 00 8b 45

>>EIP; c0324e00 <unix_stream_sendmsg+70/370>   <=====
Trace; c0108941 <setup_frame+111/210>
Trace; c02b36c7 <sock_sendmsg+67/90>
Trace; c02b38b5 <sock_write+95/a0>
Trace; c01488c6 <sys_write+96/190>
Trace; c01092cb <system_call+33/38>
Code;  c0324e00 <unix_stream_sendmsg+70/370>
00000000 <_EIP>:
Code;  c0324e00 <unix_stream_sendmsg+70/370>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0324e02 <unix_stream_sendmsg+72/370>
   2:   ba 00 e0 6b 33            mov    $0x336be000,%edx
Code;  c0324e07 <unix_stream_sendmsg+77/370>
   7:   c0                        (bad)  
Code;  c0324e08 <unix_stream_sendmsg+78/370>
   8:   f0 83 28 01               lock subl $0x1,(%eax)
Code;  c0324e0c <unix_stream_sendmsg+7c/370>
   c:   0f 88 60 12 00 00         js     1272 <_EIP+0x1272> c0326072 <.text.lock.af_unix+18d/27b>
Code;  c0324e12 <unix_stream_sendmsg+82/370>
  12:   8b 45 00                  mov    0x0(%ebp),%eax

Contact me or Bill Stearns (wstearns at pobox dot com) if anyone needs more
information.

				Jeff

