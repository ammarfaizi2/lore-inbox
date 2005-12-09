Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVLIBEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVLIBEI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 20:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVLIBEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 20:04:08 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:50117 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750736AbVLIBEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 20:04:06 -0500
Subject: Re: 2.6.14-rt15: cannot build with !PREEMPT_RT
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <20051129093231.GA5028@elte.hu>
References: <1133031912.5904.12.camel@mindpipe>
	 <1133034406.32542.308.camel@tglx.tec.linutronix.de>
	 <20051127123052.GA22807@elte.hu> <1133141224.4909.1.camel@mindpipe>
	 <20051128114852.GA3391@elte.hu> <1133189789.5228.7.camel@mindpipe>
	 <20051128160052.GA29540@elte.hu> <1133217651.4678.2.camel@mindpipe>
	 <1133230103.5640.0.camel@mindpipe> <20051129072922.GA21696@elte.hu>
	 <20051129093231.GA5028@elte.hu>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 20:05:15 -0500
Message-Id: <1134090316.11053.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-29 at 10:32 +0100, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > * Lee Revell <rlrevell@joe-job.com> wrote:
> > 
> > > On Mon, 2005-11-28 at 17:40 -0500, Lee Revell wrote:
> > > > 2.6.11-RT-V0.7.40-04 works
> > > 
> > > and 2.6.12-RT-V0.7.51-28 does not.
> > 
> > thanks. I have further narrowed it down from this point: your .config 
> > breaks from the 51-01 to the 51-02 kernel (on my testbox).
> 
> ok, fixed this one, it was the CURRENT_PTR optimization on UP that broke 
> if 4K stacks were enabled. (i disabled the optimization for now)
> 
> But interestingly, your .config unearthed 2 other serious bugs (!) as 
> well: the spin_unlock_irq() upon printk was incorrect for !PREEMPT_RT, 
> and there was an assert introduced by the get-rid-of-bitlocks ext3 
> patches which was invalid on UP && !PREEMPT_RT. We had these bugs for 
> quite some time.
> 
> I've released -rt21 with these fixes, does it work better for you?

Ingo,

We are unable to build a similar .config (PREEMPT_DESKTOP with soft and
hardirq preemption disabled) on x86-64:

In file included from include/linux/mm.h:15,
                 from kernel/printk.c:20:
include/linux/fs.h: In function `lock_super':
include/linux/fs.h:849: warning: implicit declaration of function `down'
include/linux/fs.h: In function `unlock_super':
include/linux/fs.h:855: warning: implicit declaration of function `up'

Let me know if you need the exact .config

Lee

