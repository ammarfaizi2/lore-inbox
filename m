Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758283AbWK0PzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758283AbWK0PzA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 10:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758334AbWK0PzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 10:55:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:17867 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1758283AbWK0Py7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 10:54:59 -0500
X-Authenticated: #5358227
Date: Mon, 27 Nov 2006 16:54:54 +0100
From: Matthias Lederhofer <matled@gmx.net>
To: Milan Broz <mbroz@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, dm-crypt@saout.de
Subject: Re: freeze with swap on dm-crypt on smp system (v2.6.18-g23541d2)
Message-ID: <20061127155454.GA21409@moooo.ath.cx>
References: <20061127000234.GA2084@moooo.ath.cx> <456AF7A8.8020901@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456AF7A8.8020901@redhat.com>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Milan Broz <mbroz@redhat.com> wrote:
> [23541d2] dm crypt: move io to workqueue
> 
> So this patch is the source of problems ?
That's it.

> Please, if you can send task list when system stops responding (sysrq + t)
> and output of
> 	dmsetup table
> 	dmsetup info -c

sysrq+t output is at the end of the mail. Is there any way I'm
supposed to post such long stuff?  E.g. put it on a webserver, paste
site, in an attachment?

# dmsetup table
swap2: 0 1959867 crypt cbc(aes)-cbc-plain \
c4992e55743a12068f1767e9b855a6388b9bf0c7191ff22823a2cf74ea0dcde8 0 8:37 0
swap1: 0 1959867 crypt cbc(aes)-cbc-plain \
cb922dc385d0d1df09139eabfb32220a968a715428c91708411affbbfecaba08 0 8:21 0
swap0: 0 1959867 crypt cbc(aes)-cbc-plain \
93c36d63556fb9a42308349d18f62a78553445add2424577e39ce1fbf175dcf7 0 8:5 0
# dmsetup info -c
Name             Maj Min Stat Open Targ Event  UUID
swap2            253   2 L--w    1    1      0 
swap1            253   1 L--w    1    1      0 
swap0            253   0 L--w    1    1      0 

> Are there any messages in syslog related to this hang ?
I can't find anything, there is also nothing on the console with
loglevel set to 9.

> > While running mprime with this options I got this warning:
> >> warning: many lost ticks.
> >> Your time source seems to be instable or some driver is hogging interupts
> >> rip xor_128+0x2/0x20
> 
> Not sure if this can be related... did you try compile it without config_preempt ?
> (and dynamic overclocking in BIOS is disabled ?)
It still happens without config_preempt and afaik I don't have dynamic
overclocking enabled (I did not find anything in the bios setup, it's
a GA-M55PLUS-S3G).


SysRq : Show State

                                                       sibling
  task                 PC          pid father child younger older
init          D 000000000000000a     0     1      0     2               (NOTLB)
 ffff81003ef83b78 0000000000000082 0000000000000296 ffffffff801f2d31
 0000000000000000 ffff81003ef814e0 ffff81003ef8e080 00000000000164f8
 ffff81003ef816b8 0000000139e071c0 0000000000000000 0000000000000046
Call Trace:
 [<ffffffff801f2d31>] __up_read+0x21/0xb0
 [<ffffffff801e4a33>] __generic_unplug_device+0x13/0x30
 [<ffffffff8014d880>] sync_page+0x0/0x50
 [<ffffffff802bd398>] io_schedule+0x28/0x40
 [<ffffffff8014d8c5>] sync_page+0x45/0x50
 [<ffffffff802bd690>] __wait_on_bit_lock+0x40/0x80
 [<ffffffff8014d85f>] __lock_page+0x5f/0x70
 [<ffffffff80140f20>] wake_bit_function+0x0/0x30
 [<ffffffff80166d50>] grab_swap_token+0xa0/0x160
 [<ffffffff8015aa15>] __handle_mm_fault+0x885/0xb40
 [<ffffffff801a7d10>] proc_delete_inode+0x0/0x40
 [<ffffffff801921ce>] invalidate_inode_buffers+0xe/0x60
 [<ffffffff80119637>] do_page_fault+0x4b7/0x8d0
 [<ffffffff80126960>] default_wake_function+0x0/0x10
 [<ffffffff8019bcf3>] compat_core_sys_select+0x203/0x240
 [<ffffffff80171bcb>] vfs_getattr+0x4b/0xa0
 [<ffffffff802bed7d>] error_exit+0x0/0x84
 [<ffffffff8019b83a>] compat_set_fd_set+0x4a/0x50
 [<ffffffff8019bcc3>] compat_core_sys_select+0x1d3/0x240
 [<ffffffff8019d9ca>] compat_sys_select+0xba/0x1a0
 [<ffffffff8011c382>] ia32_sysret+0x0/0xa

migration/0   S 0000000000000001     0     2      1             3       (L-TLB)
 ffff81003ef87e90 0000000000000046 0000000000000082 ffff81003ca77e98
 0000000000000001 ffff81003ef80e00 ffffffff802f73c0 0000000000000d17
 ffff81003ef80fd8 0000000080125124 0000000300000000 ffff81003ca77e88
