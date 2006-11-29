Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966393AbWK2I5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966393AbWK2I5N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 03:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966403AbWK2I5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 03:57:13 -0500
Received: from web57906.mail.re3.yahoo.com ([68.142.236.99]:21692 "HELO
	web57906.mail.re3.yahoo.com") by vger.kernel.org with SMTP
	id S966393AbWK2I5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 03:57:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=clU4AnTP2NENGx3LKzhuYZwLlwnt6g/UsSeiHtsuH43II6Xxui6cvXIjCFOXgE0m5NND/b/Iqubm4UKje7RCs+Gg/AHNx5/o0GGGoJnA3PkFODWS/FvJGSUNcmxtdIJE84bzHHa51Hw+3RHu0+Y7ekQ+s4XN+eHug6TNcOYC0cA=  ;
Message-ID: <20061129085705.52839.qmail@web57906.mail.re3.yahoo.com>
Date: Wed, 29 Nov 2006 00:57:05 -0800 (PST)
From: tike64 <tike64@yahoo.com>
Subject: realtime-preempt and arm
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm trying the realtime-preempt patch-2.6.18-rt6 on
lh7a400 arm system with little success. In a test
program I try 5 ms timeout with select() but get 20 ms
avg or 26 ms max. When the framebuffer scrolls, the
max delay goes up to 59 ms. With a vanilla kernel I
get 10 ms (because of tick resolution?), 11 ms and 39
ms.

My question is, is the realtime-preempt patch supposed
to work on arm architecture and/or without high
resolution timer (which lh7a40x seems to lack) at all
or should I just try to be more clever.

Relevant code:

====
prio.sched_priority = 99;
if (sched_setscheduler(0, SCHED_RR, &prio) < 0) ...
if (mlockall(MCL_CURRENT | MCL_FUTURE) < 0) ...
while (1) {
	t = raw_timer();
	tv.tv_usec = 5000;
	tv.tv_sec = 0;
	select(0, 0, 0, 0, &tv);
	t = raw_timer() - t;
	if (max_t < t) max_t = t;
	if (min_t > t) min_t = t;
	avg_t += t;
	++n;
	if (n < 100) continue;
	printf("%i revs; min: %i max: %i avg: %i\n",
		n,
		min_t,
		max_t,
		(avg_t + n / 2) / n);
====

Relevant config: PREEMPT_RT, PREEMPT_SOFTIRQS,
PREEMPT_HARDIRQS

I didnt' enable HIGH_RES_TIMERS because lh7a40x seems
not to support it.

--

tike



 
____________________________________________________________________________________
Cheap talk?
Check out Yahoo! Messenger's low PC-to-Phone call rates.
http://voice.yahoo.com
