Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbUHSHsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUHSHsn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 03:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUHSHsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 03:48:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:10632 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263093AbUHSHsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 03:48:31 -0400
Date: Thu, 19 Aug 2004 09:49:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Charbonnel <thomas@undata.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P2
Message-ID: <20040819074946.GB2075@elte.hu>
References: <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu> <1092627691.867.150.camel@krustophenia.net> <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092741974.14015.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092741974.14015.17.camel@localhost>
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


* Thomas Charbonnel <thomas@undata.org> wrote:

> When entering check_preempt_timing, preempt_thresh was 0, and
> preempt_max_latency had been freshly reset to 100. It should have
> triggered this code :
>
> 		if (latency < preempt_max_latency)
> 			goto out;
>
> but for some reason it didn't (or there is a problem in the tracing
> code, not showing events that would have increased 'latency').

there is one case where we could 'miss' a new latency: when
/proc/latency_trace is accessed. For the duration of /proc/latency_trace
access, the updating of the max latency is stopped:

        if (down_trylock(&max_mutex))
                goto out;

this is not really a practical problem and fixing it would be quite 
complex.

	Ingo
