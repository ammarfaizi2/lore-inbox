Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261997AbSIYVAt>; Wed, 25 Sep 2002 17:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262001AbSIYVAt>; Wed, 25 Sep 2002 17:00:49 -0400
Received: from out009pub.verizon.net ([206.46.170.131]:26759 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP
	id <S261997AbSIYVAq>; Wed, 25 Sep 2002 17:00:46 -0400
Message-ID: <3D922531.50205@bellatlantic.net>
Date: Wed, 25 Sep 2002 17:05:53 -0400
From: "James C. Owens" <owensjc@bellatlantic.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: [Fwd: Re: Testing of Reiserfs write speedup patch]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am posting some bonnie++, dbench and AIM benchmark results on the 
suggestion of Hans Reiser. The below tests were stability/speed tests 
after applying the ReiserFS write speedup patch available on the namesys 
site. Note that I received a message from Oleg informing me that the 
write speedup patch I used is the one largely written by Chris, and 
consists of work to prevent unnecessary disk flushes, etc. It is now 
part of Chris' data logging patches. This is not the new patch which 
removes the 4 kB allocation/balance loop.

Another point to be underlined is that the patch was applied after 
applying Andrea Arcangeli's collected patches to the 2.4.19-rc5 (same as 
2.4.19 release) kernel, these patches include an asynch I/O 
implementation, as well as the O(1) scheduler.

As you can see below, the bonnie++ results are excellent. The dbench 
results are in-line with what I have gotten with Andrea's kernels before.

It would be nice to have some comparison to others running the AIM suite 
7 (s7110), since it has been released. The results seem pretty good to 
me! When I get the time, I will rerun AIM with the ac series and the 
stock 2.4.19 kernel and compare.

Please cc me on responses since I don't subscribe to the lkml.

Thanks,

Jim


-------- Original Message --------
Subject: Re: Testing of Reiserfs write speedup patch
Date: Tue, 24 Sep 2002 13:53:03 +0400
From: Hans Reiser <reiser@namesys.com>
To: James C. Owens <owensjc@bellatlantic.net>
CC: Oleg Drokin <green@namesys.com>, Chris Mason <mason@suse.com>
References: <3D8FF28D.3040607@bellatlantic.net>

Excellent.  You might want to post your results on lkml and/or
reiserfs-list@namesys.com.:)
Good work Oleg.

Hans

James C. Owens wrote:

 > Don't know if this is useful or not... I thought I would send my
 > testing results to you guys. I have tested the heck out of my system
 > after applying the ReiserFS_speedup-2.4.19-pre6.diff patch to AA's
 > 2.4.19-rc5-aa1. This is actually aa's version of the released 2.4.19,
 > since 2.4.19-rc5 is the 2.4.19 release. Of note is that AA's kernel
 > includes aio and the O(1) scheduler.
 >
 > I have not noted any fs corruption or other problems during the testing.
 >
 > System Specs relevant:
 >
 > Tyan S2460 Tiger MP motherboard
 > 2xAthlon MP 1600+ processors
 > 1.5 GB RAM
 > Mylex AcceleRAID 170 RAID controller with 32 MB onboard cache, running
 > 5 IBM DDYS-T18350N 10k rpm U160 SCSI drives in a RAID 5 configuration.
 >
 > Note /proc/sys/vm/max-readahead in all cases set to 511.
 >
 > First bonnie++ (2.4.19-aa1 w/o speedup patch)
 > Version 1.01d       ------Sequential Output------ --Sequential Input-
 > --Random-
 >                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block--
 > --Seeks--
 > Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP
 > /sec %CP
 > jco-linux     3100M 21468  33 28510  20 17655  10 38814  65 82601  40
 > 399.0   3
 >                    ------Sequential Create------ --------Random
 > Create--------
 >                    -Create-- --Read--- -Delete-- -Create-- --Read---
 > -Delete--
 >              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
 > /sec %CP
 >                 16 17419  56 +++++ +++ 16464  58 17617  59 +++++ +++
 > 7220  40
 > 
jco-linux,3100M,21468,33,28510,20,17655,10,38814,65,82601,40,399.0,3,16,17419,56,+++++,+++,16464,58,17617,59,+++++,+++,7220,40 

 >
 >
 > Second bonnie++ (2.4.19-aa1 w/ speedup patch)
 > Version 1.01d       ------Sequential Output------ --Sequential Input-
 > --Random-
 >                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block--
 > --Seeks--
 > Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP
 > /sec %CP
 > jco-linux     3100M 37048  58 39513  30 18319  11 40981  68 93992  47
 > 373.0   3
 >                    ------Sequential Create------ --------Random
 > Create--------
 >                    -Create-- --Read--- -Delete-- -Create-- --Read---
 > -Delete--
 >              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
 > /sec %CP
 >                 16 17602  90 +++++ +++ 15377  92 14751  83 +++++ +++
 > 13464  94
 > 
