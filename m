Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269087AbUJSTAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269087AbUJSTAq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 15:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269968AbUJSSXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 14:23:01 -0400
Received: from mx2.elte.hu ([157.181.151.9]:55745 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S270101AbUJSR7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 13:59:39 -0400
Date: Tue, 19 Oct 2004 20:00:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U7
Message-ID: <20041019180059.GA23113@elte.hu>
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041019124605.GA28896@elte.hu>
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


i have released the -U7 Real-Time Preemption patch:

  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U7

this too is a fixes-only release.

Changes since -U6:

 - crash fix: turn off 4K stacks when using RWSEM_DEADLOCK_DETECTION, 
   and tune down the default max # of tasks traced per semaphore. This 
   increases process-stack size and reduces the footprint of lock 
   objects. This should fix the bootup crash reported by Rui Nuno 
   Capela.

 - assert fix: fixed an ide-taskfile scheduling-with-irqs-off assert
   that Rui's .config triggers.

 - assert workaround: disabled PARPORT_1284 for now, this should fix the
   assert seen by Mark H Johnson.

 - NFS fix: clnt.c fix from Thomas Gleixner

 - debugging helper: print stackframe-size in backtraces.

 - large-stackframe fix: inflate.c fix

to create a -U7 tree from scratch, the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
 + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc4.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/2.6.9-rc4-mm1.bz2
 + http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U7

	Ingo
