Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265543AbTIJSwL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 14:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265542AbTIJSwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 14:52:11 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:30384 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265543AbTIJSwC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 14:52:02 -0400
Message-ID: <3F5F72A2.5010705@austin.ibm.com>
Date: Wed, 10 Sep 2003 13:51:14 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
References: <3F5D023A.5090405@austin.ibm.com> <20030908155639.2cdc8b56.akpm@osdl.org>
In-Reply-To: <20030908155639.2cdc8b56.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, looks like I reversed 2 set of results yesterday when I posted.  
Here is a more complete (and hopefully accurate) reporting of the 3 patches.

A) *** test5 + sched-CAN_MIGRATE_TASK-fix.patch
degrades volanomark, specjbb and specsdet

B) *** test5 + sched-balance-fix-2.6.0-test3-mm3-A0.patch
improves specjbb with no real change on sdet or volanomark

C) *** test5 + sched-CAN_MIGRATE_TASK-fix.patch + sched-balance-fix-2.6.0-test3-mm3-A0.patch
degrades volanomark and sdet, more degrade than improvement on specjbb

D) *** test5 + sched-CAN_MIGRATE_TASK-fix.patch + sched-balance-fix-2.6.0-test3-mm3-A0.patch + sched-2.6.0-test2-mm2-A3.patch
degrades volanomark and sdet, mixed results on specjbb



Below are the details for each of the runs.


A) *** test5 + sched-CAN_MIGRATE_TASK-fix.patch ********************

Volanomark                                
            2.6.0-test5 2.6.0-test5MIGRATE
               Msgs/sec     Msgs/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1        40915        38518    -5.86     -2397.00      1227.45  * 
 
SPECJBB
            2.6.0-test5 2.6.0-test5MIGRATE
  # of WHs      OPs/sec      OPs/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1     10118.42      9980.90    -1.36      -137.52       303.55 
         4     35316.38     34065.11    -3.54     -1251.27      1059.49  * 
         7     54126.17     52697.10    -2.64     -1429.07      1623.79 
        10     56906.64     55466.77    -2.53     -1439.87      1707.20 
        13     51589.86     43152.57   -16.35     -8437.29      1547.70  * 
        16     41410.52     45201.21     9.15      3790.69      1242.32  * 
        19     32944.48     29025.16   -11.90     -3919.32       988.33  * 

SPECSDET                         
            2.6.0-test5 2.6.0-test5MIGRATE
   Threads      Ops/sec      Ops/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1         3232         3111    -3.74      -121.00        96.96  * 
         4        11794        11383    -3.48      -411.00       353.82  * 
        16        19008        18726    -1.48      -282.00       570.24 
        64        18736        18701    -0.19       -35.00       562.08 



B) *** test5 + sched-balance-fix-2.6.0-test3-mm3-A0.patch *************************

VOLANOMARK
            2.6.0-test5 2.6.0-test5BALANCE
               Msgs/sec     Msgs/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1        40915        41391     1.16       476.00      1227.45 

SPECJBB
            2.6.0-test5 2.6.0-test5BALANCE
  # of WHs      OPs/sec      OPs/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1     10118.42     10062.66    -0.55       -55.76       303.55 
         4     35316.38     34676.03    -1.81      -640.35      1059.49 
         7     54126.17     52717.84    -2.60     -1408.33      1623.79 
        10     56906.64     56587.53    -0.56      -319.11      1707.20 
        13     51589.86     54625.25     5.88      3035.39      1547.70  * 
        16     41410.52     43120.66     4.13      1710.14      1242.32  * 
        19     32944.48     35820.89     8.73      2876.41       988.33  * 
   
SPECSDET
            2.6.0-test5 2.6.0-test5BALANCE
  # of WHs      OPs/sec      OPs/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1     10118.42     10062.66    -0.55       -55.76       303.55 
         4     35316.38     34676.03    -1.81      -640.35      1059.49 
         7     54126.17     52717.84    -2.60     -1408.33      1623.79 
        10     56906.64     56587.53    -0.56      -319.11      1707.20 
        13     51589.86     54625.25     5.88      3035.39      1547.70  * 
        16     41410.52     43120.66     4.13      1710.14      1242.32  * 
        19     32944.48     35820.89     8.73      2876.41       988.33  * 
  

C) *** test5 + sched-CAN_MIGRATE_TASK-fix.patch + sched-balance-fix-2.6.0-test3-mm3-A0.patch

VOLANOMARK
            2.6.0-test5 2.6.0-test5MIGRATE-BALANCE
               Msgs/sec     Msgs/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1        40915        38651    -5.53     -2264.00      1227.45  * 

SPECJBB  
             2.6.0-test5 2.6.0-test5MIGRATE-BALANCE
  # of WHs      OPs/sec      OPs/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1     10118.42     10103.50    -0.15       -14.92       303.55 
         4     35316.38     35420.78     0.30       104.40      1059.49 
         7     54126.17     54256.02     0.24       129.85      1623.79 
        10     56906.64     57224.95     0.56       318.31      1707.20 
        13     51589.86     43993.71   -14.72     -7596.15      1547.70  * 
        16     41410.52     45037.11     8.76      3626.59      1242.32  * 
        19     32944.48     30018.34    -8.88     -2926.14       988.33  * 

SPECSDET
             2.6.0-test5 2.6.0-test5MIGRATE-BALANCE
   Threads      Ops/sec      Ops/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1         3232         3031    -6.22      -201.00        96.96  * 
         4        11794        11288    -4.29      -506.00       353.82  * 
        16        19008        18716    -1.54      -292.00       570.24 
        64        18736        18775     0.21        39.00       562.08 
 

D) *** test5 + sched-CAN_MIGRATE_TASK-fix.patch + sched-balance-fix-2.6.0-test3-mm3-A0.patch + 
	sched-2.6.0-test2-mm2-A3.patch 

VOLANOMARK 
             2.6.0-test5 2.6.0-test5ALL
               Msgs/sec     Msgs/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1        40915        37204    -9.07     -3711.00      1227.45  * 

 
SPECJBB
             2.6.0-test5 2.6.0-test5ALL
  # of WHs      OPs/sec      OPs/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1     10118.42     10124.52     0.06         6.10       303.55 
         4     35316.38     34240.71    -3.05     -1075.67      1059.49  * 
         7     54126.17     54015.28    -0.20      -110.89      1623.79 
        10     56906.64     56618.95    -0.51      -287.69      1707.20 
        13     51589.86     47911.50    -7.13     -3678.36      1547.70  * 
        16     41410.52     46771.18    12.95      5360.66      1242.32  * 
        19     32944.48     33306.14     1.10       361.66       988.33 
 
SPECSDET
             2.6.0-test5 2.6.0-test5ALL
   Threads      Ops/sec      Ops/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1         3232         3097    -4.18      -135.00        96.96  * 
         4        11794        11251    -4.60      -543.00       353.82  * 
        16        19008        18657    -1.85      -351.00       570.24 
        64        18736        18703    -0.18       -33.00       562.08 

 


Steve






