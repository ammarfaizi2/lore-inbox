Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267235AbUJRR5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267235AbUJRR5u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 13:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267250AbUJRR5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 13:57:50 -0400
Received: from brown.brainfood.com ([146.82.138.61]:3456 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S267235AbUJRR5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 13:57:44 -0400
Date: Mon, 18 Oct 2004 12:57:34 -0500 (CDT)
From: Adam Heath <adam@doogie.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
In-Reply-To: <20041018145008.GA25707@elte.hu>
Message-ID: <Pine.LNX.4.58.0410181249150.1218@gradall.private.brainfood.com>
References: <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
 <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
 <20041018145008.GA25707@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004, Ingo Molnar wrote:

>
> i have released the -U5 Real-Time Preemption patch:
>
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U5
>

EXT3 FS on hda5, internal journal
(mount/71/CPU#0): new 493 us maximum-latency critical section.
 => started at timestamp 29143938: <kernel_fpu_begin+0x21/0x60>
 =>   ended at timestamp 29144431: <_mmx_memcpy+0x131/0x180>
 [<c0132480>] sub_preempt_count+0x60/0x90
 [<c01321ff>] check_preempt_timing+0x1af/0x250
 [<c01dcf51>] _mmx_memcpy+0x131/0x180
 [<c0132480>] sub_preempt_count+0x60/0x90
 [<c01dcf51>] _mmx_memcpy+0x131/0x180
 [<c01dcf51>] _mmx_memcpy+0x131/0x180
 [<c01e3625>] vgacon_scroll+0x245/0x260
 [<c01f3bba>] scrup+0xda/0xf0
 [<c0113104>] mcount+0x14/0x18
 [<c01f5702>] lf+0x72/0x80
 [<c01f7e9f>] vt_console_print+0x13f/0x320
 [<c011c231>] __call_console_drivers+0x61/0x70
 [<c011c35a>] call_console_drivers+0x9a/0x140
 [<c011c721>] release_console_sem+0x71/0x100
 [<c011c5f6>] vprintk+0x116/0x180
 [<c011c4dd>] printk+0x1d/0x20
 [<c01a0957>] ext3_setup_super+0x127/0x1b0
 [<c01db07f>] up_write+0x4f/0x80
 [<c01a2552>] ext3_remount+0x132/0x190
 [<c01dae41>] down_write+0x71/0xa0
 [<c0162903>] do_remount_sb+0xb3/0xe0
 [<c0179712>] do_remount+0x72/0xc0
 [<c017a073>] do_mount+0x1a3/0x1b0
 [<c01dae41>] down_write+0x71/0xa0
 [<c017a3ec>] sys_mount+0x9c/0x100
 [<c0106013>] syscall_call+0x7/0xb
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: kernel_fpu_begin+0x21/0x60 / (_mmx_memcpy+0x36/0x180)
.. entry 2: print_traces+0x1d/0x70 / (dump_stack+0x23/0x30)

 =>   dump-end timestamp 29144924

The kernel is jsut getting ready to start init at this point(mounting root),
so I don't know if you are really interested in this high latency trace, but
I'm sending anyways.

However, after I reset the threshold to 50(and got a few small traces), I got
this whopper.

(XFree86/1129/CPU#0): new 4692 us maximum-latency critical section.
 => started at timestamp 358506933: <call_console_drivers+0x76/0x140>
 =>   ended at timestamp 358511625: <finish_task_switch+0x43/0xa0>
 [<c0132480>] sub_preempt_count+0x60/0x90
 [<c01321ff>] check_preempt_timing+0x1af/0x250
 [<c0117ca3>] finish_task_switch+0x43/0xa0
 [<c0132480>] sub_preempt_count+0x60/0x90
 [<c0117ca3>] finish_task_switch+0x43/0xa0
 [<c0117ca3>] finish_task_switch+0x43/0xa0
 [<c02a2859>] __sched_text_start+0x2d9/0x570
 [<c02a3323>] schedule_timeout+0x63/0xc0
 [<c02a316e>] cond_resched+0xe/0x90
 [<c01253a0>] process_timeout+0x0/0x20
 [<c02a3185>] cond_resched+0x25/0x90
 [<c016f592>] do_select+0x172/0x280
 [<c016f280>] __pollwait+0x0/0xb0
 [<c016f984>] sys_select+0x294/0x570
 [<c0106013>] syscall_call+0x7/0xb
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: __sched_text_start+0x3b/0x570 / (schedule_timeout+0x63/0xc0)
.. entry 2: print_traces+0x1d/0x70 / (dump_stack+0x23/0x30)

 =>   dump-end timestamp 358512077

ps: I've never mentioned the hardware I am running.  Athlon XP 2000, 1G ram,
    460G(usable) software raid5(3*250g ide)(plus boot 120G), LVM, extra
    SiliconImage UDMA133 controller(mobo can only do 100).

    I'm not certain what kind of latencies to expect with this setup.  I'm
    tending to ignore <100us, at least for now.
