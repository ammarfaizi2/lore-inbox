Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbUCKA4P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 19:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262922AbUCKA4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 19:56:15 -0500
Received: from ns.cohaesio.net ([212.97.129.16]:42199 "EHLO ns.cohaesio.net")
	by vger.kernel.org with ESMTP id S262912AbUCKAzw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 19:55:52 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.3 userspace freeze
Date: Thu, 11 Mar 2004 01:45:59 +0100
Message-ID: <222BE5975A4813449559163F8F8CF503458439@cohsrv1.cohaesio.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.3 userspace freeze
Thread-Index: AcQGtogxF2QlXBWNRvSvfDEWZ/gK3QASZEZw
From: "Anders K. Pedersen" <akp@cohaesio.com>
To: "Jan Kara" <jack@suse.cz>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> -----Original Message-----
> From: Jan Kara [mailto:jack@suse.cz] 
> Sent: Wednesday, March 10, 2004 4:44 PM
> To: Anders K. Pedersen
> Cc: Andrew Morton; linux-kernel@vger.kernel.org
> Subject: Re: 2.6.3 userspace freeze

> > I will try this to night; just to make sure I understand 
> you correctly:
> > You just want me to turn off quotas on all file systems 
> (currently they
> > are in use on one of them), and it is not necessary to recompile the
> > kernel without quota support?
>   Yes, just turning quotas off with quotaoff(8) should be 
> enough to rule
> out possible deadlocks caused by quotas.

I just tried booting the 2.6.3 kernel without any qoutas enabled in
fstab, and it failed like previously after only 17 minutes.

Output from vmstat 1 before the freeze:

   procs                      memory      swap          io     system
cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us
sy id
 0  1  0      0 1388352  67052 138104    0    0   440   364 1309   806
15  5 80
 0  1  0      0 1386304  67496 138068    0    0   436   668 1410  1008
24  5 71
 0  1  0      0 1384512  67980 138196    0    0   584   692 1583  1295
33  5 62
 0  1  1      0 1385024  68436 138284    0    0   500   492 1404   995
17  2 80
 1  1  0      0 1383888  68880 138316    0    0   448   568 1422  1099
24 22 53
 0  1  0      0 1381968  69276 138328    0    0   396   316 1382   929
26  4 71
 0  1  0      0 1381016  69712 138300    0    0   428  1488 1415  1095
12  3 85
 0  1  0      0 1379864  70136 138352    0    0   424   500 1275   873
11  2 87
 0  1  1      0 1378792  70600 138296    0    0   460   660 1320   967
11  1 88
 0  1  0      0 1377704  71020 138352    0    0   416   884 1445  1245
25 24 51
 0  1  0      0 1376616  71440 138340    0    0   420   556 1372   991
23  5 72
 0  1  0      0 1374632  71884 138372    0    0   436  1308 1423  1065
17  4 79
 0  1  0      0 1373672  72324 138340    0    0   444   448 1319   983
9  3 88
 0  1  0      0 1372584  72752 138320    0    0   428   316 1309   840
16  2 82
 0  1  0      0 1371496  73208 138340    0    0   448   688 1315  1085
9 13 78
 0  3  0      0 1370216  73676 138552    0    0   672   604 1436  1172
13  3 84
 0  1  0      0 1367976  74088 138616    0    0   448   524 1442  1035
22  4 74
 0  1  0      0 1365280  74536 138644    0    0   448   564 1306   918
9  4 87
 0  1  0      0 1363808  74960 138696    0    0   424   360 1291   804
11  2 87
 0  1  1      0 1362848  75428 138704    0    0   460   772 1321  1117
18 27 55
 0  1  0      0 1361504  75916 138692    0    0   488   464 1322   928
15  2 83
   procs                      memory      swap          io     system
cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us
sy id
 0  1  0      0 1360224  76376 138708    0    0   452   432 1286   783
15  3 83
 1  0  0      0 1358712  76812 138680    0    0   436   604 1366  1091
11 12 76
 0  1  0      0 1357624  77256 138780    0    0   556   740 1363  1025
7  3 90
 0  1  0      0 1356600  77708 138804    0    0   452   492 1303   943
10 17 74
 0  1  0      0 1355064  78196 138860    0    0   480   244 1322   928
24  5 71
 1  0  0      0 1353976  78668 138864    0    0   472   272 1323   837
