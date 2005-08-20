Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbVHTVZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVHTVZE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 17:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbVHTVZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 17:25:03 -0400
Received: from highlandsun.propagation.net ([66.221.212.168]:17934 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S1751235AbVHTVZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 17:25:01 -0400
Message-ID: <43079FA9.700@symas.com>
Date: Sat, 20 Aug 2005 14:24:57 -0700
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b4) Gecko/20050810 SeaMonkey/1.0a
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sched_yield() makes OpenLDAP slow
References: <4D8eT-4rg-31@gated-at.bofh.it> <4306A176.3090907@shaw.ca>	 <4306AF26.3030106@yahoo.com.au>  <4307788E.1040209@symas.com> <1124571437.2115.3.camel@mindpipe>
In-Reply-To: <1124571437.2115.3.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
>  On Sat, 2005-08-20 at 11:38 -0700, Howard Chu wrote:
> > But I also found that I needed to add a new yield(), to work around
> > yet another unexpected issue on this system - we have a number of
> > threads waiting on a condition variable, and the thread holding the
> > mutex signals the var, unlocks the mutex, and then immediately
> > relocks it. The expectation here is that upon unlocking the mutex,
> > the calling thread would block while some waiting thread (that just
> > got signaled) would get to run. In fact what happened is that the
> > calling thread unlocked and relocked the mutex without allowing any
> > of the waiting threads to run. In this case the only solution was
> > to insert a yield() after the mutex_unlock().
>
>  That's exactly the behavior I would expect.  Why would you expect
>  unlocking a mutex to cause a reschedule, if the calling thread still
>  has timeslice left?

That's beside the point. Folks are making an assertion that 
sched_yield() is meaningless; this example demonstrates that there are 
cases where sched_yield() is essential.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

