Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUAOHqX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 02:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266361AbUAOHqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 02:46:23 -0500
Received: from chello212017098056.surfer.at ([212.17.98.56]:35346 "EHLO
	hofr.at") by vger.kernel.org with ESMTP id S266193AbUAOHqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 02:46:19 -0500
From: Der Herr Hofrat <der.herr@hofr.at>
Message-Id: <200401140745.i0E7j7q29175@hofr.at>
Subject: 2.6.0 SCHED_RR/SCHED_FIFO strangness .
To: linux-kernel@vger.kernel.org
Date: Wed, 14 Jan 2004 08:45:07 +0100 (CET)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi !

 doing some simple benchmarks with 2.6.0 I have results I don't
 understand. The setup is a P4 2GHz 2.6.0 kernel running
 Slackware 9.1 with one soft real-time task active only. This one
 task is:

	param.sched_priority = 0;
	sched_setscheduler(getpid(),SCHED_FIFO,&param);
//	sched_setscheduler(getpid(),SCHED_RR,&param);
	...

	while(n < loops) {
                hwtime2 = hwtime();
		hwtime1 = hwtime();
		jitt=hwtime1-hwtime2;
		...
	}

 the jitter is then put into an array using jitt converted to microseconds as
 index. hwtime is:

__inline__ unsigned long long int hwtime(void)
{
        unsigned long long int x;
        __asm__ __volatile__("rdtsc\n\t"
                :"=A" (x));
        return x;
}

 So this should shows how long the task can be interrupted between two 
 consecutive statements (loops is around 1E9).

 The strange thing is that SCHED_FIFO runs always return worse results than
 SCHED_RR runs under even moderate load (one find / in an endless loop, system
 otherwise idle) - any ideas what is causing this ?

 As there is only one task with rt priority in the system I was actually 
 expecting more or less identical worst case results with a slight preference
 for SCHED_FIFO in the average case.

hofrat
