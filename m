Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWAKOlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWAKOlE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 09:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWAKOlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 09:41:04 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:43770 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751163AbWAKOlC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 09:41:02 -0500
Subject: Re: 2.6.15-rt3 + Open Posix Test Suite
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, mingo@elte.hu,
       linux-kernel@vger.kernel.org
In-Reply-To: <1136951593.6197.81.camel@localhost.localdomain>
References: <1136934210.5756.13.camel@localhost.localdomain>
	 <1136951593.6197.81.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 06:41:00 -0800
Message-Id: <1136990460.17984.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 22:53 -0500, Steven Rostedt wrote:

> 
> This runs a while loop at SCHED_FIFO prio 99?  And alarm never happens.
> Doesn't the alarm get activated by the softirqd that is running at a
> lower priority?  Seems that this is starving out the softirq from
> getting the alarm.

I thought alarm was a signal (SIGALRM) ? If it's delivered by softirqd
then this makes sense. Your right , it's softirqd related. 

The processes also calls yield() inside it's while loop . We have
warnings about yield() and RT tasks. 

> I believe that Thomas once had priorities attached to the timers.  I'd
> like to see that again, and may even start adding them myself, such that
> when a process activates a timer, when that timer goes off, the softirq
> will get the priority of the timer.  But this has some complications to
> be sorted out.

Yes, I remember . Do we fix the test in this case, or the kernel ?

Daniel

