Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269196AbUICDYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269196AbUICDYf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 23:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269115AbUICDOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 23:14:16 -0400
Received: from mx1.elte.hu ([157.181.1.137]:63950 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268929AbUIBUgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:36:32 -0400
Date: Thu, 2 Sep 2004 22:38:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: linux-kernel@vger.kernel.org, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q9
Message-ID: <20040902203804.GA22309@elte.hu>
References: <OF77CAEAC1.5B07194A-ON86256F03.006FD5A2-86256F03.006FD5AB@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF77CAEAC1.5B07194A-ON86256F03.006FD5A2-86256F03.006FD5AB@raytheon.com>
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


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> 00000002 0.003ms (+0.000ms): dummy_switch_tasks (schedule)
> 00000002 0.003ms (+0.000ms): schedule (worker_thread)
> 00000002 0.003ms (+0.000ms): schedule (worker_thread)
> 00000002 0.004ms (+0.000ms): schedule (worker_thread)
> 00000002 0.004ms (+0.000ms): schedule (worker_thread)
> 00000002 0.004ms (+0.000ms): schedule (worker_thread)
> 00000002 0.004ms (+0.274ms): schedule (worker_thread)
> 04000002 0.279ms (+0.000ms): __switch_to (schedule)

a quick suggestion: could you add this near the top of sched.c (below
the #include lines):

 #define static

this will turn off all inlining and makes the scheduler-internal
functions visible. If there's any scheduler-internal overhead we should
see it. Maybe this is the CR3 flush (switch_mm()) - but 274 usecs is
still excessive ...

	Ingo