jco-linux,3100M,37048,58,39513,30,18319,11,40981,68,93992,47,373.0,3,16,17602,90,+++++,+++,15377,92,14751,83,+++++,+++,13464,94 

 >
 >
 > Notice the tremendous speedup on writes, and even a decent speedup on
 > sequential reads! I'm a happy man here! (94 MB/sec reads are real
 > rates from the combined output of the drives, since I am using a file
 > size more than double the memory size. The peak transfer I see during
 > actual physical media sequential reads from the controller is about
 > 105 MB/sec, pretty close to saturation for the 32-bit PCI bus.) I
 > think the combined real sequential output of four DDYS's (i.e. not
 > including the parity equivalent) is a bit higher than 100 MB/sec, but
 > the PCI bus is constraining here. (Too bad I don't have the AcceleRAID
 > 352 or ExtremeRAID 64 bit controllers.)
 >
 >
 > During bonnie++ runs without the speedup patch, the system is really
 > prone to read starvation during the big writes. The behaviour with the
 > speed-up patch is vastly improved (although not perfect).
 >
 >
 > Dbench results with speedup patch applied (without any tweaking to the
 > /proc/sys/vm settings):
 >
 > Throughput 68.9744 MB/sec (NB=86.2179 MB/sec  689.744 MBit/sec)  8 procs
 > Throughput 65.0722 MB/sec (NB=81.3403 MB/sec  650.722 MBit/sec)  16 procs
 > Throughput 43.4186 MB/sec (NB=54.2732 MB/sec  434.186 MBit/sec)  32 procs
 > Throughput 35.9702 MB/sec (NB=44.9627 MB/sec  359.702 MBit/sec)  64 procs
 >
 > I ran dbenchs all the way up to 256. Throughput asymptoted out at ~30
 > MB/sec. These results are consistent with runs I did a while back with
 > the 2.4.18 kernel. No problems were observed.
 >
 >
 > I have also run the AIM suite7 benchmark, since it has now been
 > released as open source. The results are attached as a text and ps
 > file. A result of peak 1059.7 jobs/minute, with a sustained rate of
 > 958.2 jobs/minute seems excellent to me. The machine was still running
 > at a total of 930.2 jobs/minute at the crossover point, where 963
 > simultaneous multiuser processes were running. (Yep, the load was at
 > ~1000.) Believe it or not, the system GUI was still very usable,
 > thanks to the O(1) scheduler.
 >
 >
 > I ran the same benchmark on a dual PIII 700 with the SuSE 2.4.18
 > default kernel and a single Maxtor 30 GB hard drive, and the peak rate
 > was at 135 jobs/minute, a factor of 7.85 difference from the dual
 > Athlon RAID system with the patches.
 >
 >
 > Anyway, I was more interested in testing stability than speed on the
 > dual Athlon. The AIM benchmark completed with no problems whatsover.
 > Not a single error or warning logged in /var/log/messages. File system
 > is perfectly fine - no corruption or other problems.
 >
 >
 > As a result of this testing, looks like the write speedup patch is a
 > keeper, at least for me!
 >
 >
 > Jim Owens
 >
 >------------------------------------------------------------------------
 >
 >Tasks	Jobs/Min	JTI	Real	CPU	Jobs/sec/task
 >Benchmark	Version	Machine	Run Date
 >AIM Multiuser Benchmark - Suite VII	"1.1"	JCO-LINUX	Sep 23 10:10:36 2002
 >1	101.4		100	57.4	7.6	1.6893
 >2	195.2		99	59.6	13.3	1.6267
 >3	301.3		99	57.9	16.4	1.6741
 >4	346.7		98	67.1	17.3	1.4447
 >5	416.1		97	69.9	24.3	1.3871
 >6	484.3		97	72.1	24.6	1.3454
 >7	535.7		97	76.0	32.7	1.2755
 >8	594.5		98	78.3	36.5	1.2385
 >10	675.6		97	86.2	43.1	1.1259
 >14	761.6		97	107.0	59.7	0.9067
 >18	835.3		97	125.4	74.6	0.7735
 >26	919.0		97	164.7	107.2	0.5891
 >29	944.6		96	178.7	111.8	0.5429
 >35	995.9		96	204.5	137.9	0.4742
 >47	1031.3		96	265.2	182.1	0.3657
 >59	1030.2		94	333.3	232.7	0.2910
 >71	1055.6		94	391.5	274.1	0.2478
 >97	1046.9		94	539.2	374.3	0.1799
 >107	1014.1		95	614.1	413.4	0.1580
 >128	973.3		96	765.4	487.4	0.1267
 >149	1031.8		96	840.5	575.4	0.1154
 >193	1017.3		95	1104.2	739.1	0.0878
 >212	1059.7		95	1164.3	816.5	0.0833
 >251	1023.3		92	1427.6	963.2	0.0679
 >290	994.8		93	1696.6	1111.3	0.0572
 >375	1003.2		93	2175.5	1431.0	0.0446
 >460	981.1		94	2728.8	1739.8	0.0355
 >545	995.1		92	3187.5	2082.8	0.0304
 >729	956.0		92	4438.0	2792.4	0.0219
 >805	968.8		92	4835.9	3099.0	0.0201
 >963	930.2		92	6025.0	3718.4	0.0161
 >
 >





