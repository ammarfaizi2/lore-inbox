Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271667AbRJRF6t>; Thu, 18 Oct 2001 01:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273534AbRJRF6k>; Thu, 18 Oct 2001 01:58:40 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:64668 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S271667AbRJRF6U>; Thu, 18 Oct 2001 01:58:20 -0400
From: rwhron@earthlink.net
Date: Thu, 18 Oct 2001 02:00:52 -0400
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: VM test on 2.4.12-ac3+vmpatch+freeswap
Message-ID: <20011018020052.A247@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel tested: 2.4.12-ac3+vmpatch+freeswap

Summary: 

freeswap patch fixes swap deallocation issue seen in 2.4.12-ac1.

Notes:

Setting page-cluster to 2 instead of 4 helps mp3blaster in this 
test, but page-cluster=2 is not as magic as in 2.4.13-pre3aa1.

page-cluster=2, 1:35 seconds of mp3 played.  
page-cluster=4, 1:09 seconds of mp3 played.  

Test duration was actually about 5:50, so there was a lot of
time the mp3 was not playing.  It's clear to me now that mp3blaster
doesn't skip, it just doesn't play for some period of time.

Test:

Run loop of 10 iterations of Linux Test Project's "mtest01 -p80 -w"
This test attempts to allocate 80% of virtual memory and write to
each page.  Simulataneously listen to mp3blaster.


Hardware:
Athlon 1333
512 Mb RAM
1024 Mb swap


page-cluster=2

Averages for 10 mtest01 runs
bytes allocated:                    1255460044
User time (seconds):                2.042
System time (seconds):              4.125
Elapsed (wall clock) time:          36.066
Percent of CPU this job got:        16.60
Major (requiring I/O) page faults:  115.8
Minor (reclaiming a frame) faults:  307297.1

page-cluster=4

Averages for 10 mtest01 runs
bytes allocated:                    1250846310
User time (seconds):                2.013
System time (seconds):              3.977
Elapsed (wall clock) time:          34.777
Percent of CPU this job got:        16.90
Major (requiring I/O) page faults:  109.4
Minor (reclaiming a frame) faults:  306173.0


For comparison, 2.4.12-ac1 allocated 743545241 bytes for the same test.

vmstat 1 - this is the end of one iteration, through a complete test, then
the start of a new iteration:

procs                      memory    swap          io     system         cpu
r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
2  4  1 809452   3060   1252   1172 384 4280   808  4284  371   317  14  44  43
5  2  1 892996   2432   1240   1240 132 104328   200 104308  706   335   1  20  79
1  4  2 894244   3060   1256   1240  20 32048    20 32080  387   196   8  32  60
1  4  0   9260 497880   1268   1532 636 140   952   160 1178   907   2   7  91
1  1  0   9220 496488   1288   2408 404   0  1292     0  400   633   0   0 100
2  0  0   9220 231068   1288   2428 188   0   208     0  291   608  46  53   1
2  0  1   9288   3060   1288   2324 184  64   184    72  300   585  36  64   0
0  3  2 402148   2980   1228   1448  84 74528    92 74524  462   321   1  50  49
1  1  1 502184   3320   1224   1192 292 228200   344 228236 3110  2044   5  11  84
2  2  1 502184   3064   1232   1192  20 85216    20 85232 1201   894   1   8  91
0  5  0 713996   3036   1232    820 128 254876   144 254900 3565  2101   5  16  79
1  3  0 713996   3060   1232    888 128   0   208     0  361   231   3   3  94
0  2  1 848896   3060   1232   1084 320 74940   516 74936  466   362  15  55  30
0  2  1 848896   3060   1232   1084   0 31556     0 31556  343   229   0   1  99
0  4  2 889816   3060   1248   1072  16 23316    20 23316  319   181  10  28  62
3  2  0   9208 497712   1264   1444 672 33792  1072 33832 1640  1112   2   7  91
1  1  0   9208 496600   1268   1956 512   0  1028     0  409   613   1   2  97
2  0  0   9168 301052   1288   2168 204   0   428     0  326   601  35  40  26


Conclusion:

For the mtest01/mp3blaster test , interactive performance and mp3blaster quality
is not as good as 2.4.13-pre3aa1.

For the mmap001/mp3blaster test I recently posted, 2.4.12-ac3+vmpatch,
gives better interactive performance and time than 2.4.13-pre3aa1.

-- 
Randy Hron

