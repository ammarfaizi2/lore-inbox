Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268090AbUJNXtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268090AbUJNXtd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 19:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267916AbUJNXtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 19:49:11 -0400
Received: from mx2.elte.hu ([157.181.151.9]:14549 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268142AbUJNXpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 19:45:38 -0400
Date: Fri, 15 Oct 2004 01:42:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Daniel Walker <dwalker@mvista.com>, Bill Huey <bhuey@lnxw.com>,
       Andrew Morton <akpm@osdl.org>, Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Subject: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U2
Message-ID: <20041014234202.GA26207@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014143131.GA20258@elte.hu>
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


i have released the -U2 PREEMPT_REALTIME patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U2

this too is a bugfixes-only release, and it is still experimental code.

Changes since -U1:

 - bugfix: fix page_lock_anon_vma() crash reported by Adam Heath and 
   Lorenzo Allegrucci.

 - bugfix: fix selinux atomic-schedule warning messages, reported by
   Mark H Johnson.

 - bugfix: ip_tables atomic-schedule fix, fixes the messages reported by 
   Daniel Walker and K.R. Foley.

 - bugfix: fix warnings/deadlocks in inet_create(), reported by Mark H 
   Johnson.

 - bugfix: fixed a crash-in-shmfs-during-heavy-swapout bug

 - bugfix: enable preemption while doing mmdrop() in the scheduler - it 
   may schedule.

 - debugging feature: when PREEMPT_TIMING is enabled then the code also 
   keeps a trace/stack of preemption enabler EIPs. (if LATENCY_TRACE is 
   enabled as well then the parent EIP is recorded as well.) Whenever a 
   stack trace due to atomicity violations is printed, the preemption
   stack is printed as well. This makes it much easier to identify the 
   place that did the illegal preemption-disabling.

to create a -U2 tree from scratch the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
 + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc4.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/2.6.9-rc4-mm1.bz2
 + http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U2

	Ingo
