Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbUKBPXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUKBPXS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 10:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUKBPTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 10:19:39 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:33234 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261512AbUKBPMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 10:12:55 -0500
From: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Organization: -ENOENT
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.10-rc1-mm2 and processes in D state
Date: Tue, 2 Nov 2004 16:12:41 +0100
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411021612.41974.l_allegrucci@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


100% reproducible running LTP's 'runalltests.sh -x 100'.
Below is the SysRq+T log after init 1 (to kill all killable processes).
The processes which are stuck in D state are "genfmod" and "genlgamma".
2.6.9 seems not to be affected.  2.6.10-rc1-bk* not tried.

SysRq : Show State

                                               sibling
  task             PC      pid father child younger older
init          S C03B81E0     0     1      0     2               (NOTLB)
c14cceac 00000086 c14cda00 c03b81e0 00000001 00000000 c14ccec0 c14cceac 
       000005ad 3a0fa6e2 000000d1 c14cda00 c14cdb5c 00087dde c14ccec0 0000000b 
       c14ccee8 c02d009e c14ccec0 00087dde c012da41 c03be210 c03be210 00087dde 
Call Trace:
 [schedule_timeout+94/176] schedule_timeout+0x5e/0xb0
 [do_select+354/640] do_select+0x162/0x280
 [sys_select+656/1184] sys_select+0x290/0x4a0
 [syscall_call+7/11] syscall_call+0x7/0xb
ksoftirqd/0   S C03B81E0     0     2      1             3       (L-TLB)
dffc2fa4 00000046 c14cd510 c03b81e0 00011e63 cb838c2f 00000039 d8cb5a40 
       00000105 b2f195f3 000000c9 c14cd510 c14cd66c 00000000 dffc2000 00000000 
       dffc2fbc c011df05 c14cd510 00000013 dffc2000 c14ccf70 dffc2fec c012d7da 
