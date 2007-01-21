Return-Path: <linux-kernel-owner+w=401wt.eu-S1751446AbXAUT1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbXAUT1h (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 14:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbXAUT1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 14:27:37 -0500
Received: from lucidpixels.com ([66.45.37.187]:43811 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbXAUT1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 14:27:36 -0500
Date: Sun, 21 Jan 2007 14:27:34 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org
cc: linux-raid@vger.kernel.org, xfs@oss.sgi.com
Subject: 2.6.20-rc5: cp 18gb 18gb.2 = OOM killer, reproducible just like
 2.16.19.2
Message-ID: <Pine.LNX.4.64.0701211424170.2552@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why does copying an 18GB on a 74GB raptor raid1 cause the kernel to invoke 
the OOM killer and kill all of my processes?

Doing this on a single disk 2.6.19.2 is OK, no issues.  However, this 
happens every time!

Anything to try?  Any other output needed?  Can someone shed some light on 
this situation?

Thanks.


The last lines of vmstat 1 (right before it kill -9'd my shell/ssh)

procs -----------memory---------- ---swap-- -----io---- -system-- 
----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id 
wa
 0  7    764  50348     12 1269988    0    0 53632   172 1902 4600  1  8 
29 62
 0  7    764  49420     12 1260004    0    0 53632 34368 1871 6357  2 11 
48 40
 0  6    764  39608     12 1237420    0    0 52880 94696 1891 7424  1 12 
47 39
 0  6    764  44264     12 1226064    0    0 42496 29723 1908 6035  1  9 
31 58
 0  6    764  26672     12 1214180    0    0 43520 117472 1944 6189  1 13  
0 87
 0  7    764   9132     12 1211732    0    0 22016 80400 1570 3304  1  8  
0 92
 1  8    764   9512     12 1200388    0    0 33288 62212 1687 4843  1  9  
0 91
 0  5    764  13980     12 1197096    0    0  5012   161 1619 2115  1  4 
42 54
 0  5    764  29604     12 1197220    0    0     0   112 1548 1602  0  3 
50 48
 0  5    764  49692     12 1197396    0    0     0   152 1484 1438  1  3 
50 47
 0  5    764  73128     12 1197644    0    0     0   120 1463 1392  1  3 
49 47
 0  4    764  99460     12 1197704    0    0    24   168 1545 1803  1  3 
39 57
 0  4    764 100088     12 1219296    0    0 11672 75450 1614 1371  0  5 
73 22
 0  6    764  50404     12 1269072    0    0 53632   145 1989 3871  1  9 
34 56
 0  6    764  51500     12 1267684    0    0 53632   608 1834 4437  1  8 
21 71
 4  5    764  51424     12 1266792    0    0 53504  7584 1847 4393  2  9 
48 42
 0  6    764  51456     12 1263736    0    0 53636  9804 1880 4326  1 10  
9 81
 0  6    764  50640     12 1263060    0    0 53504  4392 1929 4430  1  8 
28 63
 0  6    764  50956     12 1257884   24    0 50724 17214 1858 4755  1 11 
35 54
 0  6    764  48360     12 1247692    0    0 50840 48880 1871 6242  1 10  
0 89
 0  6    764  40028     12 1225860    0    0 42512 93346 1770 5599  2 11  
0 87
procs -----------memory---------- ---swap-- -----io---- -system-- 
----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id 
wa
 0  6    764  20372     12 1211744    0    0 21512 123664 1747 4378  0  9  
3 88
 0  6    764  12140     12 1188584    0    0 20224 111244 1628 4244  1  9 
15 76
 0  7    764  11280     12 1171144    0    0 22300 80936 1669 5314  1  8 
11 80
 0  6    764  12168     12 1162840    0    0 28168 44072 1808 5065  1  8  
0 92
 1  7   3132 123740     12 1051848    0 2368  3852 34246 2097 2376  0  5  
0 94
 1  6   3132  19996     12 1155664    0    0 51752   290 1999 2136  2  8  
0 91


The last lines of iostat (right before it kill -9'd my shell/ssh)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle  
           0.51    0.00    7.65   91.84    0.00    0.00

Device:         rrqm/s   wrqm/s   r/s   w/s    rkB/s    wkB/s avgrq-sz 
avgqu-sz   await  svctm  %util
sda              87.63  3873.20 254.64 65.98 21905.15 24202.06   287.61   
144.37  209.54   3.22 103.30
sdb               0.00  3873.20  1.03 132.99    12.37 60045.36   896.25    
41.19  398.53   6.93  92.89
sdc               0.00     0.00  0.00  0.00     0.00     0.00     0.00     
0.00    0.00   0.00   0.00
sdd               0.00     0.00  0.00  0.00     0.00     0.00     0.00     
0.00    0.00   0.00   0.00
sde               0.00     0.00  0.00  0.00     0.00     0.00     0.00     
0.00    0.00   0.00   0.00
sdf               0.00     0.00  0.00  0.00     0.00     0.00     0.00     
0.00    0.00   0.00   0.00
sdg               0.00    30.93  0.00  9.28     0.00   157.73    34.00     
0.01    1.11   1.11   1.03
sdh               0.00     0.00  0.00  0.00     0.00     0.00     0.00     
0.00    0.00   0.00   0.00
sdi              12.37     0.00  7.22  1.03    78.35     1.03    19.25     
0.04    5.38   5.38   4.43
sdj              12.37     0.00  6.19  1.03    74.23     1.03    20.86     
0.02    2.43   2.43   1.75
sdk               0.00    30.93  0.00  9.28     0.00   157.73    34.00     
0.01    0.56   0.56   0.52
md0               0.00     0.00  0.00 610.31     0.00  2441.24     8.00     
0.00    0.00   0.00   0.00
md2               0.00     0.00 347.42 996.91 22181.44  7917.53    44.78     
0.00    0.00   0.00   0.00
md1               0.00     0.00  0.00  0.00     0.00     0.00     0.00     
0.00    0.00   0.00   0.00
md3               0.00     0.00  1.03  9.28     4.12   164.95    32.80     
0.00    0.00   0.00   0.00
md4               0.00     0.00  0.00  0.00     0.00     0.00     0.00     
0.00    0.00   0.00   0.00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle  
           1.02    0.00   12.24   86.73    0.00    0.00

Device:         rrqm/s   wrqm/s   r/s   w/s    rkB/s    wkB/s avgrq-sz 
avgqu-sz   await  svctm  %util
sda             142.00  2497.00 403.00 38.00 34828.00 15112.00   226.49   
142.77  181.95   2.27 100.10
sdb               0.00  2498.00  8.00 27.00    36.00 12844.00   736.00     
3.63   45.31   6.06  21.20
sdc               0.00     0.00  0.00  0.00     0.00     0.00     0.00     
0.00    0.00   0.00   0.00
sdd               0.00     0.00  0.00  0.00     0.00     0.00     0.00     
0.00    0.00   0.00   0.00
sde               0.00     0.00  0.00  0.00     0.00     0.00     0.00     
0.00    0.00   0.00   0.00
sdf               0.00     0.00  0.00  0.00     0.00     0.00     0.00     
0.00    0.00   0.00   0.00
sdg               7.00    25.00  1.00 11.00    32.00   144.00    29.33     
0.04    3.58   2.58   3.10
sdh               0.00     0.00  0.00  0.00     0.00     0.00     0.00     
0.00    0.00   0.00   0.00
sdi              10.00     7.00  4.00  1.00    56.00    32.00    35.20     
0.01    2.40   2.40   1.20
sdj              10.00    22.00  4.00  8.00    56.00   120.00    29.33     
0.03    2.50   2.50   3.00
sdk               7.00    10.00  1.00  4.00    32.00    56.00    35.20     
0.01    2.40   2.40   1.20
md0               0.00     0.00  0.00  0.00     0.00     0.00     0.00     
0.00    0.00   0.00   0.00
md2               0.00     0.00 558.00 7028.00 34664.00 56076.00    23.92     
0.00    0.00   0.00   0.00
md1               0.00     0.00  0.00  0.00     0.00     0.00     0.00     
0.00    0.00   0.00   0.00
md3               0.00     0.00  0.00 11.00     0.00   168.00    30.55     
0.00    0.00   0.00   0.00
md4               0.00     0.00  0.00  0.00     0.00     0.00     0.00     
0.00    0.00   0.00   0.00


The last lines of dmesg:
[ 5947.199985] lowmem_reserve[]: 0 0 0
[ 5947.199992] DMA: 0*4kB 1*8kB 1*16kB 0*32kB 1*64kB 1*128kB 1*256kB 
0*512kB 1*1024kB 1*2048kB 0*4096kB = 3544kB
[ 5947.200010] Normal: 1*4kB 0*8kB 1*16kB 1*32kB 0*64kB 1*128kB 0*256kB 
1*512kB 0*1024kB 1*2048kB 0*4096kB = 2740kB
[ 5947.200035] HighMem: 98*4kB 35*8kB 9*16kB 69*32kB 4*64kB 1*128kB 
1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 3664kB
[ 5947.200052] Swap cache: add 789, delete 189, find 16/17, race 0+0
[ 5947.200055] Free swap  = 2197628kB
[ 5947.200058] Total swap = 2200760kB
[ 5947.200060] Free swap:       2197628kB
[ 5947.205664] 517888 pages of RAM 
[ 5947.205671] 288512 pages of HIGHMEM
[ 5947.205673] 5666 reserved pages 
[ 5947.205675] 257163 pages shared
[ 5947.205678] 600 pages swap cached 
[ 5947.205680] 88876 pages dirty
[ 5947.205682] 115111 pages writeback
[ 5947.205684] 5608 pages mapped
[ 5947.205686] 49367 pages slab
[ 5947.205688] 541 pages pagetables
[ 5947.205795] Out of memory: kill process 1853 (named) score 9937 or a 
child
[ 5947.205801] Killed process 1853 (named)
[ 5947.206616] bash invoked oom-killer: gfp_mask=0x84d0, order=0, 
oomkilladj=0
[ 5947.206621]  [<c013e33b>] out_of_memory+0x17b/0x1b0
[ 5947.206631]  [<c013fcac>] __alloc_pages+0x29c/0x2f0
[ 5947.206636]  [<c01479ad>] __pte_alloc+0x1d/0x90
[ 5947.206643]  [<c0148bf7>] copy_page_range+0x357/0x380
[ 5947.206649]  [<c0119d75>] copy_process+0x765/0xfc0
[ 5947.206655]  [<c012c3f9>] alloc_pid+0x1b9/0x280
[ 5947.206662]  [<c011a839>] do_fork+0x79/0x1e0
[ 5947.206674]  [<c015f91f>] do_pipe+0x5f/0xc0
[ 5947.206680]  [<c0101176>] sys_clone+0x36/0x40
[ 5947.206686]  [<c0103138>] syscall_call+0x7/0xb
[ 5947.206691]  [<c0420033>] __sched_text_start+0x853/0x950
[ 5947.206698]  ======================= 

