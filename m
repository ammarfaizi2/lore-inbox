Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316897AbSILS1U>; Thu, 12 Sep 2002 14:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316898AbSILS1T>; Thu, 12 Sep 2002 14:27:19 -0400
Received: from [213.4.129.129] ([213.4.129.129]:30038 "EHLO tsmtp7.mail.isp")
	by vger.kernel.org with ESMTP id <S316897AbSILS1N>;
	Thu, 12 Sep 2002 14:27:13 -0400
Date: Thu, 12 Sep 2002 20:32:30 +0200
From: Arador <diegocg@teleline.es>
To: Oleg Drokin <green@namesys.com>
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [BK] ReiserFS changesets for 2.4 (performs writes more than 4k at a time)
Message-Id: <20020912203231.70621a75.diegocg@teleline.es>
In-Reply-To: <20020912111029.A4997@namesys.com>
References: <20020910190950.A1064@namesys.com>
	<Pine.LNX.4.44.0209101504590.16518-100000@freak.distro.conectiva>
	<20020911193024.24fb7514.diegocg@teleline.es>
	<20020912111029.A4997@namesys.com>
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2002 11:10:29 +0400
Oleg Drokin <green@namesys.com> escribió:

> 
> What kind of hardware were these tests on?

The sis ide chipset can do multiword dma 2, (16 mb/s i think)
A seagate barracuda 40 GB 7200 rpm UDMA 100
32 mb ram and a cyrix 6x86 MX 233+ (200 mhz)

> 
> Can you please conduct one more test with line 212 in fs/reiserfs/file.c
> changed:
> hint.preallocate = 0;
> change 0 there to 1

Sure ;)

I've run two tests per kernel version, (-pre5 and -pre6 + that tweak)
I can do more tests if you want ;)

Unit information
================
File size = megabytes
Blk Size  = bytes
Rate      = megabytes per second
CPU%      = percentage of CPU used during the test
Latency   = milliseconds
Lat%      = percent of requests that took longer than X seconds
CPU Eff   = Rate divided by CPU% - throughput per cpu load

The two 2.4.20-pre5 benchs

================================================= 2.4.20-pre5 =====================================================

Sequential Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre5                   200   4096    1   12.12 26.54%     0.319      187.11   0.00000  0.00000    46
2.4.20-pre5                   200   4096    2   10.46 27.03%     0.735     1425.90   0.00000  0.00000    39
2.4.20-pre5                   200   4096    4    9.77 21.92%     1.361     1201.57   0.00000  0.00000    45
2.4.20-pre5                   200   4096    8    8.84 20.69%     2.750     2648.61   0.00195  0.00000    43

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre5                   200   4096    1    0.54 2.590%     7.219       20.03   0.00000  0.00000    21
2.4.20-pre5                   200   4096    2    0.56 2.395%    13.948       39.78   0.00000  0.00000    23
2.4.20-pre5                   200   4096    4    0.54 2.494%    27.794      100.76   0.00000  0.00000    22
2.4.20-pre5                   200   4096    8    0.60 2.809%    50.116      160.74   0.00000  0.00000    21

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre5                   200   4096    1   11.86 87.89%     0.314      265.36   0.00000  0.00000    13
2.4.20-pre5                   200   4096    2   11.91 88.60%     0.616      504.35   0.00000  0.00000    13
2.4.20-pre5                   200   4096    4   12.06 89.30%     1.224      280.16   0.00000  0.00000    14
2.4.20-pre5                   200   4096    8   11.84 88.50%     2.466      432.46   0.00000  0.00000    13

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre5                   200   4096    1    1.14 4.236%     0.244      429.52   0.00000  0.00000    27
2.4.20-pre5                   200   4096    2    1.13 4.060%     0.255       24.09   0.00000  0.00000    28
2.4.20-pre5                   200   4096    4    1.15 3.668%     0.476       49.99   0.00000  0.00000    31
2.4.20-pre5                   200   4096    8    1.16 4.098%     0.935       81.35   0.00000  0.00000    28


----------> The second becnh for -pre5....

