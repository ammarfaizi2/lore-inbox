Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263335AbSJFFfp>; Sun, 6 Oct 2002 01:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263337AbSJFFfp>; Sun, 6 Oct 2002 01:35:45 -0400
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:8576 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S263335AbSJFFfo> convert rfc822-to-8bit; Sun, 6 Oct 2002 01:35:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Subject: load additions to contest
Date: Sun, 6 Oct 2002 15:38:08 +1000
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, rcastro@ime.usp.br, ciarrocchi@linuxmail.org
References: <20021005182850.31930.qmail@linuxmail.org> <3D9F3A52.4FB46701@digeo.com>
In-Reply-To: <3D9F3A52.4FB46701@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210061538.43778.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've added some load conditions to an experimental version of contest 
(http://contest.kolivas.net) and here are some of the results I've obtained 
so far:

First an explanation
The time column shows how long it took to conduct the kernel compile in the 
presence of the load
The cpu% shows what percentage of the cpu the kernel compile managed to use 
during compilation
Loads shows how many times the load managed to run while the kernel compile 
was happening
Lcpu% shows the percentage cpu the load used while running
Ratio shows a ratio of kernel compilation time to the reference (2.4.19)

Use a fixed width font to see the tables correctly.

tarc_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [2]              88.0    74      50      25      1.31
2.4.19-cc [1]           86.1    78      51      26      1.28
2.5.38 [1]              91.8    74      46      22      1.37
2.5.39 [1]              94.4    71      58      27      1.41
2.5.40 [1]              95.0    71      59      27      1.41
2.5.40-mm1 [1]          93.8    72      56      26      1.40

This load repeatedly creates a tar of the include directory of the linux 
kernel. You can see a decrease in performance was visible at 2.5.38 without a 
concomitant increase in loads, but this improved by 2.5.39.


tarx_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [2]              87.6    74      13      24      1.30
2.4.19-cc [1]           81.5    80      12      24      1.21
2.5.38 [1]              296.5   23      54      28      4.41
2.5.39 [1]              108.2   64      9       12      1.61
2.5.40 [1]              107.0   64      8       11      1.59
2.5.40-mm1 [1]          120.5   58      12      16      1.79

This load repeatedly extracts a tar  of the include directory of the linux 
kernel. A performance boost is noted by the compressed cache kernel 
consistent with this data being cached better (less IO). 2.5.38 shows very 
heavy writing and a performance penalty with that. All the 2.5 kernels show 
worse performance than the 2.4 kernels as the time taken to compile the 
kernel is longer even though the amount of work done by the load has 
decreased.


read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [2]              134.1   54      14      5       2.00
2.4.19-cc [2]           92.5    72      22      20      1.38
2.5.38 [2]              100.5   76      9       5       1.50
2.5.39 [2]              101.3   74      14      6       1.51
2.5.40 [1]              101.5   73      13      5       1.51
2.5.40-mm1 [1]          104.5   74      9       5       1.56

This load repeatedly copies a file the size of the physical memory to 
/dev/null. Compressed caching shows the performance boost of caching more of 
this data in physical ram - caveat is that this data would be simple to 
compress so the advantage is overstated. The 2.5 kernels show equivalent 
performance at 2.5.38 (time down at the expense of load down) but have better 
performance at 2.5.39-40 (time down with equivalent load being performed). 
2.5.40-mm1 seems to exhibit the same performance as 2.5.38.


lslr_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [2]              83.1    77      34      24      1.24
2.4.19-cc [1]           82.8    79      34      24      1.23
2.5.38 [1]              74.8    89      16      13      1.11
2.5.39 [1]              76.7    88      18      14      1.14
2.5.40 [1]              74.9    89      15      12      1.12
2.5.40-mm1 [1]          76.0    89      15      12      1.13

This load repeatedly does a `ls -lR >/dev/null`. The performance seems to be 
overall similar, with the bias towards the kernel compilation being performed 
sooner.

These were very interesting loads to conduct as suggested by AKPM and 
depending on the feedback I get I will probably incorporate them into 
contest.

Comments?
Con 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9n8xCF6dfvkL3i1gRAqQMAJwJ1lgYI0ebW1yw7frZt7lncYBFVQCeIsYN
NNgrrWyrqTWGLO11IlxtyPs=
=Ldnh
-----END PGP SIGNATURE-----
