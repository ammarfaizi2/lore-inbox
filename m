Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbUCCT3a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 14:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbUCCT3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 14:29:30 -0500
Received: from NS1.idleaire.net ([65.220.16.2]:29401 "EHLO iasrv1.idleaire.net")
	by vger.kernel.org with ESMTP id S262555AbUCCT3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 14:29:21 -0500
Subject: Re: poll() in 2.6 and beyond
From: Dave Dillow <dave@thedillows.org>
To: root@chaos.analogic.com
Cc: Bill Davidsen <davidsen@tmr.com>, Roland Dreier <roland@topspin.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0403031313270.12900@chaos>
References: <1vmPm-4lU-11@gated-at.bofh.it> <1vonq-6dr-37@gated-at.bofh.it>
	 <1voGY-6vC-41@gated-at.bofh.it> <1vpjt-7dl-17@gated-at.bofh.it>
	 <1vpCV-7wY-41@gated-at.bofh.it> <1vpWa-7Py-19@gated-at.bofh.it>
	 <4045106D.8060902@tmr.com>  <Pine.LNX.4.53.0403021817050.9351@chaos>
	 <1078286221.4302.23.camel@ori.thedillows.org>
	 <Pine.LNX.4.53.0403031313270.12900@chaos>
Content-Type: text/plain
Message-Id: <1078342159.1123.18.camel@dillow.idleaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 03 Mar 2004 14:29:19 -0500
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Mar 2004 19:29:19.0513 (UTC) FILETIME=[D2E29890:01C40155]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-03 at 13:23, Richard B. Johnson wrote:
> The very great problems that exist with poll on linux-2.6.0
> are being quashed by those who just like to argue.

No, the argument has always been that your understanding of poll()'s
internals is not entirely correct. We have simply asked you to post code
that shows poll()'s problems, which you have finally provided. Sort of.

>  Therefore,
> I wrote some code that emulates the environment in which I
> discovered the poll failure. Experts can decide whatever they
> want about the inner workings of poll(). I supposed that if
> `ps` showed that a task was sleeping in poll() then it must
> be sleeping in poll(). 

This we all agree on -- poll() sleeps. Duh. No argument there.
poll_wait() doesn't and never has, which was your original assertion.

But on to the code!

> So, even it that's wrong, here is
> irrefutable proof that there is a problem with polling events
> getting lost on 2.6.0.

Ahem, no, not so much. What you have here is proof that your user
program is not getting control again withing 0.488ms of the interrupt
happening. That does not mean poll() is loosing events.

You are definately seeing some significant latency -- 50 lost increments
is ~25ms.

What else is running when you perform this test? Can you repeat with a
more recent kernel? Can you repeat in single user mode, with it being
the only process present? With as few extra modules loaded as possible?

I still think your problem is not poll() -- if there were problems
there, bug reports would be coming out of the woodwork.
-- 
Dave Dillow <dave@thedillows.org>

