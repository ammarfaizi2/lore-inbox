Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbUKAMz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbUKAMz3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 07:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbUKAMz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 07:55:29 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:52647
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261781AbUKAMnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 07:43:50 -0500
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>, Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
In-Reply-To: <20041101123701.GA4443@elte.hu>
References: <1099171567.1424.9.camel@krustophenia.net>
	 <20041030233849.498fbb0f@mango.fruits.de> <20041031120721.GA19450@elte.hu>
	 <20041031124828.GA22008@elte.hu>
	 <1099227269.1459.45.camel@krustophenia.net>
	 <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu>
	 <20041031162059.1a3dd9eb@mango.fruits.de>
	 <20041031165913.2d0ad21e@mango.fruits.de> <20041101115546.GA2620@elte.hu>
	 <20041101123701.GA4443@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Organization: linutronix
Date: Mon, 01 Nov 2004 13:35:27 +0100
Message-Id: <1099312527.3337.5.camel@thomas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-01 at 13:37 +0100, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > i've uploaded -V0.6.3 to the usual place:
> > 
> >     http://redhat.com/~mingo/realtime-preempt/
> 
> hm, make it -V0.6.4. -V0.6.3 had a bug in where the system clock
> 'stopped' a couple of minutes after bootup, creating weird effects. (it
> stopped when jiffies overflowed from negative territory they default to
> at bootup, into positive numbers.)
> 
> 	Ingo

I'm doing some tests from my RT environment on 0.6.2. I'm quite sure,
that interrupts are sporadically disabled for > 200µs. Did you change
anything relevant to this between 0.6.2 and 0.6.4 ?
I also had a freeze of the machine. Sysrq-T was the only thing that
worked.

tglx


                                               sibling
  task             PC      pid father child younger older
init          [c113d6f0]D C03D9540     0     1      0     2
(NOTLB)
c113fe5c 00000086 c113d6f0 c03d9540 00000246 c113d6f0 00000001 c113fea4 
       c012007c c0326060 c113fea4 c01c9988 c113fea4 00001f7c 26c698f9
000002d0 
       c113d8a4 c113e000 c113fe98 0000000b c113fe80 c02d49fb 00000296
c0327ff4 
Call Trace:
 [<c012007c>] __mod_timer+0x11c/0x1e0 (36)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c02d49fb>] schedule+0x3b/0x130 (40)
 [<c02d5678>] schedule_timeout+0x88/0xe0 (36)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (60)
 [<c0120d30>] process_timeout+0x0/0x10 (20)
 [<c0169ec7>] do_select+0x197/0x2f0 (28)
 [<c0169b60>] __pollwait+0x0/0xd0 (84)
 [<c016a33b>] sys_select+0x2db/0x4f0 (32)
 [<c010602b>] syscall_call+0x7/0xb (92)
ksoftirqd/0   [c113d140]R C03D9540     0     2      1             3
(L-TLB)
c7fe3f88 00000046 c113d140 c03d9540 c7fe3f6c c0326370 c7fe3f6c c7fe2000 
       c0120a86 00000000 c0364580 00000000 c7fe2000 000000d5 02053ba5
000002d1 
       c113d2f4 c7fe2000 c7fe2000 00000000 c7fe3fac c02d49fb c011cad0
00000000 
Call Trace:
 [<c0120a86>] run_timer_softirq+0x2a6/0x460 (36)
 [<c02d49fb>] schedule+0x3b/0x130 (52)
 [<c011cad0>] ksoftirqd+0x0/0xe0 (4)
 [<c011cad0>] ksoftirqd+0x0/0xe0 (28)
 [<c011cb96>] ksoftirqd+0xc6/0xe0 (4)
 [<c012ca7a>] kthread+0xaa/0xb0 (20)
 [<c012c9d0>] kthread+0x0/0xb0 (28)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
desched/0     [c113cb90]D C03D9540     0     3      1             4
2 (L-TLB)
c7fe5f88 00000046 c113cb90 c03d9540 c013f0dd c7ff9a40 c1137ee4 c012d597 
       c7ff9a40 c1137ee4 c013f0dd c1137ee4 c135a0d0 00000107 95a45f2d
0000029e 
       c113cd44 c7fe4000 c7fe4000 00000000 c7fe5fac c02d49fb c2d1e7a4
c0116cf3 
Call Trace:
 [<c013f0dd>] kmem_cache_free+0x4d/0xe0 (20)
 [<c012d597>] _mutex_lock+0x17/0x20 (12)
 [<c013f0dd>] kmem_cache_free+0x4d/0xe0 (12)
 [<c02d49fb>] schedule+0x3b/0x130 (44)
 [<c0116cf3>] mmdrop_complete+0x73/0x110 (8)
 [<c0116de0>] desched_thread+0x0/0x90 (24)
 [<c0116e4e>] desched_thread+0x6e/0x90 (4)
 [<c012ca7a>] kthread+0xaa/0xb0 (20)
 [<c012c9d0>] kthread+0x0/0xb0 (28)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
events/0      [c113c5e0]R C03D9570     0     4      1             5
3 (L-TLB)
c7fedf20 00000046 c113d140 c03d9570 000002d1 00000000 00000246 c113c5e0 
       00000246 c113c5e0 015f136e 000002d1 c113d140 000002f7 015f3f88
000002d1 
       c113c794 c7fec000 c7fca740 c7fedf94 c7fedf44 c02d49fb c7fedf94
c7fca77c 
Call Trace:
 [<c02d49fb>] schedule+0x3b/0x130 (88)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (12)
 [<c0127fe8>] worker_thread+0x258/0x280 (24)
 [<c01f8f60>] console_callback+0x0/0xe0 (24)
 [<c0113460>] default_wake_function+0x0/0x30 (28)
 [<c0113460>] default_wake_function+0x0/0x30 (32)
 [<c0127d90>] worker_thread+0x0/0x280 (36)
 [<c012ca7a>] kthread+0xaa/0xb0 (4)
 [<c012c9d0>] kthread+0x0/0xb0 (28)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
khelper       [c113c030]D C03D9540     0     5      1            10
4 (L-TLB)
c7fcdf20 00000046 c113c030 c03d9540 c113c030 00000000 00000246 c113c030 
       00000246 c113c030 00000001 c7fca67c c113d140 00004693 32e90bc6
00000023 
       c113c1e4 c7fcc000 c7fca640 c7fcdf94 c7fcdf44 c02d49fb c7fcdf94
c7fca67c 
Call Trace:
 [<c02d49fb>] schedule+0x3b/0x130 (88)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (12)
 [<c0127fe8>] worker_thread+0x258/0x280 (24)
 [<c0127910>] __call_usermodehelper+0x0/0x70 (24)
 [<c0113460>] default_wake_function+0x0/0x30 (28)
 [<c0113460>] default_wake_function+0x0/0x30 (32)
 [<c0127d90>] worker_thread+0x0/0x280 (36)
 [<c012ca7a>] kthread+0xaa/0xb0 (4)
 [<c012c9d0>] kthread+0x0/0xb0 (28)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
kthread       [c7fd1710]D C03D9540     0    10      1    24      77
5 (L-TLB)
c7fd3f20 00000046 c7fd1710 c03d9540 c7fd1710 00000000 00000246 c7fd1710 
       00000246 c7fd1710 00000001 c7fca57c c7d05770 00001363 36d5ab71
00000023 
       c7fd18c4 c7fd2000 c7fca540 c7fd3f94 c7fd3f44 c02d49fb c7fd3f94
c7fca57c 
Call Trace:
 [<c02d49fb>] schedule+0x3b/0x130 (88)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (12)
 [<c0127fe8>] worker_thread+0x258/0x280 (24)
 [<c012ca80>] keventd_create_kthread+0x0/0x60 (24)
 [<c0113460>] default_wake_function+0x0/0x30 (28)
 [<c0113460>] default_wake_function+0x0/0x30 (32)
 [<c0127d90>] worker_thread+0x0/0x280 (36)
 [<c012ca7a>] kthread+0xaa/0xb0 (4)
 [<c012c9d0>] kthread+0x0/0xb0 (28)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
kblockd/0     [c7fd1160]D C03D9540     0    24     10            75
(L-TLB)
c7fdff20 00000046 c7fd1160 c03d9540 c7fd1160 00000000 00000246 c7fd1160 
       00000246 c7fd1160 00000001 c7fca37c c135ac30 0000228e 9bb8ebd4
00000190 
       c7fd1314 c7fde000 c7fca340 c7fdff94 c7fdff44 c02d49fb c7fdff94
c7fca37c 
Call Trace:
 [<c02d49fb>] schedule+0x3b/0x130 (88)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (12)
 [<c0127fe8>] worker_thread+0x258/0x280 (24)
 [<c0215410>] as_work_handler+0x0/0x60 (24)
 [<c0113460>] default_wake_function+0x0/0x30 (28)
 [<c0113460>] default_wake_function+0x0/0x30 (32)
 [<c0127d90>] worker_thread+0x0/0x280 (36)
 [<c012ca7a>] kthread+0xaa/0xb0 (4)
 [<c012c9d0>] kthread+0x0/0xb0 (28)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
pdflush       [c7fd0bb0]D C03D9540     0    75     10            76
24 (L-TLB)
c7f43f5c 00000046 c7fd0bb0 c03d9540 c013b0c8 c013bd30 00000246 c7fd0bb0 
       00000ccc 00002146 00000000 00000000 c0d28c30 00001fb6 bba27e42
00000190 
       c7fd0d64 c7f42000 c7f43fb0 c7f43fa4 c7f43f80 c02d49fb c0328500
00000001 
Call Trace:
 [<c013b0c8>] background_writeout+0x98/0xc0 (20)
 [<c013bd30>] pdflush+0x0/0x30 (4)
 [<c02d49fb>] schedule+0x3b/0x130 (64)
 [<c013bbff>] __pdflush+0x7f/0x1b0 (12)
 [<c012d5d7>] _mutex_lock_irq+0x17/0x20 (12)
 [<c013bd30>] pdflush+0x0/0x30 (8)
 [<c013bc04>] __pdflush+0x84/0x1b0 (4)
 [<c013bd56>] pdflush+0x26/0x30 (20)
 [<c013bd30>] pdflush+0x0/0x30 (40)
 [<c012ca7a>] kthread+0xaa/0xb0 (4)
 [<c012c9d0>] kthread+0x0/0xb0 (28)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
pdflush       [c7fd0600]D C03D9540     0    76     10            78
75 (L-TLB)
c7f57f5c 00000046 c7fd0600 c03d9540 002a8188 c013bd30 00000246 c7fd0600 
       c0328420 002a8188 0029f8d0 00000000 c113d140 000003b9 2698f358
