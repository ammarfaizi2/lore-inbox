Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbTIWJ3Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 05:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTIWJ3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 05:29:25 -0400
Received: from pop.gmx.de ([213.165.64.20]:38311 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263335AbTIWJ3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 05:29:18 -0400
Date: Tue, 23 Sep 2003 11:29:17 +0200 (MEST)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: [BUG] [2.6.0-test4] processes hung (reiserfs related?)
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <30181.1064309357@www55.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed 'ifconfig' hanging on my box, so did a sys-request kill, which
killed off all processes except ones which were hung, so captured the
sys-request 'show tasks' output, showing hung processes and kernel threads.

Filesystem is reiserfs - I'm not on the mailing list, so reply directly to
seek further information!

---

SysRq : Show State


                         free                        sibling
  task             PC    stack   pid father child younger older
init          S C038C9E0 4294789536     1      0     2               (NOTLB)
dfb91e44 00000082 00000246 c038c9e0 dfb91e58 c1150b80 00000001 00000001 
       d6d4d005 df008004 00000000 00000246 3822d4e9 dfb91e58 0000000b
dfb91ea0 
       c012cac8 dfb91e58 3822d4e9 000000d0 c038d2a0 c038d2a0 3822d4e9
1d244b3c 
Call Trace:
 [<c012cac8>] schedule_timeout+0x8c/0xdd
 [<c012ca30>] process_timeout+0x0/0xc
 [<c017ce5d>] do_select+0x244/0x3fa
 [<c011a1d1>] kernel_map_pages+0x28/0x5f
 [<c017ca8f>] __pollwait+0x0/0xa9
 [<c017d2ef>] sys_select+0x2b1/0x4e6
 [<c01718e8>] sys_stat64+0x35/0x37
 [<c010a34b>] syscall_call+0x7/0xb


ksoftirqd/0   S 00000000 4294789536     2      1             3       (L-TLB)
dfb8ffd0 00000046 dfb8ff98 00000000 dfb8ffb4 c012734a 00000000 00000001 
       dfb8ffd0 00000246 c044a628 d6f04000 00000000 dfb8e000 dfb8e000
dfb8ffec 
       c01274f4 dfbb9000 00000013 c012748c 00000000 00000000 00000000
c01074b1 
Call Trace:
 [<c012734a>] tasklet_action+0x43/0x65
 [<c01274f4>] ksoftirqd+0x68/0xb3
 [<c012748c>] ksoftirqd+0x0/0xb3
 [<c01074b1>] kernel_thread_helper+0x5/0xb


events/0      S 00000086 4294801824     3      1             4     2 (L-TLB)
dfb6ff50 00000046 dfb6ff50 00000086 00000246 00000003 00000001 00000000 
       dfb6ff50 c01375e3 00000246 00000086 df1810c0 dfb97004 dfb6e000
dfb6ffec 
       c0137abd df181000 dfb6ffa0 00000000 5a5a5a5a 5a5a5a5a 5a5a5a5a
5a5a5a5a 
Call Trace:
 [<c01375e3>] queue_delayed_work+0x63/0xa0
 [<c0137abd>] worker_thread+0x49d/0x4c2
 [<c0211d3f>] flush_to_ldisc+0x0/0x252
 [<c011b574>] default_wake_function+0x0/0x2e
 [<c010a222>] ret_from_fork+0x6/0x14
 [<c011b574>] default_wake_function+0x0/0x2e
 [<c0137620>] worker_thread+0x0/0x4c2
 [<c01074b1>] kernel_thread_helper+0x5/0xb


kblockd/0     S 00000086 4294773152     4      1             5     3 (L-TLB)
c178df50 00000046 c178df50 00000086 00000246 00000003 00000001 00000000 
       c178c000 cad4d000 00000001 00000086 df66d13c c17bd004 c178c000
c178dfec 
       c0137abd df66d004 c178dfa0 00000000 5a5a5a5a 5a5a5a5a 5a5a5a5a
5a5a5a5a 
Call Trace:
 [<c0137abd>] worker_thread+0x49d/0x4c2
 [<c0229240>] blk_unplug_work+0x0/0x16
 [<c011b574>] default_wake_function+0x0/0x2e
 [<c010a222>] ret_from_fork+0x6/0x14
 [<c011b574>] default_wake_function+0x0/0x2e
 [<c0137620>] worker_thread+0x0/0x4c2
 [<c01074b1>] kernel_thread_helper+0x5/0xb


khubd         S C177BF9A 4294789536     5      1             6     4 (L-TLB)
c177bfa8 00000046 c177bf96 c177bf9a 00000246 c01239ca c177bfa8 c177a000 
       df51b004 c177a000 00000000 00000103 c177a000 c177a000 c177bfc0
c177bfec 
       c025a9fa 00000009 c0388e40 c177a000 c177a000 00000000 c17a5000
c011b574 
Call Trace:
 [<c01239ca>] allow_signal+0xcc/0x200
 [<c025a9fa>] hub_thread+0x93/0xd1
 [<c011b574>] default_wake_function+0x0/0x2e
 [<c025a967>] hub_thread+0x0/0xd1
 [<c01074b1>] kernel_thread_helper+0x5/0xb


pdflush       S 00000000 3790031264     6      1             7     5 (L-TLB)
c1639f88 00000046 00000000 00000000 dfbd9004 c1639fcc c1639f78 c01947d2 
       dfbd9004 00000000 00000000 c1639f88 c1639fd8 c1639fcc c1638000
c1639fc0 
       c0146eb6 c0362ab7 c011a8e5 5a5a5a5a 5a5a5a5a 5a5a5a5a 5a5a5a5a
5a5a5a5a 
Call Trace:
 [<c01947d2>] sync_inodes+0x18/0x93
 [<c0146eb6>] __pdflush+0x15e/0x65b
 [<c011a8e5>] schedule_tail+0x10e/0x14f
 [<c01473b3>] pdflush+0x0/0x15
 [<c01473c4>] pdflush+0x11/0x15
 [<c01074b1>] kernel_thread_helper+0x5/0xb


pdflush       S 00000000 4294785440     7      1             8     6 (L-TLB)
df797f88 00000046 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 df797fd8 df797fcc df796000
df797fc0 
       c0146eb6 00000000 c011a8e5 5a5a5a5a 5a5a5a5a 5a5a5a5a 5a5a5a5a
5a5a5a5a 
Call Trace:
 [<c0146eb6>] __pdflush+0x15e/0x65b
 [<c011a8e5>] schedule_tail+0x10e/0x14f
 [<c01473b3>] pdflush+0x0/0x15
 [<c01473c4>] pdflush+0x11/0x15
 [<c01074b1>] kernel_thread_helper+0x5/0xb


kswapd0       S 000000F6 4294781344     8      1             9     7 (L-TLB)
df795f08 00000046 000000d0 000000f6 00000246 df795f20 0000000c 00000001 
       df795f1c 0000000b fffffe25 00000000 c038e840 df795f20 df795fc0
df795fec 
       c01504f7 c038e420 000001db df795f20 000000e4 0000052d 00000000
00000000 
Call Trace:
 [<c01504f7>] kswapd+0xc1/0xeb
 [<c011e536>] autoremove_wake_function+0x0/0x4b
 [<c010a222>] ret_from_fork+0x6/0x14
 [<c011e536>] autoremove_wake_function+0x0/0x4b
 [<c0150436>] kswapd+0x0/0xeb
 [<c01074b1>] kernel_thread_helper+0x5/0xb


aio/0         S DF7B45F4 4294760864     9      1            10     8 (L-TLB)
df783f50 00000046 00010000 df7b45f4 00000246 dfb91f28 00000003 00000001 
       00000000 df782000 00010000 00000010 df782000 df7b5004 dfb91f20
df783fec 
       c0137abd 00000011 df783fa0 00000000 5a5a5a5a 5a5a5a5a 5a5a5a5a
5a5a5a5a 
Call Trace:
 [<c0137abd>] worker_thread+0x49d/0x4c2
 [<c011b55a>] preempt_schedule+0x36/0x50
 [<c011a8e5>] schedule_tail+0x10e/0x14f
 [<c011b574>] default_wake_function+0x0/0x2e
 [<c010a222>] ret_from_fork+0x6/0x14
 [<c011b574>] default_wake_function+0x0/0x2e
 [<c0137620>] worker_thread+0x0/0x4c2
 [<c01074b1>] kernel_thread_helper+0x5/0xb


reiserfs/0    S 00000086 5376416    10      1           798     9 (L-TLB)
df6b1f50 00000046 df6b1f50 00000086 00000246 00000003 00000001 00000000 
       00000001 df6b0000 00010000 00000086 cd9ffb78 df279004 df6b0000
df6b1fec 
       c0137abd cd9ffb68 df6b1fa0 00000000 5a5a5a5a 5a5a5a5a 5a5a5a5a
5a5a5a5a 
Call Trace:
 [<c0137abd>] worker_thread+0x49d/0x4c2
 [<c01f7aeb>] reiserfs_journal_commit_task_func+0x0/0x219
 [<c011b574>] default_wake_function+0x0/0x2e
 [<c010a222>] ret_from_fork+0x6/0x14
 [<c011b574>] default_wake_function+0x0/0x2e
 [<c0137620>] worker_thread+0x0/0x4c2
 [<c01074b1>] kernel_thread_helper+0x5/0xb


pppd          S current  4294752672   798      1         11556    10 (NOTLB)
da73fdac c010cca4 00000004 da73fdb4 df22e2e4 da73fda4 c012c420 00000000 
       00000001 da73e000 da73fda4 df22e2e4 3822c20f da73fe2c da73fe2c
da73fe18 
       c010acb8 3822c20f c0429754 c038ca78 da73fe2c da73fe2c da73fe18
c012ca30 
Call Trace:
 [<c010cca4>] do_IRQ+0x144/0x3a4
 [<c012c420>] update_process_times+0x46/0x50
 [<c010acb8>] common_interrupt+0x18/0x20
 [<c012ca30>] process_timeout+0x0/0xc
 [<c012b2dc>] __mod_timer+0x33/0x861
 [<c012cac3>] schedule_timeout+0x87/0xdd
 [<c012ca30>] process_timeout+0x0/0xc
 [<c02b4e6f>] dev_close+0x83/0xc0
 [<c02b6ad1>] dev_change_flags+0x12f/0x147
 [<c030effa>] devinet_ioctl+0x2c2/0x6d6
 [<c0312a87>] inet_ioctl+0xcc/0x112
 [<c02acf54>] sock_ioctl+0x213/0x3f2
 [<c017b80e>] do_fcntl+0x216/0x2cd
 [<c017c299>] sys_ioctl+0x20d/0x3fc
 [<c017b96b>] sys_fcntl64+0x50/0x8c
 [<c010a34b>] syscall_call+0x7/0xb


nmbd          D C230E000 168638880 11556      1         25640   798 (NOTLB)
d3f69e7c 00000082 c230e000 c230e000 c1000118 00000282 c658d000 dfbed640 
       80030c00 00000ff4 c658d004 c658d000 c03a0420 d3f68000 00000286
d3f69ed8 
       c01083d3 c658d000 0000005a c0184af7 c658d004 00000000 c230e004
d3f69f1e 
Call Trace:
 [<c01083d3>] __down+0x13a/0x347
 [<c0184af7>] d_alloc+0x1e/0x383
 [<c011b574>] default_wake_function+0x0/0x2e
 [<c0108ae7>] __down_failed+0xb/0x14
 [<c02b7f93>] .text.lock.dev+0x2d/0x8e
 [<c02ac61d>] sock_map_fd+0x118/0x12e
 [<c0312abd>] inet_ioctl+0x102/0x112
 [<c02acf54>] sock_ioctl+0x213/0x3f2
 [<c017c299>] sys_ioctl+0x20d/0x3fc
 [<c017b96b>] sys_fcntl64+0x50/0x8c
 [<c010a34b>] syscall_call+0x7/0xb


ifconfig      D C0141713 4149340576 25640      1         27590 11556 (NOTLB)
ca6d5e7c 00000082 ca6d5e80 c0141713 d60c90f8 00000004 00000246 c038e670 
       00000000 d60c903c c647504c ca6d5e80 c03a0420 ca6d4000 00000286
ca6d5ed8 
       c01083d3 c01547a9 dafafe80 00000004 00000000 c53c7404 40413000
40014000 
Call Trace:
 [<c0141713>] filemap_nopage+0x21c/0x2f9
 [<c01083d3>] __down+0x13a/0x347
 [<c01547a9>] do_no_page+0x29b/0x621
 [<c011b574>] default_wake_function+0x0/0x2e
 [<c0108ae7>] __down_failed+0xb/0x14
 [<c02b7f93>] .text.lock.dev+0x2d/0x8e
 [<c0118f89>] do_page_fault+0x27e/0x4b7
 [<c0312abd>] inet_ioctl+0x102/0x112
 [<c02acf54>] sock_ioctl+0x213/0x3f2
 [<c01578b3>] do_munmap+0x1f1/0x2be
 [<c017c299>] sys_ioctl+0x20d/0x3fc
 [<c010a34b>] syscall_call+0x7/0xb


ifconfig      D C0141713 4294773152 27590      1               25640 (NOTLB)
dc6c5e7c 00000082 dc6c5e80 c0141713 d60c90f8 00000004 00000246 c038e670 
       00000000 d60c903c d7af704c dc6c5e80 c03a0420 dc6c4000 00000286
dc6c5ed8 
       c01083d3 c015473b 000000d0 00000004 00000000 dc6e5404 40413000
40014000 
Call Trace:
 [<c0141713>] filemap_nopage+0x21c/0x2f9
 [<c01083d3>] __down+0x13a/0x347
 [<c015473b>] do_no_page+0x22d/0x621
 [<c011b574>] default_wake_function+0x0/0x2e
 [<c0108ae7>] __down_failed+0xb/0x14
 [<c02b7f93>] .text.lock.dev+0x2d/0x8e
 [<c0118f89>] do_page_fault+0x27e/0x4b7
 [<c0312abd>] inet_ioctl+0x102/0x112
 [<c02acf54>] sock_ioctl+0x213/0x3f2
 [<c01578b3>] do_munmap+0x1f1/0x2be
 [<c017c299>] sys_ioctl+0x20d/0x3fc
 [<c010a34b>] syscall_call+0x7/0xb

-- 
Daniel J Blueman

+++ GMX - die erste Adresse für Mail, Message, More! +++

Getestet von Stiftung Warentest: GMX FreeMail (GUT), GMX ProMail (GUT)
(Heft 9/03 - 23 e-mail-Tarife: 6 gut, 12 befriedigend, 5 ausreichend)

Jetzt selbst kostenlos testen: http://www.gmx.net