Call Trace:
 [<ffffffff80129083>] migration_thread+0x193/0x2c0
 [<ffffffff80128ef0>] migration_thread+0x0/0x2c0
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80201be0>] vgacon_cursor+0x0/0x1d0
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

ksoftirqd/0   S 0000000000000001     0     3      1             4     2 (L-TLB)
 ffff81003ef8bef0 0000000000000046 ffff81003ef8bf00 0000000000000046
 0000000000000086 ffff81003ef80720 ffff81003e6f77a0 00000000000005e4
 ffff81003ef808f8 000000008012584c 0000000000000013 ffff81003e6f77a0
Call Trace:
 [<ffffffff80131e90>] ksoftirqd+0x0/0xc0
 [<ffffffff80131ee1>] ksoftirqd+0x51/0xc0
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

watchdog/0    S 0000000000000001     0     4      1             5     3 (L-TLB)
 ffff81003ef8dee0 0000000000000046 0000000000000001 ffffffff802bcb83
 ffff81003ef8df00 ffff81003ef80040 ffffffff802f73c0 0000000000000157
 ffff81003ef80218 0000000000000001 ffff810001dd4b18 ffffffff802f73c0
Call Trace:
 [<ffffffff802bcb83>] thread_return+0x0/0xfd
 [<ffffffff80125124>] __wake_up_common+0x44/0x80
 [<ffffffff8014acb0>] watchdog+0x0/0x70
 [<ffffffff8014ad09>] watchdog+0x59/0x70
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

migration/1   S 0000000000000001     0     5      1             6     4 (L-TLB)
 ffff81003ef91e90 0000000000000046 0000000000000082 ffff81003d5a1e98
 0000000000000001 ffff81003ef8f520 ffff81003ef8e080 0000000000001022
 ffff81003ef8f6f8 0000000180125124 0000000300000000 ffff81003d5a1e88
Call Trace:
 [<ffffffff80129083>] migration_thread+0x193/0x2c0
 [<ffffffff80128ef0>] migration_thread+0x0/0x2c0
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

ksoftirqd/1   S 000000000000000a     0     6      1             7     5 (L-TLB)
 ffff81003ef99ef0 0000000000000046 ffff810001f818e0 000000000001325b
 ffff81003ef8f020 ffff81003ef8ee40 ffff81003ef8e080 0000000000000386
 ffff81003ef8f018 000000018012584c ffff810001dd97f8 ffff81003ef1ee80
Call Trace:
 [<ffffffff80131e90>] ksoftirqd+0x0/0xc0
 [<ffffffff80131ee1>] ksoftirqd+0x51/0xc0
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

watchdog/1    S 0000000000000009     0     7      1             8     6 (L-TLB)
 ffff81003ef9bee0 0000000000000046 000000000000000a ffffffff802bcb83
 ffff81003ef9bf00 ffff81003ef8e760 ffff81003ef8e080 00000000000003ff
 ffff81003ef8e938 0000000100000001 ffff810001dda0d8 ffff81003ef8e080
Call Trace:
 [<ffffffff802bcb83>] thread_return+0x0/0xfd
 [<ffffffff80125124>] __wake_up_common+0x44/0x80
 [<ffffffff8014acb0>] watchdog+0x0/0x70
 [<ffffffff8014ad09>] watchdog+0x59/0x70
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

events/0      S 000000000000000a     0     8      1             9     7 (L-TLB)
 ffff81003efb1e70 0000000000000046 0000000000000086 0000000000000003
 ffff81003efb1e20 ffff81003ef1f560 ffffffff802f73c0 0000000000005a8a
 ffff81003ef1f738 0000000000000000 0000000000000286 ffffffff8016c250
Call Trace:
 [<ffffffff8016c250>] cache_reap+0x0/0x130
 [<ffffffff8013d468>] run_workqueue+0xd8/0x110
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff8013dc36>] worker_thread+0xf6/0x160
 [<ffffffff80126960>] default_wake_function+0x0/0x10
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

events/1      S 000000000000000a     0     9      1            10     8 (L-TLB)
 ffff81003efb3e70 0000000000000046 0000000000000086 0000000000000003
 ffff81003efb3e20 ffff81003ef1ee80 ffff81003ef8e080 00000000000058f9
 ffff81003ef1f058 0000000100000000 0000000000000286 ffffffff8016c250
Call Trace:
 [<ffffffff8016c250>] cache_reap+0x0/0x130
 [<ffffffff8013d468>] run_workqueue+0xd8/0x110
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff8013dc36>] worker_thread+0xf6/0x160
 [<ffffffff80126960>] default_wake_function+0x0/0x10
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

khelper       S 0000000000000006     0    10      1            11     9 (L-TLB)
 ffff81003efb5e70 0000000000000046 0000000000000086 0000000000000003
 ffff81003efb5e20 ffff81003ef1e7a0 ffffffff802f73c0 0000000000000577
 ffff81003ef1e978 000000003ef83cb8 0000000000000286 ffffffff8013ce00
