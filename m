Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262590AbSJ0VWH>; Sun, 27 Oct 2002 16:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbSJ0VWH>; Sun, 27 Oct 2002 16:22:07 -0500
Received: from h-66-166-207-249.SNVACAID.covad.net ([66.166.207.249]:30954
	"EHLO freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262590AbSJ0VWG>; Sun, 27 Oct 2002 16:22:06 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 27 Oct 2002 13:27:58 -0800
Message-Id: <200210272127.NAA03536@adam.yggdrasil.com>
To: akpm@digeo.com
Subject: Re: Pauses in 2.5.44 (some kind of memory policy change?)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>"Adam J. Richter" wrote:
>> 
>>         I run /usr/bin/mail to read my mail box file, which has about
>> 24 megabytes (in 2300 messages, mostly spam).  After this, about half
>> of the time, my keyboard and mouse will intermittently stop responding
>> for a second or two, maybe one or two times, and then everything
>> seems to be OK.  This happens *after* the mail spool has been read.
>> This did not happen in previous kernels (well, maybe 2.5.43, I can't
>> quite be sure about that one).
>> 
>>         The mail spool is on NFS, but I suspect the culprit might be
>> some kind of memory balancing change in 2.5.44.
>> 

>Clean pagecache usually doesn't cause much trouble...

>Please send a `vmstat 1' trace which covers the episode.

	Here are two traces.  Also, thanks for your help in pointing out
the new version of procps at surriel.com/procps.


   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 0  0  0      0  52160  31420 135796    0    0     1     9   91    40  0  0 99
 0  0  0      0  52156  31420 135796    0    0     0    28 1054   267  1  1 98
 0  0  0      0  52156  31420 135796    0    0     0     0 1043   159  1  1 98
 1  0  2      0  45252  31420 142520    0    0     0     0 3573   349  9 38 53

...Started /usr/bin/mail around here...

 1  0  2      0  30024  31420 157636    0    0     0     0 6540   510 20 80  0
 1  0  2      0  14908  31420 172544    0    0     0     0 6433   499 16 84  0
 3  0  2      0   9196  31420 178172    0    0     0 17152 6939   259  3 97  0
 1  0  1      0   2452  31420 185112    0    0     0  4056 4061   278  9 91  0
 0  0  0      0   2636  31420 184848    0    0     0     0 1294   195  2  6 92

...Pause occurred around here...

 1  0  1      0   2664  31420 184848    0    0     0  4004 1766    55  0 44 56
 0  0  0      0   2676  31420 184848    0    0     0    40 1103   282  2  3 95
 0  0  0      0   2676  31420 184848    0    0     0     0 1064   169  0  0 100
 0  0  0      0   2676  31420 184848    0    0     0     0 1082   225  1  1 98
 0  0  0      0   2676  31420 184848    0    0     0     0 1097   263  1  1 98


Here is another run:

   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 0  0  0      0   3992  30860 180424    0    0     1     9   92    40  0  0 99
 0  0  0      0   3988  30860 180424    0    0     0     0 1069   267  1  2 97
 0  0  0      0   3988  30860 180424    0    0     0     0 1032   136  1  0 99
 2  0  1      0   2464  29912 182696    0    0     4   380 1121   229 18 19 63
 2  0  3      0   4548  24556 185780    0    0     0  4732 1983   206 26 74  0
 3  0  1      0   4572  24532 185780    0    0     0 10172 2696    46  1 99  0
 0  0  0      0   3000  23460 188292    0    0     0   640 1160   248 12 18 70
...Pause occurred here...
 2  0  1      0   3348  23460 188292    0    0     0  9412 3409   109  0 58 41
 0  0  0      0   3352  23460 188292    0    0     0     4 1036   147  1  2 97
 0  0  0      0   3352  23460 188292    0    0     0     0 1032   153  0  1 99
 0  0  0      0   3352  23460 188292    0    0     0     0 1014   105  1  0 99
 1  0  0      0   3352  23460 188292    0    0     0     0 1089   435  1  1 98


Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
