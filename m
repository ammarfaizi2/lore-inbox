Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269749AbUICS1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269749AbUICS1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 14:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269704AbUICSWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 14:22:06 -0400
Received: from mx2.elte.hu ([157.181.151.9]:50379 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269729AbUICSUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 14:20:10 -0400
Date: Fri, 3 Sep 2004 20:17:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R0
Message-ID: <20040903181710.GA10217@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu> <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu> <4138A56B.4050006@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4138A56B.4050006@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> Managed to hang the system again under heavy load. This time with the
> above patch:
> 
> http://www.cybsft.com/testresults/crashes/2.6.9-rc1-bk4-R0.txt
> 
> Last time was with Q7:
> 
> http://www.cybsft.com/testresults/crashes/2.6.9-rc1-bk4-Q7.txt

seems to be the same thing - an unbalanced preemption count, possibly
due to some locking error. Unfortunately the assert catches the
imbalance only at exit time. (it's unlikely that the do_exit() code is
buggy.)

i'll add a new feature to debug this: when crashing on an assert and
tracing is enabled the trace leading up to the crash will be printed to
the console. How did you capture the crash - was it in the syslog or do
you have serial logging? Maybe this is not the real crash but only a
followup crash?

	Ingo
