Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270221AbUJSXri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270221AbUJSXri (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270220AbUJSXq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:46:57 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:55505 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S270211AbUJSXjN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 19:39:13 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U7
From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
In-Reply-To: <20041019180059.GA23113@elte.hu>
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
	 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
	 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
	 <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
	 <20041019180059.GA23113@elte.hu>
Content-Type: text/plain
Organization: 
Message-Id: <1098229098.26927.40.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Oct 2004 16:38:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 11:00, Ingo Molnar wrote:
> i have released the -U7 Real-Time Preemption patch:
> 
>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U7
> 
> this too is a fixes-only release.

First Ux I try to boot, on install I get this:

WARNING:
/lib/modules/2.6.8-1.520.1rU7.ll.rhfc2.ccrma/kernel/drivers/scsi/aacraid/aacraid.ko needs unknown symbol __you_cannot_kmalloc_that_much
WARNING:
/lib/modules/2.6.8-1.520.1rU7.ll.rhfc2.ccrma/kernel/drivers/message/i2o/i2o_block.ko needs unknown symbol i2o_msg_in_to_virt
WARNING:
/lib/modules/2.6.8-1.520.1rU7.ll.rhfc2.ccrma/kernel/drivers/message/i2o/i2o_core.ko needs unknown symbol i2o_msg_in_to_virt
WARNING:
/lib/modules/2.6.8-1.520.1rU7.ll.rhfc2.ccrma/kernel/drivers/message/i2o/i2o_core.ko needs unknown symbol i2o_msg_out_to_virt
WARNING:
/lib/modules/2.6.8-1.520.1rU7.ll.rhfc2.ccrma/kernel/drivers/message/i2o/i2o_scsi.ko needs unknown symbol i2o_msg_in_to_virt

No luck booting, I get a kernel panic, the last lines printed to the
screen are like this (transcribed by hand, there may be errors):

printk+0x17/0x20 (20)
print_preempt_trace+0x51/0xa0 (12)
print_traces+0x1e/0x40 (24)
show_stack+0x70/0x90 (8)
error_code+0x2d/0x38 (20)
down_write_interruptible+0xba/0x278 (52)
scsi_error_handler+0x98/0x1a0 [scsi_mod] (44)
scsi_error_handler+0x0/0x1a0 [scsi_mod] (284)
kernel_thread_helper+0x5/0x18 (8)

preempt count: 04000008
. 8 level deep critical section nesting:
.. entry 1: down_write_interruptible+0x273/0x278 / (0x0)
.. entry 2: down_write_interruptible+0x5a/0x278 / (0x0)
.. entry 3: __schedule+0x34/0x650 / (0x0)
.. entry 4: __schedule+0xcb/0x650 / (0x0)
.. entry 5: __schedule+0x34/0x650 / (0x0)
.. entry 6: __schedule+0xcb/0x650 / (0x0)
.. entry 7: die+0x36/0x180 / (0x0)
.. entry 8: print_traces+0xd/0x40 / (0x0)
<0> Kernel panic - not syncing: Fatal exception in interrupt

I hope this can be useful...
-- Fernando


