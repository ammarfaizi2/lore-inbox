Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264474AbTCXSbO>; Mon, 24 Mar 2003 13:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264477AbTCXSbO>; Mon, 24 Mar 2003 13:31:14 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:15378 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S264474AbTCXSbM>; Mon, 24 Mar 2003 13:31:12 -0500
Date: Mon, 24 Mar 2003 19:36:17 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.65 interactivity
In-Reply-To: <20030322132551.75ff8ab8.akpm@digeo.com>
Message-ID: <Pine.LNX.4.51.0303241931360.11544@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0303221929350.28558@dns.toxicfilms.tv>
 <20030322132551.75ff8ab8.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> First thing we need to work out is whether it is a CPU scheduler thing
> or if it is a VM/MM/block/fs latency problem.
OK

> - How much memory do you have?
128 MB

> - Are your disks runnning in DMA mode? (run hdparm /dev/hda)
yes, two drives / and /home on quite modern 20gb disks with dma == 1

> - Send `vmstat 1' traces from when the problem is happening.
see below. The machine stopped (even the hdd activity was 0) about 10
lines from the bottom of the log.

> - If you nice up the X server, does that help?
you mean to lower priority ? i've had the same with -10 and 0.
It is 0 now, and i think it is more responsive.

> - Try setting /proc/sys/vm/swappiness to zero
i will try.

> - Try decreasing /proc/sys/vm/dirty_ratio to 15
will try that too.

I will send reports after experimenting with sysctls.

Regards,
Maciej

vmstat 1 output

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0  21640   4628    916  41600    0    4    76    61 1185   493  2  1 95  2
 0  0  21640   4628    924  41600    0    0     0   100 1419  1346  4  1 94  1
 0  0  21640   4484    924  41728    0    0   128     0 1364  1117  3  0 97  0
 0  0  21640   4484    924  41728    0    0     0     0 1259  1032  2  0 98  0
 0  0  21640   4444    932  41740   32    0    44    16 1280  1109  1  1 94  4
 2  0  21640   4420    932  41748    0    0     8     0 1280  1217  3  0 97  0
 7  2  21640  12472    948  33636    0    0     8    20 1321  1306  1  2 96  1
 1  0  21640  10424    960  35732    0    0     0    16 3887  4489 10 12 77  1
 0  0  21640   7712    968  38420   32    0   168     0 4423  5275 10 15 72  2
 1  3  21684   3760    896  41160   32   44  4176  7196 5490  6572 16 28 15 42
 1  1  21936   3748    896  41044    0  252  3460  6580 4221  4056 42 19  0 39
 0  2  22356   3660    924  41124    0  420  1784  2968 3639  3418 60 14  0 26
 3  0  22356   4164    876  40420    0    0  1012  1320 5491  6073 14 23 54  9
 1  0  22356   3852    884  40728    0    0   172  6880 9954 10642 27 43 17 13
 4  1  22356   2728    864  41976    0    0    72  5736 8883 10087 14 31 31 24
 2  0  23148   3160    844  42312    0  792    28  5688 8599  9551 22 36 38  4
 0  0  23616   2992    804  43100    0  472    48 11236 7861  8476 16 31 36 18
 1  0  24000   3808    772  42560    0  408    24   836 8338  9604 21 31 43  4
 1  1  24164   3680    748  43120    0  164    36  5084 8234  9113 21 33 33 13
 0  0  24164   3848    744  42960    0    0    48  3000 4658  4848 11 16 30 43
 1  1  24440   3516    684  43532    0  276    52  8052 8522  9310 22 38 26 15
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  2  25508   4052    584  44564    0 1068   588 13340 12071 12322 31 48  6 15
 4  0  26484   3644    644  45348    0  976   920  2480 10823 11594 35 49  0 17
 2  2  26484   3640    544  45048    0    0   236 14464 8417  8757 30 37  0 32
 2  4  26484   3636    612  44072   80    0   408     0 9503  9860 29 36  0 35
 1  5  26788   1916    600  44892  876  304  1104  7332 9195 11260 32 35  0 33
 1  6  27004   2092    680  44432    0  216   216  3120 5617  8959 43 24  0 33
 0 12  27168   1936    644  43232   64  164  1028  7112 5605  4233 26 21  0 53
 1  8  29164   3360    484  42304   96 1996   384 14128 8047  7891 24 34  0 42
 1 10  33048   2996    524  44348  300 3924   896  6156 8508  9007  7 19  0 73
 2  3  33292   2304    620  46836 1360  244  2492  6288 16644 17416 25 34  0 42
 6  1  33856   3316    636  45768   92  564  1224 12368 10741 10624 36 44  0 20
 0  7  34736   1908    664  47120   28  880   444 14280 10979 12214 18 38  0 44
 1  9  35164   2324    648  46716    0  440     0  2012 2669  2242  0  5  0 95
 0 11  35164   2360    656  46720    0    0     4     8 1260   434  0  0  0 100
 0  6  35712   3764    716  47392   96  548  1004  3788 29699 19348  1  2  0 96
 2  3  35712   3388    892  47360   64    0   704  6004 1718  1478 25  4  0 72
 1  0  35712   3544   1012  46636  196    0   792    48 1398  1425  7  2 31 60
 0  0  35712   3424   1012  46764    0    0   128     0 1548  1305  2  1 97  0
 0  0  35712   3424   1020  46764    0    0     0    20 1438  1218  1  1 98  0
 1  0  35712   3408   1036  46780  128    0   144   224 1314  1300  2  0 91  7
 0  0  35712   3420   1036  46780    0    0     0     0 1341  1184  3  1 96  0
