Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269945AbUJTKsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269945AbUJTKsL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 06:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269942AbUJTKmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 06:42:55 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:53518 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S269401AbUJTKi7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 06:38:59 -0400
Message-ID: <4176403B.5@stud.feec.vutbr.cz>
Date: Wed, 20 Oct 2004 12:38:51 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041005)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu>
In-Reply-To: <20041020094508.GA29080@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the -U8 Real-Time Preemption patch:
> 
>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U8
> 

I'm getting these BUGs when I use netconsole with Real-Time Preemption 
(but netconsole works):

kjournald starting.  Commit interval 5 seconds
BUG: sleeping function called from invalid context kjournald(775) at 
kernel/mutex.c:25
in_atomic():0 [00000000], irqs_disabled():1
  [<c0105fbe>] dump_stack+0x1e/0x20 (20)
  [<c01194d8>] __might_sleep+0xb8/0xd0 (36)
  [<c0130bc0>] _mutex_lock+0x20/0x40 (20)
  [<c02675f7>] netpoll_send_skb+0x37/0xc0 (28)
  [<c0231081>] write_msg+0x41/0x60 (36)
  [<c011c208>] __call_console_drivers+0x58/0x60 (32)
  [<c011c326>] call_console_drivers+0x96/0x140 (40)
  [<c011c6e1>] release_console_sem+0x71/0x100 (36)
  [<c011c5b6>] vprintk+0x116/0x180 (36)
  [<c011c498>] printk+0x18/0x20 (16)
  [<c01a31af>] kjournald+0x8f/0x250 (140)
  [<c01032d1>] kernel_thread_helper+0x5/0x14 (141484052)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x18/0x50 / (dump_stack+0x1e/0x20)

EXT3 FS on hda8, <3>BUG: sleeping function called from invalid context 
mount(786) at kernel/mutex.c:25
in_atomic():0 [00000000], irqs_disabled():1
  [<c0105fbe>] dump_stack+0x1e/0x20 (20)
  [<c01194d8>] __might_sleep+0xb8/0xd0 (36)
  [<c0130bc0>] _mutex_lock+0x20/0x40 (20)
  [<c02675f7>] netpoll_send_skb+0x37/0xc0 (28)
  [<c0231081>] write_msg+0x41/0x60 (36)
  [<c011c208>] __call_console_drivers+0x58/0x60 (32)
  [<c011c302>] call_console_drivers+0x72/0x140 (40)
  [<c011c6e1>] release_console_sem+0x71/0x100 (36)
  [<c011c5b6>] vprintk+0x116/0x180 (36)
  [<c011c498>] printk+0x18/0x20 (16)
  [<c01989f2>] ext3_setup_super+0xd2/0x1c0 (80)
  [<c019a5ed>] ext3_remount+0x12d/0x190 (48)
  [<c015d9b0>] do_remount_sb+0xa0/0xf0 (32)
  [<c0173c6d>] do_remount+0x6d/0xc0 (36)
  [<c01745fb>] do_mount+0x19b/0x1b0 (116)
  [<c01749e7>] sys_mount+0x97/0xe0 (48)
  [<c010518f>] syscall_call+0x7/0xb (-8124)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x18/0x50 / (dump_stack+0x1e/0x20)

internal journal


I have hacked the sk98lin driver to support netpoll (I sent the patch to 
netdev), so maybe I did something wrong and these BUGs are my own fault.

Does anybody else use netconsole with Real-Time Preemption?

Michal
