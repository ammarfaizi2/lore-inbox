Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269135AbTCDCnl>; Mon, 3 Mar 2003 21:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269136AbTCDCnl>; Mon, 3 Mar 2003 21:43:41 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:20661 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S269135AbTCDCni>;
	Mon, 3 Mar 2003 21:43:38 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [BENCHMARK] 2.5.63-mm2 + i/o schedulers with contest
Date: Tue, 4 Mar 2003 13:54:03 +1100
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303041354.03428.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are contest (http://contest.kolivas.org) benchmarks using the osdl 
hardware (http://www.osdl.org) for 2.5.63-mm2 and various i/o schedulers:

2.5.63-mm2: anticipatory scheduler (AS)
2.5.63-mm2cfq: complete fair queueing scheduler (CFQ)
2.5.63-mm2dl: deadline scheduler (DL)

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.63              4   79      94.9    0.0     0.0     1.00
2.5.63-mm2cfq       3   79      93.7    0.0     0.0     1.00
2.5.63-mm2          3   80      92.5    0.0     0.0     1.00
2.5.63-mm2dl        3   79      93.7    0.0     0.0     1.00

cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.63              4   76      97.4    0.0     0.0     0.96
2.5.63-mm2cfq       3   75      98.7    0.0     0.0     0.95
2.5.63-mm2          3   75      98.7    0.0     0.0     0.94
2.5.63-mm2dl        3   75      98.7    0.0     0.0     0.95

process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.63              4   92      81.5    28.2    15.2    1.16
2.5.63-mm2cfq       3   92      80.4    27.7    16.3    1.16
2.5.63-mm2          3   92      80.4    29.3    16.3    1.15
2.5.63-mm2dl        3   92      80.4    28.3    16.3    1.16

ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.63              3   99      79.8    1.0     4.0     1.25
2.5.63-mm2cfq       3   102     76.5    0.0     0.0     1.29
2.5.63-mm2          3   112     70.5    1.0     6.2     1.40
2.5.63-mm2dl        3   103     75.7    0.0     0.0     1.30

xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.63              3   102     74.5    1.0     3.9     1.29
2.5.63-mm2cfq       3   106     71.7    1.0     3.8     1.34
2.5.63-mm2          3   108     70.4    1.0     4.6     1.35
2.5.63-mm2dl        3   105     72.4    1.0     3.8     1.33

io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.63              5   217     35.0    56.7    15.1    2.75
2.5.63-mm2cfq       3   218     34.9    50.3    12.8    2.76
2.5.63-mm2          3   99      75.8    15.1    7.1     1.24
2.5.63-mm2dl        3   168     44.6    39.6    13.1    2.13

io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.63              4   95      78.9    15.3    8.3     1.20
2.5.63-mm2cfq       3   93      80.6    14.7    7.5     1.18
2.5.63-mm2          3   92      80.4    13.2    6.5     1.15
2.5.63-mm2dl        3   96      78.1    15.3    7.3     1.22

read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.63              3   106     74.5    5.7     4.7     1.34
2.5.63-mm2cfq       3   112     68.8    6.8     5.4     1.42
2.5.63-mm2          3   121     64.5    8.4     5.8     1.51
2.5.63-mm2dl        3   107     72.9    6.2     4.7     1.35

list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.63              3   96      79.2    0.0     6.2     1.22
2.5.63-mm2cfq       3   97      79.4    0.0     6.2     1.23
2.5.63-mm2          3   99      76.8    0.0     6.1     1.24
2.5.63-mm2dl        3   98      78.6    0.0     6.1     1.24

mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.63              3   104     75.0    57.7    1.9     1.32
2.5.63-mm2cfq       3   101     76.2    52.3    2.0     1.28
2.5.63-mm2          3   132     59.1    90.3    2.3     1.65
2.5.63-mm2dl        3   100     79.0    52.0    2.0     1.27

dbench_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.63              4   194     39.2    2.0     38.7    2.46
2.5.63-mm2cfq       3   269     28.3    3.7     37.2    3.41
2.5.63-mm2          3   236     32.2    2.7     43.2    2.95
2.5.63-mm2dl        3   207     36.7    2.0     36.2    2.62

It seems the AS scheduler reliably takes slightly longer to compile the kernel 
in no load conditions, but only about 1% cpu.

CFQ and DL faster to compile the kernel than AS while extracting or creating 
tars.

AS significantly faster under writing large file to the same disk (io_load) or 
other disk (io_other) conditions. The CFQ and DL schedulers showed much more 
variability on io_load during testing but did not drop below 140 seconds.

CFQ and DL scheduler were faster compiling the kernel under read_load,  
list_load and dbench_load.

Mem_load result of AS being slower was just plain weird with the result rising 
from 100 to 150 during testing.

Con
