Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269230AbUISMYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269230AbUISMYw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 08:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269236AbUISMYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 08:24:52 -0400
Received: from mx2.elte.hu ([157.181.151.9]:22188 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269230AbUISMYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 08:24:49 -0400
Date: Sun, 19 Sep 2004 14:26:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Mark_H_Johnson@Raytheon.com
Subject: [patch] voluntary-preempt-2.6.9-rc2-mm1-S1
Message-ID: <20040919122618.GA24982@elte.hu>
References: <20040906110626.GA32320@elte.hu> <200409061348.41324.rjw@sisk.pl> <1094473527.13114.4.camel@boxen> <20040906122954.GA7720@elte.hu> <20040907092659.GA17677@elte.hu> <20040907115722.GA10373@elte.hu> <1094597988.16954.212.camel@krustophenia.net> <20040908082050.GA680@elte.hu> <1094683020.1362.219.camel@krustophenia.net> <20040909061729.GH1362@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909061729.GH1362@elte.hu>
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


i've released the -S1 VP patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm1-S1

NOTE: this patch is against Andrew's -mm tree and the VP patchset will
stay based on -mm until the merging process has been finished.

to get a 2.6.9-rc2-mm1-VP-S1 kernel, the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
 + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc2.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm1/2.6.9-rc2-mm1.bz2
 + http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm1-S1

Changes relative to -S0:

- lots of merging. A good chunk of the VP patch latency breakers and
  support patches are in -mm already.

- integrated my 'preemptible big kernel lock' patch into VP. This makes 
  all BKL code preemptible while keeping correctness. A new debugging 
  infrastructure has been added to catch code that might use the BKL
  in an unsafe way. If the debugging check triggers it will print 
  messages like:

    using smp_processor_id() in preemptible code: bash/1020

  please report such messages and backtraces to me. Most of the messages 
  i've fixed so far were false positives, but one bug has been caught 
  already via this.

  Also, this BKL patch allowed the removal of two questionable 
  latency breakers: the tty.c and the DRM BKL relaxation hack.

- fixed an SMP hardirq redirection bug - IRQ threads could be bound to 
  multiple CPUs resulting in potentially illegal preemption of hardirq
  contexts.

- temporarily dropped the ppc/ppc64 GENERIC_HARDIRQS changes, they broke
  and i cannot test them.

Reports, comments welcome,

	Ingo
