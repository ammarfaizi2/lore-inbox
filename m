Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUIAI3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUIAI3m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 04:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbUIAI3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 04:29:41 -0400
Received: from mx1.elte.hu ([157.181.1.137]:54926 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264246AbUIAI3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 04:29:18 -0400
Date: Wed, 1 Sep 2004 10:29:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: "K.R. Foley" <kr@cybsft.com>, Mark_H_Johnson@raytheon.com,
       Lee Revell <rlrevell@joe-job.com>
Subject: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q6
Message-ID: <20040901082958.GA22920@elte.hu>
References: <20040828194449.GA25732@elte.hu> <200408282210.03568.pnambic@unu.nu> <20040828203116.GA29686@elte.hu> <1093727453.8611.71.camel@krustophenia.net> <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net> <1093737080.1385.2.camel@krustophenia.net> <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu> <20040830090608.GA25443@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830090608.GA25443@elte.hu>
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


i've released the -Q6 patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q6

ontop of:

  http://redhat.com/~mingo/voluntary-preempt/diff-bk-040828-2.6.8.1.bz2

this patch includes two changes that should shorten the networking
latencies reported. There's a new 'RX granularity' sysctl now:

    /proc/sys/net/core/netdev_backlog_granularity

It defaults to the most finegrained value, 1.

netdev_max_backlog has been moved back to the upstream value of 300.

Also, the backlog processing is now sensitive to preemption requests and
will break out early in that case.

(This should not result in TCP connection quality issues (all processing
is restarted after such a breakout), but nevertheless i'd suggest
everyone to keep an eye on lost packets and seemingly hung TCP
connections.)

other changes since -Q5:

 - mtrr simplifications and IRQ-disabling. (reported & tested by Lee
   Revell) Still under discussion though.

 - fix /dev/random driver latency (reported & tested by Lee Revell)

 - move vgacon_do_font_op out of the BKL (reported by P.O. Gaillard)

 - increase percpu space for tracing (by Mark H Johnson)

 - added user-triggerable generic kernel tracing enabled via
   tracing_enabled=2 and turned on via gettimeofday(0,1) and turned off
   via gettimeofday(0,0).

	Ingo
