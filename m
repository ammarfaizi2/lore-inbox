Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268025AbUHTTyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268025AbUHTTyU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 15:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268042AbUHTTyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 15:54:20 -0400
Received: from mx1.elte.hu ([157.181.1.137]:48827 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268025AbUHTTyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 15:54:18 -0400
Date: Fri, 20 Aug 2004 21:55:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Lee Revell <rlrevell@joe-job.com>, Mark_H_Johnson@raytheon.com
Subject: [patch] voluntary-preempt-2.6.8.1-P6
Message-ID: <20040820195540.GA31798@elte.hu>
References: <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820133031.GA13105@elte.hu>
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


i've uploaded the -P6 patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P6

i'm releasing another patch today because the mystic 900 usec latency
seems to be nailed finally, with the help of Mark H Johnson's traces:
there were two places that set ->preempt_count back to 0 without the
tracer noticing it: preempt_schedule() and entry.S's return path.

other changes since -P5:

 - generic kernel fix: do not ignore idle=poll on non-P4 CPUs.
   (Mark H Johnson)

 - fix the __trace link bug reported by Martin Rumori. All combinations
   of CONFIG_PREEMPT_TIMING & CONFIG_LATENCY_TRACE should work now.

 - make kernel_preemption=1 the default. Most people use this anyway.

	Ingo