000002d0 
       c7fd07b4 c7f56000 c7f57fb0 c7f57fa4 c7f57f80 c02d49fb c0328500
00000001 
Call Trace:
 [<c013bd30>] pdflush+0x0/0x30 (24)
 [<c02d49fb>] schedule+0x3b/0x130 (64)
 [<c013bbff>] __pdflush+0x7f/0x1b0 (12)
 [<c012d5d7>] _mutex_lock_irq+0x17/0x20 (12)
 [<c013bd30>] pdflush+0x0/0x30 (8)
 [<c013bc04>] __pdflush+0x84/0x1b0 (4)
 [<c013bd56>] pdflush+0x26/0x30 (20)
 [<c013bd30>] pdflush+0x0/0x30 (40)
 [<c012ca7a>] kthread+0xaa/0xb0 (4)
 [<c012c9d0>] kthread+0x0/0xb0 (28)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
aio/0         [c7f5b730]D C03D9540     0    78     10           664
76 (L-TLB)
c7f5df20 00000046 c7f5b730 c03d9540 00000000 00000000 00000246 c7f5b730 
       00000246 c7f5b730 00000001 c7fca07c c113d6f0 00003100 deb9886e
00000004 
       c7f5b8e4 c7f5c000 c7fca040 c7f5df94 c7f5df44 c02d49fb c7f5df94
c7fca07c 
Call Trace:
 [<c02d49fb>] schedule+0x3b/0x130 (88)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (12)
 [<c0127fe8>] worker_thread+0x258/0x280 (24)
 [<c0113460>] default_wake_function+0x0/0x30 (52)
 [<c0113460>] default_wake_function+0x0/0x30 (32)
 [<c0127d90>] worker_thread+0x0/0x280 (36)
 [<c012ca7a>] kthread+0xaa/0xb0 (4)
 [<c012c9d0>] kthread+0x0/0xb0 (28)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
kswapd0       [c7fd0050]D C03D9540     0    77      1           666
10 (L-TLB)
c7f59f60 00000046 c7fd0050 c03d9540 00000000 00000000 c0327ea0 00000246 
       c7fd0050 00000001 c03282ec c012cf9e c2314700 00000508 d7982974
00000190 
       c7fd0204 c7f58000 c7f59f98 c7f59fc0 c7f59f84 c02d49fb c03282ec
c012cf9e 
Call Trace:
 [<c012cf9e>] prepare_to_wait+0x5e/0x80 (48)
 [<c02d49fb>] schedule+0x3b/0x130 (40)
 [<c012cf9e>] prepare_to_wait+0x5e/0x80 (8)
 [<c0142cb3>] kswapd+0xd3/0xe0 (28)
 [<c012d0b0>] autoremove_wake_function+0x0/0x60 (32)
 [<c0105f02>] ret_from_fork+0x6/0x14 (20)
 [<c012d0b0>] autoremove_wake_function+0x0/0x60 (12)
 [<c0142be0>] kswapd+0x0/0xe0 (24)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
IRQ 8         [c7f5b180]D C03D9570     0   664     10           672
78 (L-TLB)
c7f71f80 00000046 c7d04c10 c03d9570 00000009 00000246 00000000 c01fb371 
       c03e8090 0000001d e9bf49d0 00000009 c7d04c10 000043a0 e9bf57a8
00000009 
       c7f5b334 c7f70000 c0398d80 c0398d80 c7f71fa4 c02d49fb 00000008
c0398d80 
Call Trace:
 [<c01fb371>] rtc_interrupt+0xe1/0x130 (32)
 [<c02d49fb>] schedule+0x3b/0x130 (56)
 [<c0133e60>] do_irqd+0x0/0xd0 (32)
 [<c0133f08>] do_irqd+0xa8/0xd0 (4)
 [<c012ca7a>] kthread+0xaa/0xb0 (28)
 [<c012c9d0>] kthread+0x0/0xb0 (28)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
IRQ 12        [c7f5a620]D C03D99E8     0   672     10           686
664 (L-TLB)
c7e0ff80 00000046 c113d6f0 c03d99e8 00000006 c1187400 000000fa 00000000 
       00000000 35fa4d60 0907682f 00000006 c113d6f0 000004f6 090772a7
00000006 
       c7f5a7d4 c7e0e000 c0398f00 c0398f00 c7e0ffa4 c02d49fb 0000000c
c0398f00 
Call Trace:
 [<c02d49fb>] schedule+0x3b/0x130 (88)
 [<c0133e60>] do_irqd+0x0/0xd0 (32)
 [<c0133f08>] do_irqd+0xa8/0xd0 (4)
 [<c012ca7a>] kthread+0xaa/0xb0 (28)
 [<c012c9d0>] kthread+0x0/0xb0 (28)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
IRQ 6         [c7f5a070]D C03D9540     0   686     10           709
672 (L-TLB)
c7e11f80 00000046 c7f5a070 c03d9540 0836a1c0 00000000 c021c610 c021c52b 
       c0303866 00000292 c7e15460 00000000 c113c5e0 0005a201 026a5625
00000005 
       c7f5a224 c7e10000 c0398cc0 c0398cc0 c7e11fa4 c02d49fb 00000006
c0398cc0 
Call Trace:
 [<c021c610>] reset_interrupt+0x0/0x90 (28)
 [<c021c52b>] floppy_interrupt+0x14b/0x1b0 (4)
 [<c02d49fb>] schedule+0x3b/0x130 (56)
 [<c0133e60>] do_irqd+0x0/0xd0 (32)
 [<c0133f08>] do_irqd+0xa8/0xd0 (4)
 [<c012ca7a>] kthread+0xaa/0xb0 (28)
 [<c012c9d0>] kthread+0x0/0xb0 (28)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
kseriod       [c7f5abd0]D C03D9540     0   666      1           778
77 (L-TLB)
c7e0df6c 00000046 c7f5abd0 c03d9540 00000000 00000246 c7f5abd0 00000246 
       c7f5abd0 00000001 c0366b40 c012cf9e 00000286 00008752 01c979f5
00000005 
       c7f5ad84 c7e0c000 c7e0c000 c7e0c000 c7e0df90 c02d49fb c0366b40
c012cf9e 
Call Trace:
 [<c012cf9e>] prepare_to_wait+0x5e/0x80 (48)
 [<c02d49fb>] schedule+0x3b/0x130 (40)
 [<c012cf9e>] prepare_to_wait+0x5e/0x80 (8)
 [<c01fcd3e>] serio_thread+0xce/0x110 (28)
 [<c012d0b0>] autoremove_wake_function+0x0/0x60 (20)
 [<c0105f02>] ret_from_fork+0x6/0x14 (20)
 [<c012d0b0>] autoremove_wake_function+0x0/0x60 (12)
 [<c01fcc70>] serio_thread+0x0/0x110 (24)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
IRQ 14        [c7e1d750]T C03D9540     0   709     10           741
686 (L-TLB)
c7e1fd98 00000046 c7e1d750 c03d9540 c03d9570 00000190 c03d9540 c6604330 
       c7e1fd84 c7e1fd94 00000086 c6604330 c6604330 00001fbe 9bc32661
00000190 
       c7e1d904 c7e1e000 00000000 c7e1d750 c7e1fdbc c02d49fb c03d9570
00000000 
Call Trace:
 [<c02d49fb>] schedule+0x3b/0x130 (88)
 [<c02d5c32>] down_write_mutex+0x102/0x1b0 (36)
 [<c013b98d>] test_clear_page_writeback+0x3d/0xe0 (20)
 [<c012d7bc>] _rw_mutex_write_lock_irqsave+0xc/0x10 (56)
 [<c013b98d>] test_clear_page_writeback+0x3d/0xe0 (4)
 [<c01572c0>] end_buffer_async_write+0x70/0x140 (8)
 [<c0134e59>] end_page_writeback+0x29/0x70 (28)
 [<c01572c8>] end_buffer_async_write+0x78/0x140 (20)
 [<c015ab9d>] bio_destructor+0x3d/0x90 (16)
 [<c015ae0d>] bio_put+0x3d/0x80 (24)
 [<c015a409>] end_bio_bh_io_sync+0x39/0x50 (20)
 [<c015bad3>] bio_endio+0x53/0x80 (16)
 [<c020f825>] __end_that_request_first+0x205/0x270 (28)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (16)
 [<c0239368>] __ide_end_request+0x78/0x1c0 (36)
 [<c0239515>] ide_end_request+0x65/0xc0 (36)
 [<c024226b>] ide_dma_intr+0x8b/0xb0 (36)
 [<c02421e0>] ide_dma_intr+0x0/0xb0 (20)
 [<c023b0b1>] ide_intr+0xe1/0x170 (4)
 [<c0133624>] handle_IRQ_event+0x44/0x80 (32)
 [<c0133dc3>] do_hardirq+0x63/0x100 (32)
 [<c0133e60>] do_irqd+0x0/0xd0 (32)
 [<c0133ef9>] do_irqd+0x99/0xd0 (4)
 [<c012ca7a>] kthread+0xaa/0xb0 (28)
 [<c012c9d0>] kthread+0x0/0xb0 (28)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
IRQ 1         [c7e1d1a0]D 00000000     0   741     10           779
709 (L-TLB)
00000015 00000000 00000000 00000000 c01fdff0 c1187200 00000046 00000000 
       00000000 15468ae0 00000001 c7e39de0 00000000 c0133624 00000001
c03e81c0 
       00000000 c0398ae0 00000001 c7e30000 00000000 c0133dc3 00000001
00000000 
Call Trace:
 [<c01fdff0>] i8042_interrupt+0xc0/0x1a0 (20)
 [<c0133624>] handle_IRQ_event+0x44/0x80 (36)
 [<c0133dc3>] do_hardirq+0x63/0x100 (32)
 [<c0133e60>] do_irqd+0x0/0xd0 (32)
 [<c0133ef9>] do_irqd+0x99/0xd0 (4)
 [<c012ca7a>] kthread+0xaa/0xb0 (28)
 [<c012c9d0>] kthread+0x0/0xb0 (28)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
kjournald     [c7e1cbf0]T C03D9540     0   778      1           929
666 (L-TLB)
c7e43d68 00000046 c7e1cbf0 c03d9540 00000000 c212b8c0 00000246 c7e1cbf0 
       c7e1cbf0 00000001 c7f75580 c012cf9e c53879f0 0000068b ae093765
00000191 
       c7e1cda4 c7e42000 c7f75580 c7e43df4 c7e43d8c c02d49fb c7f75414
