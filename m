Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269765AbUICTdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269765AbUICTdz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269745AbUICT3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:29:51 -0400
Received: from mx2.elte.hu ([157.181.151.9]:63362 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269759AbUICT3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:29:23 -0400
Date: Fri, 3 Sep 2004 21:30:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Subject: [patch] voluntary-preempt-2.6.9-rc1-bk4-R3
Message-ID: <20040903193052.GA16617@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu> <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu> <4138A56B.4050006@cybsft.com> <20040903181710.GA10217@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903181710.GA10217@elte.hu>
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

> i'll add a new feature to debug this: when crashing on an assert and
> tracing is enabled the trace leading up to the crash will be printed
> to the console. [...]

the -R3 patch has this feature:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-R3 

you can enable it via enabling CONFIG_LATENCY_TRACE and doing:

  echo 3 > /proc/sys/kernel/trace_enabled

it's all automatic from this point on: tracing will happen nonstop and
any assert or crash that prints the process stack will also print the
last 100 trace entries. Sample output:

 Call Trace:
  [<c0160401>] sys_munmap+0x61/0x80
  [<c010520d>] sysenter_past_esp+0x52/0x71
 Last 100 trace entries:
 00000001: zap_pmd_range+0xe/0x90  <= (unmap_page_range+0x55/0x80)
 00000001: stop_trace+0x8/0x20  <= (bust_spinlocks+0x20/0x60)
 00000001: bust_spinlocks+0xe/0x60  <= (die+0xbc/0x2a0)
 [... 97 more trace entries ...]

Please capture and mail the first 'extended' oops that triggers
(secondary followup traces are probably just side-effects of the crash),
it could give us clues about where the bug is.

	Ingo