11  2 87
 0  1  0      0 1352824  79132 138876    0    0   464   560 1365   993
11  3 86
 0  1  0      0 1350152  79592 138824    0    0   460   508 1434  1044
22  3 75
 0  1  0      0 1350344  80060 138900    0    0   500   348 1279   894
10 17 73
 0  1  0      0 1349200  80544 138892    0    0   480   668 1387  1124
20  5 75
 0  1  0      0 1348240  80988 138924    0    0   436  1256 1427  1256
6  2 92
 0  1  0      0 1345440  81488 138968    0    0   524   500 1368   940
14  4 82
 0  1  0      0 1344272  81952 138912    0    0   464   440 1352   918
13  4 83
 2  0  0      0 1344784  82428 138980    0    0   476   552 1310   914
6  8 86
 0  1  0      0 1343632  82904 138912    0    0   468   664 1331  1163
6 15 79
 0  1  0      0 1342352  83376 138916    0    0   464   816 1354  1085
5  2 93
 0  1  0      0 1341264  83820 138948    0    0   444   316 1216   678
3  1 96
 0  1  0      0 1340112  84248 138996    0    0   428   392 1233   752
3  2 95
 0  1  0      0 1338824  84660 139060    0    0   464   524 1363   949
11  1 88
 0  1  1      0 1337352  85132 139064    0    0   512   608 1374  1143
9 21 70
 0  1  0      0 1335992  85616 139124    0    0   516  1012 1655  1483
16  4 79
   procs                      memory      swap          io     system
cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us
sy id
 1  0  0      0 1334904  86100 139116    0    0   488   352 1248   788
3  2 95
 0  1  0      0 1334008  86552 139140    0    0   448   696 1359  1045
3  1 96
 0  1  0      0 1333048  87036 139200    0    0   484   492 1423  1021
4  2 94
 0  1  1      0 1331960  87528 139184    0    0   476   596 1295   990
4 22 74
 1  0  0      0 1369848  87920 139268    0    0   392   664 1291   837
14 10 76
 1  0  0      0 1361848  87920 139268    0    0     0   488 1216   648
54  6 41
 1  0  0      0 1357048  87928 139260    0    0    16   300 1147   513
49  4 47
 1  1  1      0 1351096  87936 139320    0    0    80   704 1276   840
50  6 44
 1  1  1      0 1346168  87988 139336    0    0    44  1308 1337   996
49 16 35
 1  1  1      0 1336312  88012 139312    0    0    72   840 1408   972
51  6 43
18  1 17      0 1567736  88012 139380    0    0     0   512 1401   718
26 50 23
 1  0  1      0 1547448  88012 139380    0    0     0  1284 1375  1122
49 27 24
 1  0  0      0 1545016  88012 139380    0    0     0   104 1077   298
48  4 49
 1  0  0      0 1542328  88036 139424    0    0     0   904 1170   568
48 11 41
 1  0  0      0 1539208  88036 139424    0    0     0   548 1165   623
49  6 45
 1  0  0      0 1534792  88036 139424    0    0     0   356 1116   457
47  6 47
 1  1  3      0 1521464  88036 139424    0    0     0   420 1119   414
32 32 36
 2  1  2      0 1508904  88036 139424    0    0     0   808 1210   620
12 89  0
 1  0  0      0 1497624  88056 139404    0    0     4   972 1151   515
13 84  3
 0  0  0      0 1497616  88056 139404    0    0     0     0 1037   281
1 11 88
 3  0  0      0 1427536  88056 139404    0    0     0     0 1157   392
39 24 36
   procs                      memory      swap          io     system
cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us
sy id
 0  1  0      0 1385352  88116 139480    0    0   152     0 1190   507
20 28 52
 1  0  0      0 1386952  88124 139472    0    0    16     0 1087   323
1  1 99
SOFTDOG: Initiating system reboot.

Last output from top before it froze:

 01:26:32  up 17 min,  2 users,  load average: 1.23, 0.52, 0.31
253 processes: 188 sleeping, 4 running, 61 zombie, 0 stopped
CPU0 states:  45.0% user  36.0% system    0.0% nice   3.1% iowait  15.2%
idle
CPU1 states:  21.3% user  34.4% system    0.0% nice   0.2% iowait  43.0%
idle
Mem:  2072988k av,  569868k used, 1503120k free,       0k shrd,   88036k
buff
       403116k active,             101256k inactive
