Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262550AbVCVIWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbVCVIWi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 03:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbVCVIWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 03:22:37 -0500
Received: from mx2.elte.hu ([157.181.151.9]:64207 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262550AbVCVIWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 03:22:32 -0500
Date: Tue, 22 Mar 2005 09:22:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Jack O'Quin" <joq@io.com>
Subject: Re: Latency tests with 2.6.12-rc1
Message-ID: <20050322082222.GB9497@elte.hu>
References: <1111204984.12740.22.camel@mindpipe> <20050319070810.GA20059@elte.hu> <1111218702.13039.5.camel@mindpipe> <1111269392.15042.12.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111269392.15042.12.camel@mindpipe>
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

> [...] Next I tried the same test but with JACK running.  The longest
> latency reported was only 200 usecs, and I did not get xruns.
> 
> Then, right after I stopped JACK, the latency tracer shot up to 1645
> usecs.
> 
> So there seems to be a bug in the latency tracer where the timer is
> not being reset on reschedule.  If an RT task like JACK is running,
> the task does wakeup properly and the counter is reset.  But if JACK
> is not running then long latencies will be reported.

hm, weird, and i have no solution for this yet. But i just found a
related bug in the -RT patch in that it reverted a latency breaker in
the ext3 path that your trace shows - affecting PREEMPT_DESKTOP. Could
you try the 40-03 patch i just uploaded (assuming it's stable for you
otherwise ...) and see whether you can still reproduce these latencies?
(if yes then please also send me a full trace via private mail, or bzip
-9 it in your public mail.)

	Ingo