00000001 
Call Trace:
 [<c012cf9e>] prepare_to_wait+0x5e/0x80 (48)
 [<c02d49fb>] schedule+0x3b/0x130 (40)
 [<c01adf3b>] journal_commit_transaction+0x156b/0x16c0 (12)
 [<c01adf40>] journal_commit_transaction+0x1570/0x16c0 (24)
 [<c012d0b0>] autoremove_wake_function+0x0/0x60 (88)
 [<c0133624>] handle_IRQ_event+0x44/0x80 (12)
 [<c01cbde2>] __delay+0x12/0x20 (8)
 [<c012d0b0>] autoremove_wake_function+0x0/0x60 (12)
 [<c02d4671>] __schedule+0x2d1/0x620 (136)
 [<c02d4b45>] preempt_schedule+0x55/0x70 (8)
 [<c02d4b45>] preempt_schedule+0x55/0x70 (72)
 [<c012d08f>] finish_wait+0x4f/0x70 (8)
 [<c01b0bf6>] kjournald+0xf6/0x280 (24)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c01b0bf6>] kjournald+0xf6/0x280 (12)
 [<c01b0c0c>] kjournald+0x10c/0x280 (24)
 [<c012d0b0>] autoremove_wake_function+0x0/0x60 (40)
 [<c0119910>] exit_notify+0x350/0x980 (12)
 [<c012d0b0>] autoremove_wake_function+0x0/0x60 (20)
 [<c0105f02>] ret_from_fork+0x6/0x14 (68)
 [<c01b0b00>] kjournald+0x0/0x280 (8)
 [<c01b0ae0>] commit_timeout+0x0/0x10 (8)
 [<c01b0b00>] kjournald+0x0/0x280 (20)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
IRQ 4         [c7e1c640]D C03D9540     0   779     10           994
741 (L-TLB)
c7e8df80 00000046 c7e1c640 c03d9540 c03e8300 00000002 00000000 00000001 
       00000060 c7e4b5e0 00000000 00000000 c682ccf0 00000505 16bd0447
0000000b 
       c7e1c7f4 c7e8c000 c0398c00 c0398c00 c7e8dfa4 c02d49fb 00000004
c0398c00 
Call Trace:
 [<c02d49fb>] schedule+0x3b/0x130 (88)
 [<c0133e60>] do_irqd+0x0/0xd0 (32)
 [<c0133f08>] do_irqd+0xa8/0xd0 (4)
 [<c012ca7a>] kthread+0xaa/0xb0 (28)
 [<c012c9d0>] kthread+0x0/0xb0 (28)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
kjournald     [c135a680]T C03D9540     0   929      1          1135
778 (L-TLB)
c787dcdc 00000046 c135a680 c03d9540 00000246 c1100570 00000246 c135a680 
       00000000 c135a834 c787c000 ffffffff c135a680 000002c4 66b1a4ec
0000019d 
       c135a834 c787c000 00000000 c787dd68 c787dd00 c02d49fb c036f180
00000001 
Call Trace:
 [<c02d49fb>] schedule+0x3b/0x130 (88)
 [<c020d46f>] blk_backing_dev_unplug+0x1f/0x30 (12)
 [<c020d431>] generic_unplug_device+0x21/0x40 (12)
 [<c02d559e>] io_schedule+0xe/0x20 (12)
 [<c0156701>] sync_buffer+0x31/0x50 (8)
 [<c02d57e7>] __wait_on_bit+0x67/0x70 (12)
 [<c01566d0>] sync_buffer+0x0/0x50 (8)
 [<c01566d0>] sync_buffer+0x0/0x50 (16)
 [<c02d5883>] out_of_line_wait_on_bit+0x93/0xa0 (4)
 [<c012d110>] wake_bit_function+0x0/0x60 (28)
 [<c012d110>] wake_bit_function+0x0/0x60 (32)
 [<c01ad908>] journal_commit_transaction+0xf38/0x16c0 (32)
 [<c01cbde2>] __delay+0x12/0x20 (84)
 [<c888d031>] lpptest_irq+0x31/0x50 [lpptest] (8)
 [<c0133624>] handle_IRQ_event+0x44/0x80 (8)
 [<c0133775>] __do_IRQ+0x115/0x160 (32)
 [<c0112f7f>] scheduler_tick+0x1f/0x470 (60)
 [<c01127d8>] recalc_task_prio+0xa8/0x1a0 (12)
 [<c02d4671>] __schedule+0x2d1/0x620 (52)
 [<c02d4b45>] preempt_schedule+0x55/0x70 (8)
 [<c02d4b45>] preempt_schedule+0x55/0x70 (72)
 [<c012d08f>] finish_wait+0x4f/0x70 (8)
 [<c01b0bf6>] kjournald+0xf6/0x280 (24)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c01b0bf6>] kjournald+0xf6/0x280 (12)
 [<c01b0c0c>] kjournald+0x10c/0x280 (24)
 [<c012d0b0>] autoremove_wake_function+0x0/0x60 (40)
 [<c012d0b0>] autoremove_wake_function+0x0/0x60 (32)
 [<c0105f02>] ret_from_fork+0x6/0x14 (68)
 [<c01b0b00>] kjournald+0x0/0x280 (8)
 [<c01b0ae0>] commit_timeout+0x0/0x10 (8)
 [<c01b0b00>] kjournald+0x0/0x280 (20)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
IRQ 3         [c135b1e0]D C03D9540     0   994     10          1282
779 (L-TLB)
c1379f80 00000046 c135b1e0 c03d9540 c03e82d0 00000002 00000001 00000001 
       00000060 c7e4bd20 00000000 00000000 c7d04c10 00002227 b5d387fe
00000009 
       c135b394 c1378000 c0398ba0 c0398ba0 c1379fa4 c02d49fb 00000003
c0398ba0 
Call Trace:
 [<c02d49fb>] schedule+0x3b/0x130 (88)
 [<c0133e60>] do_irqd+0x0/0xd0 (32)
 [<c0133f08>] do_irqd+0xa8/0xd0 (4)
 [<c012ca7a>] kthread+0xaa/0xb0 (28)
 [<c012c9d0>] kthread+0x0/0xb0 (28)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
portmap       [c7e1c090]D C03D9540     0  1135      1          1199
929 (NOTLB)
c7cd5eb8 00000086 c7e1c090 c03d9540 c7e1c090 00000282 c0328040 00000282 
       00000000 00000000 00000246 00000246 c7e1c090 000202dc efd174bd
0000000a 
       c7e1c244 c7cd4000 7fffffff c7cd5f68 c7cd5edc c02d49fb c77fb028
c12caa78 
Call Trace:
 [<c02d49fb>] schedule+0x3b/0x130 (88)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (24)
 [<c02d56c4>] schedule_timeout+0xd4/0xe0 (12)
 [<c0292b97>] tcp_poll+0x37/0x190 (12)
 [<c015647b>] fget+0x4b/0x70 (20)
 [<c02674a9>] sock_poll+0x29/0x40 (28)
 [<c016a5ab>] do_pollfd+0x5b/0xa0 (20)
 [<c016a698>] do_poll+0xa8/0xd0 (28)
 [<c016a821>] sys_poll+0x161/0x240 (48)
 [<c0169b60>] __pollwait+0x0/0xd0 (36)
 [<c010602b>] syscall_call+0x7/0xb (32)
syslogd       [c78600f0]T C03D9540     0  1199      1          1206
1135 (NOTLB)
c78afc7c 00000086 c78600f0 c03d9540 00000000 c7f7547c 00000246 c78600f0 
       c78600f0 00000001 c7f7547c c012cf9e 00000282 00008fb6 2ad9eccb
00000239 
       c78602a4 c78ae000 00000000 c78afd18 c78afca0 c02d49fb c7f75414
00000001 
Call Trace:
 [<c012cf9e>] prepare_to_wait+0x5e/0x80 (48)
 [<c02d49fb>] schedule+0x3b/0x130 (40)
 [<c01a9891>] start_this_handle+0x2a1/0x410 (12)
 [<c01a9896>] start_this_handle+0x2a6/0x410 (24)
 [<c013ee9c>] kmem_cache_alloc+0x4c/0xe0 (56)
 [<c012d0b0>] autoremove_wake_function+0x0/0x60 (16)
 [<c012d0b0>] autoremove_wake_function+0x0/0x60 (32)
 [<c01a9b1b>] journal_start+0xcb/0xf0 (40)
 [<c0107deb>] do_IRQ+0x2b/0x40 (20)
 [<c019d3e9>] ext3_dirty_inode+0x39/0x90 (16)
 [<c01786a6>] __mark_inode_dirty+0x1e6/0x1f0 (24)
 [<c0136c83>] remove_suid+0x3/0x90 (16)
 [<c0133775>] __do_IRQ+0x115/0x160 (20)
 [<c0171f50>] inode_update_time+0xd0/0xe0 (24)
 [<c01377f0>] generic_file_aio_write_nolock+0x230/0x4c0 (48)
 [<c0137b23>] generic_file_write_nolock+0xa3/0xc0 (100)
 [<c012d0b0>] autoremove_wake_function+0x0/0x60 (112)
 [<c0105e5d>] do_signal+0xcd/0x130 (16)
 [<c0137e14>] generic_file_writev+0x44/0xb0 (24)
 [<c0155a0c>] do_readv_writev+0x22c/0x280 (44)
 [<c0155360>] do_sync_write+0x0/0xf0 (40)
 [<c01cbde2>] __delay+0x12/0x20 (52)
 [<c888d031>] lpptest_irq+0x31/0x50 [lpptest] (8)
 [<c0155b28>] vfs_writev+0x58/0x70 (24)
 [<c0155c11>] sys_writev+0x51/0x80 (24)
 [<c010602b>] syscall_call+0x7/0xb (40)
klogd         [c7d04c10]D C03D9540     0  1206      1          1214
1199 (NOTLB)
c7d15d08 00000082 c7d04c10 c03d9540 00000060 00000246 c7d04c10 c032829c 
       c0327ff4 000000d0 00000000 00000001 c113d6f0 00089689 bda57400
000002a9 
       c7d04dc4 c7d14000 7fffffff 00000001 c7d15d2c c02d49fb c7d14000
