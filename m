Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265383AbUF2DtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265383AbUF2DtW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 23:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265387AbUF2DtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 23:49:22 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:51925 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S265383AbUF2Dsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 23:48:35 -0400
Message-ID: <40E0E690.2040100@candelatech.com>
Date: Mon, 28 Jun 2004 20:48:32 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.7 tiobench results for 3ware 9500 system
Content-Type: multipart/mixed;
 boundary="------------040309070501010205090400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040309070501010205090400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I am trying to build a box that can handle streaming 2Gbps to disk for
sustained periods of time.  I benchmarked a few different file systems
and wanted to share the results.

Software:
2.6.7 + my networking patches (my modules were not loaded, should not matter)
Fedora Core 2 fully up-to-date.
Latest 3w-9xxxx driver from their web site.

Hardware:
dual 2.8 Xeon, 1GB RAM, 40GB IDE OS hard drive
2 3ware 9500 controllers with 6 WD 7200 RPM 250GB SATA disks each
(Only one of the controllers was used for these tests, though initial
  testing shows that when both are used, each runs as fast as when only
  a single controller is used)
The 9500 controllers are set up for raid-0 with 64k stripes.
Motherboard:  Tyan S2726 (Thunder i7501 Xtreme)

General test procedure:
mkfs.XXX /dev/sda1  (Default arguments only)
mount [sda1]
run tiobench
umount [sda1]

NOTE:  I hear there is a patch to fix the crummy ext3 performance when using
multiple threads:  I have not applied this patch.  jfs and xfs both seem superior
performers, so I probably will not use ext3.

I am new to this type of thing, so suggestions are welcome.  I can also run
other tests if someone has suggestions or results they would like to see.

Enjoy,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


--------------040309070501010205090400
Content-Type: text/plain;
 name="ext2_tiobench.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ext2_tiobench.txt"


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
2.6.7                         1000  12800   1   55.80 6.437%     2.184       29.24   0.00000  0.00000   867
2.6.7                         1000  12800   2   65.61 10.67%     3.662      218.81   0.00000  0.00000   615
2.6.7                         1000  12800   4   48.30 7.471%     8.134      286.69   0.00000  0.00000   647
2.6.7                         1000  12800   8   51.03 6.597%    14.025      572.58   0.00000  0.00000   774

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.7                         1000  12800   1   62.96 5.014%     1.935       25.86   0.00000  0.00000  1255
2.6.7                         1000  12800   2   60.83 7.099%     3.993       95.92   0.00000  0.00000   857
2.6.7                         1000  12800   4   70.60 7.936%     5.576      233.25   0.00000  0.00000   890
2.6.7                         1000  12800   8   66.05 7.182%    10.621      488.71   0.00000  0.00000   920

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.7                         1000  12800   1  185.59 45.27%     0.548     1490.13   0.00000  0.00000   410
2.6.7                         1000  12800   2  108.42 39.23%     1.438      268.93   0.00000  0.00000   276
2.6.7                         1000  12800   4   74.47 42.78%     3.973      987.19   0.00000  0.00000   174
2.6.7                         1000  12800   8   88.51 43.78%     6.093     1708.28   0.00000  0.00000   202

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.7                         1000  12800   1  132.81 24.61%     0.202        0.59   0.00000  0.00000   540
2.6.7                         1000  12800   2   95.08 26.32%     0.347      109.14   0.00000  0.00000   361
2.6.7                         1000  12800   4   76.59 37.64%     0.642       35.48   0.00000  0.00000   203
2.6.7                         1000  12800   8   90.18 46.29%     1.218      224.59   0.00000  0.00000   195

--------------040309070501010205090400
Content-Type: text/plain;
 name="ext3_tiobench.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ext3_tiobench.txt"


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
2.6.7                         1000  12800   1   52.18 6.615%     2.335       33.21   0.00000  0.00000   789
2.6.7                         1000  12800   2   54.98 9.906%     4.385      253.42   0.00000  0.00000   555
2.6.7                         1000  12800   4   54.32 9.574%     6.196      315.84   0.00000  0.00000   567
2.6.7                         1000  12800   8   33.83 5.932%    23.921     1229.75   0.00000  0.00000   570

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.7                         1000  12800   1   67.52 5.793%     1.804       27.06   0.00000  0.00000  1166
2.6.7                         1000  12800   2   62.62 8.116%     3.865      164.90   0.00000  0.00000   771
2.6.7                         1000  12800   4   64.20 7.519%     5.261      297.04   0.00000  0.00000   854
2.6.7                         1000  12800   8   45.60 7.059%    18.862      455.58   0.00000  0.00000   646

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.7                         1000  12800   1  163.32 82.79%     0.677       85.31   0.00000  0.00000   197
2.6.7                         1000  12800   2   29.43 19.55%     7.155     3915.82   0.01221  0.00000   151
2.6.7                         1000  12800   4   26.18 25.22%    14.522     3480.24   0.12207  0.00000   104
2.6.7                         1000  12800   8   23.36 24.54%    24.205     8794.75   0.70801  0.00000    95

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.7                         1000  12800   1   93.00 24.92%     1.197      304.51   0.00000  0.00000   373
2.6.7                         1000  12800   2   23.90 10.97%     0.400        1.41   0.00000  0.00000   218
2.6.7                         1000  12800   4   25.93 16.61%     0.723       18.13   0.00000  0.00000   156
2.6.7                         1000  12800   8   25.01 16.12%     1.360      217.93   0.00000  0.00000   155

