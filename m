Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319242AbSIKRZR>; Wed, 11 Sep 2002 13:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319244AbSIKRZR>; Wed, 11 Sep 2002 13:25:17 -0400
Received: from [213.4.129.129] ([213.4.129.129]:13456 "EHLO tsmtp6.mail.isp")
	by vger.kernel.org with ESMTP id <S319242AbSIKRZO>;
	Wed, 11 Sep 2002 13:25:14 -0400
Date: Wed, 11 Sep 2002 19:30:23 +0200
From: Arador <diegocg@teleline.es>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: green@namesys.com, reiser@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [BK] ReiserFS changesets for 2.4 (performs writes more than 4k at a time)
Message-Id: <20020911193024.24fb7514.diegocg@teleline.es>
In-Reply-To: <Pine.LNX.4.44.0209101504590.16518-100000@freak.distro.conectiva>
References: <20020910190950.A1064@namesys.com>
	<Pine.LNX.4.44.0209101504590.16518-100000@freak.distro.conectiva>
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2002 15:16:51 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> escribió:

> 
> Huh, now that I released -pre6 _with_ this stuff by accident its too late.
> Silly me.
> 
> Can you make me a tree which backouts the big write code please?
> 
> Will be releasing a -pre7 shortly due to that.

Although some changes are going to be removed in -pre7, i've run tiobench to test the changes.
Kernel versions are plain -pre4 and -pre6

Unit information
================
File size = megabytes
Blk Size  = bytes
Rate      = megabytes per second
CPU%      = percentage of CPU used during the test
Latency   = milliseconds
Lat%      = percent of requests that took longer than X seconds
CPU Eff   = Rate divided by CPU% - throughput per cpu load

Sequential Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre4                   200   4096    1   11.78 28.50%     0.328      146.54   0.00000  0.00000    41
2.4.20-pre4                   200   4096    2   10.30 23.02%     0.709     1349.77   0.00000  0.00000    45
2.4.20-pre4                   200   4096    4    9.14 22.06%     1.585     1309.01   0.00000  0.00000    41
2.4.20-pre4                   200   4096    8    8.92 21.84%     2.751     1472.06   0.00000  0.00000    41

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre4                   200   4096    1    0.53 2.389%     7.307       20.08   0.00000  0.00000    22
2.4.20-pre4                   200   4096    2    0.55 2.201%    14.157       39.98   0.00000  0.00000    25
2.4.20-pre4                   200   4096    4    0.55 2.766%    27.646       80.48   0.00000  0.00000    20
2.4.20-pre4                   200   4096    8    0.60 2.527%    49.805      159.53   0.00000  0.00000    24

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre4                   200   4096    1   10.76 80.14%     0.348     1100.04   0.00000  0.00000    13
2.4.20-pre4                   200   4096    2   11.63 87.26%     0.637      294.75   0.00000  0.00000    13
2.4.20-pre4                   200   4096    4   11.42 85.24%     1.258      424.02   0.00000  0.00000    13
2.4.20-pre4                   200   4096    8   11.49 84.29%     2.514      745.41   0.00000  0.00000    14

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre4                   200   4096    1    1.13 3.620%     0.131        1.94   0.00000  0.00000    31
2.4.20-pre4                   200   4096    2    1.18 3.770%     0.254       22.61   0.00000  0.00000    31
2.4.20-pre4                   200   4096    4    1.14 4.002%     0.483       42.89   0.00000  0.00000    28
2.4.20-pre4                   200   4096    8    1.19 4.048%     0.930       83.60   0.00000  0.00000    29
root@diego:/home/diego/kernel/tiobench/tiobench-0.3.3#

Unit information
================
File size = megabytes
Blk Size  = bytes
Rate      = megabytes per second
CPU%      = percentage of CPU used during the test
Latency   = milliseconds
Lat%      = percent of requests that took longer than X seconds
CPU Eff   = Rate divided by CPU% - throughput per cpu load

Sequential Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre6                   200   4096    1   12.16 29.78%     0.317      135.42   0.00000  0.00000    41
2.4.20-pre6                   200   4096    2   10.20 23.96%     0.697     1226.99   0.00000  0.00000    43
2.4.20-pre6                   200   4096    4    9.49 23.14%     1.409     1197.27   0.00000  0.00000    41
2.4.20-pre6                   200   4096    8    8.36 21.69%     2.970     5532.30   0.00391  0.00000    39

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre6                   200   4096    1    0.55 2.037%     7.106       30.01   0.00000  0.00000    27
2.4.20-pre6                   200   4096    2    0.54 2.118%    14.170       40.09   0.00000  0.00000    26
2.4.20-pre6                   200   4096    4    0.56 2.308%    27.007       79.38   0.00000  0.00000    24
2.4.20-pre6                   200   4096    8    0.58 2.593%    51.235      321.18   0.00000  0.00000    22

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre6                   200   4096    1   12.01 87.73%     0.311      280.04   0.00000  0.00000    14
2.4.20-pre6                   200   4096    2   11.36 83.79%     0.645      509.40   0.00000  0.00000    14
2.4.20-pre6                   200   4096    4   11.58 85.63%     1.261      528.34   0.00000  0.00000    14
2.4.20-pre6                   200   4096    8    9.67 69.58%     2.986     2158.01   0.00195  0.00000    14

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.4.20-pre6                   200   4096    1    1.19 4.191%     0.130        0.76   0.00000  0.00000    28
2.4.20-pre6                   200   4096    2    1.16 4.067%     0.255       23.82   0.00000  0.00000    28
2.4.20-pre6                   200   4096    4    1.23 4.159%     0.495       42.33   0.00000  0.00000    29
2.4.20-pre6                   200   4096    8    1.21 4.432%     1.270      228.09   0.00000  0.00000    27
root@diego:/home/diego/kernel/tiobench/tiobench-0.3.3#



Diego Calleja