Call Trace:
 [ksoftirqd+165/192] ksoftirqd+0xa5/0xc0
 [kthread+170/176] kthread+0xaa/0xb0
 [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
events/0      R running     0     3      1             4     2 (L-TLB)
khelper       S C03B81E0     0     4      1             9     3 (L-TLB)
dffc8f3c 00000046 dffc7a20 c03b81e0 dffc8f3c c0114f35 c14db7f8 00000003 
       0000046a 699a3c9e 000000cb dffc7a20 dffc7b7c de174d50 c14db7f0 dffc8f90 
       dffc8fbc c0129111 00000000 dffc8f70 00000000 c14db7f8 dffc8000 de174d90 
Call Trace:
 [worker_thread+609/640] worker_thread+0x261/0x280
 [kthread+170/176] kthread+0xaa/0xb0
 [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
kthread       S C03B81E0     0     9      1    17     116     4 (L-TLB)
dffc9f3c 00000046 dffc7530 c03b81e0 dffc9f3c c0114f35 dffd4f78 00000003 
       000004f6 271792a7 00000068 dffc7530 dffc768c c150bee8 dffd4f70 dffc9f90 
       dffc9fbc c0129111 00000000 dffc9f70 00000000 dffd4f78 dffc9000 c150bf28 
Call Trace:
 [worker_thread+609/640] worker_thread+0x261/0x280
 [kthread+170/176] kthread+0xaa/0xb0
 [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
kacpid        S C03B81E0     0    17      9            77       (L-TLB)
dffd7f3c 00000046 dffc7040 c03b81e0 00010000 dffc7040 dffd7000 dffd7f3c 
       000003b6 3da99566 0000000b dffc7040 dffc719c dffd7000 dffd4cf0 dffd7f90 
       dffd7fbc c0129111 00000011 dffd7f70 00000000 c011439a dffc7530 c03b81e0 
Call Trace:
 [worker_thread+609/640] worker_thread+0x261/0x280
 [kthread+170/176] kthread+0xaa/0xb0
 [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
kblockd/0     S C03B81E0     0    77      9           114    17 (L-TLB)
dff06f3c 00000046 dff05a40 c03b81e0 dff06f3c c0114f35 dffd41f8 00000003 
       000008a6 b4c4e847 000000d1 dff05a40 dff05b9c c15c17b0 dffd41f0 dff06f90 
       dff06fbc c0129111 00000000 dff06f70 00000000 dffd41f8 dff06000 c15c1730 
Call Trace:
 [worker_thread+609/640] worker_thread+0x261/0x280
 [kthread+170/176] kthread+0xaa/0xb0
 [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
pdflush       S C03B81E0     0   114      9           117    77 (L-TLB)
c150bf70 00000046 dff05550 c03b81e0 00000000 00000000 00000005 00000000 
       0000710b b49b3e6f 000000d1 dff05550 dff056ac c150b000 c150bfa8 c150bf9c 
       c150bf8c c013d198 00000000 c150b000 c150b000 c14ccf6c 00000000 c150bfbc 
Call Trace:
 [__pdflush+152/512] __pdflush+0x98/0x200
 [pdflush+42/48] pdflush+0x2a/0x30
 [kthread+170/176] kthread+0xaa/0xb0
 [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
kswapd0       S C03B81E0     0   116      1           707     9 (L-TLB)
c1516f88 00000046 c1515a60 c03b81e0 00000001 00000001 0000007e 0000002e 
       00001c38 44ed4d32 00000054 c1515a60 c1515bbc c1516000 00000000 c031ea9c 
       c1516fec c014356f c031e6e0 00000000 00000000 00000000 00000000 c1515a60 
Call Trace:
 [kswapd+223/256] kswapd+0xdf/0x100
 [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
aio/0         S C03B81E0     0   117      9          7074   114 (L-TLB)
c1519f3c 00000046 c1515570 c03b81e0 00010000 c1515570 c1519000 c1519f3c 
       0000077b 3fa686ba 0000000b c1515570 c15156cc c1519000 c150d3f0 c1519f90 
       c1519fbc c0129111 00000011 c1519f70 00000000 99d458fc c1519f6c c0114710 
Call Trace:
 [worker_thread+609/640] worker_thread+0x261/0x280
 [kthread+170/176] kthread+0xaa/0xb0
 [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
kseriod       S C03B81E0     0   707      1           783   116 (L-TLB)
c1580f8c 00000046 c1515080 c03b81e0 00000068 c1580000 c1580f74 c0215452 
       000023e0 47f5736b 0000000b c1515080 c15151dc c1580fc0 fffff000 c1580000 
       c1580fec c021567e 0000000f c03188e0 c1580000 00000000 c1515080 c012dd20 
Call Trace:
 [serio_thread+190/288] serio_thread+0xbe/0x120
 [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
kjournald     S C03B81E0     0   783      1          1309   707 (L-TLB)
c15fbf60 00000046 c15b5a80 c03b81e0 c15fbf60 c0114f35 c15ce6c4 00000003 
       000000a1 8ae92c3f 000000d0 c15b5a80 c15b5bdc 00000000 c15ce680 00000001 
       c15fbfec c01afb92 00000000 00000005 c15ce6c4 c15ce6d4 c15fb000 00000011 
Call Trace:
 [kjournald+626/656] kjournald+0x272/0x290
 [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
kjournald     S C03B81E0     0  1309      1          6241   783 (L-TLB)
d9d9df60 00000046 d6d58080 c03b81e0 d9d9df60 c0114f35 df00eee4 00000003 
       00000164 93276bee 000000cc d6d58080 d6d581dc 00000000 df00eea0 00000001 
       d9d9dfec c01afb92 00000000 00000005 df00eee4 df00eef4 d9d9d000 00000000 
Call Trace:
 [kjournald+626/656] kjournald+0x272/0x290
 [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
genfmod       D C03B81E0     0  6228      1          7347  6241 (NOTLB)
d5edbe50 00000082 d9599ac0 c03b81e0 d5edbe1c d6c98920 00030058 cee78800 
       0000432f c0777b71 00000055 d9599ac0 d9599c1c d9599ac0 dd9c976c d9599ac0 
       d5edbe84 c02d05e2 00000055 d5edbe7c c01142b2 dd9c9770 dd9c9770 dd9c9770 
Call Trace:
 [rwsem_down_write_failed+146/464] rwsem_down_write_failed+0x92/0x1d0
 [.text.lock.open+16/177] .text.lock.open+0x10/0xb1
 [may_open+479/624] may_open+0x1df/0x270
 [open_namei+165/1616] open_namei+0xa5/0x650
 [filp_open+60/96] filp_open+0x3c/0x60
 [sys_open+70/144] sys_open+0x46/0x90
 [syscall_call+7/11] syscall_call+0x7/0xb
genlgamma     D C03B81E0     0  6241      1          6228  1309 (NOTLB)
c8dbce50 00000086 cedf0530 c03b81e0 00000000 00001000 00030058 da6b820c 
       00091245 313a5c11 00000056 cedf0530 cedf068c cedf0530 dcf5c72c cedf0530 
       c8dbce84 c02d05e2 c8dbce68 00030058 dcf5c6ac dcf5c730 dcf5c730 dcf5c730 
Call Trace:
 [rwsem_down_write_failed+146/464] rwsem_down_write_failed+0x92/0x1d0
 [.text.lock.open+16/177] .text.lock.open+0x10/0xb1
 [may_open+479/624] may_open+0x1df/0x270
 [open_namei+165/1616] open_namei+0xa5/0x650
 [filp_open+60/96] filp_open+0x3c/0x60
 [sys_open+70/144] sys_open+0x46/0x90
 [syscall_call+7/11] syscall_call+0x7/0xb
pdflush       S C03B81E0     0  7074      9                 117 (L-TLB)
d99f7f70 00000046 d92e5590 c03b81e0 000003f9 00000000 00000000 00000000 
       000000b7 bf473736 000000bc d92e5590 d92e56ec d99f7000 d99f7fa8 d99f7f9c 
       d99f7f8c c013d198 00000007 d99f7000 d99f7000 c150bf28 00000000 d99f7fbc 
Call Trace:
 [__pdflush+152/512] __pdflush+0x98/0x200
 [pdflush+42/48] pdflush+0x2a/0x30
 [kthread+170/176] kthread+0xaa/0xb0
 [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
init          S C03B81E0     0  7347      1  7350          6228 (NOTLB)
de174f10 00000082 dac86550 c03b81e0 de174fb4 c01127d0 d77bd980 d82fbcd4 
       00003fda 69a0144b 000000cb dac86550 dac866ac de174000 00000001 fffffe00 
       de174f88 c011c686 00001cb6 00000004 d956baa0 de174000 de174f48 00010000 
Call Trace:
 [do_wait+406/1072] do_wait+0x196/0x430
 [sys_wait4+62/64] sys_wait4+0x3e/0x40
 [sys_waitpid+39/41] sys_waitpid+0x27/0x29
 [syscall_call+7/11] syscall_call+0x7/0xb
bash          S C03B81E0     0  7350   7347                     (NOTLB)
deeb5e68 00000082 d956baa0 c03b81e0 0000000d 0000000e 00000003 d956c000 
       0004553f 5ba1730d 000000cc d956baa0 d956bbfc d956c000 7fffffff d95aa240 
       deeb5ea4 c02d00eb 0000000b 0000000d 0000000e 00000003 dab2900b deeb5000 
Call Trace:
 [schedule_timeout+171/176] schedule_timeout+0xab/0xb0
 [read_chan+1602/1856] read_chan+0x642/0x740
 [tty_read+226/256] tty_read+0xe2/0x100
 [vfs_read+160/288] vfs_read+0xa0/0x120
 [sys_read+75/128] sys_read+0x4b/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb

-- 
I route therefore you are
