Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268097AbUJCTz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268097AbUJCTz7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 15:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268104AbUJCTz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 15:55:58 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:23785 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268097AbUJCTz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 15:55:56 -0400
Date: Sun, 3 Oct 2004 21:57:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm4-S7
Message-ID: <20041003195725.GA31882@elte.hu>
References: <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <1096785457.1837.0.camel@krustophenia.net> <1096786248.1837.4.camel@krustophenia.net> <1096787179.1837.8.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096787179.1837.8.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> Finally, there's this one which makes no sense to me:
> 
> preemption latency trace v1.0.7 on 2.6.9-rc2-mm4-VP-S7
> -------------------------------------------------------
>  latency: 507 us, entries: 45 (45)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:1]
>     -----------------
>     | task: events/0/3, uid:0 nice:-10 policy:0 rt_prio:0
>     -----------------
>  => started at: kernel_fpu_begin+0x15/0x70
>  => ended at:   _mmx_memcpy+0x13a/0x180
> =======>
> 00000001 0.000ms (+0.002ms): kernel_fpu_begin (_mmx_memcpy)
> 00010001 0.002ms (+0.000ms): do_IRQ (_mmx_memcpy)

> 00000002 0.028ms (+0.478ms): preempt_schedule (try_to_wake_up)
> 00000001 0.507ms (+0.000ms): sub_preempt_count (_mmx_memcpy)

> 478 usecs in try_to_wake_up?

no, 478 usecs in _mmx_memcpy - the timer interrupt interrupted that
function and we returned to it after the timer irq. We only know that
the latency happens between try_to_wake_up()'s preempt_schedule() and
_mmax_memcpy. Latency tracing does not capture function exits (would be
too costly) so effects of two functions can add up. The try_to_wake_up()
was simply the last function _entry_ that happened in the timer irq,
that's why it got 'credited' for the latency.

do you still have the stacktrace too that went to the syslog? What
codepath called _mmx_memcpy()?

	Ingo
