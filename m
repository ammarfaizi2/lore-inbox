Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264101AbUKZUsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264101AbUKZUsH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 15:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbUKZUri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:47:38 -0500
Received: from mx2.elte.hu ([157.181.151.9]:43710 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264105AbUKZUmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 15:42:06 -0500
Date: Fri, 26 Nov 2004 21:41:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
Message-ID: <20041126204138.GB21180@elte.hu>
References: <20041126010841.GA3563@elte.hu> <Pine.OSF.4.05.10411261649150.23754-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10411261649150.23754-100000@da410.ifa.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> > 	task-A			task-B			task-RT
> > 
> > 	spin_lock(&lock2);
> > 	[ gets lock2 ]
> > 				spin_lock(&lock1);
> > 				[ gets lock1 ]
> > 							spin_lock(&lock2);
> > 							[ boosts task-A ]
> > 							[ waits ]
> > 	[ gets RT prio ]				.
> > 	spin_lock(&lock1);				.
> > 	[ boosts task-B ]				.
> > 	[ waits ]					.
> > 	.			[ gets RT prio ]	.
> > 	.			[ 1 msec loop ]		.
> > 	.			spin_unlock(&lock1);	.
> > 	[ gets lock 1 ]					.
> > 				spin_lock(&lock1);	.
> 
> point of disagreement          ----^   

> No :-)

> Why should task B get lock1 the 2. time before the rt-task? That would
> be an error! 

then make it task-C, which tried to take the lock before the RT task
came into the picture. Btw., the above scenario can still happen on SMP.

when task-A unlocks lock1, it can very well give it to task-C - there's
no reason not to do it, task-RT has not expressed any interest in lock1 
yet.

so my example and analysis still stands.

> I can't see how it can produce a flow like the one you describe above!

it can produce such a flow on SMP, or if you add in a third non-RT task
(task-C). Agreed?

In the test where you got 3 msecs you had more than 2 non-RT tasks,
correct?

	Ingo