Call Trace:
 [<ffffffff8013ce00>] __call_usermodehelper+0x0/0x80
 [<ffffffff8013d468>] run_workqueue+0xd8/0x110
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff8013dc36>] worker_thread+0xf6/0x160
 [<ffffffff80126960>] default_wake_function+0x0/0x10
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80116410>] flat_send_IPI_mask+0x0/0x50
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

kthread       S 000000000000000a     0    11      1    35     321    10 (L-TLB)
 ffff81003efb9e70 0000000000000046 0000000000000086 0000000000000003
 ffff81003efb9e20 ffff81003ef1e0c0 ffffffff802f73c0 00000000000007d8
 ffff81003ef1e298 000000003c51f9b8 0000000000000286 ffffffff80140a60
Call Trace:
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff8013d468>] run_workqueue+0xd8/0x110
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff8013dc36>] worker_thread+0xf6/0x160
 [<ffffffff80126960>] default_wake_function+0x0/0x10
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

kblockd/0     S ffff81003ef02540     0    35     11            36       (L-TLB)
 ffff81003e517e70 0000000000000046 0000000000000086 0000000000000003
 ffff81003e517e20 ffff81003e62c240 ffff810001f81200 0000000000001637
 ffff81003e62c418 000000003ee1b2d8 0000000000000282 ffffffff801ec410
Call Trace:
 [<ffffffff801ec410>] cfq_kick_queue+0x0/0x50
 [<ffffffff8013d468>] run_workqueue+0xd8/0x110
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff8013dc36>] worker_thread+0xf6/0x160
 [<ffffffff80126960>] default_wake_function+0x0/0x10
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

kblockd/1     S 000000000000000a     0    36     11            37    35 (L-TLB)
 ffff81003e51be70 0000000000000046 0000000000000086 0000000000000003
 ffff81003e51be20 ffff81003e519720 ffff81003ef8e080 000000000000d34a
 ffff81003e5198f8 000000013ee1b2d8 0000000000000282 ffffffff801ec410
Call Trace:
 [<ffffffff801ec410>] cfq_kick_queue+0x0/0x50
 [<ffffffff8013d468>] run_workqueue+0xd8/0x110
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff8013dc36>] worker_thread+0xf6/0x160
 [<ffffffff80126960>] default_wake_function+0x0/0x10
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

kseriod       S ffffffff803187c0     0    37     11            92    36 (L-TLB)
 ffff81003ef5deb0 0000000000000046 ffffffff80314f80 ffff81003ef1c788
 00000000ffffffef ffff81003e519040 ffff81003ef1ee80 0000000000507007
 ffff81003e519218 0000000180314f80 ffff810001dd97f8 ffffffff80319670
Call Trace:
 [<ffffffff8022418d>] driver_create_file+0x3d/0x60
 [<ffffffff80249350>] serio_thread+0x0/0x330
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80249643>] serio_thread+0x2f3/0x330
 [<ffffffff80140ef0>] autoremove_wake_function+0x0/0x30
 [<ffffffff80249350>] serio_thread+0x0/0x330
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

pdflush       S 000000000000000a     0    92     11            93    37 (L-TLB)
 ffff81003ef29ec0 0000000000000046 0000000000000400 0000000000000000
 ffffffff80153940 ffff810001f80b20 ffffffff802f73c0 0000000000000195
 ffff810001f80cf8 0000000000000400 0000000000000000 0000000000000000
Call Trace:
 [<ffffffff80153940>] pdflush+0x0/0x1d0
 [<ffffffff80153940>] pdflush+0x0/0x1d0
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80153a10>] pdflush+0xd0/0x1d0
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

pdflush       S 000000000000000a     0    93     11            94    92 (L-TLB)
 ffff81003ef2bec0 0000000000000046 0000000000000282 0000000000000286
 00000000000004e2 ffff810001f81200 ffffffff802f73c0 000000000000063f
 ffff810001f813d8 00000000801534d5 0000000000000000 0000000000000000
Call Trace:
 [<ffffffff80153940>] pdflush+0x0/0x1d0
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80153a10>] pdflush+0xd0/0x1d0
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

kswapd0       D 000000000000000a     0    94     11            95    93 (L-TLB)
 ffff81003ef27a40 0000000000000046 ffff81003ef279e0 ffffffff80300a10
 ffff810001f818e0 ffff810001f818e0 ffff81003ef8e080 00000000000008bd
 ffff810001f81ab8 000000018015218b 0000000000000286 ffffffff80135f89
