Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264354AbTLKGmB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 01:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264360AbTLKGmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 01:42:01 -0500
Received: from cs2417481-26.houston.rr.com ([24.174.81.26]:10720 "EHLO
	dmdtech.org") by vger.kernel.org with ESMTP id S264354AbTLKGly
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 01:41:54 -0500
Message-ID: <001801c3bfb1$e734ce20$1e01a8c0@dmdtech2>
From: "Darren Dupre" <darren@dmdtech.org>
To: <linux-kernel@vger.kernel.org>
Subject: cifs causes high system load avg, oopses when unloaded on 2.6.0-test11
Date: Thu, 11 Dec 2003 00:42:10 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using CIFS causes a very high load average (approx. 12 according to uptime).
After I umout all filesystems (CIFS ones) and then unload the module, it
oopses (below).

CC me replies if more information is needed.

Dec 11 00:33:09 dmdtech kernel: slab error in kmem_cache_destroy(): cache
`cifs_request': Can't free all objects
Dec 11 00:33:09 dmdtech kernel: Call Trace:
Dec 11 00:33:09 dmdtech kernel:  [<c013a955>] kmem_cache_destroy+0x85/0x100
Dec 11 00:33:09 dmdtech kernel:  [<e08f96e0>]
cifs_destroy_request_bufs+0x10/0x30 [cifs]
Dec 11 00:33:09 dmdtech kernel:  [<e0910823>] exit_cifs+0x23/0x9d [cifs]
Dec 11 00:33:09 dmdtech kernel:  [<c0130d08>] sys_delete_module+0x138/0x1b0
Dec 11 00:33:09 dmdtech kernel:  [<c014392c>] do_munmap+0x14c/0x190
Dec 11 00:33:09 dmdtech kernel:  [<c0109165>] sysenter_past_esp+0x52/0x71
Dec 11 00:33:09 dmdtech kernel:
Dec 11 00:33:09 dmdtech kernel: cifs_destroy_request_cache: error not all
structures were freed
Dec 11 00:33:09 dmdtech kernel: Unable to handle kernel paging request at
virtual address e0900b92
Dec 11 00:33:09 dmdtech kernel:  printing eip:
Dec 11 00:33:09 dmdtech kernel: e0900b92
Dec 11 00:33:09 dmdtech kernel: *pde = 1ff6d067
Dec 11 00:33:09 dmdtech kernel: *pte = 00000000
Dec 11 00:33:09 dmdtech kernel: Oops: 0000 [#1]
Dec 11 00:33:09 dmdtech kernel: CPU:    0
Dec 11 00:33:09 dmdtech kernel: EIP:    0060:[<e0900b92>]    Not tainted
Dec 11 00:33:09 dmdtech kernel: EFLAGS: 00010292
Dec 11 00:33:09 dmdtech kernel: EIP is at 0xe0900b92
Dec 11 00:33:09 dmdtech kernel: eax: 00000000   ebx: 00000000   ecx:
d5dc8644   edx: 00000000
Dec 11 00:33:09 dmdtech kernel: esi: c92fbf34   edi: c92fbf30   ebp:
cfe50000   esp: cfe51f48
Dec 11 00:33:09 dmdtech kernel: ds: 007b   es: 007b   ss: 0068
Dec 11 00:33:09 dmdtech kernel: Process cifsd (pid: 27573,
threadinfo=cfe50000 task=c8a9e0c0)
Dec 11 00:33:09 dmdtech kernel: Stack: 00000002 00000001 00000006 c92fbf30
c92fbf00 c92fbf34 c92fbf30 e08ff46f
Dec 11 00:33:09 dmdtech kernel:        c92fbf34 c92fbf30 00000000 fffffe00
c94c0200 c92fbf00 fffffffc ce0fbac0
Dec 11 00:33:09 dmdtech kernel:        e08ff6a8 c92fbf00 cfe51fc0 00000024
00000002 c92fbf4c cfe50000 00000027
Dec 11 00:33:09 dmdtech kernel: Call Trace:
Dec 11 00:33:09 dmdtech kernel:  [<c01070c9>] kernel_thread_helper+0x5/0xc
Dec 11 00:33:09 dmdtech kernel:
Dec 11 00:33:09 dmdtech kernel: Code:  Bad EIP value.
Dec 11 00:33:09 dmdtech kernel:  <1>Unable to handle kernel paging request
at virtual address e0900b1d
Dec 11 00:33:09 dmdtech kernel:  printing eip:
Dec 11 00:33:09 dmdtech kernel: e0900b1d
Dec 11 00:33:09 dmdtech kernel: *pde = 1ff6d067
Dec 11 00:33:09 dmdtech kernel: *pte = 00000000
Dec 11 00:33:09 dmdtech kernel: Oops: 0000 [#2]
Dec 11 00:33:09 dmdtech kernel: CPU:    0
Dec 11 00:33:09 dmdtech kernel: EIP:    0060:[<e0900b1d>]    Not tainted
Dec 11 00:33:09 dmdtech kernel: EFLAGS: 00010246
Dec 11 00:33:09 dmdtech kernel: EIP is at 0xe0900b1d
Dec 11 00:33:09 dmdtech kernel: eax: cd308cc0   ebx: fffffe00   ecx:
00000287   edx: cd308cd8
Dec 11 00:33:09 dmdtech kernel: esi: c92fbab4   edi: c92fbab0   ebp:
df812000   esp: df813f48
Dec 11 00:33:09 dmdtech kernel: ds: 007b   es: 007b   ss: 0068
Dec 11 00:33:09 dmdtech kernel: Process cifsd (pid: 18107,
threadinfo=df812000 task=cfae0080)
Dec 11 00:33:09 dmdtech kernel: Stack: cd308cc0 c92fbab4 00000010 00000000
c92fba80 c92fbab4 c92fbab0 e08ff46f
Dec 11 00:33:09 dmdtech kernel:        c92fbab4 c92fbab0 0000007b fffffe00
d2dc8140 c92fba80 fffffffc d2fe3040
Dec 11 00:33:09 dmdtech kernel:        e08ff6a8 c92fba80 df813fc0 00000024
00000002 c92fbacc df812000 00000027
Dec 11 00:33:09 dmdtech kernel: Call Trace:
Dec 11 00:33:09 dmdtech kernel:  [<c01070c9>] kernel_thread_helper+0x5/0xc
Dec 11 00:33:09 dmdtech kernel:
Dec 11 00:33:09 dmdtech kernel: Code:  Bad EIP value.
Dec 11 00:33:09 dmdtech kernel:  <1>Unable to handle kernel paging request
at virtual address e0900b5f
Dec 11 00:33:09 dmdtech kernel:  printing eip:
Dec 11 00:33:09 dmdtech kernel: e0900b5f
Dec 11 00:33:09 dmdtech kernel: *pde = 1ff6d067
Dec 11 00:33:09 dmdtech kernel: *pte = 00000000
Dec 11 00:33:09 dmdtech kernel: Oops: 0000 [#3]
Dec 11 00:33:09 dmdtech kernel: CPU:    0
Dec 11 00:33:09 dmdtech kernel: EIP:    0060:[<e0900b5f>]    Not tainted
Dec 11 00:33:09 dmdtech kernel: EFLAGS: 00010292
Dec 11 00:33:09 dmdtech kernel: EIP is at 0xe0900b5f
Dec 11 00:33:09 dmdtech kernel: eax: fffffe00   ebx: 00000000   ecx:
00000202   edx: db955258
Dec 11 00:33:09 dmdtech kernel: esi: c92fbb74   edi: c92fbb70   ebp:
c38e8000   esp: c38e9f48
Dec 11 00:33:09 dmdtech kernel: ds: 007b   es: 007b   ss: 0068
Dec 11 00:33:09 dmdtech kernel: Process cifsd (pid: 11564,
threadinfo=c38e8000 task=dd85a100)
Dec 11 00:33:09 dmdtech kernel: Stack: db955240 c92fbb74 00000010 00000000
c92fbb40 c92fbb74 c92fbb70 e08ff46f
Dec 11 00:33:09 dmdtech kernel:        c92fbb74 c92fbb70 c38e9fc0 fffffe00
c20a0040 c92fbb40 fffffffc db955240
Dec 11 00:33:09 dmdtech kernel:        e08ff6a8 c92fbb40 c38e9fc0 00000024
00000002 c92fbb8c c38e8000 00000027
Dec 11 00:33:09 dmdtech kernel: Call Trace:
Dec 11 00:33:09 dmdtech kernel:  [<c01070c9>] kernel_thread_helper+0x5/0xc
Dec 11 00:33:09 dmdtech kernel:
Dec 11 00:33:09 dmdtech kernel: Code:  Bad EIP value.

