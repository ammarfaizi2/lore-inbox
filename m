Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279788AbRKROze>; Sun, 18 Nov 2001 09:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279778AbRKROz1>; Sun, 18 Nov 2001 09:55:27 -0500
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:10400 "EHLO
	hawk.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S279768AbRKROzN>; Sun, 18 Nov 2001 09:55:13 -0500
Date: Sun, 18 Nov 2001 09:57:20 -0500
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: VM tests on 2.4.15-pre6 and 2.4.15pre6aa1
Message-ID: <20011118095720.A324@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernels:	2.4.15-pre6 and 2.4.15pre6aa1

Tests:		Fill and write to 80% of vitual memory 10 times.
		mmap, touch, msync, and munmap 500000 pages 5 times.
		Simultaneously listen to long mp3 sampled at 128k with
		mp3blaster.

Summary:	2.4.15-pre6 49% faster on memfill test with higher mp3
		play time.  2.4.15-pre6 11% faster on mmap test.

Config diff:	CONFIG_RWSEM_XCHGADD_ALGORITHM=y in 2.4.15-pre6

Hardware:
Athlon 1333
1024 MB RAM
1024 MB swap

2.4.15-pre6 used a higher percentage of CPU time for both tests.
2.4.15-pre6 played 97% of mp3 and 2.4.15pre6aa1 played 84% during memfill test.
I include one iteration of vmstat 1 from the memfill test because of differences
in b, free, memcache, etc columns.


2.4.15-pre6
-------------
mp3 played 297 seconds of 304 second run.  (97%)

Averages for 10 mtest01 runs
bytes allocated:                    1652241203
User time (seconds):                7.621
System time (seconds):              6.058
Elapsed (wall clock) time:          30.314
Percent of CPU this job got:        44.60
Major (requiring I/O) page faults:  103.8
Minor (reclaiming a frame) faults:  404169.7

vmstat 1 from second iteration of mtest01 -w -p 80:

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 3  0  0 587712   2784   1164   7860   0 70656    56 70656 1278  2094  11  24  65
 2  0  0   4560 863708   1204   8256   0 11136   432 11140  562   942  49  26  25
 2  0  0   4560 695072   1236   8256   0   0     8    40  311   575  75  25   0
 2  0  0   4560 525692   1236   8256   0   0     0     0  277   540  74  26   0
 3  0  0   4560 357032   1236   8384   0   0   128     0  301   564  81  19   0
 2  0  0   4560 187624   1236   8384   0   0     0     0  300   542  81  19   0
 2  0  0   4560  17892   1236   8384   0   0     0     0  309   603  83  17   0
 2  1  1  86896   4932   1172   7812   0 15384    40 15416  554  1779  10  77  13
 9  0  2 139632   2176   1164   7808   0 92680    36 92672 1717  2363   5  15  80
 1  2  1 150768   2564   1188   7820   0 27052    92 27080  612   843  35  16  49
 2  1  0 184176   2240   1172   7812   0 35876    20 35884  718  1136  10  30  60
 1  1  0 218864   2660   1176   7816   0 36720    28 36724  625  1113  15  36  49
 1  2  0 243952   2584   1176   7812   0 35880    20 35880  612  1059  13  22  64
 0  2  0 303600   2604   1176   7816 248 55772   344 55800 1097  1960  13  24  63
 1  1  0 363632   2580   1168   7820   0 51452    48 51460 1049  1929  14  26  60
 0  2  0 400496   2656   1176   7816   0 49192    36 49192  819  1348  11  24  65
 0  2  1 450672   2552   1188   7820   0 49416    44 49444  911  1699  11  26  62
 2  2  0 498416   2592   1172   7820   0 44628    40 44632  901  1658  13  24  64
 1  2  0 535408   2644   1176   7816   0 40996    32 41000  706  1295  14  20  66
 0  2  0 584432   2548   1172   7816   0 49024    40 49028  901  1664  13  26  62
 1  2  0 643568   2608   1172   7816   0 59132   316 59160 1158  1951  14  24  63
 2  0  0  18580 880156   1208   7992 272 220   496   224  537   938  51  26  22

mp3 played 807 seconds of 808 second run.