Call Trace:
 [<ffffffff80135f89>] lock_timer_base+0x29/0x60
 [<ffffffff802bd5da>] schedule_timeout+0x9a/0xd0
 [<ffffffff80135bd0>] process_timeout+0x0/0x10
 [<ffffffff802bce18>] io_schedule_timeout+0x28/0x40
 [<ffffffff801503a3>] mempool_alloc+0xd3/0x110
 [<ffffffff80140ef0>] autoremove_wake_function+0x0/0x30
 [<ffffffff801939a1>] bio_alloc_bioset+0xd1/0x150
 [<ffffffff80163c40>] end_swap_bio_write+0x0/0x90
 [<ffffffff80193a80>] bio_alloc+0x10/0x30
 [<ffffffff80163a9f>] get_swap_bio+0x2f/0xd0
 [<ffffffff80163d1e>] swap_writepage+0x4e/0xd0
 [<ffffffff80156178>] shrink_zone+0x9a8/0xe20
 [<ffffffff80156b6f>] kswapd+0x30f/0x460
 [<ffffffff80140ef0>] autoremove_wake_function+0x0/0x30
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80156860>] kswapd+0x0/0x460
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

aio/0         S ffff810001f65440     0    95     11            96    94 (L-TLB)
 ffff81003e543e70 0000000000000046 0000000000000064 0000000000000000
 ffff81003e542000 ffff81003e676400 ffff81003ef1e0c0 000000000000098a
 ffff81003e6765d8 000000003e676400 ffff810001dd4238 ffffffff80136d0b
Call Trace:
 [<ffffffff80136d0b>] do_sigaction+0x1ab/0x1d0
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff8013dc36>] worker_thread+0xf6/0x160
 [<ffffffff80126960>] default_wake_function+0x0/0x10
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

aio/1         S ffff810001f653c0     0    96     11           193    95 (L-TLB)
 ffff81003efbde70 0000000000000046 ffff81003efbde40 ffff81003efbddf0
 ffffffff80124fad ffff81003e676ae0 ffff81003ef1e7a0 00000000000012d4
 ffff81003e676cb8 000000013ef1e0c0 ffff810001dd97f8 0000000000000000
Call Trace:
 [<ffffffff80124fad>] deactivate_task+0x1d/0x30
 [<ffffffff80136cd2>] do_sigaction+0x172/0x1d0
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff8013dc36>] worker_thread+0xf6/0x160
 [<ffffffff80126960>] default_wake_function+0x0/0x10
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

ata/0         S ffff81003e5a2640     0   193     11           194    96 (L-TLB)
 ffff81003ee17e70 0000000000000046 0000000000000064 0000000000000000
 ffff81003ee16000 ffff81003ee14aa0 ffff81003ef1e0c0 0000000000000b4a
 ffff81003ee14c78 000000003ee14aa0 ffff810001dd4238 ffffffff80136d0b
Call Trace:
 [<ffffffff80136d0b>] do_sigaction+0x1ab/0x1d0
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff8013dc36>] worker_thread+0xf6/0x160
 [<ffffffff80126960>] default_wake_function+0x0/0x10
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

ata/1         S 0000000000000008     0   194     11           195   193 (L-TLB)
 ffff81003ee0fe70 0000000000000046 ffff81003ee0fe40 ffff81003ee0fdf0
 ffffffff80124fad ffff81003ee15180 ffff81003ef8e080 00000000000009e4
 ffff81003ee15358 000000013ef1e0c0 0000000000000086 0000000000000000
Call Trace:
 [<ffffffff80124fad>] deactivate_task+0x1d/0x30
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff8013dc36>] worker_thread+0xf6/0x160
 [<ffffffff80126960>] default_wake_function+0x0/0x10
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

ata_aux       S 0000000000000008     0   195     11           197   194 (L-TLB)
 ffff81003ee0be70 0000000000000046 ffff81003ee0be40 ffff81003ee0bdf0
 ffffffff80124fad ffff81003ee15860 ffffffff802f73c0 00000000000003f6
 ffff81003ee15a38 000000003ef1e0c0 0000000000000086 0000000000000000
Call Trace:
 [<ffffffff80124fad>] deactivate_task+0x1d/0x30
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff8013dc36>] worker_thread+0xf6/0x160
 [<ffffffff80126960>] default_wake_function+0x0/0x10
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

scsi_eh_0     S 0000000000000246     0   197     11           198   195 (L-TLB)
 ffff81003e62be70 0000000000000046 ffff81003e62be10 ffffffff80125783
 0000000000000296 ffff81003ee08a60 ffff81003ef814e0 00000000002df9e2
 ffff81003ee08c38 000000013e684098 0000000000000000 0000000000000001
Call Trace:
 [<ffffffff80125783>] __wake_up+0x43/0x70
 [<ffffffff8022ecfa>] __scsi_iterate_devices+0x5a/0x80
 [<ffffffff8023218f>] scsi_error_handler+0x6f/0x730
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80232120>] scsi_error_handler+0x0/0x730
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

scsi_eh_1     S 0000000000000246     0   198     11           219   197 (L-TLB)
 ffff81003ef2fe70 0000000000000046 ffff81003ef2fe10 ffffffff80125783
 0000000000000296 ffff81003ee09140 ffff81003ef814e0 00000000002dce40
 ffff81003ee09318 000000013ee1c098 0000000000000000 0000000000000001