c7d14000 
Call Trace:
 [<c02d49fb>] schedule+0x3b/0x130 (88)
 [<c02d56c4>] schedule_timeout+0xd4/0xe0 (36)
 [<c012d01d>] prepare_to_wait_exclusive+0x5d/0x80 (32)
 [<c02c7a7e>] unix_wait_for_peer+0xae/0xe0 (28)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c02c7a7e>] unix_wait_for_peer+0xae/0xe0 (12)
 [<c02c7aa7>] unix_wait_for_peer+0xd7/0xe0 (24)
 [<c012d0b0>] autoremove_wake_function+0x0/0x60 (16)
 [<c01cc432>] copy_from_user+0x42/0x70 (12)
 [<c012d0b0>] autoremove_wake_function+0x0/0x60 (20)
 [<c02c85a2>] unix_dgram_sendmsg+0x282/0x5f0 (40)
 [<c0134fde>] find_get_page+0x3e/0x50 (48)
 [<c0145f51>] do_no_page+0x1b1/0x3b0 (32)
 [<c0266fa6>] sock_aio_write+0xf6/0x120 (20)
 [<c0145f51>] do_no_page+0x1b1/0x3b0 (28)
 [<c0155417>] do_sync_write+0xb7/0xf0 (84)
 [<c01118e9>] do_page_fault+0x409/0x610 (24)
 [<c01118e9>] do_page_fault+0x409/0x610 (4)
 [<c012d0b0>] autoremove_wake_function+0x0/0x60 (88)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c015554f>] vfs_write+0xff/0x130 (36)
 [<c0155651>] sys_write+0x51/0x80 (44)
 [<c010602b>] syscall_call+0x7/0xb (40)
inetd         [c135b790]D C03D9540     0  1214      1          1218
1206 (NOTLB)
c135de5c 00000082 c135b790 c03d9540 00000292 00000292 c0328040 00000292 
       c0139999 0000000d 00000246 c135b790 c135a0d0 000d1e8d 3dd989aa
0000000a 
       c135b944 c135c000 7fffffff 0000000e c135de80 c02d49fb c012ce1f
c7661ae4 
Call Trace:
 [<c0139999>] buffered_rmqueue+0x89/0xf0 (36)
 [<c02d49fb>] schedule+0x3b/0x130 (52)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (4)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c02d56c4>] schedule_timeout+0xd4/0xe0 (20)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (16)
 [<c0292b97>] tcp_poll+0x37/0x190 (24)
 [<c015647b>] fget+0x4b/0x70 (20)
 [<c02674a9>] sock_poll+0x29/0x40 (28)
 [<c0169ec7>] do_select+0x197/0x2f0 (20)
 [<c0169b60>] __pollwait+0x0/0xd0 (84)
 [<c016a33b>] sys_select+0x2db/0x4f0 (32)
 [<c010602b>] syscall_call+0x7/0xb (92)
lpd           [c78606a0]D C03D9540     0  1218      1          1272
1214 (NOTLB)
c78cde5c 00000086 c78606a0 c03d9540 c10ed420 c0327ff4 c01c9988 c0328040 
       00000001 00000006 00000246 c78606a0 00000286 00085c44 51ea0297
0000000a 
       c7860854 c78cc000 7fffffff 00000007 c78cde80 c02d49fb c012ce1f
c7661364 
Call Trace:
 [<c01c9988>] up_write_mutex+0x38/0xc0 (28)
 [<c02d49fb>] schedule+0x3b/0x130 (60)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (4)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c02d56c4>] schedule_timeout+0xd4/0xe0 (20)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (16)
 [<c0292b97>] tcp_poll+0x37/0x190 (24)
 [<c015647b>] fget+0x4b/0x70 (20)
 [<c02674a9>] sock_poll+0x29/0x40 (28)
 [<c0169ec7>] do_select+0x197/0x2f0 (20)
 [<c0169b60>] __pollwait+0x0/0xd0 (84)
 [<c016a33b>] sys_select+0x2db/0x4f0 (32)
 [<c0148d72>] sys_munmap+0x42/0x50 (68)
 [<c010602b>] syscall_call+0x7/0xb (24)
nfsd          [c76d37f0]D C03D9540     0  1272      1          1273
1218 (L-TLB)
c76e1eb0 00000046 c76d37f0 c03d9540 00000246 c76d37f0 00000001 c76e1ef8 
       c012007c c0326060 c76e1ef8 c01c9988 c76d3240 000046bc a7bad305
0000000a 
       c76d39a4 c76e0000 c76e1eec c76fd278 c76e1ed4 c02d49fb 00000292
c79c1b14 
Call Trace:
 [<c012007c>] __mod_timer+0x11c/0x1e0 (36)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c02d49fb>] schedule+0x3b/0x130 (40)
 [<c02d5678>] schedule_timeout+0x88/0xe0 (36)
 [<c883f907>] svc_recv+0x3a7/0x540 [sunrpc] (60)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c0120d30>] process_timeout+0x0/0x10 (8)
 [<c883f910>] svc_recv+0x3b0/0x540 [sunrpc] (28)
 [<c02d4b45>] preempt_schedule+0x55/0x70 (16)
 [<c0113460>] default_wake_function+0x0/0x30 (20)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c0113460>] default_wake_function+0x0/0x30 (20)
 [<c0123e7d>] sigprocmask+0x6d/0xe0 (16)
 [<c8865359>] nfsd+0x109/0x3c0 [nfsd] (24)
 [<c8865250>] nfsd+0x0/0x3c0 [nfsd] (48)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
nfsd          [c76d3240]D C03D9540     0  1273      1          1274
1272 (L-TLB)
c76e3eb0 00000046 c76d3240 c03d9540 00000246 c76d3240 00000001 c76e3ef8 
       c012007c c0326060 c76e3ef8 c01c9988 c76d2130 00002394 a7baf699
0000000a 
       c76d33f4 c76e2000 c76e3eec c76fd278 c76e3ed4 c02d49fb 00000292
00000000 
Call Trace:
 [<c012007c>] __mod_timer+0x11c/0x1e0 (36)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c02d49fb>] schedule+0x3b/0x130 (40)
 [<c02d5678>] schedule_timeout+0x88/0xe0 (36)
 [<c883f907>] svc_recv+0x3a7/0x540 [sunrpc] (60)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c0120d30>] process_timeout+0x0/0x10 (8)
 [<c883f910>] svc_recv+0x3b0/0x540 [sunrpc] (28)
 [<c02d4b45>] preempt_schedule+0x55/0x70 (16)
 [<c0113460>] default_wake_function+0x0/0x30 (20)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c0113460>] default_wake_function+0x0/0x30 (20)
 [<c0123e7d>] sigprocmask+0x6d/0xe0 (16)
 [<c8865359>] nfsd+0x109/0x3c0 [nfsd] (24)
 [<c8865250>] nfsd+0x0/0x3c0 [nfsd] (48)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
nfsd          [c76d2130]D C03D9540     0  1274      1          1275
1273 (L-TLB)
c6c33eb0 00000046 c76d2130 c03d9540 00000246 c76d2130 00000001 c6c33ef8 
       c012007c c0326060 c6c33ef8 c01c9988 c76d26e0 000020ea a7bb1783
0000000a 
       c76d22e4 c6c32000 c6c33eec c76fd278 c6c33ed4 c02d49fb 00000292
00000000 
Call Trace:
 [<c012007c>] __mod_timer+0x11c/0x1e0 (36)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c02d49fb>] schedule+0x3b/0x130 (40)
 [<c02d5678>] schedule_timeout+0x88/0xe0 (36)
 [<c883f907>] svc_recv+0x3a7/0x540 [sunrpc] (60)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c0120d30>] process_timeout+0x0/0x10 (8)
 [<c883f910>] svc_recv+0x3b0/0x540 [sunrpc] (28)
 [<c02d4b45>] preempt_schedule+0x55/0x70 (16)
 [<c0113460>] default_wake_function+0x0/0x30 (20)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c0113460>] default_wake_function+0x0/0x30 (20)
 [<c0123e7d>] sigprocmask+0x6d/0xe0 (16)
 [<c8865359>] nfsd+0x109/0x3c0 [nfsd] (24)
 [<c8865250>] nfsd+0x0/0x3c0 [nfsd] (48)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
nfsd          [c76d26e0]D C03D9540     0  1275      1          1276
1274 (L-TLB)
c73fbeb0 00000046 c76d26e0 c03d9540 00000246 c76d26e0 00000001 c73fbef8 
       c012007c c0326060 c73fbef8 c01c9988 c76d2c90 000020ea a7bb386d
0000000a 
       c76d2894 c73fa000 c73fbeec c76fd278 c73fbed4 c02d49fb 00000292
00000000 
Call Trace:
 [<c012007c>] __mod_timer+0x11c/0x1e0 (36)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c02d49fb>] schedule+0x3b/0x130 (40)
 [<c02d5678>] schedule_timeout+0x88/0xe0 (36)
 [<c883f907>] svc_recv+0x3a7/0x540 [sunrpc] (60)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c0120d30>] process_timeout+0x0/0x10 (8)
 [<c883f910>] svc_recv+0x3b0/0x540 [sunrpc] (28)
 [<c02d4b45>] preempt_schedule+0x55/0x70 (16)
 [<c0113460>] default_wake_function+0x0/0x30 (20)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c0113460>] default_wake_function+0x0/0x30 (20)
 [<c0123e7d>] sigprocmask+0x6d/0xe0 (16)
 [<c8865359>] nfsd+0x109/0x3c0 [nfsd] (24)
 [<c8865250>] nfsd+0x0/0x3c0 [nfsd] (48)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
nfsd          [c76d2c90]D C03D9540     0  1276      1          1277
1275 (L-TLB)
c73c3eb0 00000046 c76d2c90 c03d9540 00000246 c76d2c90 00000001 c73c3ef8 
       c012007c c0326060 c73c3ef8 c01c9988 c6c4b810 0000221b a7bb5a88
0000000a 
       c76d2e44 c73c2000 c73c3eec c76fd278 c73c3ed4 c02d49fb 00000292
00000000 
Call Trace:
 [<c012007c>] __mod_timer+0x11c/0x1e0 (36)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c02d49fb>] schedule+0x3b/0x130 (40)
 [<c02d5678>] schedule_timeout+0x88/0xe0 (36)
 [<c883f907>] svc_recv+0x3a7/0x540 [sunrpc] (60)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c0120d30>] process_timeout+0x0/0x10 (8)
 [<c883f910>] svc_recv+0x3b0/0x540 [sunrpc] (28)
 [<c02d4b45>] preempt_schedule+0x55/0x70 (16)
 [<c0113460>] default_wake_function+0x0/0x30 (20)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c0113460>] default_wake_function+0x0/0x30 (20)
 [<c0123e7d>] sigprocmask+0x6d/0xe0 (16)
 [<c8865359>] nfsd+0x109/0x3c0 [nfsd] (24)
 [<c8865250>] nfsd+0x0/0x3c0 [nfsd] (48)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
nfsd          [c6c4b810]D C03D9540     0  1277      1          1278
1276 (L-TLB)
c6c4deb0 00000046 c6c4b810 c03d9540 00000246 c6c4b810 00000001 c6c4def8 
       c012007c c0326060 c6c4def8 c01c9988 c6c4b260 0000189c a7bbaf55
