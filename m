Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbUBQAnX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 19:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263903AbUBQAnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 19:43:23 -0500
Received: from mail.tmr.com ([216.238.38.203]:10254 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S263466AbUBQAnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 19:43:16 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [BENCHMARK] 2.6.3-rc2 v 2.6.3-rc3-mm1 kernbench
Date: 17 Feb 2004 00:42:25 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <c0ro1h$48t$1@gatekeeper.tmr.com>
References: <200402170000.00524.kernel@kolivas.org> <4030C38A.4050909@cyberone.com.au> <200402170130.24070.kernel@kolivas.org>
X-Trace: gatekeeper.tmr.com 1076978545 4381 192.168.12.62 (17 Feb 2004 00:42:25 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200402170130.24070.kernel@kolivas.org>,
Con Kolivas  <kernel@kolivas.org> wrote:
| On Tue, 17 Feb 2004 00:20, Nick Piggin wrote:

| >
| > Thanks Con,
| > Results look pretty good. The half-load context switches are
| > increased - that is probably a result of active balancing.
| > And speaking of active balancing, it is not yet working across
| > nodes with the configuration you're on.
| >
| > To get some idea of our worst case SMT performance (-j8), would
| > it be possible to do -j8 and -j64 runs with HT turned off?
| 
| sure.

Now, I have a problem with the numbers here, either I don't understand
them (likely) or I don't believe them (also possible).
| 
| results.2.6.3-rc3-mm1 + SMT:
| Average Half Load Run:
| Elapsed Time 113.008
| User Time 742.786
| System Time 90.65
| Percent CPU 738
| Context Switches 28062.6
| Sleeps 24571.8


| 2.6.3-rc3-mm1 no SMT:
| Average Half Load Run:
| Elapsed Time 133.51
| User Time 799.268
| System Time 92.784
| Percent CPU 669
| Context Switches 19340.8
| Sleeps 24427.4

As I look at these numbers, I see that with SMT the real time is lower,
the system time is higher, and the system time is higher. All what I
would expect since effectively the system has twice as many CPUs.

But the user time, there I have a problem understanding. User time is
time in the user program, and I would expect user time to go up, since
resource contention inside a CPU is likely to mean less work being done
per unit of time, and therefore if you measure CPU time from the outside
you need more of it to get the job done.

And what do you get running on one non-SMT CPU for the same mix? When I
run stuff I usually see the user CPU go up a tad and the e.t. go down a
little (SMT) or quite a bit (SMP).

I have faith in the reporting of the numbers, but I wonder about the way
the data were measured. Hopefully someone can clarify, because it looks
a little like what you would see if you counted "one" for one tick worth
of user mode time in the CPU, regardless of whether one or two threads
were executing.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