Call Trace:
 [<ffffffff80125783>] __wake_up+0x43/0x70
 [<ffffffff8022ecfa>] __scsi_iterate_devices+0x5a/0x80
 [<ffffffff8023218f>] scsi_error_handler+0x6f/0x730
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80232120>] scsi_error_handler+0x0/0x730
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

scsi_eh_2     S 0000000000000246     0   219     11           220   198 (L-TLB)
 ffff81003e627e70 0000000000000046 ffff81003e627e10 ffffffff80125783
 0000000000000296 ffff81003e6b6180 ffff81003ef814e0 00000000002df821
 ffff81003e6b6358 000000013ee10098 0000000000000000 0000000000000001
Call Trace:
 [<ffffffff80125783>] __wake_up+0x43/0x70
 [<ffffffff8022ecfa>] __scsi_iterate_devices+0x5a/0x80
 [<ffffffff8023218f>] scsi_error_handler+0x6f/0x730
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80232120>] scsi_error_handler+0x0/0x730
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

scsi_eh_3     S 000000000000000a     0   220     11           237   219 (L-TLB)
 ffff81003e645e70 0000000000000046 ffff81003e645e10 ffffffff80125783
 0000000000000296 ffff81003ee08380 ffffffff802f73c0 000000000116007a
 ffff81003ee08558 000000003e66c098 0000000000000000 0000000000000001
Call Trace:
 [<ffffffff80125783>] __wake_up+0x43/0x70
 [<ffffffff8022ecfa>] __scsi_iterate_devices+0x5a/0x80
 [<ffffffff8023218f>] scsi_error_handler+0x6f/0x730
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80232120>] scsi_error_handler+0x0/0x730
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

kcryptd/0     D 000000000000000a     0   237     11           238   220 (L-TLB)
 ffff81003e6a7c50 0000000000000046 ffff810022780ff0 0000000000000001
 ffff81003ef36340 ffff81003ef36340 ffffffff802f73c0 0000000000000956
 ffff81003ef36518 000000008015227d 0000000000000286 ffffffff80135f89
Call Trace:
 [<ffffffff80135f89>] lock_timer_base+0x29/0x60
 [<ffffffff802bd5da>] schedule_timeout+0x9a/0xd0
 [<ffffffff80135bd0>] process_timeout+0x0/0x10
 [<ffffffff802bce18>] io_schedule_timeout+0x28/0x40
 [<ffffffff801503a3>] mempool_alloc+0xd3/0x110
 [<ffffffff80140ef0>] autoremove_wake_function+0x0/0x30
 [<ffffffff801939a1>] bio_alloc_bioset+0xd1/0x150
 [<ffffffff80193a80>] bio_alloc+0x10/0x30
 [<ffffffff80265d3a>] kcryptd_do_work+0x1ea/0x370
 [<ffffffff80265b50>] kcryptd_do_work+0x0/0x370
 [<ffffffff8013d442>] run_workqueue+0xb2/0x110
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff8013dc61>] worker_thread+0x121/0x160
 [<ffffffff80126960>] default_wake_function+0x0/0x10
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

kcryptd/1     D 000000000000000a     0   238     11           242   237 (L-TLB)
 ffff81003e69dc50 0000000000000046 ffff810033338ff0 0000000000000001
 ffff81003ee09820 ffff81003ee09820 ffff81003ef8e080 0000000000000877
 ffff81003ee099f8 000000018015227d 0000000000000286 ffffffff80135f89
Call Trace:
 [<ffffffff80135f89>] lock_timer_base+0x29/0x60
 [<ffffffff802bd5da>] schedule_timeout+0x9a/0xd0
 [<ffffffff80135bd0>] process_timeout+0x0/0x10
 [<ffffffff802bce18>] io_schedule_timeout+0x28/0x40
 [<ffffffff801503a3>] mempool_alloc+0xd3/0x110
 [<ffffffff80140ef0>] autoremove_wake_function+0x0/0x30
 [<ffffffff801939a1>] bio_alloc_bioset+0xd1/0x150
 [<ffffffff80193a80>] bio_alloc+0x10/0x30
 [<ffffffff80265d3a>] kcryptd_do_work+0x1ea/0x370
 [<ffffffff80265b50>] kcryptd_do_work+0x0/0x370
 [<ffffffff8013d442>] run_workqueue+0xb2/0x110
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff8013dc61>] worker_thread+0x121/0x160
 [<ffffffff80126960>] default_wake_function+0x0/0x10
 [<ffffffff8013db40>] worker_thread+0x0/0x160
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

md11_raid1    S 7fffffffffffffff     0   242     11           244   238 (L-TLB)
 ffff81003e6dde50 0000000000000046 0000000000000002 ffff81003e6ce800
 ffff81003e6dddf0 ffff81003ef36a20 ffff81003ef2cf40 0000000000000235
 ffff81003ef36bf8 000000008012584c ffff81003e6dde10 ffff81003ef2cf40
