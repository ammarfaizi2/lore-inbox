Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264630AbSKIDiE>; Fri, 8 Nov 2002 22:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264632AbSKIDiE>; Fri, 8 Nov 2002 22:38:04 -0500
Received: from paloma14.e0k.nbg-hannover.de ([62.181.130.14]:14211 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S264630AbSKIDiB> convert rfc822-to-8bit; Fri, 8 Nov 2002 22:38:01 -0500
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Date: Sat, 9 Nov 2002 04:44:44 +0100
User-Agent: KMail/1.4.7
Cc: Con Kolivas <conman@kolivas.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200211090444.44658.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreww Morton wrote:
> Con Kolivas wrote:
> >
> > io_load:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > 2.4.18 [3]              474.1   15      36      10      6.64
> > 2.4.19 [3]              492.6   14      38      10      6.90
> > 2.4.19-ck9 [2]          140.6   49      5       5       1.97
> > 2.4.20-rc1 [2]          1142.2  6       90      10      16.00
> > 2.4.20-rc1aa1 [1]       1132.5  6       90      10      15.86
> >
>
> 2.4.20-pre3 included some elevator changes.  I assume they are the
> cause of this.  Those changes have propagated into Alan's and Andrea's
> kernels.   Hence they have significantly impacted the responsiveness
> of all mainstream 2.4 kernels under heavy writes.
>
> (The -ck patch includes rmap14b which includes the read-latency2 thing)

No, the 2.4.19-ck9 that I have (the default?) include -AA and preemption (!!!)

Preemption is for several months the clear throughput winner for me.
Latest 2.4.19-ck9 and now 2.5.46-mm1.

I know you all "hate" dbench but 2.5.45/2.5.46-mm1 halved (!!!) my "dbench 32" 
numbers. deadline IO is so GREAT.

2.4.19-ck5:	~55-60 seconds
2.5.46-mm1:	~31-45 seconds (even under VM pressure)

             total       used       free     shared    buffers     cached
Mem:       1034988     864172     170816          0     231840     345120
-/+ buffers/cache:     287212     747776
Swap:      1028120       8452    1019668
Total:     2063108     872624    1190484

Throughput 110.61 MB/sec (NB=138.263 MB/sec  1106.1 MBit/sec)
7.941u 38.251s 0:39.20 117.8%   0+0k 0+0io 841pf+0w

Sorry, "free -t" forgotten.

Throughput 114.462 MB/sec (NB=143.077 MB/sec  1144.62 MBit/sec)
7.986u 35.900s 0:37.90 115.7%   0+0k 0+0io 841pf+0w

             total       used       free     shared    buffers     cached
Mem:       1034988     481812     553176          0     178788      54048
-/+ buffers/cache:     248976     786012
Swap:      1028120       9836    1018284
Total:     2063108     491648    1571460

Throughput 112.283 MB/sec (NB=140.354 MB/sec  1122.83 MBit/sec)
7.728u 37.358s 0:38.62 116.7%   0+0k 0+0io 841pf+0w


             total       used       free     shared    buffers     cached
Mem:       1034988     461736     573252          0     163260      51488
-/+ buffers/cache:     246988     788000
Swap:      1028120       9976    1018144
Total:     2063108     471712    1591396

Only one MP3 playback hiccup during "dbench 32" and nearly no slowdown of 
dbench.

2.5.45+ need some more memory during my normal workload and do little more 
swap than 2.4.19+AA.

MemTotal:      1034988 kB
MemFree:        559784 kB
MemShared:           0 kB
Buffers:        164260 kB
Cached:          63308 kB
SwapCached:       2884 kB
Active:         399388 kB
Inactive:        10096 kB
HighTotal:      131008 kB
HighFree:        46508 kB
LowTotal:       903980 kB
LowFree:        513276 kB
SwapTotal:     1028120 kB
SwapFree:      1018156 kB
Dirty:              44 kB
Writeback:           0 kB
Mapped:         220700 kB
Slab:            36904 kB
Committed_AS:   530908 kB
PageTables:       3436 kB
ReverseMaps:    125959
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB

slabinfo - version: 1.2
fib6_nodes             7    112     32    1    1    1 :  248  124
ip6_dst_cache          9     20    192    1    1    1 :  248  124
ndisc_cache            1     30    128    1    1    1 :  248  124
raw6_sock              0      0    576    0    0    1 :  120   60
udp6_sock              1      7    576    1    1    1 :  120   60
tcp6_sock              5      8   1024    2    2    1 :  120   60
ip_conntrack           8     60    320    5    5    1 :  120   60
unix_sock            192    261    448   29   29    1 :  120   60
tcp_tw_bucket          0      0    128    0    0    1 :  248  124
tcp_bind_bucket       13    112     32    1    1    1 :  248  124
tcp_open_request       0      0    128    0    0    1 :  248  124
inet_peer_cache        2     59     64    1    1    1 :  248  124
secpath_cache          0      0     32    0    0    1 :  248  124
flow_cache             0      0     64    0    0    1 :  248  124
xfrm4_dst_cache        0      0    192    0    0    1 :  248  124
ip_fib_hash           15    112     32    1    1    1 :  248  124
ip_dst_cache          25    100    192    5    5    1 :  248  124
arp_cache              3     60    128    2    2    1 :  248  124
raw4_sock              0      0    448    0    0    1 :  120   60
udp_sock               7     18    448    2    2    1 :  120   60
tcp_sock              24     40    896   10   10    1 :  120   60
sgpool-MAX_PHYS_SEGMENTS     32     33   2560   11   11    2 :   54   27
sgpool-64             32     33   1280   11   11    1 :   54   27
sgpool-32             32     36    640    6    6    1 :  120   60
sgpool-16             32     36    320    3    3    1 :  120   60
sgpool-8              36     40    192    2    2    1 :  248  124
reiser_inode_cache   3900  19320    384 1932 1932    1 :  120   60
eventpoll              0      0     96    0    0    1 :  248  124
kioctx                 0      0    192    0    0    1 :  248  124
kiocb                  0      0    192    0    0    1 :  248  124
dnotify_cache          0      0     20    0    0    1 :  248  124
file_lock_cache      104    160     96    4    4    1 :  248  124
fasync_cache           2    202     16    1    1    1 :  248  124
shmem_inode_cache     12     27    448    3    3    1 :  120   60
uid_cache              5    112     32    1    1    1 :  248  124
deadline_drq        1792   1792     32   16   16    1 :  248  124
blkdev_requests     1280   1320    192   66   66    1 :  248  124
biovec-BIO_MAX_PAGES    256    260   3072   52   52    4 :   54   27
biovec-128           256    260   1536   52   52    2 :   54   27
biovec-64            256    260    768   52   52    1 :  120   60
biovec-16            256    260    192   13   13    1 :  248  124
biovec-4             256    295     64    5    5    1 :  248  124
biovec-1             325    404     16    2    2    1 :  248  124
bio                  272    295     64    5    5    1 :  248  124
sock_inode_cache     237    330    384   33   33    1 :  120   60
skbuff_head_cache    897    980    192   49   49    1 :  248  124
sock                   7     10    384    1    1    1 :  120   60
proc_inode_cache     117    696    320   58   58    1 :  120   60
sigqueue              87     87    132    3    3    1 :  248  124
radix_tree_node     4560  11340    320  945  945    1 :  120   60
cdev_cache            24    177     64    3    3    1 :  248  124
bdev_cache            15     30    128    1    1    1 :  248  124
mnt_cache             24     59     64    1    1    1 :  248  124
inode_cache          548    588    320   49   49    1 :  120   60
dentry_cache        7302  36560    192 1828 1828    1 :  248  124
filp                2512   2550    128   85   85    1 :  248  124
names_cache            6      6   4096    6    6    1 :   54   27
buffer_head        56609 158616     52 2203 2203    1 :  248  124
mm_struct             90    110    384   11   11    1 :  120   60
vm_area_struct      5357   6300    128  210  210    1 :  248  124
fs_cache              90    295     64    5    5    1 :  248  124
files_cache           90     99    448   11   11    1 :  120   60
signal_act            99     99   1344   33   33    1 :   54   27
task_struct          133    145   1600   29   29    2 :   54   27
pte_chain          19930  28851     64  489  489    1 :  248  124
mm_chain               0      0      8    0    0    1 :  248  124
size-131072(DMA)       0      0 131072    0    0   32 :    8    4
size-131072            0      0 131072    0    0   32 :    8    4
size-65536(DMA)        0      0  65536    0    0   16 :    8    4
size-65536             0      0  65536    0    0   16 :    8    4
size-32768(DMA)        0      0  32768    0    0    8 :    8    4
size-32768             1      1  32768    1    1    8 :    8    4
size-16384(DMA)        0      0  16384    0    0    4 :    8    4
size-16384            11     15  16384   11   15    4 :    8    4
size-8192(DMA)         0      0   8192    0    0    2 :    8    4
size-8192              5      9   8192    5    9    2 :    8    4
size-4096(DMA)         0      0   4096    0    0    1 :   54   27
size-4096            198    212   4096  198  212    1 :   54   27
size-2048(DMA)         0      0   2048    0    0    1 :   54   27
size-2048            190    206   2048   99  103    1 :   54   27
size-1024(DMA)         0      0   1024    0    0    1 :  120   60
size-1024            268    268   1024   67   67    1 :  120   60
size-512(DMA)          0      0    512    0    0    1 :  120   60
size-512             512    512    512   64   64    1 :  120   60
size-256(DMA)          0      0    256    0    0    1 :  248  124
size-256             360    360    256   24   24    1 :  248  124
size-192(DMA)          0      0    192    0    0    1 :  248  124
size-192              54     60    192    3    3    1 :  248  124
size-128(DMA)          0      0    128    0    0    1 :  248  124
size-128             923   1050    128   35   35    1 :  248  124
size-64(DMA)           0      0     64    0    0    1 :  248  124
size-64             1851   2124     64   36   36    1 :  248  124
size-32(DMA)           0      0     64    0    0    1 :  248  124
size-32             1891   2065     64   35   35    1 :  248  124
kmem_cache           112    128    120    4    4    1 :  248  124

GREAT work!

Regards,
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel at hamburg.de (replace at with @)
