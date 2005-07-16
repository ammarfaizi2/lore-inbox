Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVGPHx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVGPHx5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 03:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVGPHx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 03:53:57 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:26064 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261165AbVGPHx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 03:53:56 -0400
Subject: Re: [ANNOUNCE] Interbench v0.21
From: Lee Revell <rlrevell@joe-job.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
In-Reply-To: <200507151401.49854.kernel@kolivas.org>
References: <200507151401.49854.kernel@kolivas.org>
Content-Type: text/plain
Date: Sat, 16 Jul 2005 03:53:54 -0400
Message-Id: <1121500435.5070.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-15 at 14:01 +1000, Con Kolivas wrote:
> his makes a large difference to the latencies measured under mem_load
> particularly when running real time benchmarks on a RT-PREEMPT kernel

Here are some results from my 600MHz C3.  In realtime mode, the
PREEMPT_RT kernel performs as expected, max latencies are around 55
usecs with a very tight distribution.

Based on what we already know about the RT kernel I think this validates
the benchmark.  So the numbers Con posted showing an interactivity
regression from HZ=250 should be taken seriously.

Lee

Realtime mode:

rlrevell@mindpipe:~/kernel-source/interbench-0.21$ ./interbench -r -t 5
84648 loops_per_ms read from file interbench.loops_per_ms

Using 84648 loops per ms, running every load for 10 seconds
Benchmarking kernel 2.6.12-RT-V0.7.51-28 at datestamp 200507160215

--- Benchmarking Audio real time in the presence of loads ---
        Latency +/- SD (us)  Max Latency   % Desired CPU  % Deadlines Met
None         35 +/- 3.85          41             100            100
Video        36 +/- 4.15          51             100            100
X            37 +/- 4.39          49             100            100
Burn         34 +/- 4.19          50             100            100
Write        40 +/- 4.9           52             100            100
Read         38 +/- 3.36          46             100            100
Compile      40 +/- 4.11          54             100            100
Memload      41 +/- 4.24          51             100            100

--- Benchmarking Video real time in the presence of loads ---
        Latency +/- SD (us)  Max Latency   % Desired CPU  % Deadlines Met
None         29 +/- 4.15          42             100            100
X            28 +/- 3.52          46             100            100
Burn         28 +/- 3.37          41             100            100
Write        41 +/- 3.25          59             100            100
Read         37 +/- 3.07          43             100            100
Compile      36 +/- 4.99          54             100            100
Memload      38 +/- 3.39          48             100            100


Non realtime mode:

rlrevell@mindpipe:~/kernel-source/interbench-0.21$ ./interbench -t 5
84648 loops_per_ms read from file interbench.loops_per_ms

Using 84648 loops per ms, running every load for 10 seconds
Benchmarking kernel 2.6.12-RT-V0.7.51-28 at datestamp 200507160237

--- Benchmarking Audio in the presence of loads ---
        Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None      0.042 +/- 0.0234     0.176             100            100
Video     0.121 +/- 0.926         13             100            100
X          1.35 +/- 2.93        19.4             100            100
Burn      0.067 +/- 0.215       3.02             100            100
Write     0.763 +/- 2.18        16.9             100            100
Read      0.263 +/- 1.12        9.01             100            100
Compile   0.216 +/- 1.06         9.2             100            100
Memload   0.541 +/- 1.86        13.1             100            100

--- Benchmarking Video in the presence of loads ---
        Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None      0.428 +/- 1.07          17             100           97.2
X           4.6 +/- 4.23          50             100           68.3
Burn      0.394 +/- 1.18        16.8             100           97.8
Write      1.31 +/- 2.05        39.4             100             93
Read      0.462 +/- 0.809       18.2             100           96.8
Compile   0.991 +/- 1.67        42.3             100           94.2
Memload   0.558 +/- 0.949       18.9             100           97.2

--- Benchmarking X in the presence of loads ---
        Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None      0.599 +/- 0.599         24             100             95
Video      13.3 +/- 13.4          93             100             64
Burn      0.519 +/- 0.52          15             100             94
Write      1.91 +/- 1.91          77             100             91
Read      0.449 +/- 0.45          20             100             95
Compile    1.01 +/- 1.04          30             100             93
Memload    1.26 +/- 1.26          30             100             88

