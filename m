Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbUCCD5c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 22:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbUCCD5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 22:57:32 -0500
Received: from smtp.knology.net ([24.214.63.101]:36544 "HELO smtp5.knology.net")
	by vger.kernel.org with SMTP id S262348AbUCCD5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 22:57:03 -0500
Subject: Re: poll() in 2.6 and beyond
From: David Dillow <dave@thedillows.org>
To: root@chaos.analogic.com
Cc: Bill Davidsen <davidsen@tmr.com>, Roland Dreier <roland@topspin.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0403021817050.9351@chaos>
References: <1vmPm-4lU-11@gated-at.bofh.it> <1vonq-6dr-37@gated-at.bofh.it>
	 <1voGY-6vC-41@gated-at.bofh.it> <1vpjt-7dl-17@gated-at.bofh.it>
	 <1vpCV-7wY-41@gated-at.bofh.it> <1vpWa-7Py-19@gated-at.bofh.it>
	 <4045106D.8060902@tmr.com>  <Pine.LNX.4.53.0403021817050.9351@chaos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1078286221.4302.23.camel@ori.thedillows.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Mar 2004 22:57:01 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-02 at 18:32, Richard B. Johnson wrote:
> Yes. The code I attached earlier shows that the poll() in a driver
> gets called (correctly), then it calls poll_wait(). Unfortunately
> the call to poll_wait() returns immediately so that the return
> value from the driver's poll() is whatever it was before some
> event occurred that the driver was going to signal with
> wake_up_interruptible().

You've been handed a clue enough times now that you should understand
that poll_wait() does not, and has never, put the process to sleep.

If you can show a case where do_poll() returns stale data, then by all
means do so. We will be happy to fix any such error in the kernel.

You say do_poll() looses the status returned from your driver's poll
method. If your driver is truly returning a nonzero status from the
poll() method call, then a simple read of the code in do_pollfd() will
show that the only way it looses information from that event mask is if
your user space is not setting that event type in pollfd.events.

If I were you, I'd check two things:
1) that your poll method is really returning a non-zero status when you
think it is
2) that your user space program is really asking for all events you
think it is

I think you'll find your problem is not this well-used mechanism in the
kernel.

Dave