0000000a 
       c6c4b9c4 c6c4c000 c6c4deec c76fd278 c6c4ded4 c02d49fb 00000292
00000000 
Call Trace:
 [<c012007c>] __mod_timer+0x11c/0x1e0 (36)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c02d49fb>] schedule+0x3b/0x130 (40)
 [<c02d5678>] schedule_timeout+0x88/0xe0 (36)
 [<c883f907>] svc_recv+0x3a7/0x540 [sunrpc] (60)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c0120d30>] process_timeout+0x0/0x10 (8)
 [<c883f910>] svc_recv+0x3b0/0x540 [sunrpc] (28)
 [<c0113460>] default_wake_function+0x0/0x30 (36)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c0113460>] default_wake_function+0x0/0x30 (20)
 [<c0123e7d>] sigprocmask+0x6d/0xe0 (16)
 [<c8865359>] nfsd+0x109/0x3c0 [nfsd] (24)
 [<c8865250>] nfsd+0x0/0x3c0 [nfsd] (48)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
nfsd          [c6c4b260]D C03D9540     0  1278      1          1279
1277 (L-TLB)
c7113eb0 00000046 c6c4b260 c03d9540 00000246 c6c4b260 00000001 c7113ef8 
       c012007c c0326060 c7113ef8 c01c9988 c7113ef8 000032c2 ab0b7866
0000000a 
       c6c4b414 c7112000 c7113eec c76fd278 c7113ed4 c02d49fb 00000292
c79c1b14 
Call Trace:
 [<c012007c>] __mod_timer+0x11c/0x1e0 (36)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c02d49fb>] schedule+0x3b/0x130 (40)
 [<c02d5678>] schedule_timeout+0x88/0xe0 (36)
 [<c883f907>] svc_recv+0x3a7/0x540 [sunrpc] (60)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c0120d30>] process_timeout+0x0/0x10 (8)
 [<c883f910>] svc_recv+0x3b0/0x540 [sunrpc] (28)
 [<c0113460>] default_wake_function+0x0/0x30 (36)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c0113460>] default_wake_function+0x0/0x30 (20)
 [<c0123e7d>] sigprocmask+0x6d/0xe0 (16)
 [<c8865359>] nfsd+0x109/0x3c0 [nfsd] (24)
 [<c8865250>] nfsd+0x0/0x3c0 [nfsd] (48)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
nfsd          [c6c4acb0]D C03D9540     0  1279      1          1281
1278 (L-TLB)
c6cbbeb0 00000046 c6c4acb0 c03d9540 00000246 c6c4acb0 00000001 c6cbbef8 
       c012007c c0326060 c6cbbef8 c01c9988 c6c4b260 00018d87 ab0b45a4
0000000a 
       c6c4ae64 c6cba000 c6cbbeec c76fd278 c6cbbed4 c02d49fb 00000292
c01c9988 
Call Trace:
 [<c012007c>] __mod_timer+0x11c/0x1e0 (36)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c02d49fb>] schedule+0x3b/0x130 (40)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (8)
 [<c02d5678>] schedule_timeout+0x88/0xe0 (28)
 [<c883f907>] svc_recv+0x3a7/0x540 [sunrpc] (60)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c0120d30>] process_timeout+0x0/0x10 (8)
 [<c883f910>] svc_recv+0x3b0/0x540 [sunrpc] (28)
 [<c0113460>] default_wake_function+0x0/0x30 (36)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c0113460>] default_wake_function+0x0/0x30 (20)
 [<c0123e7d>] sigprocmask+0x6d/0xe0 (16)
 [<c8865359>] nfsd+0x109/0x3c0 [nfsd] (24)
 [<c8865250>] nfsd+0x0/0x3c0 [nfsd] (48)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
lockd         [c6c4a700]D C03D9540     0  1281      1          1285
1279 (L-TLB)
c6c8becc 00000046 c6c4a700 c03d9540 c6c8be8c c6c8be8c c79c0108 00000246 
       c6c4a700 00000000 00000000 00000000 c76d37f0 00005dec a7b980d4
0000000a 
       c6c4a8b4 c6c8a000 7fffffff c76fd178 c6c8bef0 c02d49fb c01c9988
c79c0114 
Call Trace:
 [<c02d49fb>] schedule+0x3b/0x130 (88)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (4)
 [<c02d56c4>] schedule_timeout+0xd4/0xe0 (32)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (36)
 [<c883f907>] svc_recv+0x3a7/0x540 [sunrpc] (24)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c883f907>] svc_recv+0x3a7/0x540 [sunrpc] (12)
 [<c883f910>] svc_recv+0x3b0/0x540 [sunrpc] (24)
 [<c0113460>] default_wake_function+0x0/0x30 (36)
 [<c01ca189>] up+0x69/0xc0 (20)
 [<c0113460>] default_wake_function+0x0/0x30 (12)
 [<c8a0e574>] lockd+0x134/0x2b0 [lockd] (40)
 [<c8a0e440>] lockd+0x0/0x2b0 [lockd] (20)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
rpciod/0      [c6c4a150]D C03D9540     0  1282     10          1471
994 (L-TLB)
c6c65f20 00000046 c6c4a150 c03d9540 0000000a 00000000 00000246 c6c4a150 
       00000246 c6c4a150 00000001 c75295dc c6c4a700 00001be9 a7b922e8
0000000a 
       c6c4a304 c6c64000 c75295a0 c6c65f94 c6c65f44 c02d49fb c6c65f94
c75295dc 
Call Trace:
 [<c02d49fb>] schedule+0x3b/0x130 (88)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (12)
 [<c0127fe8>] worker_thread+0x258/0x280 (24)
 [<c0113460>] default_wake_function+0x0/0x30 (52)
 [<c0113460>] default_wake_function+0x0/0x30 (32)
 [<c0127d90>] worker_thread+0x0/0x280 (36)
 [<c012ca7a>] kthread+0xaa/0xb0 (4)
 [<c012c9d0>] kthread+0x0/0xb0 (28)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
rpc.mountd    [c6f49830]D C03D9540     0  1285      1          1309
1281 (NOTLB)
c6f4be5c 00000082 c6f49830 c03d9540 c10de0e0 c0327ff4 c01c9988 c0328040 
       00000001 00000004 00000246 c6f49830 c135a0d0 00082460 af6c86af
0000000a 
       c6f499e4 c6f4a000 7fffffff 00000005 c6f4be80 c02d49fb c012ce1f
c6d47884 
Call Trace:
 [<c01c9988>] up_write_mutex+0x38/0xc0 (28)
 [<c02d49fb>] schedule+0x3b/0x130 (60)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (4)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c02d56c4>] schedule_timeout+0xd4/0xe0 (20)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (16)
 [<c0292b97>] tcp_poll+0x37/0x190 (24)
 [<c015647b>] fget+0x4b/0x70 (20)
 [<c02674a9>] sock_poll+0x29/0x40 (28)
 [<c0169ec7>] do_select+0x197/0x2f0 (20)
 [<c0169b60>] __pollwait+0x0/0xd0 (84)
 [<c016a33b>] sys_select+0x2db/0x4f0 (32)
 [<c010602b>] syscall_call+0x7/0xb (92)
sshd          [c6f48cd0]D C03D9540     0  1309      1  1893    1315
1285 (NOTLB)
c6f71e5c 00000086 c6f48cd0 c03d9540 00000292 00000292 c0328040 00000292 
       c0139999 00000003 00000246 c6f48cd0 c6988800 0000944a fb0b23a8
0000005a 
       c6f48e84 c6f70000 7fffffff 00000004 c6f71e80 c02d49fb c012ce1f
c6d47604 
Call Trace:
 [<c0139999>] buffered_rmqueue+0x89/0xf0 (36)
 [<c02d49fb>] schedule+0x3b/0x130 (52)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (4)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c02d56c4>] schedule_timeout+0xd4/0xe0 (20)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (16)
 [<c0292b97>] tcp_poll+0x37/0x190 (24)
 [<c015647b>] fget+0x4b/0x70 (20)
 [<c02674a9>] sock_poll+0x29/0x40 (28)
 [<c0169ec7>] do_select+0x197/0x2f0 (20)
 [<c0169b60>] __pollwait+0x0/0xd0 (84)
 [<c016a33b>] sys_select+0x2db/0x4f0 (32)
 [<c02d4ba8>] preempt_schedule_irq+0x48/0x70 (72)
 [<c010602b>] syscall_call+0x7/0xb (20)
rpc.statd     [c6f49280]D C03D9540     0  1315      1          1318
1309 (NOTLB)
c70c7e5c 00000082 c6f49280 c03d9540 c10e0f80 c0327ff4 c01c9988 c0328040 
       00000001 00000006 00000246 c6f49280 00000286 0001de0e efe0198d
0000000a 
       c6f49434 c70c6000 7fffffff 00000007 c70c7e80 c02d49fb c012ce1f
c6fc6b24 
Call Trace:
 [<c01c9988>] up_write_mutex+0x38/0xc0 (28)
 [<c02d49fb>] schedule+0x3b/0x130 (60)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (4)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c02d56c4>] schedule_timeout+0xd4/0xe0 (20)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (16)
 [<c0292b97>] tcp_poll+0x37/0x190 (24)
 [<c015647b>] fget+0x4b/0x70 (20)
 [<c02674a9>] sock_poll+0x29/0x40 (28)
 [<c0169ec7>] do_select+0x197/0x2f0 (20)
 [<c0169b60>] __pollwait+0x0/0xd0 (84)
 [<c016a33b>] sys_select+0x2db/0x4f0 (32)
 [<c010602b>] syscall_call+0x7/0xb (92)
atd           [c6f48720]D C03D9540     0  1318      1          1321
1315 (NOTLB)
c6f97ef8 00000086 c6f48720 c03d9540 00000246 c6f48720 00000001 c6f97f40 
       c012007c c0326060 c6f97f40 c01c9988 c7d040b0 000313e4 f3b1a1b5
0000000a 
       c6f488d4 c6f96000 c6f97f34 000f41a7 c6f97f1c c02d49fb 00000282
00000246 
Call Trace:
 [<c012007c>] __mod_timer+0x11c/0x1e0 (36)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c02d49fb>] schedule+0x3b/0x130 (40)
 [<c02d5678>] schedule_timeout+0x88/0xe0 (36)
 [<c0123e7d>] sigprocmask+0x6d/0xe0 (64)
 [<c0120d30>] process_timeout+0x0/0x10 (16)
 [<c0120e2e>] sys_nanosleep+0xde/0x170 (28)
 [<c010602b>] syscall_call+0x7/0xb (52)
