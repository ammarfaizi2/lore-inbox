Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267371AbTBIRhW>; Sun, 9 Feb 2003 12:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267382AbTBIRhW>; Sun, 9 Feb 2003 12:37:22 -0500
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:24541 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S267371AbTBIRhU>; Sun, 9 Feb 2003 12:37:20 -0500
From: Chris Rankin <cj.rankin@ntlworld.com>
Message-Id: <200302091747.h19Hl30g031558@twopit.underworld>
Subject: Re: Linux 2.4.20-SMP: where is all my CPU time going?
To: hahn@physics.mcmaster.ca (Mark Hahn)
Date: Sun, 9 Feb 2003 17:47:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0302091219320.30451-100000@coffee.psychology.mcmaster.ca> from "Mark Hahn" at Feb 09, 2003 12:23:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have been running Linux-2.4.20-SMP on my dual PIII-9333MHz machine
> > (1 GB RAM) for over 3 weeks as a desktop machine, with 2 instances of
> > SETI@Home running at nice 19 in the background the whole time:
> 
> but other unknown factors have changed, right?  like daily use 
> of the desktop?

Yes, I do *use* my destop occasionally... ;-). However, my full "SETI
statistics" file contains daily data going back to October 2000. For
example, here is a excerpt from September 2002:

TIMESTAMP [2002] CLIENT NAME             RUN-TIME         SYS-TIME
Sep 22 23:08:00: SETI-5              20606.560000       190.480000
Sep 23 02:19:22: SETI-1              31343.990000       289.770000
Sep 23 08:47:07: SETI-2              32592.250000       273.890000
Sep 23 11:19:43: SETI-3              30795.910000       265.160000
Sep 23 18:10:38: SETI-4              32877.130000       270.660000
Sep 23 20:11:08: SETI-6              30946.050000       265.570000
Sep 24 03:51:53: SETI-5              33192.640000       270.920000
Sep 24 05:53:52: SETI-1              33039.560000       279.380000
Sep 24 13:32:49: SETI-2              32785.650000       271.290000
Sep 24 15:38:35: SETI-3              33046.460000       282.480000
Sep 24 23:16:30: SETI-4              32947.420000       279.430000
Sep 25 00:12:22: SETI-6              28678.120000       259.580000
Sep 25 07:52:13: SETI-5              28920.640000       268.700000
Sep 25 10:57:25: SETI-1              33598.060000       554.140000
Sep 25 22:24:01: SETI-3              16284.640000      2286.710000
Sep 26 00:34:02: SETI-2              31303.880000      2678.700000
Sep 26 08:17:12: SETI-6              33268.100000       281.640000
Sep 26 09:52:11: SETI-5              31248.750000       276.190000
Sep 26 18:00:18: SETI-1              32560.010000       274.440000
Sep 26 19:08:24: SETI-3              31045.920000       269.040000
Sep 27 03:54:47: SETI-2              33266.910000       276.200000
Sep 27 04:46:27: SETI-4              32386.510000       272.180000
Sep 27 13:27:50: SETI-6              33058.870000       267.090000
Sep 27 14:21:14: SETI-5              33171.320000       271.520000
Sep 27 21:45:00: SETI-1              28743.730000       251.880000
Sep 27 23:59:34: SETI-3              33474.890000       261.430000
Sep 28 07:17:16: SETI-2              33210.900000       256.300000

I have not changed the way I have used this machine, and yet these
"sys-spikes" only appear for two work units. This box should also not
suffer from memory starvation:

$ free -t
             total       used       free     shared    buffers     cached
Mem:       1033532     839516     194016          0      57468     596040
-/+ buffers/cache:     186008     847524
Swap:       498004      12000     486004
Total:     1531536     851516     680020

> > Feb 07 18:20:19: SETI-1              33722.820000       203.570000
> > Feb 09 06:14:08: SETI-1              33391.280000      2165.590000
> 
> do you have any other data?  if the kernel happens to pull pages away
> from the seti process, it could easily cause this sort of thing.

Well, I actually have no idea what sort of activity counts towards the
sys-time total. Is this time spent in spinlocks? Semaphores? Waiting
for DMA transfers to complete? And we're talking 36 minutes-worth of
sys-time here! It sounds as if some in-kernel process is going
completely off the deep end.

> check your cron jobs; I'm guessing you simply run updatedb or something
> at that interval.  it does enough IO to flush pages in the seti client's
> working set.

My only cron job is one that runs "rmmod -a" every hour.

> that's just one possible perturber, though: there are plenty of other
> mechanisms that would work fine to produce this kind of effect.
> some sort of cache-thrashing in particular.

Could cache-thrashing account for the 9 hours of missing run-time? I
didn't see or hear any unusual disc activity last night, and the only
processes in my run-queue were the two setiathome ones.

Chris
