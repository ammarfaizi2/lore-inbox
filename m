Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVHFFAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVHFFAJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 01:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263164AbVHFFAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 01:00:09 -0400
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:6337 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262135AbVHFFAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 01:00:07 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Gabriel Devenyi <ace@staticwave.ca>
Subject: Re: [ck] [ANNOUNCE] Interbench 0.27
Date: Sat, 6 Aug 2005 14:59:58 +1000
User-Agent: KMail/1.8.2
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org
References: <200508031758.31246.kernel@kolivas.org> <42F207BE.40609@staticwave.ca> <200508052337.55270.ace@staticwave.ca>
In-Reply-To: <200508052337.55270.ace@staticwave.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508061459.58945.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Aug 2005 13:37, Gabriel Devenyi wrote:
> After conducting some further research I've determined that cool n quiet
> has no effect on this "bug" if you can call it that. With the system
> running in init 1, and cool n quiet disabled in the bios, a sleep(N>0)
> results in the run_time value afterwards always being nearly the same value
> of ~995000 on my athlon64, similarly, my server an athlon-tbird, which
> definitely has no power saving features, hovers at ~1496000

We know that sleep(1) doesn't give us accurate sleep of 1 second, only close 
to it limited by Hz, schedule_timeout and how busy the kernel otherwise is.

> Obviously since these values are nowhere near 10000, the loops_per_ms
> benchmark runs forever, has anyone seen/read about sleep on amd machines
> doing something odd? Can anyone else with an amd machine confirm this
> behavior? Con: should we attempt to get the attention of LKML to see why
> amd chips act differently?

None of that matters because the timing is done during a non sleep period 
using the real time clock:

	start_time = get_nsecs(&myts);
	burn_loops(loops);
	run_time = get_nsecs(&myts) - start_time;

So the time spent in sleep(1) should be irrelevant to the timing of 
loops_per_ms. Something else is happening to the cpu _during_ the sleep that 
makes the next lot of loops take a different length of time. That's the bit I 
haven't been able to figure out.

Cheers,
Con