Swap: 8384880k av,       0k used, 8384880k free                  139424k
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU
COMMAND
 1109 root      25   0  113M 105M 11316 R    88.6  5.2   0:16   1 httpd
 2018 root      16   0  2360 1348  1936 R     1.5  0.0   0:22   0 top
 1879 root      16   0  1412  468  1356 S     0.7  0.0   0:05   1 vmstat
   19 root      15   0     0    0     0 SW    0.3  0.0   0:01   1
kjournald
  781 named     15   0 52932  50M  2056 S     0.3  2.4   0:02   1 named
 3144 root      25   0  3656  748  3388 S     0.3  0.0   0:00   1
rotatelogs
 3145 root      25   0  3656  748  3388 S     0.3  0.0   0:00   0
rotatelogs
 3147 root      25   0  3656  748  3388 S     0.3  0.0   0:00   0
rotatelogs
 3149 root      25   0  3656  748  3388 S     0.3  0.0   0:00   0
rotatelogs
 3153 root      25   0  3660  752  3388 S     0.3  0.0   0:00   0
rotatelogs
 3154 root      25   0  3660  748  3388 S     0.3  0.0   0:00   1
rotatelogs
 3155 root      25   0  3660  748  3388 S     0.3  0.0   0:00   1
rotatelogs
 3163 root      25   0  3660  752  3388 S     0.3  0.0   0:00   0
rotatelogs
 3167 root      25   0  3660  752  3388 S     0.3  0.0   0:00   0
rotatelogs
 3178 root      25   0  3660  752  3388 S     0.3  0.0   0:00   1
rotatelogs
 3179 root      25   0  3660  752  3388 S     0.3  0.0   0:00   0
rotatelogs
 3181 root      25   0  3660  752  3388 S     0.3  0.0   0:00   0
rotatelogs
 3185 root      25   0  3664  756  3388 S     0.3  0.0   0:00   0
rotatelogs
 3186 root      25   0  3664  752  3388 S     0.3  0.0   0:00   1
rotatelogs
 3191 root      25   0  3664  756  3388 S     0.3  0.0   0:00   0
rotatelogs
 3202 root      25   0  3656  748  3388 S     0.3  0.0   0:00   0
rotatelogs
 3206 root      25   0  3656  748  3388 S     0.3  0.0   0:00   0
rotatelogs
 3207 root      25   0  3656  748  3388 S     0.3  0.0   0:00   1
rotatelogs
 3210 root      25   0  3656  748  3388 S     0.3  0.0   0:00   1
rotatelogs
 3222 root      25   0  3660  752  3388 S     0.3  0.0   0:00   1
rotatelogs
 3224 root      25   0  3660  752  3388 S     0.3  0.0   0:00   1
rotatelogs
 3229 root      25   0   448  136   276 R     0.3  0.0   0:00   0
rotatelogs
  591 root      15   0  1428  540  1368 S     0.1  0.0   0:00   0
syslogd
 1312 ftpd      15   0  2312 1188  1864 S     0.1  0.0   0:00   1
proftpd
 3135 root      25   0  3664  752  3388 S     0.1  0.0   0:00   1
rotatelogs
 3136 root      25   0  3656  748  3388 S     0.1  0.0   0:00   0
rotatelogs
 3137 root      25   0  3656  748  3388 S     0.1  0.0   0:00   1
rotatelogs
 3138 root      25   0  3656  748  3388 S     0.1  0.0   0:00   0
rotatelogs
 3139 root      25   0  3656  748  3388 S     0.1  0.0   0:00   1
rotatelogs
 3140 root      25   0  3656  748  3388 S     0.1  0.0   0:00   0
rotatelogs
 3141 root      25   0  3656  748  3388 S     0.1  0.0   0:00   0
rotatelogs
 3142 root      25   0  3656  748  3388 S     0.1  0.0   0:00   1
rotatelogs
 3143 root      25   0  3656  748  3388 S     0.1  0.0   0:00   0
rotatelogs
 3146 root      25   0  3656  748  3388 S     0.1  0.0   0:00   1
rotatelogs
 3148 root      25   0  3656  748  3388 S     0.1  0.0   0:00   1
rotatelogs
 3150 root      25   0  3660  752  3388 S     0.1  0.0   0:00   1
rotatelogs

Regards,
Anders K. Pedersen
