Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261848AbSJQHen>; Thu, 17 Oct 2002 03:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261849AbSJQHen>; Thu, 17 Oct 2002 03:34:43 -0400
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:64743 "EHLO
	kolivas.net") by vger.kernel.org with ESMTP id <S261848AbSJQHem>;
	Thu, 17 Oct 2002 03:34:42 -0400
Message-ID: <1034840438.3dae6976a93fb@kolivas.net>
Date: Thu, 17 Oct 2002 17:40:38 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
Subject: [BENCHMARK] 2.5.43-mm2 with contest
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the updated benchmarks with contest v0.51 (http://contest.kolivas.net)
showing the change from -mm1 to -mm2. Other results removed for clarity.

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              71.8    93      0       0       1.01
2.5.43 [2]              74.6    92      0       0       1.04
2.5.43-mm1 [4]          74.9    93      0       0       1.05
2.5.43-mm2 [2]          73.4    93      0       0       1.03

Interesting. This was significant. The slow start that occurs with noload after
a memory flush seems to have been tamed somewhat.

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.43 [2]              99.7    71      44      31      1.40
2.5.43-mm1 [5]          100.4   73      37      28      1.41
2.5.43-mm2 [2]          105.8   71      44      31      1.48

One pathological run removed from -mm1 and 3 removed from -mm2. Don't know why
it's getting stuck doing process_load now and the other 2.5 kernels only do it
at bigger data sizes for process_load. 2.4 doesnt seem to exhibit this at all.

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.43 [1]              97.6    79      1       7       1.37
2.5.43-mm1 [3]          94.6    81      1       6       1.32
2.5.43-mm2 [1]          92.3    82      1       5       1.29

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.43 [1]              114.9   67      1       7       1.61
2.5.43-mm1 [3]          221.2   46      3       7       3.10
2.5.43-mm2 [2]          171.0   45      2       8       2.39

Improvement

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.43 [1]              578.9   13      45      12      8.11
2.5.43-mm1 [3]          383.0   21      27      11      5.36
2.5.43-mm2 [2]          301.1   26      21      11      4.22

Improvement

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.43 [3]              117.3   64      6       3       1.64
2.5.43-mm1 [3]          104.4   74      7       4       1.46
2.5.43-mm2 [1]          105.7   73      6       4       1.48

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.43 [2]              93.0    76      1       18      1.30
2.5.43-mm1 [3]          97.3    73      0       19      1.36
2.5.43-mm2 [1]          98.9    72      1       23      1.39

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.43 [1]              102.0   75      28      2       1.43
2.5.43-mm1 [3]          104.4   71      27      2       1.46
2.5.43-mm2 [2]          106.5   69      27      2       1.49

Removal of per-cpu pages patch does not seem to have been detrimental to contest
benchmarks at least - perhaps this is responsible for the noload being better now?

Con
