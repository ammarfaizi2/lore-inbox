Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVCRJij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVCRJij (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 04:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVCRJij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 04:38:39 -0500
Received: from mx1.elte.hu ([157.181.1.137]:11463 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261552AbVCRJiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 04:38:23 -0500
Date: Fri, 18 Mar 2005 10:38:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: dipankar@in.ibm.com, shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050318093801.GA13442@elte.hu>
References: <20050318002026.GA2693@us.ibm.com> <20050318090406.GA9188@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318090406.GA9188@elte.hu>
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

> * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> 
> > 4. Preemptible read side.
> > 
> > 	RCU read-side critical sections can (in theory, anyway) be quite
> > 	large, degrading realtime scheduling response.	Preemptible RCU
> > 	read-side critical sections avoid such degradation.  Manual
> > 	insertion of "preemption points" might be an alternative as well.
> > 	But I have no intention of trying to settle the long-running
> > 	argument between proponents of preemption and of preemption
> > 	points.  Not today, anyway!  ;-)
> 
> i'm cleverly sidestepping that argument by offering 4 preemption
> models in the -RT tree :-) We dont have to pick a winner, users will.
> [...]

also, it turned out that "preemption points" vs. "forced preemption" are
not exclusive concepts: PREEMPT_RT relies on _both_ of them.

when a highprio task tries to acquire a lock that another, lower-prio
task already holds, then 'the time it takes for the lowprio task to drop
the lock' directly depends on the frequency of explicit preemption
points within the critical section. So to get good 'lock dependent'
latencies on PREEMPT_RT we need both a good distribution of preemption
points (within locked sections).

(obviously, 'lock independent' preemption latencies purely depends on
the quality of forced preemption and the size of non-preempt critical
sections, not on any explicit preemption point.)

dont we love seemingly conflicting concepts that end up helping each
other? It's a nice flamewar-killer ;-)

	Ingo
