Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289313AbSBEALa>; Mon, 4 Feb 2002 19:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289312AbSBEALV>; Mon, 4 Feb 2002 19:11:21 -0500
Received: from www3.aname.net ([62.119.28.103]:1482 "EHLO www3.aname.net")
	by vger.kernel.org with ESMTP id <S289313AbSBEALI>;
	Mon, 4 Feb 2002 19:11:08 -0500
From: "Johan Ekenberg" <johan@ekenberg.se>
To: <linux-kernel@vger.kernel.org>
Subject: Oops in mm/page_alloc.c: __free_pages_ok, kernel = patched 2.4.17
Date: Tue, 5 Feb 2002 01:09:38 +0100
Message-ID: <000301c1add9$66bd3930$050010ac@FUTURE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2377.0
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System:
     Intel SMP
Kernel:
     2.4.17
Relevant patches:
     quota-for-reiserfs patches
     Andreas ptrace patch (fixes an oops in kernel/ptrace.c - from
2.4.18-pre?)
     Ben LaHaise's page_cache_release.patch (from 2.4.18-pre3)
     A tar.gz with all applied patches + .config can be found here:
     http://www.ekenberg.se/oops/against-2.4.17.tar.gz
Modules:
     none
Other:
     Please Cc: me since I'm not currently subscribed to LKM.

2 x Oops:

invalid operand: 0000
CPU:    0
EIP:    0010:[__free_pages_ok+40/524]    Not tainted
EFLAGS: 00010282
eax: c14bce9c   ebx: c1be2300   ecx: c1be2300   edx: e709b4f4
esi: c1be2300   edi: 00000000   ebp: 000001f2   esp: f7ee3f28
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=f7ee3000)
Stack: c9692600 c1be2300 0000000c 000001f2 c1be2300 000001d0 c9692600
c1be2300
       c012c2e2 c012d138 c012c329 00000020 000001d0 00000020 00000006
f7ee2000
       f7ee2000 000031c6 000001d0 c02711d0 c012c592 00000006 00000021
00000006
Call Trace: [shrink_cache+526/908] [__free_pages+28/32]
[shrink_cache+597/908] [shrink_caches+86/132] [try_to_free_pages+60/92]
[kswapd_balance_pgdat+67/140] [kswapd_balance+18/40] [kswapd+153/188]
[kernel_thread+40/56]
Code: 0f 0b 89 d8 2b 05 4c b6 2e c0 c1 f8 06 3b 05 40 b6 2e c0 72

invalid operand: 0000
CPU:    1
EIP:    0010:[__free_pages_ok+40/524]    Not tainted
EFLAGS: 00010282
eax: 00000009   ebx: c1be2300   ecx: c1be2300   edx: e709b4f4
esi: 00001000   edi: 00000000   ebp: 00000380   esp: d3cb9f08
ds: 0018   es: 0018   ss: 0018
Process mysqld (pid: 13273, stackpage=d3cb9000)
Stack: c1be2300 00001000 e709b4f4 00000380 c1be2300 c1be2300 f7f9fcb0
e709b4f4
       0000037f c012d138 c01263ad d3cb9f8c c1be2300 00000000 00001000
00000000
       ffffffea 00000000 00200000 00001000 00000001 00000000 00000000
e709b440
Call Trace: [__free_pages+28/32] [do_generic_file_read+577/1124]
[generic_file_read+126/300] [file_read_actor+0/208] [sys_read+143/196]
[system_call+51/56]
Code: 0f 0b 89 d8 2b 05 4c b6 2e c0 c1 f8 06 3b 05 40 b6 2e c0 72


Is this a known bug, and if so: is there a patch for it?

Thanks,
/Johan Ekenberg

