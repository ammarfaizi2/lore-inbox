Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267647AbUGWL1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267647AbUGWL1T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 07:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267649AbUGWL1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 07:27:19 -0400
Received: from mx2.elte.hu ([157.181.151.9]:13709 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267647AbUGWL1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 07:27:18 -0400
Date: Fri, 23 Jul 2004 13:28:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: linux-kernel@vger.kernel.org, Rudo Thomas <rudo@matfyz.cz>,
       Matt Heler <lkml@lpbproductions.com>
Subject: [patch] voluntary-preempt-2.6.8-rc2-I4
Message-ID: <20040723112842.GA5133@elte.hu>
References: <20040722160055.GA4837@ss1000.ms.mff.cuni.cz> <20040722161941.GA23972@elte.hu> <20040722172428.GA5632@ss1000.ms.mff.cuni.cz> <20040722175457.GA5855@ss1000.ms.mff.cuni.cz> <20040722180142.GC30059@elte.hu> <20040722180821.GA377@elte.hu> <20040722181426.GA892@elte.hu> <20040723104246.GA2752@elte.hu> <4d8e3fd30407230358141e0e58@mail.gmail.com> <20040723110430.GA3787@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040723110430.GA3787@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > >  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-I3
> > > 
> > > it mainly fixes an ext3 livelock that could result in long delays during
> > > heavy commit traffic.
> > 
> > Hello Ingo, do you have any measurement of the improvement available ?
> 
> it's a bug in the patch, not really a latency fix. When this (rare)
> condition under heavy write traffic occurs then kjournald would loop for
> many seconds (or tens of seconds) in __journal_clean_checkpoint_list(),
> effectively hanging the system. The system is still preemptible but the
> user cannot do much with it. Note that this condition is not present in
> the vanilla kernel, it got introduced by earlier versions of
> voluntary-preempt.

there's one more new version:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-I4

this fixes another rare bug: release_task() could trigger a 'Badness'
atomicity message when the right conditions occur on a preemptible
kernel. This bugfix also allowed the addition of might_sleep() checks
(and hence voluntary-preemption points) to dput() and fput(), two common
functions.

	Ingo
