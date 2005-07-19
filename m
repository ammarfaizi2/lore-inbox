Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVGSWOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVGSWOD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 18:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVGSWOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 18:14:02 -0400
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:27604 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262007AbVGSWNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 18:13:50 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Interbench real time benchmark results
Date: Wed, 20 Jul 2005 08:16:11 +1000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507200816.11386.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are results running the real time component with the new version of 
interbench v0.22 (no formal release announcement yet) available here:
http://ck.kolivas.org/apps/interbench/interbench-0.22.tar.bz2

Benchmarked on a pentium M 1.7


2.6.12 non-preempt kernel:
--- Benchmarking Audio real time in the presence of loads ---
	Latency +/- SD (us)  Max Latency   % Desired CPU  % Deadlines Met
None	      3 +/- 0.262          5		 100	        100
Video	      3 +/- 0.949          6		 100	        100
X	      2 +/- 1.17           6		 100	        100
Burn	      2 +/- 0.801          5		 100	        100
Write	      7 +/- 6.05          23		 100	        100
Read	      7 +/- 2.2           42		 100	        100
Compile	      6 +/- 4.71          21		 100	        100
Memload	      6 +/- 4.35          21		 100	        100

--- Benchmarking Video real time in the presence of loads ---
	Latency +/- SD (us)  Max Latency   % Desired CPU  % Deadlines Met
None	      3 +/- 0.145          4		 100	        100
X	      2 +/- 1.09           6		 100	        100
Burn	      2 +/- 0.764          5		 100	        100
Write	      6 +/- 6.26          38		 100	        100
Read	      4 +/- 1.24          37		 100	        100
Compile	      5 +/- 5.88         123		 100	        100
Memload	      6 +/- 7.81         299		 100	        100

Notice pretty good latencies with a max latency of 300us under extreme memory 
load which is still quite respectable.


2.6.12 config-preempt kernel:
--- Benchmarking Audio real time in the presence of loads ---
	Latency +/- SD (us)  Max Latency   % Desired CPU  % Deadlines Met
None	      3 +/- 0.187          5		 100	        100
Video	      2 +/- 0.752          4		 100	        100
X	      2 +/- 0.897          5		 100	        100
Burn	      2 +/- 0.541          5		 100	        100
Write	      7 +/- 6.03          22		 100	        100
Read	      7 +/- 1.58          11		 100	        100
Compile	      6 +/- 5.84          89		 100	        100
Memload	      6 +/- 4.09          23		 100	        100

--- Benchmarking Video real time in the presence of loads ---
	Latency +/- SD (us)  Max Latency   % Desired CPU  % Deadlines Met
None	      3 +/- 0.974          5		 100	        100
X	      2 +/- 1.08           6		 100	        100
Burn	      2 +/- 0.665          5		 100	        100
Write	      6 +/- 7.08         174		 100	        100
Read	      4 +/- 1.23          37		 100	        100
Compile	      5 +/- 10.1         312		 100	        100
Memload	      6 +/- 4.27         101		 100	        100

Not entirely what some would expect. Very little difference under low loads, 
but the maximum latencies exhibited are about the same at 300us. However they 
hare under different workloads. With these worklods, on this hardware, 
running these real time simulations there is not a convincing argument for 
CONFIG-PREEMPT. Note that running interbench with the non-real time 
benchmarks also does not show a convincing reason for preempt.

As a data point I went back to a 2.6.10 kernel which predates some latency 
fixes that went into mainline.


2.6.10 non-preempt
--- Benchmarking Audio real time in the presence of loads ---
	Latency +/- SD (us)  Max Latency   % Desired CPU  % Deadlines Met
None	      3 +/- 0.216          6		 100	        100
Video	      2 +/- 0.811          4		 100	        100
X	      2 +/- 0.802          6		 100	        100
Burn	      2 +/- 0.337          5		 100	        100
Write	      6 +/- 5.62          22		 100	        100
Read	      6 +/- 1.72          17		 100	        100
Compile	      6 +/- 5.03          22		 100	        100
Memload	      8 +/- 4.52          21		 100	        100

--- Benchmarking Video real time in the presence of loads ---
	Latency +/- SD (us)  Max Latency   % Desired CPU  % Deadlines Met
None	      3 +/- 0.724          6		 100	        100
X	      2 +/- 0.895          5		 100	        100
Burn	      2 +/- 0.542          4		 100	        100
Write	      6 +/- 7.81         240		 100	        100
Read	      4 +/- 0.888         15		 100	        100
Compile	      5 +/- 5.12          24		 100	        100
Memload	      6 +/- 6.72         228		 100	        100

This is different again, with similar maximum latencies, but note that read 
induced latencies were actually lower in this kernel, and write induced 
latencies were much larger. Interesting.

Finally the latest rt-preempt kernel:


2.6.12-RT-V0.7.51-32 with all preempt options and no debugging.
--- Benchmarking Audio real time in the presence of loads ---
	Latency +/- SD (us)  Max Latency   % Desired CPU  % Deadlines Met
None	      4 +/- 0.737          9		 100	        100
Video	      4 +/- 1.02           8		 100	        100
X	      4 +/- 0.98           8		 100	        100
Burn	      4 +/- 0.995          8		 100	        100
Write	      7 +/- 5.31          23		 100	        100
Read	      8 +/- 1.54          12		 100	        100
Compile	      7 +/- 3.62          21		 100	        100
Memload	      8 +/- 3.82          24		 100	        100

--- Benchmarking Video real time in the presence of loads ---
	Latency +/- SD (us)  Max Latency   % Desired CPU  % Deadlines Met
None	      4 +/- 0.783          7		 100	        100
X	      4 +/- 0.657          8		 100	        100
Burn	      4 +/- 0.231          9		 100	        100
Write	      7 +/- 5.16          24		 100	        100
Read	      5 +/- 1.32          11		 100	        100
Compile	      6 +/- 3.86          22		 100	        100
Memload	      7 +/- 3.83          25		 100	        100


Interestingly the average latencies are slightly higher (in the miniscule <2us 
range), but the maximum latencies are excellently bound to 25us.

The results are quite reproducible.

Food for thought.

Cheers,
Con
