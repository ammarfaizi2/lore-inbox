Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267498AbSLSBX5>; Wed, 18 Dec 2002 20:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267500AbSLSBX5>; Wed, 18 Dec 2002 20:23:57 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:13477 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S267498AbSLSBXz>;
	Wed, 18 Dec 2002 20:23:55 -0500
Message-ID: <1040261508.3e012184e56c4@kolivas.net>
Date: Thu, 19 Dec 2002 12:31:48 +1100
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>
Subject: [BENCHMARK] scheduler tunables with contest - max_timeslice
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Using the osdl (http://www.osdl.org) resources provided to me I'm running a
series of contest benchmarks on 2.5.52-mm1 and modifying the scheduler tunables
as provided by RML's patch. SMP used to minimise how long it will take me to do
these. This is the first in the series and I've run a range of max_timeslices
(default is 300ms; range 100-400):

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [8]          39.7    180     0       0       1.10
max_tim100 [3]          39.7    180     0       0       1.10
max_tim200 [3]          39.6    180     0       0       1.09
max_tim400 [3]          39.7    181     0       0       1.10

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          36.9    194     0       0       1.02
max_tim100 [3]          36.7    194     0       0       1.01
max_tim200 [3]          36.8    193     0       0       1.02
max_tim400 [3]          36.8    194     0       0       1.02

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          49.0    144     10      50      1.35
max_tim100 [3]          52.5    133     14      60      1.45
max_tim200 [3]          47.8    150     9       43      1.32
max_tim400 [3]          48.3    146     10      48      1.33

Slight balance change here. Note process load forks off 4*num_cpus processes
that do their task in a very short time and shortening the max timeslice seems
to slightly favour these tasks at the expense of kernel compilation time.

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          55.5    156     1       10      1.53
max_tim100 [3]          56.0    156     1       10      1.55
max_tim200 [3]          53.9    162     1       10      1.49
max_tim400 [3]          55.5    148     1       10      1.53

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          77.4    122     1       8       2.14
max_tim100 [3]          73.0    123     1       8       2.02
max_tim200 [3]          82.5    115     1       8       2.28
max_tim400 [3]          82.8    117     1       9       2.29

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          80.5    108     10      19      2.22
max_tim100 [3]          93.8    100     13      20      2.59
max_tim200 [3]          88.8    98      12      19      2.45
max_tim400 [3]          71.4    114     8       18      1.97

The trend here is one of definite shortening of duration of kernel compilation
during io load as the max timeslice is made longer


io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          60.1    131     7       18      1.66
max_tim100 [3]          64.5    127     8       19      1.78
max_tim200 [3]          62.8    125     8       19      1.73
max_tim400 [3]          62.5    126     6       15      1.73

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          49.9    149     5       6       1.38
max_tim100 [3]          50.4    150     5       6       1.39
max_tim200 [3]          50.5    149     5       6       1.39
max_tim400 [3]          50.6    148     5       6       1.40

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          43.8    167     0       9       1.21
max_tim100 [3]          44.2    166     0       9       1.22
max_tim200 [3]          43.6    168     0       9       1.20
max_tim400 [3]          43.3    167     0       9       1.20

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          71.1    123     36      2       1.96
max_tim100 [3]          81.1    100     38      2       2.24
max_tim200 [3]          84.1    101     36      2       2.32
max_tim400 [3]          82.8    97      36      2       2.29

No idea what's going on in mem_load

I will continue to do these with some of the other scheduler tunables. I will
need recommendations if anyone is interested in further resolution testing than
that I'm currently doing.

Con
