Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269471AbUICJ2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269471AbUICJ2u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269616AbUICJ1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:27:42 -0400
Received: from mx1.elte.hu ([157.181.1.137]:7862 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269577AbUICJZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:25:42 -0400
Date: Fri, 3 Sep 2004 11:25:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Free Ekanayaka <free@agnula.org>, Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
Subject: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
Message-ID: <20040903092547.GA18594@elte.hu>
References: <20040902221402.GA29434@elte.hu> <1094171082.19760.7.camel@krustophenia.net> <1094181447.4815.6.camel@orbiter> <1094192788.19760.47.camel@krustophenia.net> <20040903063658.GA11801@elte.hu> <1094194157.19760.71.camel@krustophenia.net> <20040903070500.GB13100@elte.hu> <1094197233.19760.115.camel@krustophenia.net> <87acw7bxkh.fsf@agnula.org> <1094198755.19760.133.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094198755.19760.133.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> As of -R0 it's definitely stable on UP and SMP users are reporting the
> same.  All known problems should be fixed, and there are no known
> regressions.  You should probably post a UP version and have your
> users test that before posting SMP packages, the latter are not quite
> as well tested.

Florian Schmidt reported a minor bug that prevents a successful build if
!CONFIG_LATENCY_TRACE - i've uploaded -R1 that fixes this:
  
 http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-R1

there are no other changes in -R1, and there are no known pending bugs
currently.

for a packaged kernel i'd suggest to enable all the CONFIG_PREEMPT_*
values in the .config, including CONFIG_PREEMPT_TIMING.

CONFIG_LATENCY_TRACE can add overhead if active, so while it would be
useful for initial packages to enable this .config option, i'd suggest
to turn it off by default by changing 'tracing_enabled = 1' to
'tracing_enabled = 0' in the patch. Then people can enable it and do
precise tracing whenever they encounter a particular high latency on
their system.

configuring the threaded/nonthreaded properties of IRQ handlers can be
tricky. Perhaps a script could scan /proc (and/or /sys) for audio
interrupts and make them directly executed? Unfortunately audio
interrupt handler requests dont seem to be going through some central
ALSA function so i see no easy way to somehow tag audio interrupts
automatically and provide some /proc flag to make audio interrupts
non-threaded by default.

	Ingo
