Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275878AbSIUECC>; Sat, 21 Sep 2002 00:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275879AbSIUECC>; Sat, 21 Sep 2002 00:02:02 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:19339 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S275878AbSIUECB>;
	Sat, 21 Sep 2002 00:02:01 -0400
Message-ID: <1032581221.3d8bf065e57ab@kolivas.net>
Date: Sat, 21 Sep 2002 14:07:01 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@digeo.com>, Rik van Riel <riel@conectiva.com.br>
Subject: [BENCHMARK] 2.5.37 and 2.4.19-ac4 tested with contest 0.35
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the latest benchmarks with contest 0.35 (http://contest.kolivas.net)

NoLoad:
Kernel                  Time            CPU
2.4.19                  66.56           99%
2.4.19-ck7              65.77           99%
2.4.19-ac4              66.31           99%
2.5.36                  67.45           99%
2.5.36-mm1              67.39           99%
2.5.37                  67.25           99%

Process Load:
Kernel                  Time            CPU
2.4.19                  81.29           80%
2.4.19-ck7              70.14           93%
2.4.19-ac4              71.10           92%
2.5.36                  71.04           94%
2.5.36-mm1              70.68           95%
2.5.37                  70.51           95%

IO Half Load:
Kernel                  Time            CPU
2.4.19                  101.39          69%
2.4.19-ck7              75.96           88%
2.4.19-ac4              97.56           73%
2.5.36                  79.30           91%
2.5.36-mm1              100.05          74%
2.5.37                  77.69           93%

IO Full Load:
Kernel                  Time            CPU
2.4.19                  170.70          41%
2.4.19-ck7              90.95           74%
2.4.19-ac4              105.53          68%
2.5.36                  197.08          36%
2.5.36-mm1              220.14          33%
2.5.37                  209.75          33%

Mem Load:
Kernel                  Time            CPU
2.4.19                  93.33           77%
2.4.19-ck7              123.15          57%
2.4.19-ac4              117.09          61%
2.5.36                  121.02          59%
2.5.36-mm1              100.47          73%
2.5.37                  104.75          70%

As you can see, kernel compile time difference from .36 is negligible for no
load and process load. All the O(1) based kernels have similar performance with
process load. The trend for good performance under half IO load is still
improving, but the performance under full sized IO load is worse again. Memory
load performance is now improving to the levels of 2.5.36-mm1.

The only change in config between the 2.5 kernels was having to disable APIC on
uniprocessors with 2.5.37 - it would not compile with it. Preempt=N for all 2.5
kernels.

I am unable to test IO loading on same and different disks (as requested by
akpm) as I simply don't have the hardware to do it. I'm looking for someone to
help me with this.

The latest version of contest produces different numbers because of priming
before each load run with an unloaded kernel compile. This makes for very
consistent results between repeat load tests, and "washing away" the effect of
previous loads. I believe I have fully addressed this concern (of mine). The
only way to eliminate it entirely would be to cold boot for each load test.

Con Kolivas
