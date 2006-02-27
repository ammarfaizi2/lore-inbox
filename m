Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWB0QjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWB0QjT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 11:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWB0QjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 11:39:19 -0500
Received: from usmimesweeper.bluearc.com ([63.203.197.133]:15888 "EHLO
	us-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S1751489AbWB0QjS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 11:39:18 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Date: Mon, 27 Feb 2006 16:39:03 -0000
Message-ID: <89E85E0168AD994693B574C80EDB9C270393BF5C@uk-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Thread-Index: AcY7r5S5ApfBiVDEQHudg6EmtSydkgACf9wg
From: "Andy Chittenden" <AChittenden@bluearc.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: "Anton Altaparmakov" <aia21@cam.ac.uk>, "Andrew Morton" <akpm@osdl.org>,
       <davej@redhat.com>, <linux-kernel@vger.kernel.org>,
       <lwoodman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sure, this is the one:
> 
> http://lkml.org/lkml/2006/2/26/212

Well, the problem hasn't reoccurred with that patch applied. I'll leave
it running overnight as quite often one or two windows have disappeared
by the morning. The machine still becomes unresponsive whilst the dd is
happening though (eg tab completion takes an age, loading programs takes
an age, typing into windows doesn't echo). Is that meant to happen? FWIW
whilst the dd was happening I did a vmstat -a 1:

procs -----------memory---------- ---swap-- -----io---- --system--
----cpu----
 r  b   swpd   free  inact active   si   so    bi    bo   in    cs us sy
id wa
...

 0  0    152  44400 3578344 275716    0    0     0     0 1138  2807  4
2 94  0
 0  0    152  44400 3578328 275732    0    0     0     0 1019  1169  1
0 99  0
 0  0    152  44400 3578352 275744    0    0    12   441 1089  1320  0
0 98  2
 0  0    152  44400 3578352 275744    0    0     0     0 1110  2639  4
2 94  0
 0  0    152  44400 3578352 275744    0    0     0     0 1075  1246  1
1 98  0

I restarted the dd about here so I guess the file was deleted somehow
freeing up memory.

 1  0    152 862668 2771716 275868    0    0    72     0 1027  1214  0
20 75  5
 0  1    152 3681804  18520 276140    0    0   184     0 1093  1282  1
78  0 21
 0  1    152 3681556  16176 279044    0    0   560     0 1157  1457  0
31  0 69
 0  1    152 3680812  14840 280996    0    0   608    12 1191  1576  0
29  0 71
 1  0    152 3545548 145780 282068    0    0   396     0 1125  1379  1
49  0 50
 0  4    152 3189756 486836 282412    0    0    12  2952 1270  1194  0
98  0  2
 0  3    152 3080188 580820 282292    0    0     8 15328 1213  1913  0
31  0 69
 0  2    152 3026124 632412 282344    0    0     4 38912 1076  1472  0
26  0 74
 0  2    152 3026124 632412 282344    0    0     0 40960 1055  1507  1
8  0 91
 0  4    152 3026124 632424 282344    0    0     4 36872 1068  1548  0
9  0 91
 0  3    152 3025876 632424 282344    0    0     0 36868 1056  1691  0
8  0 92
 2  3    152 3025876 632424 282344    0    0     0 40960 1079  1679  1
10  0 89
 0  3    152 3025876 632420 282348    0    0     0 39936 1055  1710  0
9  0 91
 0  3    152 3025876 632420 282348    0    0     0 39936 1073  1694  0
10  0 90
 0  3    152 3025876 632420 282348    0    0     0 40960 1054  1678  1
8  0 91
 0  4    152 3025876 632428 282348    0    0     0 38920 1072  1676  0
9  0 91
 1  3    152 3033552 635180 282376    0    0    40 32900 1065  1570  1
13  0 86
 1  4    152 2823012 827508 285828    0    0    24 34404 1083  1715  0
75  0 25
 1  3    152 2608068 1028180 285964    0    0    12 38912 1057  2213  0
82  0 18
 1  2    152 2338100 1285928 286196    0    0    12 37888 1088  2331  1
92  0  7
 1  3    152 2082540 1529624 286412    0    0     8 36568 1058  2414  1
84  0 15
 1  5    152 1796064 1815408 286696    0    0    12 15600 1237  1720  0
89  0 11
procs -----------memory---------- ---swap-- -----io---- --system--
----cpu----
 r  b   swpd   free  inact active   si   so    bi    bo   in    cs us sy
id wa
 2  3    152 1538724 2048260 286896    0    0     8 42264 1316  2669  0
84  0 16
 0  2    152 1503004 2081924 286924    0    0     0 23360 1205  1992  1
18  0 81
 0  2    152 1502964 2081924 286924    0    0     0  8088 1251  3369  5
3  0 92
 0  2    152 1503496 2081156 286924    0    0     0 38440 1196  1709  1
11  0 88
 1  3    152 1413716 2176572 287032    0    0    28 30320 1084  1712  0
37  0 63
 0  5    152 1359752 2214508 287072    0    0     4 163140 1105  1302  0
24  0 76
 1  4    152 1351744 2224172 287080    0    0     0 25884 1120  1382  1
6  0 93
 0  5    152 1291080 2283732 287144    0    0     4 26452 1216  2457  4
21  0 75
 0  5    152 1295324 2283732 287144    0    0     0  2156 1322  2000  0
2  0 98
 0  4    152 1298864 2283736 287144    0    0     0  1964 1288  1831  1
2  0 97
 1  4    152 1303208 2291816 287152    0    0     0 29320 1336  1663  1
8  0 91
 1  5    152 1145576 2431324 287292    0    0     4 119636 1430  1920  1
47  0 52
 0  5    152 1106392 2472340 287332    0    0     0  2388 1169  1593  1
16  0 83
 0  5    152 1074856 2509208 287368    0    0     0  2404 1079  1324  1
12  0 87
 1  4    152 1038816 2549536 287412    0    0     4  1072 1077  1361  0
14  0 86
 0  4    152 994080 2578952 287440    0    0     0 134876 1377  1779  1
17  0 82
 0  5    152 952192 2617100 287480    0    0     4 61440 1130  1486  1
16  0 83
 0  6    152 916632 2649484 287504    0    0     4 55300 1104  1417  0
15  0 85
 0  6    152 919176 2648212 287500    0    0     0 27652 1121  1421  1
1  0 98
 0  6    152 920448 2645652 287500    0    0     0 49376 1121  1325  1
4  0 95
 0  6    152 923568 2644884 287500    0    0     0 24352 1104  1304  0
2  0 98
 1  5    152 846176 2717684 287572    0    0     4 49156 1114  1419  1
28  0 71
 0  6    152 791688 2769408 287620    0    0     4 29696 1097  1405  0
19  0 81
 0  6    152 792320 2767872 287620    0    0     0 60380 1120  1418  1
3  0 96
 0  6    152 793804 2767872 287620    0    0     0 19492 1074  1267  0
2  0 98
 1  4    152 741732 2816792 287676    0    0     4 53248 1111  1503  1
18  0 81
 0  5    152 567780 2983084 287856    0    0     4 16388 1080  1392  1
56  0 43
 0  5    152 531088 3017648 287888    0    0     0 40964 1119  1494  0
15  0 85
 0  5    152 486648 3062592 287936    0    0     4 32768 1091  1409  1
16  0 83
 0  5    152 449296 3099456 287972    0    0     0 64512 1089  1323  0
15  0 85
 0  6    152 415596 3136384 288008    0    0     0 32776 1068  1381  1
13  0 86
 0  6    152 375792 3177400 288052    0    0     4 32788 1094  1348  1
16  0 83
 1  5    152 332888 3218584 288092    0    0     0 31744 1065  1262  0
14  0 86
 0  6    152 281976 3259376 288132    0    0     0 62464 1130  1690  2
18  0 80
 0  6    152 239856 3296300 288172    0    0     4 32772 1163  2431  5
14  0 81
 0  6    152 199400 3333168 288208    0    0     0 31748 1073  1331  2
14  0 84
 0  6    152 159796 3375464 288252    0    0     0 25600 1204  1610  1
18  0 81
 0  6    152 118320 3412384 288292    0    0     4 65536 1219  1492  1
15  0 84
 0  6    152  75704 3453344 288332    0    0     0 31744 1078  1449  0
17  0 83
 0  5    152  40556 3486168 288364    0    0     0 32772 1237  1662  1
13  0 86
 0  5    152  14716 3510608 288372    0    0     0 16688 1111  1802  0
15  0 85
 1  4    152  17180 3511204 288336    0    0     4 50896 1197  2581  1
19  0 80
 0  5    152  20412 3510108 288300    0    0     0 64512 1100  2340  1
16  0 83
 0  5    152  25720 3509648 288288    0    0     0 32768 1176  2731  6
18  0 76
 0  5    152  25660 3509524 288252    0    0     4 32772 1113  2384  0
16  0 84
 2  4    152  24604 3510716 288200    0    0     0 22476 1271  2626  2
17  0 81
 0  5    152  26568 3511984 287224    0    0     0   112 1132  2431  0
16  0 84

And so on. As you can see the amount of free memory dwindles to almost
nothing as the dd continues.

-- 
Andy, BlueArc Engineering
