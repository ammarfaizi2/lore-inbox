Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287563AbSAYAwQ>; Thu, 24 Jan 2002 19:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289352AbSAYAwJ>; Thu, 24 Jan 2002 19:52:09 -0500
Received: from freeside.toyota.com ([63.87.74.7]:44813 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S287563AbSAYAv5>; Thu, 24 Jan 2002 19:51:57 -0500
Message-ID: <3C50AC22.7090203@lexus.com>
Date: Thu, 24 Jan 2002 16:51:46 -0800
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020123
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Testing the effects of the low latency patch
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had earlier posted reports about the low latency patch in terms
that are too subjective - e.g. saying that "quake 3 arena feels much
smoother and I frag a lot more" isn't the kind of hard statistical
evidence demanded by some. I have attempted to quanitify the latency
differences in one of the workloads where I see and feel a difference.

I built and benchmarked 2 kernels for comparison  - my normal kernel,
which is at present 2.4.18-pre6 + Trond M's nfs fixes + Ingo M's tux
webserver + Andrew M's Low Latency patch; and a test kernel which was
built identically to the first kernel but without the low latency patch.


The bottom line is that the latency improvements are clearly visible
in the histograms and and the graphs (attached), and the obligatory
dbench runs at 2, 4, 8, 16, 32, 64 and 80 procs show that at worst,
the low latency patches do no harm to throughput, and may even improve
throughput. To be certain of the latter, better statistical samples
should of course be taken.


Note - I would be happy to add comparisons of the preempt patches if
and when their mortal conflict with tux is resolved.


The results:


Latency tests
--------------

Procedure:

1. Start realfeel
2. Play a round of "Return to castle Wolfenstein" online
3. Terminate realfeel and generate graphs with the included script
4. Compare the resulting histograms and graphs

2.4.18-pre6+tux+nfs-fixes
-------------
0.0 1964970
0.1 2809
0.2 2273
0.3 1330
0.4 943
0.5 826
0.6 832
0.7 657
0.8 117
0.9 3
1.0 5
1.1 9
1.2 15
1.3 5
1.4 14
1.5 6
1.6 3
1.7 3
1.8 1
1.9 2
2.0 10
2.1 2
2.2 1
2.7 1
3.3 1
3.4 2
3.6 1
3.7 2
7.6 1
7.8 1
21.1 1


2.4.18-pre6+tux+nfs-fixes + low latency patch
-------------
0.0 2596680
0.1 3303
0.2 4047
0.3 2341
0.4 1821
0.5 1803
0.6 1788
0.7 1505
0.8 272
0.9 1
1.0 12
1.1 18
1.2 42
1.3 26
1.4 23
1.5 9



The dbench results:

2.4.18-pre6+tux+nfs-fixes
---------------------------------
Throughput 25.873 MB/sec  (NB=32.3413 MB/sec  258.73 MBit/sec)   80 procs
Throughput 34.8035 MB/sec (NB=43.5043 MB/sec  348.035 MBit/sec)  64 procs
Throughput 42.8055 MB/sec (NB=53.5069 MB/sec  428.055 MBit/sec)  32 procs
Throughput 48.9432 MB/sec (NB=61.179 MB/sec   489.432 MBit/sec)  16 procs
Throughput 111.575 MB/sec (NB=139.469 MB/sec  1115.75 MBit/sec)  8 procs
Throughput 111.66 MB/sec  (NB=139.575 MB/sec  1116.6 MBit/sec)   4 procs
Throughput 112.307 MB/sec (NB=140.384 MB/sec  1123.07 MBit/sec)  2 procs

2.4.18-pre6+tux+nfs-fixes + low latency patch
---------------------------------
Throughput 32.1261 MB/sec (NB=40.1576 MB/sec  321.261 MBit/sec)  80 procs
Throughput 32.8968 MB/sec (NB=41.1211 MB/sec  328.968 MBit/sec)  64 procs
Throughput 48.2933 MB/sec (NB=60.3666 MB/sec  482.933 MBit/sec)  32 procs
Throughput 106.361 MB/sec (NB=132.951 MB/sec  1063.61 MBit/sec)  16 procs
Throughput 106.489 MB/sec (NB=133.111 MB/sec  1064.89 MBit/sec)  8 procs
Throughput 112.754 MB/sec (NB=140.942 MB/sec  1127.54 MBit/sec)  4 procs
Throughput 113.354 MB/sec (NB=141.693 MB/sec  1133.54 MBit/sec)  2 procs

Best,

Joe





