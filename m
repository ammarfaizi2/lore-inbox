Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265488AbTFRTUV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 15:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbTFRTUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 15:20:21 -0400
Received: from mail.ccur.com ([208.248.32.212]:3083 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S265488AbTFRTUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 15:20:19 -0400
Date: Wed, 18 Jun 2003 15:34:02 -0400
From: Joe Korty <joe.korty@ccur.com>
To: george anzinger <george@mvista.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: O(1) scheduler seems to lock up on sched_FIFO and sched_RR tasks
Message-ID: <20030618193053.GA15576@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <3EF0979C.8060603@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF0979C.8060603@mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 09:47:24AM -0700, george anzinger wrote:
> It seems that once a SCHED_FIFO or SCHED_RR tasks gets control it does 
> not yield to other tasks of higher priority.
> 
> Attached is a test program (busyloop) that just loops doing 
> gettimeofday() for the requested time and a little utility (rt) to run 
> programs at real time priorities.
> 
> Here is an annoted example of the problem:
> 
> First, become root then:
> > rt 90 bash        <-- run bash at priority 90 SCHED_RR
> > rt -f 30 busyloop 10 &  <-- busyloop 10 at priority 30 SCHED_FIFO
> 
> At this point the bash at priority 90 should be available, but is not. 
>  When the 10 second busyloop completes, bash returns.


Hi George,
 When I boost the priority of each of the per-cpu 'events/%d' daemon to
96, the problem goes away.

Joe
