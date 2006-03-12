Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWCLWDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWCLWDQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 17:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWCLWDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 17:03:15 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:60561 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932276AbWCLWDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 17:03:15 -0500
Date: Sun, 12 Mar 2006 23:02:18 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Subject: 2.6.16-rc6-rt1
Message-ID: <20060312220218.GA3469@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have released the 2.6.16-rc6-rt1 tree, which can be downloaded from 
the usual place:

   http://redhat.com/~mingo/realtime-preempt/

again, lots of changes all over the map:

- firstly, the -rt tree has been rebased to 2.6.16-rc6, which was a more
  complex operation than usual, due to the many changes in 2.6.16 (in 
  particular the mutex code).

- the PI code got reworked again, this time by Thomas Gleixner. The
  priority boosting chain is now instantaneous again (and not 
  wakeup/scheduling based) - but the previous list-walking hell has been 
  avoided via the clever use of plists. Plus many other changes and
  lots of cleanups to the rt-mutex proper.

- the rt-SLAB code got reworked too - hopefully for the better.

- there's also a completely new PI-futex approach included, ontop of the
  robust-list futex feature. All combinations of PI and robustness are
  supported: default non-robust non-PI futexes, robust+PI, !robust+PI,
  PI+!robust futexes.

- new latency tracer feature: print every function call done by the
  kernel to the console - useful to debug early bootup hangs or other
  nasty bugs.

- plus zillions of bugfixes (and no doubt new regressions).

to build a 2.6.16-rc6-rt1 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.15.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.16-rc6.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.16-rc6-rt1

	Ingo