Call Trace:
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff802bd565>] schedule_timeout+0x25/0xd0
 [<ffffffff80141083>] prepare_to_wait+0x23/0x80
 [<ffffffff8025c13e>] md_thread+0xee/0x130
 [<ffffffff80140ef0>] autoremove_wake_function+0x0/0x30
 [<ffffffff8025c050>] md_thread+0x0/0x130
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

md10_raid1    S 000000000000000a     0   244     11           245   242 (L-TLB)
 ffff81003e6dfe50 0000000000000046 0000000000000002 ffff81003e6ce400
 ffff81003e6dfdf0 ffff81003ef37100 ffff81003ef8e080 0000000000001338
 ffff81003ef372d8 000000018012584c ffff810001dd97f8 ffff81003ef8e080
Call Trace:
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff802bd565>] schedule_timeout+0x25/0xd0
 [<ffffffff80141083>] prepare_to_wait+0x23/0x80
 [<ffffffff8025c13e>] md_thread+0xee/0x130
 [<ffffffff80140ef0>] autoremove_wake_function+0x0/0x30
 [<ffffffff8025c050>] md_thread+0x0/0x130
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

kjournald     S 000000000000000a     0   245     11           696   244 (L-TLB)
 ffff81003d61fe80 0000000000000046 ffff81003e6be000 0000000000000000
 ffff81003a329024 ffff81003e661820 ffffffff802f73c0 0000000000002b21
 ffff81003e6619f8 000000003e6c5a90 0000000000000000 0000000000000001
Call Trace:
 [<ffffffff801cd0f8>] kjournald+0x1a8/0x230
 [<ffffffff80140ef0>] autoremove_wake_function+0x0/0x30
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff801ccf50>] kjournald+0x0/0x230
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

udevd         S 0000000000000001     0   321      1           977    11 (NOTLB)
 ffff81003d321b08 0000000000000082 00000000fff57000 ffff81003d770740
 0000000000000001 ffff81003e660380 ffffffff802f73c0 000000000000c060
 ffff81003e660558 00000000802db5d9 0000000000000003 ffff81003e6d7000
Call Trace:
 [<ffffffff802bd565>] schedule_timeout+0x25/0xd0
 [<ffffffff801411bc>] add_wait_queue+0x1c/0x60
 [<ffffffff80199c4d>] inotify_poll+0x5d/0x80
 [<ffffffff8017c217>] do_select+0x477/0x530
 [<ffffffff8017c8a0>] __pollwait+0x0/0x120
 [<ffffffff80126960>] default_wake_function+0x0/0x10
 [<ffffffff80126960>] default_wake_function+0x0/0x10
 [<ffffffff80126960>] default_wake_function+0x0/0x10
 [<ffffffff80126960>] default_wake_function+0x0/0x10
 [<ffffffff80184bb4>] mntput_no_expire+0x24/0xa0
 [<ffffffff801780b5>] __link_path_walk+0x6e5/0xd90
 [<ffffffff80180174>] d_lookup+0x24/0x50
 [<ffffffff80184bb4>] mntput_no_expire+0x24/0xa0
 [<ffffffff80178860>] link_path_walk+0x100/0x140
 [<ffffffff801410f9>] remove_wait_queue+0x19/0x60
 [<ffffffff8012fa3d>] do_wait+0xabd/0xbb0
 [<ffffffff8016f08b>] vfs_read+0x11b/0x160
 [<ffffffff80126960>] default_wake_function+0x0/0x10
 [<ffffffff8019bc8d>] compat_core_sys_select+0x19d/0x240
 [<ffffffff8019d9ee>] compat_sys_select+0xde/0x1a0
 [<ffffffff8011c382>] ia32_sysret+0x0/0xa

md126_raid1   S 000000000000000a     0   696     11                 245 (L-TLB)
 ffff81003ce01e50 0000000000000046 0000000000000002 ffff81003d2eb400
 0000000000000000 ffff81003e6c01c0 ffff81003ef8e080 000000000000073e
 ffff81003e6c0398 000000018012584c ffff81003ce01e10 ffff81003ef8e080
Call Trace:
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff802bd565>] schedule_timeout+0x25/0xd0
 [<ffffffff80141083>] prepare_to_wait+0x23/0x80
 [<ffffffff8025c13e>] md_thread+0xee/0x130
 [<ffffffff80140ef0>] autoremove_wake_function+0x0/0x30
 [<ffffffff8025c050>] md_thread+0x0/0x130
 [<ffffffff80140bb9>] kthread+0xd9/0x120
 [<ffffffff8010a958>] child_rip+0xa/0x12
 [<ffffffff80140a60>] keventd_create_kthread+0x0/0x80
 [<ffffffff80140ae0>] kthread+0x0/0x120
 [<ffffffff8010a94e>] child_rip+0x0/0x12

syslogd       D 0000000000000009     0   977      1           983   321 (NOTLB)
 ffff81003aa45628 0000000000000082 0000000000000000 ffffffff80300a10
 ffff81003e6f69e0 ffff81003e6f69e0 ffff81003ef8e080 0000000000000995
 ffff81003e6f6bb8 000000018015218b 0000000000000286 ffffffff80135f89
