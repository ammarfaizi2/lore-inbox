Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945962AbWJ0FvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945962AbWJ0FvT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 01:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945977AbWJ0FvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 01:51:19 -0400
Received: from mx2.cs.washington.edu ([128.208.2.105]:25300 "EHLO
	mx2.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1945962AbWJ0FvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 01:51:18 -0400
Date: Thu, 26 Oct 2006 22:51:12 -0700 (PDT)
From: David Rientjes <rientjes@cs.washington.edu>
To: Martin Tostrup Setek <martitse@student.matnat.uio.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH: 2.6.18.1] delayacct: cpu_count in taskstats updated
 correctly
In-Reply-To: <Pine.LNX.4.63.0610270545000.21448@honbori.ifi.uio.no>
Message-ID: <Pine.LNX.4.64N.0610262238510.30255@attu4.cs.washington.edu>
References: <Pine.LNX.4.63.0610270440500.21448@honbori.ifi.uio.no>
 <Pine.LNX.4.64N.0610262027350.12347@attu2.cs.washington.edu>
 <Pine.LNX.4.63.0610270545000.21448@honbori.ifi.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006, Martin Tostrup Setek wrote:

> In include/linux/taskstats.h, I found:
> 
>          * xxx_count is the number of delay values recorded
>          * xxx_delay_total is the corresponding cumulative delay in
>          nanoseconds
> 
> I interpret these comments as saying that:
> 
> cpu_delay should be the total number of nanoseconds a task has been waiting in
> a runqueue for a CPU, and cpu_count is equal to the number of times the task
> got the CPU (or waited for it). If so, then the code updates
> taskstats.cpu_delay_total incorrectly too (which my patch didn't fix).
> 

I don't see a cpu_delay, I see a cpu_delay_total.  This is the CPU's
cumulative delay and is only accessible through the user-space accounting 
program Documentation/accounting/getdelays.c.  It reports the number of 
delay values recorded and the real total, virtual total, and delay total; 
each of these are cumulative.

In the use case for cpu_count, taking the difference of two successive 
cpu_count readings as reported by getdelays.c would find the number of 
delays experienced in that interval.  This is described in the program's 
documentation so by definition the count must be cumulative.  It is also 
possible to find the average delay but dividing cpu_delay_total by 
cpu_count.

The original code is correct and accumulation is appropriate.

		David
