Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265008AbTBOURM>; Sat, 15 Feb 2003 15:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbTBOURM>; Sat, 15 Feb 2003 15:17:12 -0500
Received: from smtp.terra.es ([213.4.129.129]:42137 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id <S265008AbTBOURE>;
	Sat, 15 Feb 2003 15:17:04 -0500
Date: Sat, 15 Feb 2003 21:27:13 +0100
From: Arador <diegocg@teleline.es>
To: Andrew Morton <akpm@digeo.com>
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.60-mm2
Message-Id: <20030215212713.47d1302e.diegocg@teleline.es>
In-Reply-To: <20030214013144.2d94a9c5.akpm@digeo.com>
References: <20030214013144.2d94a9c5.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2003 01:31:44 -0800
Andrew Morton <akpm@digeo.com> wrote:

>   The main obective of the anticipatory scheduler is not really to improve
>   interactivity.  It is to increase throughput.  Nick is showing some
>   impressive benchmark results with this now.  Some benchmarking of the
>   non-contest variety would be appreciated.
[...]
> anticipatory_io_scheduling.patch
>   Subject: [PATCH] 2.5.59-mm3 antic io sched
> 
> ant-sched-9feb.patch
>   anticipatory scheduler fix
> 
> ant-sched-12feb.patch
>   Anticipatory scheduler tuning

(I applied those three)
Those are tiobench's results:
in both:
No size specified, using 510 MB

Unit information
================
File size = megabytes
Blk Size  = bytes
Rate      = megabytes per second
CPU%      = percentage of CPU used during the test
Latency   = milliseconds
Lat%      = percent of requests that took longer than X seconds
CPU Eff   = Rate divided by CPU% - throughput per cpu load

diff between both 

Sequential reads
                               File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
 Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
 ---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
-2.5.60-mm2                    510   4096    1   21.23 8.264%     0.183      111.66   0.00000  0.00000   257
-2.5.60-mm2                    510   4096    2    7.33 3.506%     1.061      196.42   0.00000  0.00000   209
-2.5.60-mm2                    510   4096    4    5.39 2.593%     2.874      275.79   0.00000  0.00000   208
-2.5.60-mm2                    510   4096    8    4.45 2.125%     6.846     1008.67   0.00000  0.00000   209

+2.5.60-mm2-ant                510   4096    1   42.07 17.81%     0.092       57.22   0.00000  0.00000   236
+2.5.60-mm2-ant                510   4096    2   22.84 12.08%     0.332      308.44   0.00000  0.00000   189
+2.5.60-mm2-ant                510   4096    4   17.40 9.298%     0.873      695.78   0.00000  0.00000   187
+2.5.60-mm2-ant                510   4096    8   11.62 6.064%     2.484     1334.89   0.00000  0.00000   192
 
 Random Reads
                               File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
 Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
 ---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
-2.5.60-mm2                    510   4096    1    0.75 0.775%     5.190       57.26   0.00000  0.00000    97
-2.5.60-mm2                    510   4096    2    0.62 0.611%    12.433      122.61   0.00000  0.00000   102
-2.5.60-mm2                    510   4096    4    0.54 0.524%    28.542      534.94   0.00000  0.00000   102
-2.5.60-mm2                    510   4096    8    0.49 0.527%    58.520      941.25   0.00000  0.00000    94

+2.5.60-mm2-ant                510   4096    1    0.71 0.742%     5.522       62.66   0.00000  0.00000    95
+2.5.60-mm2-ant                510   4096    2    0.63 0.574%    12.137      274.13   0.00000  0.00000   109
+2.5.60-mm2-ant                510   4096    4    0.58 0.548%    24.428      282.18   0.00000  0.00000   106
+2.5.60-mm2-ant                510   4096    8    0.63 0.549%    41.976      596.08   0.00000  0.00000   115
 


 Sequential Writes
                               File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
 Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
 ---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
-2.5.60-mm2                    510   4096    1   26.59 38.97%     0.119      559.77   0.00000  0.00000    68
-2.5.60-mm2                    510   4096    2   16.14 29.96%     0.390     6813.03   0.00306  0.00000    54
-2.5.60-mm2                    510   4096    4    9.55 18.37%     1.249    16573.28   0.01615  0.00154    52
-2.5.60-mm2                    510   4096    8    6.35 11.40%     4.342    45796.21   0.02093  0.01550    56

+2.5.60-mm2-ant                510   4096    1   33.87 49.55%     0.093      370.18   0.00000  0.00000    68
+2.5.60-mm2-ant                510   4096    2   12.56 24.08%     0.531     9524.84   0.00613  0.00000    52
+2.5.60-mm2-ant                510   4096    4    6.68 13.08%     2.071    20422.31   0.03153  0.00231    51
+2.5.60-mm2-ant                510   4096    8    6.90 13.45%     3.086    41464.78   0.02790  0.01163    51
 


 Random Writes
                               File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
 Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
 ---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
-2.5.60-mm2                    510   4096    1    0.99 1.050%     0.140       33.67   0.00000  0.00000    95
-2.5.60-mm2                    510   4096    2    1.02 1.138%     0.043       11.72   0.00000  0.00000    90
-2.5.60-mm2                    510   4096    4    1.02 1.423%     0.082       99.74   0.00000  0.00000    72
-2.5.60-mm2                    510   4096    8    0.99 1.329%     0.074       74.51   0.00000  0.00000    74

+2.5.60-mm2-ant                510   4096    1    0.96 0.917%     0.027        1.03   0.00000  0.00000   105
+2.5.60-mm2-ant                510   4096    2    1.00 1.472%     0.044        2.42   0.00000  0.00000    68
+2.5.60-mm2-ant                510   4096    4    0.95 1.367%     0.044        1.96   0.00000  0.00000    69
+2.5.60-mm2-ant                510   4096    8    0.99 1.431%     0.079       75.46   0.00000  0.00000    69