Average for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                4.184
System time (seconds):              25.596
Elapsed (wall clock seconds) time:  161.70
Percent of CPU this job got:        18.00
Major (requiring I/O) page faults:  500153.2
Minor (reclaiming a frame) faults:  35.6

2.4.15pre6aa1
-------------
mp3 played 370 seconds of 454 second run.  (84%)

Averages for 10 mtest01 runs
bytes allocated:                    1666501836
User time (seconds):                7.602
System time (seconds):              3.114
Elapsed (wall clock) time:          45.371
Percent of CPU this job got:        23.20
Major (requiring I/O) page faults:  145.0
Minor (reclaiming a frame) faults:  407645.8

vmstat 1 from second iteration of mtest01 -w -p 80:

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  4  1 580208  28232   1180   1272  84 23680   192 23684  466   709   8  13  79
 2  1  0   9524 1009964   1248   2204 332 384  1316   428  459   617  11  15  74
 2  0  0   9520 855112   1268   2476  28   0   316     0  303   569  78  19   3
 3  0  0   9520 685728   1268   2476   0   0     0     0  275   543  76  24   0
 2  0  0   9520 516008   1268   2476   0   0     0     0  275   544  81  19   0
 2  0  0   9520 346556   1268   2476   0   0     0     0  275   540  75  25   0
 3  0  0   9520 176932   1284   2476   0   0     0    24  292   547  85  15   0
 1  1  1  12588  27572   1176   1392 236 5084   388  5092  549   818  53  22  25
 1  9  1  27532  27876   1200    488 380 14684   692 14688  563   562   6  17  77
 1  6  1  47108  26108   1176    600 428 19696   896 19700  657   666   6  15  79
 0  5  0  80120  28000   1188    628 688 32992  1132 33028  971   896   7  16  77
 1  4  1  92892  26452   1164    728 576 12800  1144 12804  573   626   6  14  80
 0  5  1 120796  25832   1164    744 496 28032   804 28036  795   714   6  16  77
 1  5  1 146776  26608   1164    792 408 25984   680 26012  764   704   6  12  81
 2  3  1 189528  27004   1180    796 408 42496   688 42500 1097  1292   8   9  83
 1  2  1 210132  26724   1184    800 192 20864   276 20868  446   609  10  12  78
 0  3  1 239188  26760   1168    836  28 28800   224 28828  700  1299  14   6  80
 1  4  1 264012  27108   1172    840  76 24704   216 24712  586  1084  10  10  81
 1  3  0 284224  28652   1176    836  36 20480   252 20484  524   992   7   7  86
 1  2  1 306748  28208   1184    844  24 22656   164 22660  522   993  11   6  82
 3  0  2 326972  26608   1192    880   0 20224   176 20252  492   866  12  10  78
 0  3  1 351036  26608   1180    864   0 23936   132 23956  550   850   9   8  82
 2  2  1 375612  27792   1176    876   0 24704   196 24708  514   776   5  12  83
 2  1  1 400316  27972   1184    892   4 24596   200 24600  571   777  10   4  86
 0  3  2 429116  26612   1188    900   4 28780   148 28800  546   878  10   8  81
 2  2  1 464316  28404   1164    912   8 35072   252 35084  678  1085  10  11  80
 1  3  1 491320  27356   1184    976  68 27136   556 27140  611   864   9   8  83
 0  4  0 515384  28860   1184    952  40 24064   180 24068  550   812   8   6  85
 0  4  0 550020  28860   1176    956 144 34816   268 34844  670  1164  12   6  82
 2  2  0 578676  27648   1172    984  24 28544   196 28548  568   985  10  12  79
 1  3  1 603868  27948   1180    976  24 25216   168 25220  534   835   8  13  79
 0  4  1 631624  26608   1172   1004  20 27648   188 27652  504   825  12   8  80
 2  3  1 662184  26904   1172    996  56 30592   224 30624  658  1076   9   7  84
 0  4  0   9712 1011020   1236   1460 308 7680   876  7684  516   775   6  11  83

mp3 played 901 seconds of 902 second run. 

Average for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                3.560
System time (seconds):              23.622
Elapsed (wall clock seconds) time:  180.49
Percent of CPU this job got:        14.60
Major (requiring I/O) page faults:  500191.6
Minor (reclaiming a frame) faults:  30.4

Hope this information is useful!

-- 
Randy Hron