Sequential Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre5                   200   4096    1   12.22 29.07%     0.316       28.21   0.00000  0.00000    42
2.4.20-pre5                   200   4096    2   10.86 25.96%     0.700     1049.20   0.00000  0.00000    42
2.4.20-pre5                   200   4096    4   10.00 24.79%     1.463     1144.01   0.00000  0.00000    40
2.4.20-pre5                   200   4096    8    8.70 20.44%     2.992     2106.78   0.00195  0.00000    43

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre5                   200   4096    1    0.55 3.295%     7.026       20.05   0.00000  0.00000    17
2.4.20-pre5                   200   4096    2    0.55 2.327%    13.977       40.04   0.00000  0.00000    24
2.4.20-pre5                   200   4096    4    0.54 3.095%    28.571       90.03   0.00000  0.00000    17
2.4.20-pre5                   200   4096    8    0.61 2.610%    48.261      150.45   0.00000  0.00000    23

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre5                   200   4096    1   11.96 85.87%     0.313      340.07   0.00000  0.00000    14
2.4.20-pre5                   200   4096    2   12.13 86.45%     0.612      279.22   0.00000  0.00000    14
2.4.20-pre5                   200   4096    4   11.61 85.42%     1.229      356.53   0.00000  0.00000    14
2.4.20-pre5                   200   4096    8   11.97 87.52%     2.421      616.12   0.00000  0.00000    14

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre5                   200   4096    1    1.18 3.463%     0.128        0.87   0.00000  0.00000    34
2.4.20-pre5                   200   4096    2    1.15 3.755%     0.244       22.89   0.00000  0.00000    31
2.4.20-pre5                   200   4096    4    1.15 3.976%     0.456       44.42   0.00000  0.00000    29
2.4.20-pre5                   200   4096    8    1.16 3.771%     0.879      102.81   0.00000  0.00000    31




========================================= 2.4.20-pre6 + tweak ==================================================


------>First for -pre6 ...

Sequential Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre6                   200   4096    1   12.21 27.22%     0.315       20.37   0.00000  0.00000    45
2.4.20-pre6                   200   4096    2   10.13 26.12%     0.682     1241.05   0.00000  0.00000    39
2.4.20-pre6                   200   4096    4    9.42 21.67%     1.382     1048.15   0.00000  0.00000    43
2.4.20-pre6                   200   4096    8    8.90 20.78%     2.882     2709.68   0.00195  0.00000    43

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre6                   200   4096    1    0.53 2.076%     7.328       20.65   0.00000  0.00000    26
2.4.20-pre6                   200   4096    2    0.54 1.915%    14.206       40.18   0.00000  0.00000    28
2.4.20-pre6                   200   4096    4    0.56 2.215%    27.334       90.00   0.00000  0.00000    25
2.4.20-pre6                   200   4096    8    0.60 2.931%    49.111      259.38   0.00000  0.00000    21

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre6                   200   4096    1   11.76 85.21%     0.314      433.33   0.00000  0.00000    14
2.4.20-pre6                   200   4096    2   11.56 84.14%     0.627      408.37   0.00000  0.00000    14
2.4.20-pre6                   200   4096    4   11.48 84.32%     1.236      393.79   0.00000  0.00000    14
2.4.20-pre6                   200   4096    8    8.91 62.13%     3.179     2189.47   0.00195  0.00000    14

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre6                   200   4096    1    1.16 3.851%     0.131        5.96   0.00000  0.00000    30
2.4.20-pre6                   200   4096    2    1.13 4.196%     0.251       24.96   0.00000  0.00000    27
2.4.20-pre6                   200   4096    4    1.11 3.540%     0.464       52.49   0.00000  0.00000    31
2.4.20-pre6                   200   4096    8    1.14 4.026%     0.936       94.44   0.00000  0.00000    28

------> and second......

Sequential Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre6                   200   4096    1   11.87 27.17%     0.325      169.14   0.00000  0.00000    44
2.4.20-pre6                   200   4096    2   10.14 24.79%     0.742      900.01   0.00000  0.00000    41
2.4.20-pre6                   200   4096    4    9.23 22.37%     1.512     1294.06   0.00000  0.00000    41
2.4.20-pre6                   200   4096    8    8.79 21.30%     2.723     3030.53   0.00195  0.00000    41

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre6                   200   4096    1    0.54 2.525%     7.206       20.13   0.00000  0.00000    21
2.4.20-pre6                   200   4096    2    0.53 2.166%    14.600       39.85   0.00000  0.00000    24
2.4.20-pre6                   200   4096    4    0.56 2.135%    27.360       79.95   0.00000  0.00000    26
2.4.20-pre6                   200   4096    8    0.60 2.672%    50.614      231.03   0.00000  0.00000    22

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre6                   200   4096    1   10.87 75.62%     0.340      981.54   0.00000  0.00000    14
2.4.20-pre6                   200   4096    2   10.87 75.41%     0.675     1233.92   0.00000  0.00000    14
2.4.20-pre6                   200   4096    4   10.40 73.56%     1.335     1160.16   0.00000  0.00000    14
2.4.20-pre6                   200   4096    8    8.73 63.34%     3.192     1543.25   0.00000  0.00000    14

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre6                   200   4096    1    1.13 3.962%     0.130        0.67   0.00000  0.00000    28
2.4.20-pre6                   200   4096    2    1.14 3.660%     0.249       29.81   0.00000  0.00000    31
2.4.20-pre6                   200   4096    4    1.15 4.184%     0.469       43.59   0.00000  0.00000    27
2.4.20-pre6                   200   4096    8    1.13 3.973%     0.887       84.27   0.00000  0.00000    28



Diego Calleja
