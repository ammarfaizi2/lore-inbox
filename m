Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267686AbUJLTxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267686AbUJLTxY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 15:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267700AbUJLTxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 15:53:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:45233 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267686AbUJLTxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 15:53:19 -0400
Date: Tue, 12 Oct 2004 21:54:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>
Subject: [patch] VP-2.6.9-rc4-mm1-T8
Message-ID: <20041012195424.GA3961@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012123318.GA2102@elte.hu>
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


i've uploaded the -T8 VP patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-T8

lots of stabilization of CONFIG_PREEMPT_REALTIME. It's still in
experimental status but general stability is improving.

Changes since -T7:

 - fixed a nasty category of bugs that were introduced by the use of 
   rwsems for rwlocks. rwsems are not read-recursive, while rwlocks are. 
   Fortunately it was not too hard to identify & fix recursive users of
   tasklist_lock, in fact each of these also qualifies as a cleanup. The 
   symptom of this bug was a soft-deadlocking of the system. 

 - fixed profiler locks, i believe this could resolve the bootup crash
   reported by K.R. Foley.

 - fixed VP / XFS namespace collision reported by Mark H. Johnson

 - fix one more final detail of the new zombie-task handling code

 - fixed 3c59x.c, fasync-handling, ipv6, module-loader runtime
   warnings reported by K.R. Foley.

 - fixed the ali5451 locking

to create a -T8 tree from scratch the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
 + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc4.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/2.6.9-rc4-mm1.bz2
 + http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-T8

	Ingo