Call Trace:
 [<ffffffff80135f89>] lock_timer_base+0x29/0x60
 [<ffffffff802bd5da>] schedule_timeout+0x9a/0xd0
 [<ffffffff80135bd0>] process_timeout+0x0/0x10
 [<ffffffff802bce18>] io_schedule_timeout+0x28/0x40
 [<ffffffff801503a3>] mempool_alloc+0xd3/0x110
 [<ffffffff80140ef0>] autoremove_wake_function+0x0/0x30
 [<ffffffff8012693c>] try_to_wake_up+0x38c/0x3b0
 [<ffffffff801939a1>] bio_alloc_bioset+0xd1/0x150
 [<ffffffff80163c40>] end_swap_bio_write+0x0/0x90
 [<ffffffff80193a80>] bio_alloc+0x10/0x30
 [<ffffffff80163a9f>] get_swap_bio+0x2f/0xd0
 [<ffffffff80163d1e>] swap_writepage+0x4e/0xd0
 [<ffffffff80156178>] shrink_zone+0x9a8/0xe20
 [<ffffffff801907e9>] __find_get_block+0x169/0x180
 [<ffffffff801c6d2c>] do_get_write_access+0x53c/0x590
 [<ffffffff80156e27>] try_to_free_pages+0x167/0x260
 [<ffffffff8015224d>] __alloc_pages+0x1bd/0x2d0
 [<ffffffff80163ef3>] read_swap_cache_async+0x43/0xe0
 [<ffffffff80158ac6>] swapin_readahead+0x56/0x90
 [<ffffffff8015a969>] __handle_mm_fault+0x7d9/0xb40
 [<ffffffff80119637>] do_page_fault+0x4b7/0x8d0
 [<ffffffff80131a6b>] current_fs_time+0x3b/0x40
 [<ffffffff80125783>] __wake_up+0x43/0x70
 [<ffffffff80183350>] file_update_time+0x30/0xb0
 [<ffffffff802bed7d>] error_exit+0x0/0x84
 [<ffffffff80271760>] datagram_poll+0x0/0xf0
 [<ffffffff8011e6e7>] ia32_setup_frame+0x67/0x1a0
 [<ffffffff8011e6b7>] ia32_setup_frame+0x37/0x1a0
 [<ffffffff801091ac>] do_notify_resume+0x1cc/0x7a0
 [<ffffffff801316b0>] getnstimeofday+0x10/0x30
 [<ffffffff80109dc6>] int_signal+0x12/0x17

klogd         R  running task       0   983      1          1048   977 (NOTLB)
login         S 0000000000000008     0  1048      1  1167    1091   983 (NOTLB)
 ffff81003b34fde8 0000000000000082 0000000000000001 ffffffff80158e0a
 0000000100000008 ffff81003ee143c0 ffff81003ef8e080 0000000000005a82
 ffff81003ee14598 000000013d103000 800000003b300065 ffff810001d5ba40
Call Trace:
 [<ffffffff80158e0a>] do_wp_page+0x1aa/0x4d0
 [<ffffffff8012fa05>] do_wait+0xa85/0xbb0
 [<ffffffff8012b83f>] copy_process+0x10ef/0x1280
 [<ffffffff80126960>] default_wake_function+0x0/0x10
 [<ffffffff801082eb>] __switch_to+0x12b/0x2c0
 [<ffffffff801498d1>] compat_sys_wait4+0x41/0xf0
 [<ffffffff802bcb83>] thread_return+0x0/0xfd
 [<ffffffff802bed7d>] error_exit+0x0/0x84
 [<ffffffff8011c382>] ia32_sysret+0x0/0xa

login         S ffff81003e6cb7d8     0  1091      1  1092          1048 (NOTLB)
 ffff81003c9d3de8 0000000000000082 0000000000000001 ffffffff80158e0a
 0000000100000008 ffff81003ef22f00 ffff81003e6f69e0 00000000000056b1
 ffff81003ef230d8 000000013d798000 ffff810001dda0d8 ffff810001cd6180
Call Trace:
 [<ffffffff80158e0a>] do_wp_page+0x1aa/0x4d0
 [<ffffffff8015ac10>] __handle_mm_fault+0xa80/0xb40
 [<ffffffff8012fa05>] do_wait+0xa85/0xbb0
 [<ffffffff8012b83f>] copy_process+0x10ef/0x1280
 [<ffffffff80126960>] default_wake_function+0x0/0x10
 [<ffffffff801082eb>] __switch_to+0x12b/0x2c0
 [<ffffffff801498d1>] compat_sys_wait4+0x41/0xf0
 [<ffffffff802bcb83>] thread_return+0x0/0xfd
 [<ffffffff802bed7d>] error_exit+0x0/0x84
 [<ffffffff8011c382>] ia32_sysret+0x0/0xa

