Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVBUHLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVBUHLS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 02:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVBUHLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 02:11:17 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:17870 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S261743AbVBUHJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 02:09:50 -0500
Date: Mon, 21 Feb 2005 02:09:45 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: 2.6.11-rc4-RT-V0.7.39-02 crash out of nowhere
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200502210209.46169.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: Multipart/Mixed; boundary="Boundary-00=_6kYGCA2nYK70RZu"
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_6kYGCA2nYK70RZu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings;

I just came back in here after a 2 hour nap, to find the box crashed,
100%.  Uptime was at least 2 days for 2.6.11-rc4-RT-V0.7.39-02, and
no hints of impending doom.  The .config is attached.

The system was quiet except for kmail's timed mail fetching runs, 
x-6.8.1 (built on site) was running, as was setiathome.  Nothing
in the crontabs covers this time frame as rsync was scheduled to
start half an hour later, with amdump following it at 1 am.  So
if anything triggered it, it might have been kmail.  This is kde
3.3.0, konstruct built, and much more stable than the rpms have
been so far.  I haven't ever seen 99% of the crashes and problems
reported on the kde mailing lists.
 
Here is the first of the crash, up and including a fraction of the
next full second of the log. I won't include any more except a
couple of lines at the bottom to show how long it looped before
totally dying as the full log is 107+ megabytes.

