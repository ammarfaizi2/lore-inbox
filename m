Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269417AbUIIKlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269417AbUIIKlq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 06:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269418AbUIIKlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 06:41:46 -0400
Received: from www2.muking.org ([216.231.42.228]:2977 "HELO www2.muking.org")
	by vger.kernel.org with SMTP id S269417AbUIIKlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 06:41:09 -0400
To: linux-kernel@vger.kernel.org
Subject: voluntary-preemption: understanding latency trace
From: Kevin Hilman <kjh-lkml@hilman.org>
Organization: None to speak of.
Date: 09 Sep 2004 03:41:07 -0700
Message-ID: <83656nk9mk.fsf@www2.muking.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing a mismatch between my manually-measured timings and the
timings I see in /proc/latency_trace.

I've got a SCHED_FIFO kernel thread at the highest priority
(MAX_USER_RT_PRIO-1) and it's sleeping on a wait queue.  The wake is
called from an ISR.  Since this thread is the highest priority in the
system, I expect it to run before the ISR threads and softIRQ threads
etc. 

In the ISR I sample sched_clock() just before the call to wake_up()
and in the thread I sample sched_clock() again just after the call to
sleep.  I'm seeing an almost 4ms latency between the call to wake_up
and the actual wakeup.  However, in /proc/latency_trace, the worst
latency I see during the running of this test is <500us.

I must be misunderstanding how the latency traces are
started/stopped.  Can anyone shed some light?  Thanks.

My current setup is using -R5, running on a PII 400MHz system.

Kevin 
http://hilman.org/
