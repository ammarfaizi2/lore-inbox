Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267396AbUJVSCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267396AbUJVSCY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 14:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267388AbUJVSBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 14:01:44 -0400
Received: from mx1.elte.hu ([157.181.1.137]:1156 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266274AbUJVRzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 13:55:16 -0400
Date: Fri, 22 Oct 2004 19:56:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: [patch] Real-Time Preemption, -RT-2.6.9-mm1-U10.2
Message-ID: <20041022175633.GA1864@elte.hu>
References: <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022155048.GA16240@elte.hu>
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


i have released the -U10.2 Real-Time Preemption patch, which can be
downloaded from:

  http://redhat.com/~mingo/realtime-preempt/
 
this is a fixes-only release.

Changes since -U10:

 - fixed a big bug present ever since: the BKL got dropped when a
   spinlock-mutex was acquired and it scheduled away. This reduced the
   locking efficiency of the BKL. A number of outstanding problems could
   be affected, in particular this should fix the tty locking breakage
   reported by Alexander Batyrshin and Adam Heath. UP and SMP systems 
   are affected too, with SMP systems having a higher chance to trigger
   this condition.

 - tulip.c breakage fix from Thomas Gleixner

 - tg3 and 3c59x fixes.

 - made the hardirq threads SCHED_FIFO by default. They get priorities 
   between 25 and 50, depending on the irq #. (this is pretty random but 
   i found no better scheme.) Made the softirq thread SCHED_FIFO by 
   default as well, albeit this probably will have to change. These 
   changes should make it easier to debug a hung system.

to create a -U10.2 tree from scratch, the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9-mm1/2.6.9-mm1.bz2
 + http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-mm1-U10.2

	Ingo
