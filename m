Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbVK2JcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbVK2JcI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 04:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbVK2JcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 04:32:07 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:8901 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750961AbVK2JcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 04:32:06 -0500
Date: Tue, 29 Nov 2005 10:32:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rt15: cannot build with !PREEMPT_RT
Message-ID: <20051129093231.GA5028@elte.hu>
References: <1133031912.5904.12.camel@mindpipe> <1133034406.32542.308.camel@tglx.tec.linutronix.de> <20051127123052.GA22807@elte.hu> <1133141224.4909.1.camel@mindpipe> <20051128114852.GA3391@elte.hu> <1133189789.5228.7.camel@mindpipe> <20051128160052.GA29540@elte.hu> <1133217651.4678.2.camel@mindpipe> <1133230103.5640.0.camel@mindpipe> <20051129072922.GA21696@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051129072922.GA21696@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.3 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > On Mon, 2005-11-28 at 17:40 -0500, Lee Revell wrote:
> > > 2.6.11-RT-V0.7.40-04 works
> > 
> > and 2.6.12-RT-V0.7.51-28 does not.
> 
> thanks. I have further narrowed it down from this point: your .config 
> breaks from the 51-01 to the 51-02 kernel (on my testbox).

ok, fixed this one, it was the CURRENT_PTR optimization on UP that broke 
if 4K stacks were enabled. (i disabled the optimization for now)

But interestingly, your .config unearthed 2 other serious bugs (!) as 
well: the spin_unlock_irq() upon printk was incorrect for !PREEMPT_RT, 
and there was an assert introduced by the get-rid-of-bitlocks ext3 
patches which was invalid on UP && !PREEMPT_RT. We had these bugs for 
quite some time.

I've released -rt21 with these fixes, does it work better for you?

	Ingo
