Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268107AbUJCUDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268107AbUJCUDh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 16:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268111AbUJCUDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 16:03:37 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:49387 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268107AbUJCUDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 16:03:33 -0400
Date: Sun, 3 Oct 2004 22:05:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm4-S7
Message-ID: <20041003200513.GA32090@elte.hu>
References: <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <1096785457.1837.0.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096785457.1837.0.camel@krustophenia.net>
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

> This one was caused by amlat:
> 
> preemption latency trace v1.0.7 on 2.6.9-rc2-mm4-VP-S7
> -------------------------------------------------------
>  latency: 264 us, entries: 5 (5)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:1]
>     -----------------
>     | task: amlat/3921, uid:1000 nice:0 policy:1 rt_prio:99
>     -----------------
>  => started at: rtc_open+0x12/0x270
>  => ended at:   rtc_open+0x13f/0x270
> =======>
> 00000001 0.000ms (+0.264ms): rtc_open (misc_open)
> 00000001 0.264ms (+0.000ms): sub_preempt_count (rtc_open)
> 00000001 0.265ms (+0.000ms): update_max_trace (check_preempt_timing)
> 00000001 0.265ms (+0.000ms): _mmx_memcpy (update_max_trace)
> 00000001 0.265ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)

weird, there's nothing in that function that should cause _any_ delay.
Is this drivers/char/rtc.c's rtc_open()? Also, how reproducible is this
delay?

	Ingo
