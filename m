Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268767AbUJPPcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268767AbUJPPcy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 11:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268765AbUJPPcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 11:32:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:7846 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268769AbUJPPc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 11:32:26 -0400
Date: Sat, 16 Oct 2004 17:33:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>
Subject: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U4
Message-ID: <20041016153344.GA16766@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041015102633.GA20132@elte.hu>
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


i have released the -U4 PREEMPT_REALTIME patch:

   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U4

this is a fixes-only release, and it is still experimental code.

Changes since -U3:

 - crash fix: fix the rtc_lock related crash reported by Bill Huey, the 
   rtc_lock is now a raw spinlock again.

 - crash fix: avoid recursion into timer code when PREEMPT_TIMING is 
   enabled.

 - crash/printout fix: revert some of selinux's locks back to raw 
   spinlocks. This could fix the problems reported by Mark H. Johnson, 
   Adam Heath.

 - build fix: fix the compilation problems reported by Lee Revell

 - debug feature: implemented 'print backtrace on all CPUs' on SMP 
   systems, SysRq+L will trigger it.

 - build cleanup: restructure the debug config options. This should 
   resolve the build problems and incompatible debug-options
   problems reported.

 - cleanup: move definitions around, turn on generic rwlocks instead of
   the x86-specific version.

i think all bugs that were reported with logs are fixed in -U4. Please
re-report any issue that might remain.

to create a -U4 tree from scratch the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
 + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc4.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/2.6.9-rc4-mm1.bz2
 + http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U4

	Ingo