cron          [c6f48170]T C03D9540     0  1321      1          1327
1318 (NOTLB)
c680fce0 00000082 c6f48170 c03d9540 00000246 c1100508 00000246 c6f48170 
       00000000 00000000 c7ffb680 00000000 c553ec50 00036951 3041657d
00000192 
       c6f48324 c680e000 00000000 c680fd6c c680fd04 c02d49fb c036f180
00000001 
Call Trace:
 [<c02d49fb>] schedule+0x3b/0x130 (88)
 [<c020d46f>] blk_backing_dev_unplug+0x1f/0x30 (12)
 [<c020d431>] generic_unplug_device+0x21/0x40 (12)
 [<c02d559e>] io_schedule+0xe/0x20 (12)
 [<c0156701>] sync_buffer+0x31/0x50 (8)
 [<c02d57e7>] __wait_on_bit+0x67/0x70 (12)
 [<c01566d0>] sync_buffer+0x0/0x50 (8)
 [<c01566d0>] sync_buffer+0x0/0x50 (16)
 [<c02d5883>] out_of_line_wait_on_bit+0x93/0xa0 (4)
 [<c012d110>] wake_bit_function+0x0/0x60 (28)
 [<c012d110>] wake_bit_function+0x0/0x60 (32)
 [<c019e846>] ext3_find_entry+0x196/0x440 (32)
 [<c016f267>] d_alloc+0x1b7/0x240 (40)
 [<c016f6f7>] __d_lookup+0x97/0x130 (60)
 [<c019ed71>] ext3_lookup+0x41/0xd0 (40)
 [<c0163955>] real_lookup+0xd5/0x100 (28)
 [<c0163cd6>] do_lookup+0x96/0xb0 (32)
 [<c01644dc>] link_path_walk+0x7ec/0xfc0 (32)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (48)
 [<c0164fd9>] path_lookup+0x99/0x1b0 (36)
 [<c01652b3>] __user_walk+0x33/0x60 (28)
 [<c015f78f>] vfs_stat+0x1f/0x60 (28)
 [<c02d5682>] schedule_timeout+0x92/0xe0 (24)
 [<c015fedb>] sys_stat64+0x1b/0x40 (64)
 [<c0120d30>] process_timeout+0x0/0x10 (16)
 [<c0120e2e>] sys_nanosleep+0xde/0x170 (28)
 [<c010ae4a>] do_gettimeofday+0x1a/0xd0 (8)
 [<c011bd2b>] sys_time+0x1b/0x60 (20)
 [<c010602b>] syscall_call+0x7/0xb (24)
bash          [c7d04660]D C03D9540     0  1327      1 12577    1328
1321 (NOTLB)
c1233ef8 00000086 c7d04660 c03d9540 c13b07ec c7d04704 00000246 c7d04660 
       00000246 c7d04660 00000001 00000086 c012ce1f 0000ebf9 3ccd43c6
0000019c 
       c7d04814 c1232000 c7d04660 fffffe00 c1233f1c c02d49fb c0324d60
00000001 
Call Trace:
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (52)
 [<c02d49fb>] schedule+0x3b/0x130 (36)
 [<c011b42b>] do_wait+0x1bb/0x4f0 (12)
 [<c011b459>] do_wait+0x1e9/0x4f0 (24)
 [<c0113460>] default_wake_function+0x0/0x30 (44)
 [<c0123e7d>] sigprocmask+0x6d/0xe0 (20)
 [<c0113460>] default_wake_function+0x0/0x30 (12)
 [<c01cc3de>] copy_to_user+0x3e/0x50 (12)
 [<c011b82d>] sys_wait4+0x3d/0x50 (28)
 [<c011b865>] sys_waitpid+0x25/0x30 (24)
 [<c010602b>] syscall_call+0x7/0xb (20)
bash          [c7d040b0]D C03D9540     0  1328      1  2302    1329
1327 (NOTLB)
c1243ef8 00000086 c7d040b0 c03d9540 c78f282c c7d04154 00000246 c7d040b0 
       00000246 c7d040b0 00000001 00000086 c4d9f300 000802fc e5d1231c
00000064 
       c7d04264 c1242000 c7d040b0 fffffe00 c1243f1c c02d49fb c0324d60
00000001 
Call Trace:
 [<c02d49fb>] schedule+0x3b/0x130 (88)
 [<c011b42b>] do_wait+0x1bb/0x4f0 (12)
 [<c011b459>] do_wait+0x1e9/0x4f0 (24)
 [<c0113460>] default_wake_function+0x0/0x30 (44)
 [<c0123e7d>] sigprocmask+0x6d/0xe0 (20)
 [<c0113460>] default_wake_function+0x0/0x30 (12)
 [<c01cc3de>] copy_to_user+0x3e/0x50 (12)
 [<c011b82d>] sys_wait4+0x3d/0x50 (28)
 [<c011b865>] sys_waitpid+0x25/0x30 (24)
 [<c010602b>] syscall_call+0x7/0xb (20)
bash          [c135a0d0]T C03D9540     0  1329      1          1330
1328 (NOTLB)
c7847ce0 00000086 c135a0d0 c03d9540 00000246 c1100f98 00000246 c135a0d0 
       00000000 00000000 c7ffb680 00000000 00000246 00016576 95b0edcf
0000029e 
       c135a284 c7846000 00000000 c7847d6c c7847d04 c02d49fb c036f180
00000001 
Call Trace:
 [<c02d49fb>] schedule+0x3b/0x130 (88)
 [<c020d46f>] blk_backing_dev_unplug+0x1f/0x30 (12)
 [<c020d431>] generic_unplug_device+0x21/0x40 (12)
 [<c02d559e>] io_schedule+0xe/0x20 (12)
 [<c0156701>] sync_buffer+0x31/0x50 (8)
 [<c02d57e7>] __wait_on_bit+0x67/0x70 (12)
 [<c01566d0>] sync_buffer+0x0/0x50 (8)
 [<c01566d0>] sync_buffer+0x0/0x50 (16)
 [<c02d5883>] out_of_line_wait_on_bit+0x93/0xa0 (4)
 [<c012d110>] wake_bit_function+0x0/0x60 (28)
 [<c012d110>] wake_bit_function+0x0/0x60 (32)
 [<c019e846>] ext3_find_entry+0x196/0x440 (32)
 [<c016f267>] d_alloc+0x1b7/0x240 (40)
 [<c016f6f7>] __d_lookup+0x97/0x130 (60)
 [<c019ed71>] ext3_lookup+0x41/0xd0 (40)
 [<c0163955>] real_lookup+0xd5/0x100 (28)
 [<c0163cd6>] do_lookup+0x96/0xb0 (32)
 [<c0163e15>] link_path_walk+0x125/0xfc0 (32)
 [<c0164fd9>] path_lookup+0x99/0x1b0 (84)
 [<c01652b3>] __user_walk+0x33/0x60 (28)
 [<c015f78f>] vfs_stat+0x1f/0x60 (28)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (24)
 [<c012d5d7>] _mutex_lock_irq+0x17/0x20 (24)
 [<c01cc3de>] copy_to_user+0x3e/0x50 (20)
 [<c015fedb>] sys_stat64+0x1b/0x40 (20)
 [<c0123f76>] sys_rt_sigprocmask+0x86/0x120 (48)
 [<c010ae4a>] do_gettimeofday+0x1a/0xd0 (4)
 [<c01114e0>] do_page_fault+0x0/0x610 (28)
 [<c01061d5>] error_code+0x2d/0x38 (8)
 [<c010602b>] syscall_call+0x7/0xb (8)
getty         [c682d850]T C03D9540     0  1330      1          1331
1329 (NOTLB)
c682fd10 00000082 c682d850 c03d9540 00000246 c1101410 00000246 c682d850 
       00000000 00000000 c7ffb680 00000000 00000246 0003b5b2 e0ecd1d1
000002a0 
       c682da04 c682e000 00000000 c682fd9c c682fd34 c02d49fb c036f180
00000001 
Call Trace:
 [<c02d49fb>] schedule+0x3b/0x130 (88)
 [<c020d46f>] blk_backing_dev_unplug+0x1f/0x30 (12)
 [<c020d431>] generic_unplug_device+0x21/0x40 (12)
 [<c02d559e>] io_schedule+0xe/0x20 (12)
 [<c0156701>] sync_buffer+0x31/0x50 (8)
 [<c02d57e7>] __wait_on_bit+0x67/0x70 (12)
 [<c01566d0>] sync_buffer+0x0/0x50 (8)
 [<c01566d0>] sync_buffer+0x0/0x50 (16)
 [<c02d5883>] out_of_line_wait_on_bit+0x93/0xa0 (4)
 [<c012d110>] wake_bit_function+0x0/0x60 (28)
 [<c012d110>] wake_bit_function+0x0/0x60 (32)
 [<c019e846>] ext3_find_entry+0x196/0x440 (32)
 [<c016f267>] d_alloc+0x1b7/0x240 (40)
 [<c016f6f7>] __d_lookup+0x97/0x130 (60)
 [<c019ed71>] ext3_lookup+0x41/0xd0 (40)
 [<c0163955>] real_lookup+0xd5/0x100 (28)
 [<c0163cd6>] do_lookup+0x96/0xb0 (32)
 [<c01644dc>] link_path_walk+0x7ec/0xfc0 (32)
 [<c0164fd9>] path_lookup+0x99/0x1b0 (84)
 [<c0160990>] open_exec+0x30/0x100 (28)
 [<c01e7c76>] tty_write+0xb6/0x260 (4)
 [<c013ee9c>] kmem_cache_alloc+0x4c/0xe0 (24)
 [<c013ee9c>] kmem_cache_alloc+0x4c/0xe0 (24)
 [<c013ee9c>] kmem_cache_alloc+0x4c/0xe0 (24)
 [<c0161b13>] do_execve+0x13/0x260 (20)
 [<c0104b36>] sys_execve+0x46/0xb0 (36)
 [<c010602b>] syscall_call+0x7/0xb (32)
getty         [c682d2a0]D C03D9540     0  1331      1          1332
1330 (NOTLB)
c1281e10 00000082 c682d2a0 c03d9540 00000000 00000000 00000286 00000046 
       c682d2a0 c682d2a0 00000001 c0328040 c01391e3 0007b645 53bd158d
0000000b 
       c682d454 c1280000 7fffffff c1281f04 c1281e34 c02d49fb c01ca189
