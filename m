Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbVHTU5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVHTU5V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 16:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVHTU5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 16:57:21 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:52646 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751145AbVHTU5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 16:57:21 -0400
Subject: Re: sched_yield() makes OpenLDAP slow
From: Lee Revell <rlrevell@joe-job.com>
To: Howard Chu <hyc@symas.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4307788E.1040209@symas.com>
References: <4D8eT-4rg-31@gated-at.bofh.it> <4306A176.3090907@shaw.ca>
	 <4306AF26.3030106@yahoo.com.au>  <4307788E.1040209@symas.com>
Content-Type: text/plain
Date: Sat, 20 Aug 2005 16:57:16 -0400
Message-Id: <1124571437.2115.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-20 at 11:38 -0700, Howard Chu wrote:
> But I also found that I needed to add a new 
> yield(), to work around yet another unexpected issue on this system -
> we have a number of threads waiting on a condition variable, and the
> thread holding the mutex signals the var, unlocks the mutex, and then 
> immediately relocks it. The expectation here is that upon unlocking
> the mutex, the calling thread would block while some waiting thread
> (that just got signaled) would get to run. In fact what happened is
> that the calling thread unlocked and relocked the mutex without
> allowing any of the waiting threads to run. In this case the only
> solution was to insert a yield() after the mutex_unlock(). 

That's exactly the behavior I would expect.  Why would you expect
unlocking a mutex to cause a reschedule, if the calling thread still has
timeslice left?

Lee

