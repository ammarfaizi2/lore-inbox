Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUIVKcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUIVKcM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 06:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUIVKcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 06:32:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:51121 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263778AbUIVKcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 06:32:10 -0400
Date: Wed, 22 Sep 2004 12:33:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@Raytheon.com
Subject: [patch] voluntary-preempt-2.6.9-rc2-mm1-S3
Message-ID: <20040922103340.GA9683@elte.hu>
References: <20040907092659.GA17677@elte.hu> <20040907115722.GA10373@elte.hu> <1094597988.16954.212.camel@krustophenia.net> <20040908082050.GA680@elte.hu> <1094683020.1362.219.camel@krustophenia.net> <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040921074426.GA10477@elte.hu>
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


i've released the -S3 VP patch:

   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm1-S3

most importantly, -S3 fixes the SMP+PREEMPT bug reported by K.R. Foley. 
It was a bug in BKL-preemption: forced preemption still caused automatic
dropping of the BKS - this is bad and broke fs/locks.c. (The race could
occur on UP+PREEMPT too but it has never been reproduced there.)

other changes since -S2:

 - introduced a CONFIG_PREEMPT_BKL - just in case there are other
   problems. This can be used to turn BKL preemption on/off. Can be 
   useful for performance tests as well.

 - fixed a couple of more smp_processor_id() false positives.

 - cleaned up hardirq.c some more

To get a 2.6.9-rc2-mm1-VP-S3 kernel, the patching order is:
 
   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
 + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc2.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm1/2.6.9-rc2-mm1.bz2
 + http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm1-S3

	Ingo