00000286 
Call Trace:
 [<c01391e3>] free_pages_bulk+0x1e3/0x300 (52)
 [<c02d49fb>] schedule+0x3b/0x130 (36)
 [<c01ca189>] up+0x69/0xc0 (4)
 [<c02d56c4>] schedule_timeout+0xd4/0xe0 (32)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (36)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (12)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (24)
 [<c01ed789>] read_chan+0x699/0x7a0 (24)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (20)
 [<c01e6c25>] tty_ldisc_try+0x45/0x60 (12)
 [<c0113460>] default_wake_function+0x0/0x30 (52)
 [<c01c9d6e>] down+0x2e/0x140 (12)
 [<c0113460>] default_wake_function+0x0/0x30 (20)
 [<c01e7b96>] tty_read+0xf6/0x120 (40)
 [<c0155522>] vfs_write+0xd2/0x130 (20)
 [<c01552e8>] vfs_read+0xb8/0x130 (24)
 [<c01555d1>] sys_read+0x51/0x80 (44)
 [<c010602b>] syscall_call+0x7/0xb (40)
getty         [c682ccf0]D C03D9540     0  1332      1         12175
1331 (NOTLB)
c1273e10 00000082 c682ccf0 c03d9540 00000000 00000000 00000286 00000046 
       c682ccf0 c682ccf0 00000001 c0328040 c7d04660 0007cdc6 539abfcc
0000000b 
       c682cea4 c1272000 7fffffff c1273f04 c1273e34 c02d49fb c01ca189
00000286 
Call Trace:
 [<c02d49fb>] schedule+0x3b/0x130 (88)
 [<c01ca189>] up+0x69/0xc0 (4)
 [<c02d56c4>] schedule_timeout+0xd4/0xe0 (32)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (36)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (12)
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (24)
 [<c01ed789>] read_chan+0x699/0x7a0 (24)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (20)
 [<c01e6c25>] tty_ldisc_try+0x45/0x60 (12)
 [<c0113460>] default_wake_function+0x0/0x30 (52)
 [<c01c9d6e>] down+0x2e/0x140 (12)
 [<c0113460>] default_wake_function+0x0/0x30 (20)
 [<c01e7b96>] tty_read+0xf6/0x120 (40)
 [<c0155522>] vfs_write+0xd2/0x130 (20)
 [<c01552e8>] vfs_read+0xb8/0x130 (24)
 [<c01555d1>] sys_read+0x51/0x80 (44)
 [<c010602b>] syscall_call+0x7/0xb (40)
IRQ 5         [c7860c50]R C03D9570     0  1471     10          1486
1282 (L-TLB)
c7a73f80 00000046 c113d140 c03d9570 000002ce c7a73f64 c0112932 c113d140 
       c03d9570 000002ce 8a5ae53c 000002ce c113d140 00000420 8a5ae838
000002ce 
       c7860e04 c7a72000 c0398c60 c0398c60 c7a73fa4 c02d49fb c0398c60
c7a73fa4 
Call Trace:
 [<c0112932>] activate_task+0x62/0x80 (28)
 [<c02d49fb>] schedule+0x3b/0x130 (60)
 [<c0112a83>] wake_up_process+0x23/0x30 (12)
 [<c0133e60>] do_irqd+0x0/0xd0 (20)
 [<c0133f08>] do_irqd+0xa8/0xd0 (4)
 [<c012ca7a>] kthread+0xaa/0xb0 (28)
 [<c012c9d0>] kthread+0x0/0xb0 (28)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
IRQ 7         [c7d051c0]D C03D9540     0  1486     10
1471 (L-TLB)
c6865f9c 00000046 c7d051c0 c03d9540 00000246 c7d051c0 00000001 c6aefea8 
       c0113652 00000296 c6865fc0 c01c9988 c7fd1710 000011a2 36d58ac6
00000023 
       c7d05374 c6864000 c6aefe9c c0398d20 c6865fc0 c02d49fb 00000296
00000001 
Call Trace:
 [<c0113652>] complete+0x52/0x60 (36)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c02d49fb>] schedule+0x3b/0x130 (40)
 [<c0133e60>] do_irqd+0x0/0xd0 (32)
 [<c012ca40>] kthread+0x70/0xb0 (4)
 [<c012c9d0>] kthread+0x0/0xb0 (28)
 [<c01040ed>] kernel_thread_helper+0x5/0x18 (16)
sshd          [c7d05770]D C03D9540     0  1893   1309  1896
(NOTLB)
c6aefcf0 00000082 c7d05770 c03d9540 00000001 c013f0dd c7f50ec0 c7f00ce4 
       c012d597 c7f50ec0 c7f00ce4 c013f0dd c62d67a0 00046315 fff1f1f7
0000005a 
       c7d05924 c6aee000 7fffffff c12cc9a0 c6aefd14 c02d49fb c0159141
00000000 
Call Trace:
 [<c013f0dd>] kmem_cache_free+0x4d/0xe0 (24)
 [<c012d597>] _mutex_lock+0x17/0x20 (12)
 [<c013f0dd>] kmem_cache_free+0x4d/0xe0 (12)
 [<c02d49fb>] schedule+0x3b/0x130 (40)
 [<c0159141>] __block_commit_write+0x91/0xc0 (4)
 [<c019a5b3>] ext3_journal_dirty_data+0x23/0x70 (8)
 [<c02d56c4>] schedule_timeout+0xd4/0xe0 (24)
 [<c012cf9e>] prepare_to_wait+0x5e/0x80 (32)
 [<c02c9112>] unix_stream_data_wait+0xd2/0x120 (28)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c02c9112>] unix_stream_data_wait+0xd2/0x120 (12)
 [<c02c9119>] unix_stream_data_wait+0xd9/0x120 (24)
 [<c012d0b0>] autoremove_wake_function+0x0/0x60 (20)
 [<c012d0b0>] autoremove_wake_function+0x0/0x60 (32)
 [<c02c95a2>] unix_stream_recvmsg+0x442/0x4a0 (16)
 [<c02c95b6>] unix_stream_recvmsg+0x456/0x4a0 (24)
 [<c0266e96>] sock_aio_read+0xf6/0x110 (116)
 [<c01551f7>] do_sync_read+0xb7/0xf0 (116)
 [<c012d6fd>] atomic_dec_and_mutex_lock+0x4d/0x70 (68)
 [<c012d6fd>] atomic_dec_and_mutex_lock+0x4d/0x70 (24)
 [<c012d56a>] __mutex_lock+0x2a/0x40 (12)
 [<c012d0b0>] autoremove_wake_function+0x0/0x60 (12)
 [<c016e423>] dput+0x33/0x2b0 (20)
 [<c015532f>] vfs_read+0xff/0x130 (28)
 [<c01555d1>] sys_read+0x51/0x80 (44)
 [<c010602b>] syscall_call+0x7/0xb (40)
sshd          [c135ac30]D C03D9540     0  1896   1893  1897
(NOTLB)
c5337e5c 00000086 c135ac30 c03d9540 00000000 00000292 c5337eb0 00000246 
       c135ac30 c56fdcc0 00000246 c135ac30 00000000 00012732 7bd4c399
000002a4 
       c135ade4 c5336000 7fffffff 0000000a c5337e80 c02d49fb c01c9988
c0363020 
Call Trace:
 [<c02d49fb>] schedule+0x3b/0x130 (88)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (4)
 [<c011354c>] __wake_up+0x4c/0x60 (12)
 [<c02d56c4>] schedule_timeout+0xd4/0xe0 (20)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c01e6d73>] tty_ldisc_deref+0x43/0xb0 (12)
 [<c01e6d73>] tty_ldisc_deref+0x43/0xb0 (24)
 [<c01e940b>] tty_poll+0x8b/0xc0 (24)
 [<c0169ec7>] do_select+0x197/0x2f0 (36)
 [<c0169b60>] __pollwait+0x0/0xd0 (84)
 [<c016a33b>] sys_select+0x2db/0x4f0 (32)
 [<c010602b>] syscall_call+0x7/0xb (92)
bash          [c4d8ed30]D C03D9540     0  1897   1896  2299
(NOTLB)
c4db5ef8 00000086 c4d8ed30 c03d9540 c64fbc2c c4d8edd4 00000246 c4d8ed30 
       00000246 c4d8ed30 00000001 00000086 c68bc8a0 00075636 3fecedf3
00000061 
       c4d8eee4 c4db4000 c4d8ed30 fffffe00 c4db5f1c c02d49fb c0324d60
00000001 
Call Trace:
 [<c02d49fb>] schedule+0x3b/0x130 (88)
 [<c011b42b>] do_wait+0x1bb/0x4f0 (12)
 [<c011b459>] do_wait+0x1e9/0x4f0 (24)
 [<c0113460>] default_wake_function+0x0/0x30 (44)
 [<c0123e7d>] sigprocmask+0x6d/0xe0 (20)
 [<c0113460>] default_wake_function+0x0/0x30 (12)
 [<c01cc3de>] copy_to_user+0x3e/0x50 (12)
 [<c011b82d>] sys_wait4+0x3d/0x50 (28)
 [<c011b865>] sys_waitpid+0x25/0x30 (24)
 [<c010602b>] syscall_call+0x7/0xb (20)
bash          [c5040130]D C03D9540     0  2299   1897 12578
(NOTLB)
c454def8 00000082 c5040130 c03d9540 c5735c4c c50401d4 00000246 c5040130 
       00000246 c5040130 00000001 00000086 c012ce1f 000066d2 abd7f311
0000019e 
       c50402e4 c454c000 c5040130 fffffe00 c454df1c c02d49fb c0324d60
00000001 
Call Trace:
 [<c012ce1f>] add_wait_queue+0x3f/0x50 (52)
 [<c02d49fb>] schedule+0x3b/0x130 (36)
 [<c011b42b>] do_wait+0x1bb/0x4f0 (12)
 [<c011b459>] do_wait+0x1e9/0x4f0 (24)
 [<c01127d8>] recalc_task_prio+0xa8/0x1a0 (20)
 [<c0113460>] default_wake_function+0x0/0x30 (24)
 [<c0123e7d>] sigprocmask+0x6d/0xe0 (20)
 [<c0113460>] default_wake_function+0x0/0x30 (12)
 [<c01cc3de>] copy_to_user+0x3e/0x50 (12)
 [<c011b82d>] sys_wait4+0x3d/0x50 (28)
 [<c011b865>] sys_waitpid+0x25/0x30 (24)
 [<c010602b>] syscall_call+0x7/0xb (20)
top           [c53fe150]T C03D9540     0  2302   1328
(NOTLB)
c5edbba8 00000082 c53fe150 c03d9540 00000246 00000000 00000246 c53fe150 
       00000000 00000000 c01127d8 42e4e86d c53fecb0 00006272 d78f69cb
