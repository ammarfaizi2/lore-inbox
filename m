Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263568AbUJ2Uwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbUJ2Uwg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263576AbUJ2UuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 16:50:15 -0400
Received: from mx1.elte.hu ([157.181.1.137]:58016 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263509AbUJ2U3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:29:32 -0400
Date: Fri, 29 Oct 2004 22:30:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: John Gilbert <jgilbert@biomail.ucsd.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.5.2
Message-ID: <20041029203031.GB5186@elte.hu>
References: <OFDD5E88CA.56DEE781-ON86256F3C.0059C080-86256F3C.0059C0A2@raytheon.com> <20041029162622.GA8016@elte.hu> <41828348.4000700@biomail.ucsd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41828348.4000700@biomail.ucsd.edu>
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


* John Gilbert <jgilbert@biomail.ucsd.edu> wrote:

> Hello all, Ingo,
> Here's a few bugs on boot with V0.5.2, and a question: what's needed to 
> get back to the verbose latency messages of previous preempt patches 
> (see the terse second log)?

> (ksoftirqd/0/2/CPU#0): new 1003 us maximum-latency wakeup.

if you have LATENCY_TRACING enabled then the wakeup trace of the last 
wakeup will be in /proc/latency_trace.

the reason that the messages are less verbose is that by default we are
not measuring critical sections anymore, but 'wakeup latency'. Wakeup 
latency is measured from the point of wakeup to the point where the task 
runs - so it makes no sense to dump the stack (which is why the previous 
tracing output was more verbose) - a stackdump would always show the 
scheduler codepath where we stop measuring.

you can switch back to critical section timing though, via:

	echo 0 > /proc/sys/kernel/preempt_wakeup_timing

this will also turn the stackdumps back on. (those make sense in this
case because we measure 'start of critical section' to 'end of critical
section', in which case both a stackdump and the symbolic printout of
the start and end address is useful - because it's variable.

	Ingo
