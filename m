Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276060AbRJPMOk>; Tue, 16 Oct 2001 08:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276069AbRJPMOV>; Tue, 16 Oct 2001 08:14:21 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:13229 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S276060AbRJPMOK>; Tue, 16 Oct 2001 08:14:10 -0400
From: rwhron@earthlink.net
Date: Tue, 16 Oct 2001 08:16:39 -0400
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: VM test on 2.4.13-pre3aa1 (compared to 2.4.12-aa1 and 2.4.13-pre2aa1)
Message-ID: <20011016081639.A209@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Summary:

Wall clock time for this test has dropped dramatically (which
is good) over the last 3 Andrea Arcangeli patched kernels.
mp3blaster sounds less pleasant though.


Test:

Run loop of 10 iterations of Linux Test Project's "mtest01 -p80 -w"
This test attempts to allocate 80% of virtual memory and write to
each page.  Simultaneously listen to mp3blaster.


Reboot before each test.

Hardware:
Athlon 1333
512 Mb RAM
1024 Mb swap


I've shown the last 2 results in a previous message.  But the
side by side comparison is pretty exciting.

2.4.13pre3aa1

Averages for 10 mtest01 runs
bytes allocated:                    1240045977
User time (seconds):                2.106
System time (seconds):              2.738
Elapsed (wall clock) time:          39.408
Percent of CPU this job got:        11.70
Major (requiring I/O) page faults:  110.0
Minor (reclaiming a frame) faults:  303527.4

2.4.13pre2aa1

Averages for 10 mtest01 runs
bytes allocated:                    1245184000
User time (seconds):                2.050
System time (seconds):              2.874
Elapsed (wall clock) time:          49.513
Percent of CPU this job got:        9.70
Major (requiring I/O) page faults:  115.6
Minor (reclaiming a frame) faults:  304781.9

2.4.12aa1

Averages for 10 mtest01 runs
bytes allocated:                    1253362892
User time (seconds):                2.099
System time (seconds):              2.823
Elapsed (wall clock) time:          64.109
Percent of CPU this job got:        7.50
Major (requiring I/O) page faults:  135.2
Minor (reclaiming a frame) faults:  306779.8


The rest of the results below are just from 2.4.13pre3aa1.

mtest01 passes each time with the expect 1.2 gigabytes of
memory allocated:

PASS ... 1215299584 bytes allocated.
PASS ... 1242562560 bytes allocated.
PASS ... 1240465408 bytes allocated.
PASS ... 1241513984 bytes allocated.
PASS ... 1244659712 bytes allocated.
PASS ... 1241513984 bytes allocated.
PASS ... 1245708288 bytes allocated.
PASS ... 1242562560 bytes allocated.
PASS ... 1243611136 bytes allocated.
PASS ... 1242562560 bytes allocated.

mp3blaster is much less pleasant as the wall clock time for VM improves.  
With 2.4.13pre3aa1, mp3blaster stutters through almost the entire run.  
The last 3-4 seconds of each iteration sound good though.  (highest vmstat 
swpd value and the next 2 low values).  This "sounds good" may actually be
the first 3-4 seconds of the test. 


vmstat 1 output for 1 iteration:

vmstat output starts towards the end of one iteration, goes through a complete cycle,
then the beginning of another.

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  6  1 685252   1548   1188   1136  72 23192   380 23192  419   310   3   8  89
 0  6  1 707740   1648   1196   1140  44 20532   412 20552  368   335   5   9  86
 0  4  0 725628   3624   1176   1152  32 20264   512 20264  343   300   2  10  88

 mp3blaster sounds good

 1  4  0 738192   3312   1216   1908 516 11276  1528 11276  467   435   3   4  93
 2  0  0  15928 387480   1264   3148 352   0  1632     0  477   686  19  24  56
 2  0  0  15756 122780   1280   3172   0   0    24    24  285   563  35  65   0

 mp3blaster stutters until the end of test iteration.

 3  3  0  47424   3788   1172   1412 860 40228   892 40236  789   819  12  23  66
 0  5  1  90244   1656   1184   1416 1032 39568  1076 39572  653   425   6   5  89
 1  3  0 129592   3744   1176   1416 236 40960   276 40988  588   432   5   8  87
 0  2  1 159260   3584   1172   1540 132 27676   300 27680  396   270   7   9  84
 0  5  1 187764   2572   1184   1416 312 29632   368 29636  534   448   5   7  88
 0  5  1 218844   1648   1176   1416 220 31268   256 31272  560   486   5   7  89
 0  2  1 242820   2548   1172   1416 124 24576   168 24600  419   376   3   8  89
 1  1  1 280660   3052   1176   1416  60 36352   116 36356  554   439   3  10  87
 0  3  1 325164   2036   1176   1416  40 44832    76 44836  586   467   4  10  86
 0  3  1 350204   1660   1172   1420  44 25824    88 25852  432   319   3  12  85
 1  2  1 396728   3564   1184   1416  72 45780   120 45784  637   528   3  12  86
 0  3  1 423816   3572   1180   1416  48 27020    80 27024  420   361   2  14  84
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  3  2 467284   1644   1200   1420  52 42816   100 42832  627   482   5  10  85
 0  3  1 490292   2040   1180   1420  32 23648    40 23656  344   242   6  12  82
 0  3  1 512764   1660   1172    956 292 23604   340 23604  426   273   5  14  81
 0  3  1 539844   2108   1184    968  56 26728   316 26728  463   338   3  11  86
 0  3  1 563852   2036   1184    976  56 23500   512 23500  440   357   3  11  86
 1  2  1 579656   1908   1172   1004 332 17356  1324 17380  411   352   3   8  89
 1  3  1 605720   1652   1184   1024  48 24656   516 24656  456   375   0  11  89
 0  6  1 627676   3176   1200   1028  64 21432   316 21436  386   283   3   9  88
 1  3  0 642980   3804   1180   1048  56 16376   888 16376  356   280   4   7  89
 2  3  1 661348   1776   1180   1064 312 18816   724 18860  390   340   2   9  89
 0  4  1 686888   2148   1184   1256  68 23992   848 23992  443   359   3   9  88
 1  4  1 705276   1896   1188   1116  44 19880   836 19880  431   331   2   6  92

 mp3blaster sounds good

 0  5  1 724676   1652   1192   1124 240 18388  1084 18388  371   336   2  13  85
 1  4  1  16348 491352   1220   1796 512 12108  1332 12132  393   403   2  11  87
 2  2  0  15872 489360   1264   3004 732   0  1984     0  472   691   2   3  95
 3  0  0  15692 266700   1284   3168 116   0   296     0  344   639  41  46  14

 mp3blaster begins to stutter again

 2  0  0  14604   4480   1284   3196 316   0   344     0  300   587  46  54   0
 0  4  0  32952   3572   1176   1464 372 21932   392 21944  393   313   9  12  79


vmstat 1 output from 2.4.12aa1 and 2.4.13pre2aa1 is in previous messages.  Subject
is something like VM Test on {kernel versions}.  Two separate tiny email threads.

-- 
Randy Hron

