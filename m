Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268446AbUJUNdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268446AbUJUNdG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 09:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268505AbUJUN26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 09:28:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:29886 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268458AbUJUN03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 09:26:29 -0400
Date: Thu, 21 Oct 2004 15:27:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9
Message-ID: <20041021132717.GA29153@elte.hu>
References: <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020094508.GA29080@elte.hu>
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


i have released the -U9 Real-Time Preemption patch, which can be
downloaded from:

  http://redhat.com/~mingo/realtime-preempt/

this too is a fixes-only release. It includes more driver fixes and
improvements from Thomas Gleixner.

Changes since -U8.1:

 - USB semaphore->completion conversion from Thomas Gleixner

 - netconsole fixes from Michal Schmidt

 - fbcon fixes

 - added counted semaphores, this is now used by firewire, XFS and ACPI. 
   This could fix the firewire breakage - but testing would be welcome.

 - PREEMPT_ACTIVE irqs-enabled critical path removal.

 - fixed irqs-off raw spinlock primitives on UP: they enabled irqs 
   before enabling preemption, creating a window for an interrupt to
   slip in and increase the critical path.

 - made the deadlock detector not crash the current process - it will
   just hang. This produces far nicer log output while still not
   endangering stability. Also, fixed a bug in the detector that happens 
   if the trace buffer overflows.

 - made the atomic-counter-underflow detector non-fatal as well, for the
   same reasons.

to create a -U9 tree from scratch, the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
 + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc4.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/2.6.9-rc4-mm1.bz2
 + http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U9

	Ingo
