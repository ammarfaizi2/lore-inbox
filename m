Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVAaSxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVAaSxG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 13:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVAaSxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 13:53:06 -0500
Received: from mail.joq.us ([67.65.12.105]:14750 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261308AbVAaSw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 13:52:59 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Alexander Nyberg <alexn@dsv.su.se>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] sched - Implement priority and fifo support for
 SCHED_ISO
References: <41F76746.5050801@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Mon, 31 Jan 2005 12:54:21 -0600
In-Reply-To: <41F76746.5050801@kolivas.org> (Con Kolivas's message of "Wed,
 26 Jan 2005 20:47:50 +1100")
Message-ID: <87acqpjuoy.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> While it is not clear what form the final soft real time
> implementation is, we should complete the partial implementation of
> SCHED_ISO that is in 2.6.11-rc2-mm1.

I finally had a chance to try this today.  I applied a slightly
different patch (2.6.11-rc2-iso3.diff) on top of patch-2.6.11-rc2.  I
tried to use 2.6.11-rc2-mm2, but could not due to conflicts with other
scheduler updates.

It is not clear whether the realtime threads are running in the new
scheduler class.  Checking with schedtool yields odd results.
(Before, my old schedtool always said "POLICY I: SCHED_ISO".)

[joq@sulphur] jack_test/ $ pst jackd
 2173  2173 TS       -   0  19   0  0.0 SLs  rt_sigsuspend  jackd
 2174  2174 ?       21   0  60   0  0.0 SL   -              jackd
 2175  2175 TS       -   0  23   0  0.0 SL   rt_sigsuspend  jackd
 2176  2176 TS       -   0  23   0  0.0 SL   -              jackd
 2177  2177 ?       20   0  59   0  0.0 SL   syscall_call   jackd
 2178  2178 ?       10   0  49   0  1.7 SL   -              jackd
[joq@sulphur] jack_test/ $ schedtool 2174 2176 2177 2178
PID  2174: PRIO  21, POLICY (null)         , NICE  0
PID  2176: PRIO   0, POLICY N: SCHED_NORMAL, NICE  0
PID  2177: PRIO  20, POLICY (null)         , NICE  0
PID  2178: PRIO  10, POLICY (null)         , NICE  0

The results of the first run indicate something is badly wrong.  It is
quite possible that I got confused and messed up the build somehow.

  http://www.joq.us/jack/benchmarks/sched-iso3/jack_test3-2.6.11-rc2-q1-200501311225.log
  http://www.joq.us/jack/benchmarks/sched-iso3/jack_test3-2.6.11-rc2-q1-200501311225.png

Loading the realtime-lsm and then running with SCHED_FIFO *does* work
as expected on this kernel.  I should retry the test with *exactly*
the expected patch sequence.  What would that be?
-- 
  joq
