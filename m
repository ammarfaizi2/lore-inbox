Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbSKKXYz>; Mon, 11 Nov 2002 18:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbSKKXYz>; Mon, 11 Nov 2002 18:24:55 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:43159 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S263246AbSKKXYw>;
	Mon, 11 Nov 2002 18:24:52 -0500
Message-ID: <1037057498.3dd03dda5a8b9@kolivas.net>
Date: Tue, 12 Nov 2002 10:31:38 +1100
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
Subject: [BENCHMARK] 2.5.47{-mm1} with contest
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the latest contest (http://contest.kolivas.net) benchmarks up to and
including 2.5.47. 

Note:
2.5.46-mm1 and later kernels tested now include preempt (previous ones didn't)
These tests were run on a system that uses reiserFS so the new changes are relevant.

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [5]              71.7    93      0       0       1.00
2.4.19 [5]              69.0    97      0       0       0.97
2.5.46 [2]              74.1    92      0       0       1.04
2.5.46-mm1 [5]          74.0    93      0       0       1.04
2.5.47 [3]              73.5    93      0       0       1.03
2.5.47-mm1 [5]          73.6    93      0       0       1.03

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [2]              66.6    99      0       0       0.93
2.4.19 [2]              68.0    99      0       0       0.95
2.5.46 [2]              67.9    99      0       0       0.95
2.5.46-mm1 [5]          68.9    99      0       0       0.96
2.5.47 [3]              68.3    99      0       0       0.96
2.5.47-mm1 [5]          68.4    99      0       0       0.96

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              109.5   57      119     44      1.53
2.4.19 [3]              106.5   59      112     43      1.49
2.5.46 [1]              92.9    74      36      29      1.30
2.5.46-mm1 [5]          82.7    82      21      21      1.16
2.5.47 [3]              83.4    82      22      21      1.17
2.5.47-mm1 [5]          83.0    83      21      20      1.16

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              117.4   63      1       7       1.64
2.4.19 [2]              106.5   70      1       8       1.49
2.5.46 [1]              98.3    80      1       7       1.38
2.5.46-mm1 [5]          95.3    80      1       5       1.33
2.5.47 [3]              93.9    80      1       5       1.32
2.5.47-mm1 [5]          94.0    81      1       5       1.32

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              150.8   49      2       8       2.11
2.4.19 [1]              132.4   55      2       9       1.85
2.5.46 [1]              113.5   67      1       8       1.59
2.5.46-mm1 [5]          227.1   34      3       7       3.18
2.5.47 [3]              167.1   45      2       7       2.34
2.5.47-mm1 [5]          118.5   64      1       7       1.66

Of note here is that 2.5.47 takes longer cf 2.5.46 despite adding preempt. Also
2.5.47-mm1 is substantially shorter than 2.5.46-mm1 (both include preempt).


io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              474.1   15      36      10      6.64
2.4.19 [3]              492.6   14      38      10      6.90
2.5.46 [1]              600.5   13      48      12      8.41
2.5.46-mm1 [5]          134.3   58      6       8       1.88
2.5.47 [3]              165.9   46      9       9       2.32
2.5.47-mm1 [5]          126.3   61      5       8       1.77

Very nice. Further improvement in 2.5.47-mm1 (note the big change in 2.5.46-47
is consistent with the preempt addition as mentioned in a previous thread)


read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              102.3   70      6       3       1.43
2.4.19 [2]              134.1   54      14      5       1.88
2.5.46 [1]              103.5   75      7       4       1.45
2.5.46-mm1 [5]          103.2   74      6       4       1.45
2.5.47 [3]              103.4   74      6       4       1.45
2.5.47-mm1 [5]          100.6   76      7       4       1.41

The improvement in 2.5.47-mm1 although small is actually statistically significant.


list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              90.2    76      1       17      1.26
2.4.19 [1]              89.8    77      1       20      1.26
2.5.46 [1]              96.8    74      2       22      1.36
2.5.46-mm1 [5]          101.4   70      1       22      1.42
2.5.47 [3]              100.2   71      1       20      1.40
2.5.47-mm1 [5]          102.4   69      1       19      1.43

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              103.3   70      32      3       1.45
2.4.19 [3]              100.0   72      33      3       1.40
2.5.46 [3]              148.0   51      34      2       2.07
2.5.46-mm1 [5]          180.5   41      35      1       2.53
2.5.47 [3]              151.1   49      35      2       2.12
2.5.47-mm1 [5]          127.0   58      29      2       1.78

Again very nice.


I refuse to speculate on what part of the kernel is responsible for these
changes, but to me the -mm1 results are encouraging to say the least.

Well done.

Con
