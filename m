Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbVCHXqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVCHXqZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 18:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVCHXk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 18:40:59 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:55687 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262206AbVCHXeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:34:19 -0500
Subject: 2.6.11 low latency audio test results
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, "Jack O'Quin" <joq@io.com>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 18:34:06 -0500
Message-Id: <1110324852.6510.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I have run some simple tests with JACK, Hydrogen, and 2.6.11.

2.6.11 does not seem to be much of an improvement over 2.6.10.  It may
in fact be slightly worse.  This was what I expected, as it appears that
a number of latency fixes in the VM got preempted by the 4-level page
tables merge.

At 32 frames (0.667 ms latency) I get an xrun about every 10-20 seconds,
just running JACK and Hydrogen.

At 64 frames (1.33 ms latency) it's better, but I can easily cause
massive xruns with "dbench 32".

At 128 frames (2.66 ms) it seems to work pretty well.

Overall, this puts us about even with Windows XP, and somewhat worse
than Mac OS X.

Of course all of the above settings provide flawless xrun-free
performance with 2.6.11-rc4 + PREEMPT_RT.

Until Ingo releases the RT preempt patch for 2.6.11, I can't provide
details, because the vanilla kernel lacks sufficient instrumentation.
But the above results should help us move in the right direction.

Given the above results, and the performance of the RT patched kernel,
I don't see why 2.6.12 should not be able to solidly outperform Windows
and Mac in this area.

See the "Latency regressions" thread for some areas that might need
attention.

Lee