--------------040309070501010205090400
Content-Type: text/plain;
 name="jfs_tiobench.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="jfs_tiobench.txt"


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
2.6.7                         1000  12800   1   52.92 5.613%     2.303       49.65   0.00000  0.00000   943
2.6.7                         1000  12800   2   50.18 6.110%     4.810      178.50   0.00000  0.00000   821
2.6.7                         1000  12800   4   46.57 6.113%    10.100      339.25   0.00000  0.00000   762
2.6.7                         1000  12800   8   45.70 5.688%    19.652      495.83   0.00000  0.00000   803

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.7                         1000  12800   1   63.84 5.046%     1.908       16.34   0.00000  0.00000  1265
2.6.7                         1000  12800   2   71.73 5.449%     3.204      270.14   0.00000  0.00000  1316
2.6.7                         1000  12800   4   65.13 5.934%     6.633      485.36   0.00000  0.00000  1097
2.6.7                         1000  12800   8   67.26 6.046%    10.600      913.86   0.00000  0.00000  1112

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.7                         1000  12800   1  188.13 56.24%     0.580       80.33   0.00000  0.00000   334
2.6.7                         1000  12800   2  185.41 76.45%     0.770       96.99   0.00000  0.00000   243
2.6.7                         1000  12800   4  162.56 84.58%     1.845      461.35   0.00000  0.00000   192
2.6.7                         1000  12800   8  154.31 90.03%     3.547      566.80   0.00000  0.00000   171

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.7                         1000  12800   1  138.54 25.55%     0.196        0.94   0.00000  0.00000   542
2.6.7                         1000  12800   2  126.92 38.46%     0.343        1.02   0.00000  0.00000   330
2.6.7                         1000  12800   4  119.43 61.67%     0.665       16.34   0.00000  0.00000   194
2.6.7                         1000  12800   8  106.90 55.92%     1.166      133.45   0.00000  0.00000   191

--------------040309070501010205090400
Content-Type: text/plain;
 name="jfs_tiobench2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="jfs_tiobench2.txt"


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
2.6.7                        50000  12800   1   49.94 6.484%     2.440      224.41   0.00000  0.00000   770
2.6.7                        50000  12800   2   48.69 6.879%     4.870      374.09   0.00000  0.00000   708
2.6.7                        50000  12800   4   35.76 5.033%    13.463      619.19   0.00000  0.00000   710
2.6.7                        50000  12800   8   27.99 4.002%    34.389     1165.18   0.00000  0.00000   699

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.7                        50000  12800   1   10.44 1.499%    11.683      167.02   0.00000  0.00000   697
2.6.7                        50000  12800   2   12.88 2.525%    18.629       93.16   0.00000  0.00000   510
2.6.7                        50000  12800   4    9.91 1.824%    48.877      217.28   0.00000  0.00000   543
2.6.7                        50000  12800   8    9.86 1.849%    97.120      489.08   0.00000  0.00000   533

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.7                        50000  12800   1  195.19 63.53%     0.621      124.73   0.00000  0.00000   307
2.6.7                        50000  12800   2  171.01 69.02%     1.412      321.78   0.00000  0.00000   248
2.6.7                        50000  12800   4  152.31 76.25%     3.161      572.92   0.00000  0.00000   200
2.6.7                        50000  12800   8  140.87 64.19%     6.767     1445.81   0.00000  0.00000   219

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.7                        50000  12800   1    9.49 1.798%    12.663      131.37   0.00000  0.00000   528
2.6.7                        50000  12800   2   10.61 2.065%    22.450      330.68   0.00000  0.00000   514
2.6.7                        50000  12800   4    9.03 1.783%    52.313      374.92   0.00000  0.00000   507
2.6.7                        50000  12800   8    8.84 1.730%   107.208      762.58   0.00000  0.00000   511

--------------040309070501010205090400
Content-Type: text/plain;
 name="xfs_tiobench2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xfs_tiobench2.txt"


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
2.6.7                        50000  12800   1   68.98 10.06%     1.765      135.34   0.00000  0.00000   685
2.6.7                        50000  12800   2   54.86 8.269%     4.392      370.28   0.00000  0.00000   663
2.6.7                        50000  12800   4   41.92 6.385%    11.543      513.13   0.00000  0.00000   657
2.6.7                        50000  12800   8   31.49 4.864%    29.887     1027.90   0.00000  0.00000   647

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.7                        50000  12800   1   10.27 1.497%    11.880       24.15   0.00000  0.00000   686
2.6.7                        50000  12800   2    9.93 1.799%    24.474       93.62   0.00000  0.00000   552
2.6.7                        50000  12800   4   10.44 2.048%    44.807      347.46   0.00000  0.00000   510
2.6.7                        50000  12800   8   12.61 2.758%    71.834      567.41   0.00000  0.00000   457

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.7                        50000  12800   1  192.34 48.40%     0.631     2190.11   0.00220  0.00000   397
2.6.7                        50000  12800   2  157.50 51.25%     1.510     4317.90   0.01904  0.00000   307
2.6.7                        50000  12800   4  127.80 45.09%     3.659    11449.32   0.04126  0.00049   283
2.6.7                        50000  12800   8  101.95 44.72%     9.067    18419.01   0.09570  0.00562   228

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.7                        50000  12800   1    9.42 2.141%    12.680      124.91   0.00000  0.00000   440
2.6.7                        50000  12800   2    9.15 2.015%    25.630     1033.29   0.00000  0.00000   454
2.6.7                        50000  12800   4    9.09 2.028%    50.828     1086.77   0.00000  0.00000   448
2.6.7                        50000  12800   8   10.04 2.460%    82.948     1219.03   0.00000  0.00000   408

--------------040309070501010205090400--
