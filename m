Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266885AbUHTN3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266885AbUHTN3P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 09:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267175AbUHTN3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 09:29:15 -0400
Received: from mx1.elte.hu ([157.181.1.137]:48831 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266885AbUHTN3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 09:29:04 -0400
Date: Fri, 20 Aug 2004 15:30:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Lee Revell <rlrevell@joe-job.com>, Mark_H_Johnson@raytheon.com
Subject: [patch] voluntary-preempt-2.6.8.1-P5
Message-ID: <20040820133031.GA13105@elte.hu>
References: <1092627691.867.150.camel@krustophenia.net> <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040819073247.GA1798@elte.hu>
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


i've uploaded the -P5 patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P5

Changes since -P4:

 - increase PERCPU_ENOUGH_ROOM to avoid percpu overflow on SMP.
   (Mark H Johnson)

 - reduce ZAP_BLOCK_SIZE to 16 when vp != 0. This pushes the exit
   latency down to below 100 usecs on Lee Revell's box.

 - added a preempt_count field to /proc/latency_trace. This makes it
   easier to spot IRQ contexts and generally it gives a nice overview of
   how the preemption depth changes. It should also help us debug
   those 900usec weirdnesses related to cpu_idle. (if they still occur)

 - made the tcp packet-queue collapsing dependent on VOLUNTARY_PREEMPT.

 - fixed 10-20 msec latencies triggered by 'netstat', which occur when
   there are lots of sockets on a box.

 - rediffed against 2.6.8.1 for the patch to apply without fuzz

	Ingo
