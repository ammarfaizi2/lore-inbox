Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269221AbUIBV57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269221AbUIBV57 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 17:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269217AbUIBV55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 17:57:57 -0400
Received: from mx2.elte.hu ([157.181.151.9]:57066 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269221AbUIBV4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 17:56:18 -0400
Date: Thu, 2 Sep 2004 23:57:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Subject: [patch] voluntary-preempt-2.6.9-rc1-bk4-R0
Message-ID: <20040902215728.GA28571@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu> <20040902111003.GA4256@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902111003.GA4256@elte.hu>
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


i've released the -R0 patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-R0
 
ontop of:

  http://redhat.com/~mingo/voluntary-preempt/diff-bk-040828-2.6.8.1.bz2

i've given up on the netdev_backlog_granularity approach, and as a
replacement i've modified specific network drivers to return at a safe
point if softirq preemption is requested. This gives the same end result
but is more robust. For the time being i've fixed 8193too.c and e100.c.
(will fix up other drivers too as latencies get reported)

this should fix the crash reported by P.O. Gaillard, and it should solve
the packet delay/loss issues reported by Mark H Johnson. I cannot see
any problems on my rtl8193 testbox anymore.

	Ingo
