Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUH1M7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUH1M7w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 08:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266611AbUH1M7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 08:59:52 -0400
Received: from mx1.elte.hu ([157.181.1.137]:47579 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263806AbUH1M7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 08:59:50 -0400
Date: Sat, 28 Aug 2004 15:01:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Scott Wood <scott@timesys.com>
Cc: manas.saksena@timesys.com, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Mark_H_Johnson@RAYTHEON.COM,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q1
Message-ID: <20040828130128.GA19751@elte.hu>
References: <20040823221816.GA31671@yoda.timesys> <20040824195122.GA9949@yoda.timesys> <20040828123622.GC17908@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828123622.GC17908@elte.hu>
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

> * Scott Wood <scott@timesys.com> wrote:
> 
> > If I'm missing something, please let me know, but I don't see a good
> > way to implement it without blocking for the IRQ thread's completion
> > (such as with the per-IRQ waitqueues in M5).
> 
> agreed, this is a hole in generic_synchronize_irq(). I've added
> handler-completion waitqueues to my current tree, it will show up in
> -Q1.

i've uploaded -Q1:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q1

as with -Q0, the following patch has to be applied to 2.6.8.1 first:

  http://redhat.com/~mingo/voluntary-preempt/diff-bk-040828-2.6.8.1.bz2

those who still have DRI problems under -Q1 - please unapply the
drm_os_linux.h change, does the fix the lockups?

Changes since -Q0:

- the synchronize_irq() fix - this might help SMP problems.

- adds unlock_kernel() to the NTFS and ext3 mount path, to fix the
  latencies reported by Lee Revell.

	Ingo
