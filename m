Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279997AbRKDOJE>; Sun, 4 Nov 2001 09:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279998AbRKDOIy>; Sun, 4 Nov 2001 09:08:54 -0500
Received: from mailrelay3.inwind.it ([212.141.54.103]:55491 "EHLO
	mailrelay3.inwind.it") by vger.kernel.org with ESMTP
	id <S279997AbRKDOIp>; Sun, 4 Nov 2001 09:08:45 -0500
Message-Id: <3.0.6.32.20011104151152.01fdaea0@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Sun, 04 Nov 2001 15:11:52 +0100
To: linux-kernel@vger.kernel.org
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: VM: qsbench numbers
Cc: Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I begin with the last Linus' kernel, three runs and kswapd CPU
time appended.

Linux-2.4.14-pre8:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.270u 7.330s 2:33.29 50.6%    0+0k 0+0io 19670pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.090u 6.890s 2:32.29 50.5%    0+0k 0+0io 18337pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.510u 6.660s 2:29.29 51.6%    0+0k 0+0io 18463pf+0w
0:01 kswapd

Double swap space (from 200M to 400M):
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.510u 6.390s 2:24.39 53.2%    0+0k 0+0io 17902pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.600u 7.600s 2:56.97 44.1%    0+0k 0+0io 23599pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.370u 7.340s 2:50.26 45.6%    0+0k 0+0io 22295pf+0w
0:03 kswapd

This is interesting.
Runs 2 and 3 are slower, even with more swap space and the new
VM seems to have lost its proverbial stability on performance.

Old results below, for performance and behaviour comparisons.

Linux-2.4.14-pre7:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
Out of Memory: Killed process 224 (qsbench).
17.770u 3.160s 1:19.95 26.1%    0+0k 0+0io 13294pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
Out of Memory: Killed process 226 (qsbench).
26.030u 15.530s 1:39.39 41.8%   0+0k 0+0io 13283pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
Out of Memory: Killed process 228 (qsbench).
29.350u 41.360s 2:27.63 47.8%   0+0k 0+0io 15214pf+0w
0:12 kswapd

Double swap space:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.530u 2.920s 2:16.35 53.8%    0+0k 0+0io 17575pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.510u 3.160s 2:19.79 52.7%    0+0k 0+0io 17639pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.540u 3.270s 2:17.39 53.7%    0+0k 0+0io 17544pf+0w
0:01 kswapd


Linux-2.4.14-pre6:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
Out of Memory: Killed process 224 (qsbench).
69.890u 3.430s 2:12.48 55.3%    0+0k 0+0io 16374pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
Out of Memory: Killed process 226 (qsbench).
69.550u 2.990s 2:11.31 55.2%    0+0k 0+0io 15374pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
Out of Memory: Killed process 228 (qsbench).
69.480u 3.100s 2:13.33 54.4%    0+0k 0+0io 15950pf+0w
0:01 kswapd


Linux-2.4.14-pre5:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.340u 3.450s 2:13.62 55.2%    0+0k 0+0io 16829pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.590u 2.940s 2:15.48 54.2%    0+0k 0+0io 17182pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.140u 3.480s 2:14.66 54.6%    0+0k 0+0io 17122pf+0w
0:01 kswapd

2.4.14-pre5 has the best VM for qsbench :)


Linux-2.4.13:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.260u 2.150s 2:20.68 52.1%    0+0k 0+0io 20173pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.020u 2.050s 2:18.78 52.6%    0+0k 0+0io 20353pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.810u 2.080s 2:19.50 52.2%    0+0k 0+0io 20413pf+0w
0:06 kswapd


Linux-2.4.11:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.020u 1.650s 2:20.74 51.6%    0+0k 0+0io 10652pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.070u 1.650s 2:21.51 51.3%    0+0k 0+0io 10499pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.790u 1.670s 2:21.01 51.3%    0+0k 0+0io 10641pf+0w
0:04 kswapd


Linux-2.4.10:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.410u 1.870s 2:45.25 43.7%    0+0k 0+0io 16088pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.910u 1.840s 2:45.16 44.0%    0+0k 0+0io 16338pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.310u 1.910s 2:45.20 44.3%    0+0k 0+0io 16211pf+0w
0:03 kswapd


Linux-2.4.13-ac4:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.800u 3.470s 3:04.15 40.3%    0+0k 0+0io 13916pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.530u 3.930s 3:13.90 38.9%    0+0k 0+0io 14101pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.260u 3.640s 3:03.54 40.8%    0+0k 0+0io 13047pf+0w
0:08 kswapd



-- 
Lorenzo
