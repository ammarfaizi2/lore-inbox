Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264786AbSL0Fhx>; Fri, 27 Dec 2002 00:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264795AbSL0Fhx>; Fri, 27 Dec 2002 00:37:53 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:31905 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S264786AbSL0Fhv>;
	Fri, 27 Dec 2002 00:37:51 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] vm swappiness with contest
Date: Fri, 27 Dec 2002 16:46:00 +1100
User-Agent: KMail/1.4.3
Cc: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212271646.01487.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here is a family of contest benchmarks using the osdl hardware in uniprocessor 
mode on 2.5.53-mm1 while varying vm swappiness. s020 is vm swappiness=20 and 
so on:

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
s000 [3]                71.1    95      0       0       1.07
s020 [5]                71.9    95      0       0       1.08
s040 [5]                71.7    95      0       0       1.07
s060 [5]                71.3    96      0       0       1.07
s080 [5]                71.3    95      0       0       1.07
s100 [5]                71.6    95      0       0       1.07

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
s000 [3]                68.4    99      0       0       1.02
s020 [5]                68.8    99      0       0       1.03
s040 [5]                68.7    99      0       0       1.03
s060 [5]                68.6    99      0       0       1.03
s080 [5]                68.5    99      0       0       1.03
s100 [5]                68.7    99      0       0       1.03

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
s000 [3]                119.0   57      49      41      1.78
s020 [5]                119.4   57      49      41      1.79
s040 [5]                118.6   57      48      41      1.78
s060 [5]                117.6   57      47      41      1.76
s080 [5]                119.5   57      49      41      1.79
s100 [5]                118.4   58      48      40      1.77

dbench_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
s000 [3]                191.6   41      1       43      2.87
s020 [5]                195.5   40      1       44      2.93
s040 [5]                197.9   41      1       43      2.96
s060 [5]                331.4   32      0       23      4.96
s080 [5]                439.4   24      0       10      6.58
s100 [5]                883.6   13      1       9       13.24
The first of the massive effect of changing this value. A recurring theme is 
large file writes with a swappy kernel seems to waste time swapping data 
because of the IO data. Obviously none of these IO loads use the o_direct 
option.

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
s000 [3]                113.4   81      3       10      1.70
s020 [5]                103.3   80      2       9       1.55
s040 [5]                110.0   79      3       9       1.65
s060 [5]                103.0   80      3       9       1.54
s080 [5]                104.4   80      2       8       1.56
s100 [5]                100.2   80      2       8       1.50
Slightly slower with an unswappy kernel

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
s000 [3]                139.2   65      3       8       2.09
s020 [5]                128.7   70      2       7       1.93
s040 [5]                152.8   59      3       7       2.29
s060 [5]                137.0   64      2       6       2.05
s080 [5]                124.6   66      2       6       1.87
s100 [5]                127.6   66      2       6       1.91
Up and down, no firm pattern

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
s000 [3]                121.8   63      21      17      1.82
s020 [5]                125.9   61      22      17      1.89
s040 [5]                130.1   59      22      17      1.95
s080 [5]                174.6   47      27      15      2.62
s100 [5]                208.1   42      25      11      3.12
Increase the swappiness, increase the kernel compile time as dbench_load does


io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
s000 [3]                103.6   73      18      17      1.55
s020 [5]                135.4   62      25      18      2.03
s040 [5]                157.7   57      28      18      2.36
s060 [5]                188.1   48      32      16      2.82
s080 [5]                246.2   37      38      15      3.69
s100 [5]                378.8   24      45      11      5.67
Another massive change.

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
s000 [3]                89.7    80      15      7       1.34
s020 [5]                91.1    79      13      6       1.36
s040 [5]                90.6    79      12      6       1.36
s060 [5]                90.3    79      12      6       1.35
s080 [5]                90.3    79      12      6       1.35
s100 [5]                92.2    78      10      5       1.38

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
s000 [3]                81.8    85      0       9       1.23
s020 [5]                81.9    85      0       9       1.23
s040 [5]                82.0    85      0       9       1.23
s060 [5]                82.2    85      0       8       1.23
s080 [5]                82.7    85      0       8       1.24
s100 [5]                83.1    85      0       8       1.24

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
s000 [3]                233.2   32      65      1       3.49
s020 [5]                172.3   42      50      1       2.58
s040 [5]                163.8   46      44      1       2.45
s060 [5]                192.2   39      38      1       2.88
s080 [5]                186.4   42      37      0       2.79
s100 [5]                128.2   57      37      1       1.92
Here it seems only the extreme values make a difference. Un unswappy kernel 
makes it slow down significantly, whereas a swappy kernel speeds it up 
significantly.

Paolo if I was to choose a number from these values I'd suggest lower than 60 
rather than higher, BUT that is because the io load effects become a real 
problem when the kernel is swappy - don't _really_ know what this means for 
the rest of the time. Maybe in the 40-50 range. There seems to be a knee 
(bend) in the curve (most noticable in dbench_load) rather than the curves 
being linear. That knee I believe simply shows the way the algorithm for 
swappiness basically works. I might throw a 50 at the machine as well to see 
what that does.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+C+kYF6dfvkL3i1gRAt2HAJ9UJFKO2i5K6LW/7WU+cJ1TBOtlEQCeISK7
7ecGaUImIiJvC1Bz649vmH8=
=UI1t
-----END PGP SIGNATURE-----