Feb 20 23:08:01 coyote kernel: move_wait_queue+0x43/0x60 (12)
Feb 20 23:08:01 coyote kernel:  [<c012ad23>] remove_wait_queue+0x43/0x60 (24)
Feb 20 23:08:01 coyote kernel:  [<c0168f44>] poll_freewait+0x24/0x50 (24)
Feb 20 23:08:01 coyote kernel:  [<c01692e9>] do_select+0x1c9/0x2d0 (16)
Feb 20 23:08:01 coyote kernel:  [<c0168f70>] __pollwait+0x0/0xd0 (84)
Feb 20 23:08:01 coyote kernel:  [<c01696df>] sys_select+0x2bf/0x4d0 (32)
Feb 20 23:08:01 coyote kernel:  [<c012d44e>] up_mutex+0xbe/0x120 (16)
Feb 20 23:08:01 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (76)
Feb 20 23:08:01 coyote kernel: X/28686: BUG in kfree at mm/slab.c:2604
Feb 20 23:08:01 coyote kernel:  [<c013f765>] kfree+0x135/0x140 (8)
Feb 20 23:08:01 coyote kernel:  [<c0169654>] sys_select+0x234/0x4d0 (44)
Feb 20 23:08:01 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (92)
Feb 20 23:08:01 coyote kernel: X/28686: BUG in kfree at mm/slab.c:2608
Feb 20 23:08:01 coyote kernel:  [<c0169654>] sys_select+0x234/0x4d0 (8)
Feb 20 23:08:01 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (92)
Feb 20 23:08:01 coyote kernel: Warning: kfree_skb on hard IRQ c0351eea
Feb 20 23:08:01 coyote kernel: X/28686: BUG in kfree at mm/slab.c:2604
Feb 20 23:08:01 coyote kernel:  [<c013f765>] kfree+0x135/0x140 (8)
Feb 20 23:08:01 coyote kernel:  [<c02f9363>] kfree_skbmem+0x13/0x30 (44)
Feb 20 23:08:01 coyote kernel:  [<c02f9405>] __kfree_skb+0x85/0x120 (16)
Feb 20 23:08:01 coyote kernel:  [<c0351eea>] unix_stream_recvmsg+0x21a/0x480 (8)
Feb 20 23:08:01 coyote kernel:  [<c0351eea>] unix_stream_recvmsg+0x21a/0x480 (24)
Feb 20 23:08:01 coyote kernel:  [<c02f53c5>] sock_aio_read+0xf5/0x110 (116)
Feb 20 23:08:01 coyote kernel:  [<c015525e>] do_sync_read+0xbe/0xf0 (116)
Feb 20 23:08:01 coyote kernel:  [<c011e5fe>] __mod_timer+0xfe/0x170 (28)
Feb 20 23:08:01 coyote kernel:  [<c012dcf7>] _spin_lock+0x17/0x20 (36)
Feb 20 23:08:01 coyote kernel:  [<c012aeb0>] autoremove_wake_function+0x0/0x60 (52)
Feb 20 23:08:02 coyote kernel:  [<c01553cc>] vfs_read+0x13c/0x150 (48)
Feb 20 23:08:02 coyote kernel:  [<c0155671>] sys_read+0x51/0x80 (36)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (40)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in kfree at mm/slab.c:2608
Feb 20 23:08:02 coyote kernel:  [<c02f9363>] kfree_skbmem+0x13/0x30 (8)
Feb 20 23:08:02 coyote kernel:  [<c02f9405>] __kfree_skb+0x85/0x120 (16)
Feb 20 23:08:02 coyote kernel:  [<c0351eea>] unix_stream_recvmsg+0x21a/0x480 (8)
Feb 20 23:08:02 coyote kernel:  [<c0351eea>] unix_stream_recvmsg+0x21a/0x480 (24)
Feb 20 23:08:02 coyote kernel:  [<c02f53c5>] sock_aio_read+0xf5/0x110 (116)
Feb 20 23:08:02 coyote kernel:  [<c015525e>] do_sync_read+0xbe/0xf0 (116)
Feb 20 23:08:02 coyote kernel:  [<c011e5fe>] __mod_timer+0xfe/0x170 (28)
Feb 20 23:08:02 coyote kernel:  [<c012dcf7>] _spin_lock+0x17/0x20 (36)
Feb 20 23:08:02 coyote kernel:  [<c012aeb0>] autoremove_wake_function+0x0/0x60 (52)
Feb 20 23:08:02 coyote kernel:  [<c01553cc>] vfs_read+0x13c/0x150 (48)
Feb 20 23:08:02 coyote kernel:  [<c0155671>] sys_read+0x51/0x80 (36)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (40)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in kmem_cache_free at mm/slab.c:2562
Feb 20 23:08:02 coyote kernel:  [<c013f5af>] kmem_cache_free+0x11f/0x130 (8)
Feb 20 23:08:02 coyote kernel:  [<c02f9374>] kfree_skbmem+0x24/0x30 (44)
Feb 20 23:08:02 coyote kernel:  [<c02f9405>] __kfree_skb+0x85/0x120 (16)
Feb 20 23:08:02 coyote kernel:  [<c0351eea>] unix_stream_recvmsg+0x21a/0x480 (8)
Feb 20 23:08:02 coyote kernel:  [<c0351eea>] unix_stream_recvmsg+0x21a/0x480 (24)
Feb 20 23:08:02 coyote kernel:  [<c02f53c5>] sock_aio_read+0xf5/0x110 (116)
Feb 20 23:08:02 coyote kernel:  [<c015525e>] do_sync_read+0xbe/0xf0 (116)
Feb 20 23:08:02 coyote kernel:  [<c011e5fe>] __mod_timer+0xfe/0x170 (28)
Feb 20 23:08:02 coyote kernel:  [<c012dcf7>] _spin_lock+0x17/0x20 (36)
Feb 20 23:08:02 coyote kernel:  [<c012aeb0>] autoremove_wake_function+0x0/0x60 (52)
Feb 20 23:08:02 coyote kernel:  [<c01553cc>] vfs_read+0x13c/0x150 (48)
Feb 20 23:08:02 coyote kernel:  [<c0155671>] sys_read+0x51/0x80 (36)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (40)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in kmem_cache_free at mm/slab.c:2564
Feb 20 23:08:02 coyote kernel:  [<c02f9374>] kfree_skbmem+0x24/0x30 (8)
Feb 20 23:08:02 coyote kernel:  [<c02f9405>] __kfree_skb+0x85/0x120 (16)
Feb 20 23:08:02 coyote kernel:  [<c0351eea>] unix_stream_recvmsg+0x21a/0x480 (8)
Feb 20 23:08:02 coyote kernel:  [<c0351eea>] unix_stream_recvmsg+0x21a/0x480 (24)
Feb 20 23:08:02 coyote kernel:  [<c02f53c5>] sock_aio_read+0xf5/0x110 (116)
Feb 20 23:08:02 coyote kernel:  [<c015525e>] do_sync_read+0xbe/0xf0 (116)
Feb 20 23:08:02 coyote kernel:  [<c011e5fe>] __mod_timer+0xfe/0x170 (28)
Feb 20 23:08:02 coyote kernel:  [<c012dcf7>] _spin_lock+0x17/0x20 (36)
Feb 20 23:08:02 coyote kernel:  [<c012aeb0>] autoremove_wake_function+0x0/0x60 (52)
Feb 20 23:08:02 coyote kernel:  [<c01553cc>] vfs_read+0x13c/0x150 (48)
Feb 20 23:08:02 coyote kernel:  [<c0155671>] sys_read+0x51/0x80 (36)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (40)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in __cache_alloc at mm/slab.c:2168
Feb 20 23:08:02 coyote kernel:  [<c013f474>] __kmalloc+0x134/0x150 (8)
Feb 20 23:08:02 coyote kernel:  [<c016940c>] select_bits_alloc+0x1c/0x20 (44)
Feb 20 23:08:02 coyote kernel:  [<c0169514>] sys_select+0xf4/0x4d0 (12)
Feb 20 23:08:02 coyote kernel:  [<c01553cc>] vfs_read+0x13c/0x150 (16)
Feb 20 23:08:02 coyote kernel:  [<c011a280>] sys_gettimeofday+0x40/0xc0 (40)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (36)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in __cache_alloc at mm/slab.c:2180
Feb 20 23:08:02 coyote kernel:  [<c013f41b>] __kmalloc+0xdb/0x150 (8)
Feb 20 23:08:02 coyote kernel:  [<c016940c>] select_bits_alloc+0x1c/0x20 (44)
Feb 20 23:08:02 coyote kernel:  [<c0169514>] sys_select+0xf4/0x4d0 (12)
Feb 20 23:08:02 coyote kernel:  [<c01553cc>] vfs_read+0x13c/0x150 (16)
Feb 20 23:08:02 coyote kernel:  [<c011a280>] sys_gettimeofday+0x40/0xc0 (40)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (36)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in _down_mutex at kernel/rt.c:1293
Feb 20 23:08:02 coyote kernel:  [<c012d1a8>] _down_mutex+0x98/0xc0 (8)
Feb 20 23:08:02 coyote kernel:  [<c012dcc2>] __spin_lock+0x32/0x50 (36)
Feb 20 23:08:02 coyote kernel:  [<c012ac61>] add_wait_queue+0x21/t+0x2bf/0x4d0 (32)
Feb 20 23:08:02 coyote kernel:  [<c01553cc>] vfs_read+0x13c/0x150 (16)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (76)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in __up_mutex at kernel/rt.c:1146
Feb 20 23:08:02 coyote kernel:  [<c012c8bf>] __up_mutex+0x9f/0x4d0 (8)
Feb 20 23:08:02 coyote kernel:  [<c012ad23>] remove_wait_queue+0x43/0x60 (32)
Feb 20 23:08:02 coyote kernel:  [<c012ad23>] remove_wait_queue+0x43/0x60 (16)
Feb 20 23:08:02 coyote kernel:  [<c012d44e>] up_mutex+0xbe/0x120 (12)
Feb 20 23:08:02 coyote kernel:  [<c012ad23>] remove_wait_queue+0x43/0x60 (12)
Feb 20 23:08:02 coyote kernel:  [<c012ad23>] remove_wait_queue+0x43/0x60 (24)
Feb 20 23:08:02 coyote kernel:  [<c0168f44>] poll_freewait+0x24/0x50 (24)
Feb 20 23:08:02 coyote kernel:  [<c01692e9>] do_select+0x1c9/0x2d0 (16)
Feb 20 23:08:02 coyote kernel:  [<c0168f70>] __pollwait+0x0/0xd0 (84)
Feb 20 23:08:02 coyote kernel:  [<c01696df>] sys_select+0x2bf/0x4d0 (32)
Feb 20 23:08:02 coyote kernel:  [<c01553cc>] vfs_read+0x13c/0x150 (16)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (76)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in kfree at mm/slab.c:2604
Feb 20 23:08:02 coyote kernel:  [<c013f765>] kfree+0x135/0x140 (8)
Feb 20 23:08:02 coyote kernel:  [<c0169654>] sys_select+0x234/0x4d0 (44)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (92)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in kfree at mm/slab.c:2608
Feb 20 23:08:02 coyote kernel:  [<c0169654>] sys_select+0x234/0x4d0 (8)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (92)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in kmem_cache_free at mm/slab.c:2562
Feb 20 23:08:02 coyote kernel:  [<c013f5af>] kmem_cache_free+0x11f/0x130 (8)
Feb 20 23:08:02 coyote kernel:  [<c0120057>] __dequeue_signal+0x117/0x1a0 (44)
Feb 20 23:08:02 coyote kernel:  [<c012018b>] dequeue_signal+0xab/0xc0 (36)
Feb 20 23:08:02 coyote kernel:  [<c0121d48>] get_signal_to_deliver+0x78/0x310 (32)
Feb 20 23:08:02 coyote kernel:  [<c0102514>] do_signal+0xa4/0x140 (40)
Feb 20 23:08:02 coyote kernel:  [<c0116274>] vprintk+0x104/0x160 (28)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (24)
Feb 20 23:08:02 coyote kernel:  [<c0102c6c>] dump_stack+0x1c/0x20 (48)
Feb 20 23:08:02 coyote kernel:  [<c0169654>] sys_select+0x234/0x4d0 (16)
Feb 20 23:08:02 coyote kernel:  [<c01025e5>] do_notify_resume+0x35/0x38 (84)
Feb 20 23:08:02 coyote kernel:  [<c0102766>] work_notifysig+0x13/0x15 (8)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in kmem_cache_free at mm/slab.c:2564
Feb 20 23:08:02 coyote kernel:  [<c0120057>] __dequeue_signal+0x117/0x1a0 (8)
Feb 20 23:08:02 coyote kernel:  [<c012018b>] dequeue_signal+0xab/0xc0 (36)
Feb 20 23:08:02 coyote kernel:  [<c0121d48>] get_signal_to_deliver+0x78/0x310 (32)
Feb 20 23:08:02 coyote kernel:  [<c0102514>] do_signal+0xa4/0x140 (40)
Feb 20 23:08:02 coyote kernel:  [<c0116274>] vprintk+0x104/0x160 (28)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (24)
Feb 20 23:08:02 coyote kernel:  [<c0102c6c>] dump_stack+0x1c/0x20 (48)
Feb 20 23:08:02 coyote kernel:  [<c0169654>] sys_select+0x234/0x4d0 (16)
Feb 20 23:08:02 coyote kernel:  [<c01025e5>] do_notify_resume+0x35/0x38 (84)
Feb 20 23:08:02 coyote kernel:  [<c0102766>] work_notifysig+0x13/0x15 (8)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in __cache_alloc at mm/slab.c:2168
Feb 20 23:08:02 coyote kernel:  [<c013f474>] __kmalloc+0x134/0x150 (8)
Feb 20 23:08:02 coyote kernel:  [<c016940c>] select_bits_alloc+0x1c/0x20 (44)
Feb 20 23:08:02 coyote kernel:  [<c0169514>] sys_select+0xf4/0x4d0 (12)
Feb 20 23:08:02 coyote kernel:  [<c012d44e>] up_mutex+0xbe/0x120 (16)
Feb 20 23:08:02 coyote kernel:  [<c011a280>] sys_gettimeofday+0x40/0xc0 (40)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (36)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in __cache_alloc at mm/slab.c:2180
Feb 20 23:08:02 coyote kernel:  [<c013f41b>] __kmalloc+0xdb/0x150 (8)
Feb 20 23:08:02 coyote kernel:  [<c016940c>] select_bits_alloc+0x1c/0x20 (44)
Feb 20 23:08:02 coyote kernel:  [<c0169514>] sys_select+0xf4/0x4d0 (12)
Feb 20 23:08:02 coyote kernel:  [<c012d44e>] up_mutex+0xbe/0x120 (16)
Feb 20 23:08:02 coyote kernel:  [<c011a280>] sys_gettimeofday+0x40/0xc0 (40)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (36)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in _down_mutex at kernel/rt.c:1293
Feb 20 23:08:02 coyote kernel:  [<c012d1a8>] _down_mutex+0x98/0xc0 (8)
Feb 20 23:08:02 coyote kernel:  [<c012dcc2>] __spin_lock+0x32/0x50 (36)
Feb 20 23:08:02 coyote kernel:  [<c012ac61>] add_wait_queue+0x21/0x50 (8)
Feb 20 23:08:02 coyote kernel:  [<c012dd57>] _spin_lock_irqsave+0x17/0x20 (12)
Feb 20 23:08:02 coyote kernel:  [<c012ac61>] add_wait_queue+0x21/0x50 (8)
Feb 20 23:08:02 coyote kernel:  [<c012ac61>] add_wait_queue+0x21/0x50 (4)
Feb 20 23:08:02 coyote kernel:  [<c025dd60>] normal_poll+0x30/0x190 (24)
Feb 20 23:08:02 coyote kernel:  [<c0259920>] tty_poll+0xa0/0xb0 (32)
Feb 20 23:08:02 coyote kernel:  [<c016938f>] do_select+0x26f/0x2d0 (36)
Feb 20 23:08:02 coyote kernel:  [<c0168f70>] __pollwait+0x0/0xd0 (84)
Feb 20 23:08:02 coyote kernel:  [<c01696df>] sys_select+0x2bf/0x4d0 (32)
Feb 20 23:08:02 coyote kernel:  [<c012d44e>] up_mutex+0xbe/0x120 (16)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (76)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in up_mutex at kernel/rt.c:1340
Feb 20 23:08:02 coyote kernel:  [<c012d42c>] up_mutex+0x9c/0x120 (8)
Feb 20 23:08:02 coyote kernel:  [<c012ac7f>] add_wait_queue+0x3f/0x50 (36)
Feb 20 23:08:02 coyote kernel:  [<c025dd60>] normal_poll+0x30/0x190 (24)
Feb 20 23:08:02 coyote kernel:  [<c0259920>] tty_poll+0xa0/0xb0 (32)
Feb 20 23:08:02 coyote kernel:  [<c016938f>] do_select+0x26f/0x2d0 (36)
Feb 20 23:08:02 coyote kernel:  [<c0168f70>] __pollwait+0x0/0xd0 (84)
Feb 20 23:08:02 coyote kernel:  [<c01696df>] sys_select+0x2bf/0x4d0 (32)
Feb 20 23:08:02 coyote kernel:  [<c012d44e>] up_mutex+0xbe/0x120 (16)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (76)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in __up_mutex at kernel/rt.c:1146
Feb 20 23:08:02 coyote kernel:  [<c012c8bf>] __up_mutex+0x9f/0x4d0 (8)
Feb 20 23:08:02 coyote kernel:  [<c012ac7f>] add_wait_queue+0x3f/0x50 (32)
Feb 20 23:08:02 coyote kernel:  [<c012ac7f>] add_wait_queue+0x3f/0x50 (16)
Feb 20 23:08:02 coyote kernel:  [<c012d44e>] up_mutex+0xbe/0x120 (12)
Feb 20 23:08:02 coyote kernel: <unix_stream_recvmsg+0x21a/0x480 (24)
Feb 20 23:08:02 coyote kernel:  [<c02f53c5>] sock_aio_read+0xf5/0x110 (116)
Feb 20 23:08:02 coyote kernel:  [<c015525e>] do_sync_read+0xbe/0xf0 (116)
Feb 20 23:08:02 coyote kernel:  [<c011e5fe>] __mod_timer+0xfe/0x170 (28)
Feb 20 23:08:02 coyote kernel:  [<c012dcf7>] _spin_lock+0x17/0x20 (36)
Feb 20 23:08:02 coyote kernel:  [<c012aeb0>] autoremove_wake_function+0x0/0x60 (52)
Feb 20 23:08:02 coyote kernel:  [<c01553cc>] vfs_read+0x13c/0x150 (48)
Feb 20 23:08:02 coyote kernel:  [<c0155671>] sys_read+0x51/0x80 (36)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (40)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in kmem_cache_free at mm/slab.c:2562
Feb 20 23:08:02 coyote kernel:  [<c013f5af>] kmem_cache_free+0x11f/0x130 (8)
Feb 20 23:08:02 coyote kernel:  [<c02f9374>] kfree_skbmem+0x24/0x30 (44)
Feb 20 23:08:02 coyote kernel:  [<c02f9405>] __kfree_skb+0x85/0x120 (16)
Feb 20 23:08:02 coyote kernel:  [<c0351eea>] unix_stream_recvmsg+0x21a/0x480 (8)
Feb 20 23:08:02 coyote kernel:  [<c0351eea>] unix_stream_recvmsg+0x21a/0x480 (24)
Feb 20 23:08:02 coyote kernel:  [<c02f53c5>] sock_aio_read+0xf5/0x110 (116)
Feb 20 23:08:02 coyote kernel:  [<c015525e>] do_sync_read+0xbe/0xf0 (116)
Feb 20 23:08:02 coyote kernel:  [<c011e5fe>] __mod_timer+0xfe/0x170 (28)
Feb 20 23:08:02 coyote kernel:  [<c012dcf7>] _spin_lock+0x17/0x20 (36)
Feb 20 23:08:02 coyote kernel:  [<c012aeb0>] autoremove_wake_function+0x0/0x60 (52)
Feb 20 23:08:02 coyote kernel:  [<c01553cc>] vfs_read+0x13c/0x150 (48)
Feb 20 23:08:02 coyote kernel:  [<c0155671>] sys_read+0x51/0x80 (36)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (40)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in kmem_cache_free at mm/slab.c:2564
Feb 20 23:08:02 coyote kernel:  [<c02f9374>] kfree_skbmem+0x24/0x30 (8)
Feb 20 23:08:02 coyote kernel:  [<c02f9405>] __kfree_skb+0x85/0x120 (16)
Feb 20 23:08:02 coyote kernel:  [<c0351eea>] unix_stream_recvmsg+0x21a/0x480 (8)
Feb 20 23:08:02 coyote kernel:  [<c0351eea>] unix_stream_recvmsg+0x21a/0x480 (24)
Feb 20 23:08:02 coyote kernel:  [<c02f53c5>] sock_aio_read+0xf5/0x110 (116)
Feb 20 23:08:02 coyote kernel:  [<c015525e>] do_sync_read+0xbe/0xf0 (116)
Feb 20 23:08:02 coyote kernel:  [<c011e5fe>] __mod_timer+0xfe/0x170 (28)
Feb 20 23:08:02 coyote kernel:  [<c012dcf7>] _spin_lock+0x17/0x20 (36)
Feb 20 23:08:02 coyote kernel:  [<c012aeb0>] autoremove_wake_function+0x0/0x60 (52)
Feb 20 23:08:02 coyote kernel:  [<c01553cc>] vfs_read+0x13c/0x150 (48)
Feb 20 23:08:02 coyote kernel:  [<c0155671>] sys_read+0x51/0x80 (36)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (40)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in __cache_alloc at mm/slab.c:2168
Feb 20 23:08:02 coyote kernel:  [<c013f474>] __kmalloc+0x134/0x150 (8)
Feb 20 23:08:02 coyote kernel:  [<c016940c>] select_bits_alloc+0x1c/0x20 (44)
Feb 20 23:08:02 coyote kernel:  [<c0169514>] sys_select+0xf4/0x4d0 (12)
Feb 20 23:08:02 coyote kernel:  [<c01553cc>] vfs_read+0x13c/0x150 (16)
Feb 20 23:08:02 coyote kernel:  [<c011a280>] sys_gettimeofday+0x40/0xc0 (40)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (36)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in __cache_alloc at mm/slab.c:2180
Feb 20 23:08:02 coyote kernel:  [<c013f41b>] __kmalloc+0xdb/0x150 (8)
Feb 20 23:08:02 coyote kernel:  [<c016940c>] select_bits_alloc+0x1c/0x20 (44)
Feb 20 23:08:02 coyote kernel:  [<c0169514>] sys_select+0xf4/0x4d0 (12)
Feb 20 23:08:02 coyote kernel:  [<c01553cc>] vfs_read+0x13c/0x150 (16)
Feb 20 23:08:02 coyote kernel:  [<c011a280>] sys_gettimeofday+0x40/0xc0 (40)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (36)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in _down_mutex at kernel/rt.c:1293
Feb 20 23:08:02 coyote kernel:  [<c012d1a8>] _down_mutex+0x98/0xc0 (8)
Feb 20 23:08:02 coyote kernel:  [<c012dcc2>] __spin_lock+0x32/0x50 (36)
Feb 20 23:08:02 coyote kernel:  [<c012ac61>] add_wait_queue+0x21/0x50 (8)
Feb 20 23:08:02 coyote kernel:  [<c012dd57>] _spin_lock_irqsave+0x17/0x20 (12)
Feb 20 23:08:02 coyote kernel:  [<c012ac61>] add_wait_queue+0x21/0x50 (8)
Feb 20 23:08:02 coyote kernel:  [<c012ac61>] add_wait_queue+0x21/0x50 (4)
Feb 20 23:08:02 coyote kernel:  [<c025dd60>] normal_poll+0x30/0x190 (24)
Feb 20 23:08:02 coyote kernel:  [<c0259920>] tty_poll+0xa0/0xb0 (32)
Feb 20 23:08:02 coyote kernel:  [<c016938f>] do_select+0x26f/0x2d0 (36)
Feb 20 23:08:02 coyote kernel:  [<c0168f70>] __pollwait+0x0/0xd0 (84)
Feb 20 23:08:02 coyote kernel:  [<c01696df>] sys_select+0x2bf/0x4d0 (32)
Feb 20 23:08:02 coyote kernel:  [<c01553cc>] vfs_read+0x13c/0x150 (16)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (76)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in up_mutex at kernel/rt.c:1340
Feb 20 23:08:02 coyote kernel:  [<c012d42c>] up_mutex+0x9c/0x120 (8)
Feb 20 23:08:02 coyote kernel:  [<c012ac7f>] add_wait_queue+0x3f/0x50 (36)
Feb 20 23:08:02 coyote kernel:  [<c025dd60>] normal_poll+0x30/0x190 (24)
Feb 20 23:08:02 coyote kernel:  [<c0259920>] tty_poll+0xa0/0xb0 (32)
Feb 20 23:08:02 coyote kernel:  [<c016938f>] do_select+0x26f/0x2d0 (36)
Feb 20 23:08:02 coyote kernel:  [<c0168f70>] __pollwait+0x0/0xd0 (84)
Feb 20 23:08:02 coyote kernel:  [<c01696df>] sys_select+0x2bf/0x4d0 (32)
Feb 20 23:08:02 coyote kernel:  [<c01553cc>] vfs_read+0x13c/0x150 (16)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (76)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in __up_mutex at kernel/rt.c:1146
Feb 20 23:08:02 coyote kernel:  [<c012c8bf>] __up_mutex+0x9f/0x4d0 (8)
Feb 20 23:08:02 coyote kernel:  [<c012ac7f>] add_wait_queue+0x3f/0x50 (32)
Feb 20 23:08:02 coyote kernel:  [<c012ac7f>] add_wait_queue+0x3f/0x50 (16)
Feb 20 23:08:02 coyote kernel:  [<c012d44e>] up_mutex+0xbe/0x120 (12)
Feb 20 23:08:02 coyote kernel:  [<c012ac7f>] add_wait_queue+0x3f/0x50 (12)
Feb 20 23:08:02 coyote kernel:  [<c012ac7f>] add_wait_queue+0x3f/0x50 (24)
Feb 20 23:08:02 coyote kernel:  [<c025dd60>] normal_poll+0x30/0x190 (24)
Feb 20 23:08:02 coyote kernel:  [<c0259920>] tty_poll+0xa0/0xb0 (32)
Feb 20 23:08:02 coyote kernel:  [<c016938f>] do_select+0x26f/0x2d0 (36)
Feb 20 23:08:02 coyote kernel:  [<c0168f70>] __pollwait+0x0/0xd0 (84)
Feb 20 23:08:02 coyote kernel:  [<c01696df>] sys_select+0x2bf/0x4d0 (32)
Feb 20 23:08:02 coyote kernel:  [<c01553cc>] vfs_read+0x13c/0x150 (16)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (76)
Feb 20 23:08:02 coyote kernel: BUG: scheduling 5/0x140 (8)
Feb 20 23:08:02 coyote kernel:  [<c0169654>] sys_select+0x234/0x4d0 (44)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (92)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in kfree at mm/slab.c:2608
Feb 20 23:08:02 coyote kernel:  [<c0169654>] sys_select+0x234/0x4d0 (8)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (92)
Feb 20 23:08:02 coyote kernel: Warning: kfree_skb on hard IRQ c0351eea
Feb 20 23:08:02 coyote kernel: X/28686: BUG in kfree at mm/slab.c:2604
Feb 20 23:08:02 coyote kernel:  [<c013f765>] kfree+0x135/0x140 (8)
Feb 20 23:08:02 coyote kernel:  [<c02f9363>] kfree_skbmem+0x13/0x30 (44)
Feb 20 23:08:02 coyote kernel:  [<c02f9405>] __kfree_skb+0x85/0x120 (16)
Feb 20 23:08:02 coyote kernel:  [<c0351eea>] unix_stream_recvmsg+0x21a/0x480 (8)
Feb 20 23:08:02 coyote kernel:  [<c0351eea>] unix_stream_recvmsg+0x21a/0x480 (24)
Feb 20 23:08:02 coyote kernel:  [<c02f53c5>] sock_aio_read+0xf5/0x110 (116)
Feb 20 23:08:02 coyote kernel:  [<c015525e>] do_sync_read+0xbe/0xf0 (116)
Feb 20 23:08:02 coyote kernel:  [<c011e5fe>] __mod_timer+0xfe/0x170 (28)
Feb 20 23:08:02 coyote kernel:  [<c012dcf7>] _spin_lock+0x17/0x20 (36)
Feb 20 23:08:02 coyote kernel:  [<c012aeb0>] autoremove_wake_function+0x0/0x60 (52)
Feb 20 23:08:02 coyote kernel:  [<c01553cc>] vfs_read+0x13c/0x150 (48)
Feb 20 23:08:02 coyote kernel:  [<c0155671>] sys_read+0x51/0x80 (36)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (40)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in kfree at mm/slab.c:2608
Feb 20 23:08:02 coyote kernel:  [<c02f9363>] kfree_skbmem+0x13/0x30 (8)
Feb 20 23:08:02 coyote kernel:  [<c02f9405>] __kfree_skb+0x85/0x120 (16)
Feb 20 23:08:02 coyote kernel:  [<c0351eea>] unix_stream_recvmsg+0x21a/0x480 (8)
Feb 20 23:08:02 coyote kernel:  [<c0351eea>] unix_stream_recvmsg+0x21a/0x480 (24)
Feb 20 23:08:02 coyote kernel:  [<c02f53c5>] sock_aio_read+0xf5/0x110 (116)
Feb 20 23:08:02 coyote kernel:  [<c015525e>] do_sync_read+0xbe/0xf0 (116)
Feb 20 23:08:02 coyote kernel:  [<c011e5fe>] __mod_timer+0xfe/0x170 (28)
Feb 20 23:08:02 coyote kernel:  [<c012dcf7>] _spin_lock+0x17/0x20 (36)
Feb 20 23:08:02 coyote kernel:  [<c012aeb0>] autoremove_wake_function+0x0/0x60 (52)
Feb 20 23:08:02 coyote kernel:  [<c01553cc>] vfs_read+0x13c/0x150 (48)
Feb 20 23:08:02 coyote kernel:  [<c0155671>] sys_read+0x51/0x80 (36)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (40)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in kmem_cache_free at mm/slab.c:2562
Feb 20 23:08:02 coyote kernel:  [<c013f5af>] kmem_cache_free+0x11f/0x130 (8)
Feb 20 23:08:02 coyote kernel:  [<c02f9374>] kfree_skbmem+0x24/0x30 (44)
Feb 20 23:08:02 coyote kernel:  [<c02f9405>] __kfree_skb+0x85/0x120 (16)
Feb 20 23:08:02 coyote kernel:  [<c0351eea>] unix_stream_recvmsg+0x21a/0x480 (8)
Feb 20 23:08:02 coyote kernel:  [<c0351eea>] unix_stream_recvmsg+0x21a/0x480 (24)
Feb 20 23:08:02 coyote kernel:  [<c02f53c5>] sock_aio_read+0xf5/0x110 (116)
Feb 20 23:08:02 coyote kernel:  [<c015525e>] do_sync_read+0xbe/0xf0 (116)
Feb 20 23:08:02 coyote kernel:  [<c011e5fe>] __mod_timer+0xfe/0x170 (28)
Feb 20 23:08:02 coyote kernel:  [<c012dcf7>] _spin_lock+0x17/0x20 (36)
Feb 20 23:08:02 coyote kernel:  [<c012aeb0>] autoremove_wake_function+0x0/0x60 (52)
Feb 20 23:08:02 coyote kernel:  [<c01553cc>] vfs_read+0x13c/0x150 (48)
Feb 20 23:08:02 coyote kernel:  [<c0155671>] sys_read+0x51/0x80 (36)
Feb 20 23:08:02 coyote kernel:  [<c01026c5>] sysenter_past_esp+0x52/0x75 (40)
Feb 20 23:08:02 coyote kernel: X/28686: BUG in kmem_cache_free at mm/slab.c:2564
Feb 20 23:08:02 coyote kernel:  [<c02f9374>] kfree_skbmem+0x24/0x30 (8)
Feb 20 23:08:02 coyote kernel:  [<c02f9405>] __kfree_skb+0x85/0x120 (16)

And this cut & paste is getting ridiculous, this is not even a full
seconds worth, so on to the last line before even the logging died:

Feb 20 23:35:05 coyote kernel:  [<c01696df>] sys_select+0x2bf/0x4d0 (32)
Feb 21 01:16:16 coyote syslogd 1.4.1: restart.

Is this enough to point a finger at?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.33% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

--Boundary-00=_6kYGCA2nYK70RZu
Content-Type: application/x-gzip;
  name="config-2.6.11-rc4-RT-V0.7.39-02.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config-2.6.11-rc4-RT-V0.7.39-02.gz"

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
hvQD8/heZMntd6G1Tvx/dC1KJFqHAAA=

--Boundary-00=_6kYGCA2nYK70RZu--
