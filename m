Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277592AbRJREum>; Thu, 18 Oct 2001 00:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277598AbRJREud>; Thu, 18 Oct 2001 00:50:33 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:38853 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S277592AbRJREuW>; Thu, 18 Oct 2001 00:50:22 -0400
From: rwhron@earthlink.net
Date: Thu, 18 Oct 2001 00:52:55 -0400
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: mmap test on 2.4.12-ac3+vmpatch and 2.4.13-pre3aa1
Message-ID: <20011018005255.A196@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LTP mmap001 test:  mmap, touch, msync munmap 50000 pages
Listen to mp3blaster.  Light IRC and shell use.

Hardware:
AMD Athlon 1333
512 MB ram
1024 MB swap

Notes: 

Interactive response was noticeably better with 2.4.12-ac3+vmpatch.  
2.4.12-ac3+vmpatch was tested right after a reboot.  


2.4.12-ac3+vmpatch (page-cluster=4)
Averages for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                19.322
System time (seconds):              16.576
Elapsed (wall clock seconds) time:  152.87
Percent of CPU this job got:        22.80
Major (requiring I/O) page faults:  500175.2
Minor (reclaiming a frame) faults:  20.0

This is the tail end of vmstat 1 on 2.4.12-ac3+vmpatch:

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 4  0  1   9280   3064   2012 481536   0   0   168 16188  438   448   0  26  74
 4  0  1   9280   3064   2020 481520   0   0   136 16372  512   447   1  21  78
 0  2  1   9280   3064   2036 481480   0   0   284 12148  461   465   0  20  80
 5  2  1   9280 480788   2524   5124   0   0   632 11396  451   421   0  42  58
 2  0  0   9280 479316   2592   6440  60   0  1872   140  671   935   0   9  91



2.4.13-pre3aa1 was tested after running 6 runalltest.sh LTP suites, 
as well as normal use.  uptime 40 hours.

2.4.13-pre3aa1 page-cluster=2

Averages for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                19.590
System time (seconds):              14.846
Elapsed (wall clock seconds) time:  213.90
Percent of CPU this job got:        15.60
Major (requiring I/O) page faults:  500171.2
Minor (reclaiming a frame) faults:  29.8

2.4.13-pre3aa1 page-cluster=4

Averages for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                19.220
System time (seconds):              15.378
Elapsed (wall clock seconds) time:  209.41
Percent of CPU this job got:        16.00
Major (requiring I/O) page faults:  500155.6
Minor (reclaiming a frame) faults:  31.2


2.4.13-pre3aa1 page-cluster=6

Averages for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                20.368
System time (seconds):              16.218
Elapsed (wall clock seconds) time:  206.08
Percent of CPU this job got:        17.20
Major (requiring I/O) page faults:  500166.6
Minor (reclaiming a frame) faults:  28.8

Just to make sure the previous tests didn't skew the results, 
I rebooted into 2.4.13-pre3aa1 and ran with the default 
page-cluster value:

2.4.13-pre3aa1 page-cluster=6 (after reboot)
Averages for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                20.364
System time (seconds):              15.798
Elapsed (wall clock seconds) time:  204.09
Percent of CPU this job got:        17.40
Major (requiring I/O) page faults:  500165.6
Minor (reclaiming a frame) faults:  30.0

tail end of vmstat from final iteration on 2.4.13-pre3aa1:

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  1  1   8644   3372   1808 484988 248   0   324 32980  873   671   0  22  77
 2  3  1   8616   3316   1824 485000  32   0    60 16192  467   405   1  27  72
 1  4  1   8600   3100   1848 485012  88   0   124 12148  422   427   1  22  77
 1  1  0   8532 488648   1508   1680  76   0   600  7108  439   561   4  28  68
 1  1  0   8340 485796   3384   2548 240   0  2984     0  858  1484   0  41  59


This test does use a little swap with both kernels.  That puzzled me,
since I thought 50000 pages was about 195 megs of RAM.

page-cluster=6 makes mp3blaster skip more on this test.


The "free -mt" output below is after the test on 2.4.13pre3aa1 to give an idea of
what memory usage is like when there is no test running.


             total       used       free     shared    buffers     cached
Mem:           502         32        470          0          4          6
-/+ buffers/cache:         21        480
Swap:         1027          7       1019
Total:        1530         39       1490

Actually, kernel hackers can probably tell that from the vmstat snippets. :)

-- 
Randy Hron

