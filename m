Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269788AbUJSWF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269788AbUJSWF0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 18:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269903AbUJSVre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 17:47:34 -0400
Received: from smtp2.netcabo.pt ([212.113.174.29]:54821 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S267549AbUJSVdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 17:33:16 -0400
Message-ID: <32844.192.168.1.5.1098221406.squirrel@192.168.1.5>
In-Reply-To: <20041019180059.GA23113@elte.hu>
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
    <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
    <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
    <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
    <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
    <20041019180059.GA23113@elte.hu>
Date: Tue, 19 Oct 2004 22:30:06 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U7
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 19 Oct 2004 21:33:12.0989 (UTC) FILETIME=[3C9784D0:01C4B623]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> i have released the -U7 Real-Time Preemption patch:
>
>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U7
>

Not critical, but I'm "consistently" getting stuck while running mkinitrd,
both on SMP (SuSE9.1, reiserfs) and UP (Mdk10.1c, ext3). This was
happening with U6 too.

Anyone care to confirm?


Some more incidents on 2.6.9-rc5-mm1-RT-U7.0smp:

kernel BUG at lib/rwsem-generic.c:130!
invalid operand: 0000 [#1]
PREEMPT SMP
Modules linked in: loop nls_iso8859_15 nls_cp860 vfat fat nls_base snd_seq
usbhi
d ehci_hcd uhci_hcd intel_mch_agp agpgart mga snd_usb_usx2y snd_usb_lib
snd_rawm
idi snd_seq_device snd_hwdep snd_intel8x0 snd_ac97_codec snd_pcm snd_timer
snd s
oundcore snd_page_alloc evdev sk98lin w83781d i2c_sensor i2c_isa i2c_i801
i2c_co
re wacom usbcore subfs dm_mod
CPU:    0
EIP:    0060:[<c01e3e5d>]    Not tainted VLI
EFLAGS: 00010002   (2.6.9-rc4-mm1-RT-U7.0smp)
EIP is at rwsem_owner_del+0x68/0x8c
eax: f41c0a50   ebx: cb736000   ecx: 00000001   edx: 00000001
esi: 00000001   edi: cdf30218   ebp: cb737fa0   esp: cb737f94
ds: 007b   es: 007b   ss: 0068   preempt: 00000003
Process loop0 (pid: 23481, threadinfo=cb736000 task=f71ba7d0)
Stack: cdf3021c cdf30000 cdf30218 cb737fc8 c01e42d0 cdf30218 f71ba7d0
c1806cd4
       c1806820 00000282 f8c839aa cdf30000 cdf30448 cb737fec f8c83a0f
f71ba7d0
       ffffffec 00000000 cdf30218 f8c839aa 00000000 00000000 00000000
c01025c9
Call Trace:
 [<c0105235>] show_stack+0xaf/0xb7 (28)
 [<c01053c5>] show_registers+0x168/0x1dd (56)
 [<c01055ce>] die+0x107/0x18f (64)
 [<c0105aee>] do_invalid_op+0x109/0x10b (188)
 [<c0104e7d>] error_code+0x2d/0x38 (80)
 [<c01e42d0>] up_write+0x57/0x1a1 (40)
 [<f8c83a0f>] loop_thread+0x65/0x11d [loop] (36)
 [<c01025c9>] kernel_thread_helper+0x5/0xb (881623060)
preempt count: 00000004
. 4-level deep critical section nesting:
.. entry 1: _spin_lock+0x17/0x6d / (up_write+0x110/0x1a1)
.. entry 2: _spin_lock+0x17/0x6d / (up_write+0x4f/0x1a1)
.. entry 3: _spin_lock_irqsave+0x17/0x70 / (die+0x3f/0x18f)
.. entry 4: print_traces+0x16/0x4c / (show_stack+0xaf/0xb7)

Code: 00 e0 ff ff 21 e3 8b 44 8f 18 3b 03 74 2a 83 c1 01 89 d6 39 d1 7c ef
8b 15
 60 fa 31 c0 85 d2 74 12 c7 05 60 fa 31 c0 00 00 00 00 <0f> 0b 82 00 0b 96
2e c0
 5b 5e 5f 5d c3 8d 56 ff 39 d1 74 08 8b
 <6>note: loop0[23481] exited with preempt_count 2
BUG: sleeping function called from invalid context loop0(23481) at
lib/rwsem-gen
eric.c:398
in_atomic():1 [00000002], irqs_disabled():0
 [<c010525b>] dump_stack+0x1e/0x20 (20)
 [<c0118408>] __might_sleep+0xb7/0xca (36)
 [<c02ca11c>] down_write+0x1f/0x184 (44)
 [<c011cfbc>] exit_notify+0x26/0x97f (60)
 [<c011db93>] do_exit+0x27e/0x492 (40)
 [<c0105656>] do_divide_error+0x0/0x12c (64)
 [<c0105aee>] do_invalid_op+0x109/0x10b (188)
 [<c0104e7d>] error_code+0x2d/0x38 (80)
 [<c01e42d0>] up_write+0x57/0x1a1 (40)
 [<f8c83a0f>] loop_thread+0x65/0x11d [loop] (36)
 [<c01025c9>] kernel_thread_helper+0x5/0xb (881623060)
preempt count: 00000003
. 3-level deep critical section nesting:
.. entry 1: _spin_lock+0x17/0x6d / (up_write+0x110/0x1a1)
.. entry 2: _spin_lock+0x17/0x6d / (up_write+0x4f/0x1a1)
.. entry 3: print_traces+0x16/0x4c / (dump_stack+0x1e/0x20)

BUG: scheduling while atomic: loop0/0x00000002/23481
caller is do_exit+0x287/0x492
 [<c010525b>] dump_stack+0x1e/0x20 (20)
 [<c02c90d6>] __schedule+0x836/0xc81 (116)
 [<c011db9c>] do_exit+0x287/0x492 (40)
 [<c0105656>] do_divide_error+0x0/0x12c (64)
 [<c0105aee>] do_invalid_op+0x109/0x10b (188)
 [<c0104e7d>] error_code+0x2d/0x38 (80)
 [<c01e42d0>] up_write+0x57/0x1a1 (40)
 [<f8c83a0f>] loop_thread+0x65/0x11d [loop] (36)
 [<c01025c9>] kernel_thread_helper+0x5/0xb (881623060)
preempt count: 00000003
. 3-level deep critical section nesting:
.. entry 1: _spin_lock+0x17/0x6d / (up_write+0x110/0x1a1)
.. entry 2: _spin_lock+0x17/0x6d / (up_write+0x4f/0x1a1)
.. entry 3: print_traces+0x16/0x4c / (dump_stack+0x1e/0x20)


Bye now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