bash          D 0000000000000009     0  1092   1091                     (NOTLB)
 ffff81003e629638 0000000000000082 00000000001763fc ffffffff80300a10
 ffff81003e6cb6a0 ffff81003e6cb6a0 ffff81003ef8e080 0000000000000917
 ffff81003e6cb878 000000018015218b 0000000000000286 ffffffff80135f89
Call Trace:
 [<ffffffff80135f89>] lock_timer_base+0x29/0x60
 [<ffffffff802bd5da>] schedule_timeout+0x9a/0xd0
 [<ffffffff80135bd0>] process_timeout+0x0/0x10
 [<ffffffff802bce18>] io_schedule_timeout+0x28/0x40
 [<ffffffff801503a3>] mempool_alloc+0xd3/0x110
 [<ffffffff80140ef0>] autoremove_wake_function+0x0/0x30
 [<ffffffff801939a1>] bio_alloc_bioset+0xd1/0x150
 [<ffffffff80163c40>] end_swap_bio_write+0x0/0x90
 [<ffffffff80193a80>] bio_alloc+0x10/0x30
 [<ffffffff80163a9f>] get_swap_bio+0x2f/0xd0
 [<ffffffff80163d1e>] swap_writepage+0x4e/0xd0
 [<ffffffff80156178>] shrink_zone+0x9a8/0xe20
 [<ffffffff8014d7c9>] find_get_page+0x29/0x60
 [<ffffffff801907e9>] __find_get_block+0x169/0x180
 [<ffffffff801907e9>] __find_get_block+0x169/0x180
 [<ffffffff80156e27>] try_to_free_pages+0x167/0x260
 [<ffffffff8015224d>] __alloc_pages+0x1bd/0x2d0
 [<ffffffff80163ef3>] read_swap_cache_async+0x43/0xe0
 [<ffffffff80158ac6>] swapin_readahead+0x56/0x90
 [<ffffffff8015a969>] __handle_mm_fault+0x7d9/0xb40
 [<ffffffff802bd5e2>] schedule_timeout+0xa2/0xd0
 [<ffffffff8021dfa0>] serial8250_tx_empty+0x40/0x60
 [<ffffffff80119637>] do_page_fault+0x4b7/0x8d0
 [<ffffffff80125e99>] find_busiest_group+0x219/0x4c0
 [<ffffffff801082eb>] __switch_to+0x12b/0x2c0
 [<ffffffff802bed7d>] error_exit+0x0/0x84
 [<ffffffff801f4ec2>] copy_user_generic_string+0x12/0x40
 [<ffffffff80208def>] copy_from_read_buf+0x8f/0xf0
 [<ffffffff8020a7a5>] read_chan+0x535/0x6c0
 [<ffffffff80126960>] default_wake_function+0x0/0x10
 [<ffffffff80207086>] tty_read+0x86/0xf0
 [<ffffffff8016f02a>] vfs_read+0xba/0x160
 [<ffffffff8016f523>] sys_read+0x53/0x90
 [<ffffffff8011c382>] ia32_sysret+0x0/0xa

mprime        D 000000000000000a     0  1167   1048                     (NOTLB)
 ffff81003d5a18d8 0000000000200086 ffff81003d5a1878 ffffffff80300a10
 ffff81003e6f77a0 ffff81003e6f77a0 ffff81003ef8e080 0000000000000a2b
 ffff81003e6f7978 000000018015218b 0000000000200286 ffffffff80135f89
Call Trace:
 [<ffffffff80135f89>] lock_timer_base+0x29/0x60
 [<ffffffff802bd5da>] schedule_timeout+0x9a/0xd0
 [<ffffffff80135bd0>] process_timeout+0x0/0x10
 [<ffffffff802bce18>] io_schedule_timeout+0x28/0x40
 [<ffffffff801503a3>] mempool_alloc+0xd3/0x110
 [<ffffffff80140ef0>] autoremove_wake_function+0x0/0x30
 [<ffffffff801939a1>] bio_alloc_bioset+0xd1/0x150
 [<ffffffff80163c40>] end_swap_bio_write+0x0/0x90
 [<ffffffff80193a80>] bio_alloc+0x10/0x30
 [<ffffffff80163a9f>] get_swap_bio+0x2f/0xd0
 [<ffffffff80163d1e>] swap_writepage+0x4e/0xd0
 [<ffffffff80156178>] shrink_zone+0x9a8/0xe20
 [<ffffffff802bcb83>] thread_return+0x0/0xfd
 [<ffffffff80140ef0>] autoremove_wake_function+0x0/0x30
 [<ffffffff80156e27>] try_to_free_pages+0x167/0x260
 [<ffffffff80140ef0>] autoremove_wake_function+0x0/0x30
 [<ffffffff8015224d>] __alloc_pages+0x1bd/0x2d0
 [<ffffffff8015a6a3>] __handle_mm_fault+0x513/0xb40
 [<ffffffff80119637>] do_page_fault+0x4b7/0x8d0
 [<ffffffff8015f906>] do_mmap_pgoff+0x656/0x7e0
 [<ffffffff802bed7d>] error_exit+0x0/0x84
