Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWDGM5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWDGM5D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 08:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWDGM5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 08:57:03 -0400
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:15551 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751273AbWDGM5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 08:57:01 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Date: Fri, 7 Apr 2006 22:56:27 +1000
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
References: <1144402690.7857.31.camel@homer>
In-Reply-To: <1144402690.7857.31.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604072256.27665.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 April 2006 19:38, Mike Galbraith wrote:
> Greetings,
>
> Problem:  Wake-up -> cpu latency increases with the number of runnable
> tasks, ergo adding this latency to sleep_avg becomes increasingly potent
> as nr_running increases.  This turns into a very nasty problem with as
> few as 10 httpd tasks doing round robin scheduling.  The result is that
> you can only login with difficulty, and interactivity is nonexistent.
>
> Solution:  Restrict the amount of boost a task can receive from this
> mechanism, and disable the mechanism entirely when load is high.  As
> always, there is a price for increasing fairness.  In this case, the
> price seems worth it.  It bought me a usable 2.6 apache server.

Since this is an RFC, here's my comments :)

This mechanism is designed to convert on-runqueue waiting time into sleep. The 
basic reason is that when the system is loaded, every task is fighting for 
cpu even if they only want say 1% cpu which means they never sleep and are 
waiting on a runqueue instead of sleeping 99% of the time. What you're doing 
is exactly biasing against what this mechanism is in place for. You'll get 
the same effect by bypassing or removing it entirely. Should we do that 
instead?

-ck
