Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267923AbRGXQUL>; Tue, 24 Jul 2001 12:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267925AbRGXQUC>; Tue, 24 Jul 2001 12:20:02 -0400
Received: from h24-78-175-24.vn.shawcable.net ([24.78.175.24]:46468 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S267923AbRGXQTr>;
	Tue, 24 Jul 2001 12:19:47 -0400
Date: Tue, 24 Jul 2001 09:19:51 -0700
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.7, 2.4.4 VM swaps out unnecessarily
Message-ID: <20010724091951.A29625@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I'm developing an application which, when run, reads a large amount of
sequential data from disk for processing.  The average data set does not
fit in cache (128MB box).  When my application runs, X becomes very jumpy
and I'm not able to even load new terminals without having to wait 5-10
seconds.  This didn't happen with 2.2, and it's quite frustrating.

IDE 5400 RPM disk, hdparm -u 1 -d 1 -c 1, Celeron 500.  "vmstat 1" shows
the machine swapping out like crazy, and processes getting blocked.  I'm
not sure where the out blocks are coming from as my program writes
absolutely nothing until right at the end.

 procs                     memory    swap        io     system         cpu
 r b w   swpd  free  buff  cache  si  so    bi   bo   in    cs  us  sy  id
 0 1 0      0  3684 23120  35028  11   4   356    6  133   677   2   1  97
 1 0 0      0  3100 16080  42580   0   0  7552    0  324  1020   8  19  74
 1 0 0      0  2800  7584  51620   0   0 10419    0  394  1191   5  16  79
 1 0 0      0  2800   912  58508   0   0 10193    0  414  1202   4  13  83
 1 0 0      0  2800   872  58548   0   0  5857   59  335  1004   3   8  89
 1 0 0  25012  2800   912  58276   0 1468  3842 1481  274   918   2   8  90
 1 0 0  26428  2800   948  61288   0 1980  3191 2001  262   884   1   8  91
 1 0 1  27764  2800   976  63280   0 2892  2714 2893  255   866   2   4  94
 0 1 1  29128  2732  1012  65960   0 2124  3608 2131  261  1007   1   6  93
 0 1 1  32732  2800  1032  67420   0 2452  1801 2456  207   860   0   5  95
 1 0 0  33400  2800  1060  69232   0 1868  3341 1876  253   868   0   6  94
 0 1 1  33628  2760  1040  70424   0 660  7287  671  358  1124   2  13  85
 1 0 0  34804  2800  1048  70912   0 428  4804  429  288   992   1   6  93
 1 0 0  35376  2800  1088  71688   0 568  6257  570  328  1080   2  11  87
 1 0 0  36288  2800  1072  72356   0 672  5625  675  329  1104   2  10  88
 1 0 0  37360  2800  1076  72652   0 400  7616  418  349  1116   1  11  88
 0 1 0  38036  2800   940  73344   0 1208  5741 1231  319  1112   2   8  90
 1 0 0  38844  2800   988  73852   0 432  6991  432  355  1090   2  10  88
 1 1 0  39372  2800   892  74916   0 656  3551  658  241   938   1   6  93
 0 2 0  40264  2800   896  74900  36 368  1745  370  200   749   0   5  95
 1 1 0  40808  2800   904  75212   0 1228   440 1334  217   662   0   1  99
 0 1 0  41632  2800   932  76976   0 1228  3022 1269  229   858   0   1  99
 0 6 1  43444  2620   956  78392  40 1936  2509 1936  468  1434   0   8  92
 0 4 1  44460  2800   960  78384   0 1392   294 1392  564  1574   1   2  97
 0 1 0  44604  2800   976  79980   0 960  1812  960  624  1687   5   8  87
 1 0 0  45792  2800   996  81396   0 636  2981  638  477  1513   1   8  91
 1 0 1  47072  2732  1012  82372   0 1540  2365 1550  276   953   0   7  93
 1 0 0  47808  2800   988  82780   0 440  2918  440  272   848   1   5  94
 1 0 0  48128  2800   964  84404   0 1416  2161 1416  252  1020   1   6  93
 0 1 1  48336  2712   992  85768   0 1904  3504 1906  253  1050   0   5  95
 0 1 0  48556  2800   996  86836   0 1432  3216 1435  257  1052   1   4  95
 0 1 0  48620  2800  1008  87920   0 748  4053  764  320  1074   0   7  93
 1 0 0  48684  2800  1020  88868   0 1064  4361 1064  362  1104   0   4  96
 0 1 1  48836  2672  1036  89924   0 1732  4392 1734  296  1116   3   9  88
 procs                    memory    swap         io     system         cpu
 r b w   swpd  free  buff  cache  si  so    bi   bo   in    cs  us  sy  id
 2 0 0  48848  2816  1024  91232   0 748  2460  749  257   960   0   5  95
 0 1 1  48848  2800  1028  91220   0 1560  3097 1560  251   812   1   5  94
 1 0 0  48876  2800  1036  92852  64  84  4476   84  284   881   1   5  94
 1 0 0  48904  2800  1044  93616   0 932  4080  954  307   884   2   7  91
 0 1 0  48952  2800  1048  94088   0 932  5166  932  322  1070   0  11  89
 1 0 0  49000  2800  1064  95004  52 780  4410  782  307  1087   0   7  93
 0 2 1  49000  2800  1072  95084   0 724  7159  724  367  1088   2  13  85
 0 2 0  49044  2800  1072  95660 164 332  1430  365  223   724   1   5  94
 0 1 0  49048  2800  1068  95828  48 704  4765  704  502  1513   3   8  89
 0 3 0  49048  2800  1052  95880 412   0  7269    0  344  1067   2  13  85
 1 2 0  49048  2800  1052  95408 484   0  1283    0  190   707   0   2  98
 0 1 0  49048  2800  1048  95052 508   0  5970    0  301   985   4   9  87
 1 0 0  49052  2800  1060  95816   0 932  5316  954  370  1190   1   7  92
 0 1 0  49092  2800  1100  96440   0 644  5249  644  309  1064   4   6  90
 1 0 0  49176  2800  1116  96480   0 372  4175  372  256   873   1   8  91
 1 0 0  49276  2800  1152  97032  44 228  6791  229  384  1109   2  14  84
 1 0 0  49344  2800  1172  97396  52 128  6284  136  319   970   5  13  82
 1 0 0  49368  2800  1192  97784 456   0  7325    0  631  1620   2  12  86
 1 0 0  49392  2800  1180  96692 692   0  1451    0  303   827  18   4  78
 0 1 0  48788  2800  1180  96996 680   0  1157    0  254   859  17   0  83
 1 1 0  48788  2800  1184  96396 428   0  1417    0  197   752   0   1  99
 0 1 0  48788  2800  1164  94820 1480   0  1999    0  233  1201   2   1  97
 0 3 0  48856  2800  1132  91952 1676   0  2182    0  254  1421   9   9  82
 0 3 0  48916  2800  1112  90604 1364   0  2237    0  214  2125   4   6  90
 0 0 0  48816  2800  1096  89384 1320   0  1739    0  181  1015   2   2  96
 0 0 0  48816  2800  1096  89384   0   0     0    0  109   627   0   0 100
 0 0 0  48816  2800  1096  89384   0   0     0    0  108   624   0   0 100
 0 0 0  48816  2800  1096  89384   0   0     0    0  106   625   0   0 100
 0 0 0  48816  2800  1096  89384   0   0     0    0  110   624   0   0 100

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