00000190 
       c53fe304 c5eda000 c5edbc34 c1100508 c5edbbcc c02d49fb c036f180
00000001 
Call Trace:
 [<c01127d8>] recalc_task_prio+0xa8/0x1a0 (44)
 [<c02d49fb>] schedule+0x3b/0x130 (44)
 [<c020d46f>] blk_backing_dev_unplug+0x1f/0x30 (12)
 [<c020d431>] generic_unplug_device+0x21/0x40 (12)
 [<c02d559e>] io_schedule+0xe/0x20 (12)
 [<c0156701>] sync_buffer+0x31/0x50 (8)
 [<c02d58ee>] __wait_on_bit_lock+0x5e/0x70 (12)
 [<c01566d0>] sync_buffer+0x0/0x50 (8)
 [<c01566d0>] sync_buffer+0x0/0x50 (16)
 [<c02d5993>] out_of_line_wait_on_bit_lock+0x93/0xa0 (4)
 [<c012d110>] wake_bit_function+0x0/0x60 (28)
 [<c012d110>] wake_bit_function+0x0/0x60 (32)
 [<c0156758>] __lock_buffer+0x38/0x40 (32)
 [<c01aa804>] do_get_write_access+0x834/0x850 (12)
 [<c01583cb>] __getblk+0x2b/0x60 (72)
 [<c019c4ba>] ext3_get_inode_loc+0x5a/0x260 (28)
 [<c01aa857>] journal_get_write_access+0x37/0x50 (24)
 [<c019d2d5>] ext3_reserve_inode_write+0x55/0xd0 (28)
 [<c019d37b>] ext3_mark_inode_dirty+0x2b/0x60 (40)
 [<c013d162>] do_page_cache_readahead+0xc2/0x1c0 (28)
 [<c019d43d>] ext3_dirty_inode+0x8d/0x90 (16)
 [<c01786a6>] __mark_inode_dirty+0x1e6/0x1f0 (24)
 [<c013d162>] do_page_cache_readahead+0xc2/0x1c0 (8)
 [<c0171e79>] update_atime+0xd9/0xe0 (52)
 [<c01356ee>] do_generic_mapping_read+0x2ae/0x5a0 (48)
 [<c0135cdb>] __generic_file_aio_read+0x20b/0x240 (116)
 [<c01359e0>] file_read_actor+0x0/0xf0 (24)
 [<c013f0dd>] kmem_cache_free+0x4d/0xe0 (8)
 [<c0135d6b>] generic_file_aio_read+0x5b/0xa0 (52)
 [<c01551f7>] do_sync_read+0xb7/0xf0 (40)
 [<c016d37b>] fcntl_setlk+0x11b/0x2f0 (64)
 [<c012d597>] _mutex_lock+0x17/0x20 (44)
 [<c012d0b0>] autoremove_wake_function+0x0/0x60 (8)
 [<c015647b>] fget+0x4b/0x70 (24)
 [<c01552e8>] vfs_read+0xb8/0x130 (24)
 [<c0168a77>] do_fcntl+0xf7/0x1b0 (24)
 [<c01555d1>] sys_read+0x51/0x80 (20)
 [<c010602b>] syscall_call+0x7/0xb (40)
grep          [c6604330]T C03D9540     0 12175      1
1332 (NOTLB)
c3289d2c 00000082 c6604330 c03d9540 00000190 c113d140 00032f46 9c11a953 
       00000190 c66044e4 c3288000 ffffffff c62dc880 00000d0c 9c11f78e
00000190 
       c66044e4 c3288000 c3289db0 c1101bc8 c3289d50 c02d49fb c66048c8
c3289db0 
Call Trace:
 [<c02d49fb>] schedule+0x3b/0x130 (88)
 [<c020007b>] uart_set_info+0x29b/0x4d0 (24)
 [<c02d559e>] io_schedule+0xe/0x20 (12)
 [<c01347a5>] sync_page+0x35/0x50 (8)
 [<c02d58ee>] __wait_on_bit_lock+0x5e/0x70 (8)
 [<c0134770>] sync_page+0x0/0x50 (8)
 [<c012d110>] wake_bit_function+0x0/0x60 (4)
 [<c0134f31>] __lock_page+0x91/0xa0 (16)
 [<c012d110>] wake_bit_function+0x0/0x60 (24)
 [<c012d110>] wake_bit_function+0x0/0x60 (32)
 [<c0134fde>] find_get_page+0x3e/0x50 (12)
 [<c013591d>] do_generic_mapping_read+0x4dd/0x5a0 (20)
 [<c0135cdb>] __generic_file_aio_read+0x20b/0x240 (116)
 [<c01359e0>] file_read_actor+0x0/0xf0 (24)
 [<c0135d6b>] generic_file_aio_read+0x5b/0xa0 (60)
 [<c01551f7>] do_sync_read+0xb7/0xf0 (40)
 [<c015fea8>] cp_new_stat64+0xf8/0x110 (24)
 [<c012d0b0>] autoremove_wake_function+0x0/0x60 (92)
 [<c01552e8>] vfs_read+0xb8/0x130 (48)
 [<c01555d1>] sys_read+0x51/0x80 (44)
 [<c010602b>] syscall_call+0x7/0xb (40)
bash          [c62dc880]T C03D9540     0 12577   1327
(NOTLB)
c5573be0 00000082 c62dc880 c03d9540 00000000 c01c9988 c1100508 00000246 
       c62dc880 00000001 c1101854 c012cf9e c7d04660 000c5ac8 3cc49ca5
0000019c 
       c62dca34 c5572000 c79cc6bc c5573c5c c5573c04 c02d49fb c1101854
c012cf9e 
Call Trace:
 [<c01c9988>] up_write_mutex+0x38/0xc0 (24)
 [<c012cf9e>] prepare_to_wait+0x5e/0x80 (24)
 [<c02d49fb>] schedule+0x3b/0x130 (40)
 [<c012cf9e>] prepare_to_wait+0x5e/0x80 (8)
 [<c01aa61c>] do_get_write_access+0x64c/0x850 (28)
 [<c012d110>] wake_bit_function+0x0/0x60 (60)
 [<c01583cb>] __getblk+0x2b/0x60 (12)
 [<c012d110>] wake_bit_function+0x0/0x60 (20)
 [<c01aa857>] journal_get_write_access+0x37/0x50 (32)
 [<c019d2d5>] ext3_reserve_inode_write+0x55/0xd0 (28)
 [<c019d37b>] ext3_mark_inode_dirty+0x2b/0x60 (40)
 [<c013d162>] do_page_cache_readahead+0xc2/0x1c0 (28)
 [<c019d43d>] ext3_dirty_inode+0x8d/0x90 (16)
 [<c01786a6>] __mark_inode_dirty+0x1e6/0x1f0 (24)
 [<c013d1ca>] do_page_cache_readahead+0x12a/0x1c0 (8)
 [<c0171e79>] update_atime+0xd9/0xe0 (52)
 [<c01356ee>] do_generic_mapping_read+0x2ae/0x5a0 (48)
 [<c0135cdb>] __generic_file_aio_read+0x20b/0x240 (116)
 [<c01359e0>] file_read_actor+0x0/0xf0 (24)
 [<c0135d6b>] generic_file_aio_read+0x5b/0xa0 (60)
 [<c01551f7>] do_sync_read+0xb7/0xf0 (40)
 [<c012d0b0>] autoremove_wake_function+0x0/0x60 (116)
 [<c01552e8>] vfs_read+0xb8/0x130 (48)
 [<c0160aae>] kernel_read+0x4e/0x60 (44)
 [<c016172a>] prepare_binprm+0xca/0xf0 (36)
 [<c0161c15>] do_execve+0x115/0x260 (32)
 [<c0104b36>] sys_execve+0x46/0xb0 (36)
 [<c010602b>] syscall_call+0x7/0xb (32)
bash          [c47fb8f0]T C03D9540     0 12578   2299
(NOTLB)
c4ae5be0 00000086 c47fb8f0 c03d9540 00000000 c01c9988 c1100508 00000246 
       c47fb8f0 00000001 c1101854 c012cf9e c5040130 00075001 abcf7095
0000019e 
       c47fbaa4 c4ae4000 c79cc6bc c4ae5c5c c4ae5c04 c02d49fb c1101854
c012cf9e 
Call Trace:
 [<c01c9988>] up_write_mutex+0x38/0xc0 (24)
 [<c012cf9e>] prepare_to_wait+0x5e/0x80 (24)
 [<c02d49fb>] schedule+0x3b/0x130 (40)
 [<c012cf9e>] prepare_to_wait+0x5e/0x80 (8)
 [<c01aa61c>] do_get_write_access+0x64c/0x850 (28)
 [<c01a975a>] start_this_handle+0x16a/0x410 (8)
 [<c01c9988>] up_write_mutex+0x38/0xc0 (12)
 [<c012d110>] wake_bit_function+0x0/0x60 (40)
 [<c01583cb>] __getblk+0x2b/0x60 (12)
 [<c012d110>] wake_bit_function+0x0/0x60 (20)
 [<c01aa857>] journal_get_write_access+0x37/0x50 (32)
 [<c019d2d5>] ext3_reserve_inode_write+0x55/0xd0 (28)
 [<c019d37b>] ext3_mark_inode_dirty+0x2b/0x60 (40)
 [<c013d162>] do_page_cache_readahead+0xc2/0x1c0 (28)
 [<c019d43d>] ext3_dirty_inode+0x8d/0x90 (16)
 [<c01786a6>] __mark_inode_dirty+0x1e6/0x1f0 (24)
 [<c013d162>] do_page_cache_readahead+0xc2/0x1c0 (8)
 [<c0171e79>] update_atime+0xd9/0xe0 (52)
 [<c01356ee>] do_generic_mapping_read+0x2ae/0x5a0 (48)
 [<c0135cdb>] __generic_file_aio_read+0x20b/0x240 (116)
 [<c01359e0>] file_read_actor+0x0/0xf0 (24)
 [<c0135d6b>] generic_file_aio_read+0x5b/0xa0 (60)
 [<c01551f7>] do_sync_read+0xb7/0xf0 (40)
 [<c012d0b0>] autoremove_wake_function+0x0/0x60 (116)
 [<c01552e8>] vfs_read+0xb8/0x130 (48)
 [<c0160aae>] kernel_read+0x4e/0x60 (44)
 [<c016172a>] prepare_binprm+0xca/0xf0 (36)
 [<c0161c15>] do_execve+0x115/0x260 (32)
 [<c0104b36>] sys_execve+0x46/0xb0 (36)
 [<c010602b>] syscall_call+0x7/0xb (32)


