Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbULNCaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbULNCaw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 21:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbULNCaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 21:30:52 -0500
Received: from webmail.sub.ru ([213.247.139.22]:9478 "HELO techno.sub.ru")
	by vger.kernel.org with SMTP id S261374AbULNC3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 21:29:13 -0500
From: Mikhail Ramendik <mr@ramendik.ru>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Date: Tue, 14 Dec 2004 05:28:59 +0300
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200412121728.16968.mr@ramendik.ru> <41BE3920.5020904@yahoo.com.au>
In-Reply-To: <41BE3920.5020904@yahoo.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_r/kvBtNEuVqyy7A"
Message-Id: <200412140528.59784.mr@ramendik.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_r/kvBtNEuVqyy7A
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Nick Piggin wrote:

> > With kernel 2.6.10-rc3 and 256 M RAM, when I start a task taht eats a ot
> > of RAM (for example, viewing a big TIFF file; also tested with a
> > synthetic "eater"), in the resulting swapping process kswapd tahes quite
> > a bit of CPU time. The computer becomes extremely unresponsive, the clock
> > (in icewm) stops for periods of time up to a minute). And the task
> > startup itself is somewhaat slow.
> >
> > I have checked both 2.6.8.1 and 2.6.9 for comparison, and they fare a lot
> > better. The CPU hogging is not there, the computer is much more
> > responsive, and the task starts faster.
> I'm not quite sure what the problem would be. Please check that you are
> using the same config for each kernel, and both kernels have detected the
> same amount of memory.

Seems so.

> Then, can you start by posting /proc/vmstat before and after running the
> synthetic "eater" for some amount of time, with both 2.6.9 and 2.6.10-rc3;

I have rerun the tests to record the data, and this time 2.6.9 behaved 
differently. There was no CPU hog for kswapd, but at some poing the computer 
went un-interactive, and after about 20 seconds the task was killed.

2.6.8.1 hummed along nicely and remained interactive (somewhat jerky as one 
would expect under heavy swapping, but at least the clock always ran)

2.6.10-rc3 started with some kswapd CPU hogging, and then became more and more 
unresponsive. It took me some minutes to become able to simply get the vmstat 
data!

The requested files (cat's of /proc/meminfo and /proc/slabinfo before the run, 
and /proc/vmstat before and during the run ["after" for 2.6.9 which killed 
the process]) are attached, as well as the eater code. I told the eater to 
eat 300 MB.

BTW, somebody told me in a private email to try the oomkiller patch, but I 
could not extract it from the Web archive, so I don't have the latest version 
of that :( I'd apreciate if anyone emailed that to me, or gave me a link. or 
a pointer to instructions on getting it right from obe of the Web archives.

-- 
Yours, Mikhail Ramendik

--Boundary-00=_r/kvBtNEuVqyy7A
Content-Type: text/plain;
  charset="iso-8859-1";
  name="meminfo.2.6.10-rc3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="meminfo.2.6.10-rc3"

MemTotal:       255352 kB
MemFree:          5304 kB
Buffers:          6808 kB
Cached:         123708 kB
SwapCached:          0 kB
Active:         188196 kB
Inactive:        34092 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255352 kB
LowFree:          5304 kB
SwapTotal:     2048244 kB
SwapFree:      2048188 kB
Dirty:             708 kB
Writeback:           0 kB
Mapped:         154868 kB
Slab:            12308 kB
CommitLimit:   2175920 kB
Committed_AS:   330276 kB
PageTables:       2704 kB
VmallocTotal:   778200 kB
VmallocUsed:      7092 kB
VmallocChunk:   770004 kB

--Boundary-00=_r/kvBtNEuVqyy7A
Content-Type: text/plain;
  charset="iso-8859-1";
  name="vmstat.2.6.8.1.post"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="vmstat.2.6.8.1.post"

nr_dirty 3
nr_writeback 4426
nr_unstable 0
nr_page_table_pages 653
nr_mapped 48547
nr_slab 3220
pgpgin 915374
pgpgout 837415
pswpin 150114
pswpout 201304
pgalloc_high 0
pgalloc_normal 1026690
pgalloc_dma 89983
pgfree 1117246
pgactivate 66409
pgdeactivate 283601
pgfault 794596
pgmajfault 21963
pgrefill_high 0
pgrefill_normal 803261
pgrefill_dma 111308
pgsteal_high 0
pgsteal_normal 238280
pgsteal_dma 30691
pgscan_kswapd_high 0
pgscan_kswapd_normal 563277
pgscan_kswapd_dma 121163
pgscan_direct_high 0
pgscan_direct_normal 98736
pgscan_direct_dma 12320
pginodesteal 0
slabs_scanned 50307
kswapd_steal 206788
kswapd_inodesteal 26
pageoutrun 1331
allocstall 1707
pgrotated 196485

--Boundary-00=_r/kvBtNEuVqyy7A
Content-Type: text/plain;
  charset="iso-8859-1";
  name="meminfo.2.6.8.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="meminfo.2.6.8.1"

MemTotal:       255380 kB
MemFree:          5896 kB
Buffers:          3828 kB
Cached:         121096 kB
SwapCached:          0 kB
Active:         177576 kB
Inactive:        38528 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255380 kB
LowFree:          5896 kB
SwapTotal:     2048244 kB
SwapFree:      2048188 kB
Dirty:             124 kB
Writeback:           0 kB
Mapped:         154204 kB
Slab:            18624 kB
Committed_AS:   329732 kB
PageTables:       2232 kB
VmallocTotal:   778200 kB
VmallocUsed:      6900 kB
VmallocChunk:   771164 kB

--Boundary-00=_r/kvBtNEuVqyy7A
Content-Type: text/plain;
  charset="iso-8859-1";
  name="slabinfo.2.6.10-rc3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="slabinfo.2.6.10-rc3"

slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
ip_fib_alias          20    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
ip_fib_hash           19    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
ip_conntrack_expect      0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
ip_conntrack           2     10    384   10    1 : tunables   54   27    0 : slabdata      1      1      0
fat_inode_cache        2     11    348   11    1 : tunables   54   27    0 : slabdata      1      1      0
fat_cache              3    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
ext3_inode_cache    1933   2896    476    8    1 : tunables   54   27    0 : slabdata    362    362      0
ext3_xattr             0      0     48   81    1 : tunables  120   60    0 : slabdata      0      0      0
journal_handle         4    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
journal_head         205    648     48   81    1 : tunables  120   60    0 : slabdata      8      8      0
revoke_table           4    290     12  290    1 : tunables  120   60    0 : slabdata      1      1      0
revoke_record          0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
unix_sock            179    190    384   10    1 : tunables   54   27    0 : slabdata     19     19      0
ip_mrt_cache           0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
tcp_tw_bucket          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
tcp_bind_bucket        6    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_open_request       0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
inet_peer_cache        1     61     64   61    1 : tunables  120   60    0 : slabdata      1      1      0
secpath_cache          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
xfrm_dst_cache         0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
ip_dst_cache          13     15    256   15    1 : tunables  120   60    0 : slabdata      1      1      0
arp_cache              4     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
raw_sock               2      7    512    7    1 : tunables   54   27    0 : slabdata      1      1      0
udp_sock              11     14    512    7    1 : tunables   54   27    0 : slabdata      2      2      0
tcp_sock              10     12   1024    4    1 : tunables   54   27    0 : slabdata      3      3      0
flow_cache             0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
uhci_urb_priv          2     88     44   88    1 : tunables  120   60    0 : slabdata      1      1      0
cfq_ioc_pool           0      0     24  156    1 : tunables  120   60    0 : slabdata      0      0      0
cfq_pool               0      0    104   38    1 : tunables  120   60    0 : slabdata      0      0      0
crq_pool               0      0     56   70    1 : tunables  120   60    0 : slabdata      0      0      0
deadline_drq           0      0     52   75    1 : tunables  120   60    0 : slabdata      0      0      0
as_arq               132    183     64   61    1 : tunables  120   60    0 : slabdata      3      3      0
ext2_inode_cache       1      9    420    9    1 : tunables   54   27    0 : slabdata      1      1      0
ext2_xattr             0      0     48   81    1 : tunables  120   60    0 : slabdata      0      0      0
dnotify_cache        100    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
dquot                  0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_epi          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
kioctx                 0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
kiocb                  0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
fasync_cache           2    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
shmem_inode_cache      6     10    384   10    1 : tunables   54   27    0 : slabdata      1      1      0
posix_timers_cache      0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache              5     61     64   61    1 : tunables  120   60    0 : slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    0 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    0 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    0 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    0 : slabdata      3      3      0
sgpool-8              32     62    128   31    1 : tunables  120   60    0 : slabdata      2      2      0
blkdev_ioc            63    156     24  156    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_queue          26     33    352   11    1 : tunables   54   27    0 : slabdata      3      3      0
blkdev_requests      135    135    148   27    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    0 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    0 : slabdata     52     52      0
biovec-16            259    270    256   15    1 : tunables  120   60    0 : slabdata     18     18      0
biovec-4             256    305     64   61    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1             354    452     16  226    1 : tunables  120   60    0 : slabdata      2      2      0
bio                  332    403    128   31    1 : tunables  120   60    0 : slabdata     13     13      0
file_lock_cache       16     45     88   45    1 : tunables  120   60    0 : slabdata      1      1      0
sock_inode_cache     270    270    384   10    1 : tunables   54   27    0 : slabdata     27     27      0
skbuff_head_cache    480    480    256   15    1 : tunables  120   60    0 : slabdata     32     32      0
sock                   6     10    384   10    1 : tunables   54   27    0 : slabdata      1      1      0
proc_inode_cache      36    195    308   13    1 : tunables   54   27    0 : slabdata     15     15      0
sigqueue               8     27    148   27    1 : tunables  120   60    0 : slabdata      1      1      0
radix_tree_node     2502   3724    276   14    1 : tunables   54   27    0 : slabdata    266    266      0
bdev_cache             9     14    512    7    1 : tunables   54   27    0 : slabdata      2      2      0
mnt_cache             21     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
inode_cache         1222   1235    292   13    1 : tunables   54   27    0 : slabdata     95     95      0
dentry_cache        2964   6670    136   29    1 : tunables  120   60    0 : slabdata    230    230      0
filp                1545   1545    256   15    1 : tunables  120   60    0 : slabdata    103    103      0
names_cache            9      9   4096    1    1 : tunables   24   12    0 : slabdata      9      9      0
idr_layer_cache       82     87    136   29    1 : tunables  120   60    0 : slabdata      3      3      0
buffer_head         1772   4500     52   75    1 : tunables  120   60    0 : slabdata     60     60      0
mm_struct            114    114    640    6    1 : tunables   54   27    0 : slabdata     19     19      0
vm_area_struct      4823   5123     84   47    1 : tunables  120   60    0 : slabdata    109    109      0
fs_cache             110    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
files_cache          109    112    512    7    1 : tunables   54   27    0 : slabdata     16     16      0
signal_cache         126    135    256   15    1 : tunables  120   60    0 : slabdata      9      9      0
sighand_cache        125    125   1408    5    2 : tunables   24   12    0 : slabdata     25     25      0
task_struct          186    189   1248    3    1 : tunables   24   12    0 : slabdata     63     63      0
anon_vma            1336   1628      8  407    1 : tunables  120   60    0 : slabdata      4      4      0
pgd                  110    117   4096    1    1 : tunables   24   12    0 : slabdata    110    117      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             1      1  65536    1   16 : tunables    8    4    0 : slabdata      1      1      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             1      1  16384    1    4 : tunables    8    4    0 : slabdata      1      1      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192            191    191   8192    1    2 : tunables    8    4    0 : slabdata    191    191      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096             62     62   4096    1    1 : tunables   24   12    0 : slabdata     62     62      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048            401    402   2048    2    1 : tunables   24   12    0 : slabdata    201    201      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024            184    184   1024    4    1 : tunables   54   27    0 : slabdata     46     46      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512             277    296    512    8    1 : tunables   54   27    0 : slabdata     37     37      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256             150    150    256   15    1 : tunables  120   60    0 : slabdata     10     10      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
size-128            1736   1736    128   31    1 : tunables  120   60    0 : slabdata     56     56      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
size-64             5367   5368     64   61    1 : tunables  120   60    0 : slabdata     88     88      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
size-32             2916   2975     32  119    1 : tunables  120   60    0 : slabdata     25     25      0
kmem_cache           124    124    128   31    1 : tunables  120   60    0 : slabdata      4      4      0

--Boundary-00=_r/kvBtNEuVqyy7A
Content-Type: text/plain;
  charset="iso-8859-1";
  name="meminfo.2.6.9"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="meminfo.2.6.9"

MemTotal:       255308 kB
MemFree:          4920 kB
Buffers:          6416 kB
Cached:         123404 kB
SwapCached:         56 kB
Active:         181336 kB
Inactive:        40544 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255308 kB
LowFree:          4920 kB
SwapTotal:     2048244 kB
SwapFree:      2048188 kB
Dirty:             100 kB
Writeback:           0 kB
Mapped:         154648 kB
Slab:            13068 kB
Committed_AS:   330532 kB
PageTables:       2716 kB
VmallocTotal:   778200 kB
VmallocUsed:      7108 kB
VmallocChunk:   770004 kB

--Boundary-00=_r/kvBtNEuVqyy7A
Content-Type: text/plain;
  charset="iso-8859-1";
  name="vmstat.2.6.9.post"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="vmstat.2.6.9.post"

nr_dirty 1
nr_writeback 0
nr_unstable 0
nr_page_table_pages 679
nr_mapped 3323
nr_slab 2948
pgpgin 1225220
pgpgout 359216
pswpin 53954
pswpout 81905
pgalloc_high 0
pgalloc_normal 1153804
pgalloc_dma 85580
pgfree 1285435
pgactivate 437029
pgdeactivate 517802
pgfault 692436
pgmajfault 11168
pgrefill_high 0
pgrefill_normal 43823473
pgrefill_dma 3836086
pgsteal_high 0
pgsteal_normal 220020
pgsteal_dma 41131
pgscan_kswapd_high 0
pgscan_kswapd_normal 1205256
pgscan_kswapd_dma 591734
pgscan_direct_high 0
pgscan_direct_normal 65736
pgscan_direct_dma 7624
pginodesteal 0
slabs_scanned 58624
kswapd_steal 249560
kswapd_inodesteal 18718
pageoutrun 8900
allocstall 297
pgrotated 81962

--Boundary-00=_r/kvBtNEuVqyy7A
Content-Type: text/plain;
  charset="iso-8859-1";
  name="vmstat.2.6.9.pre"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="vmstat.2.6.9.pre"

nr_dirty 14
nr_writeback 0
nr_unstable 0
nr_page_table_pages 679
nr_mapped 38687
nr_slab 3262
pgpgin 853252
pgpgout 30300
pswpin 0
pswpout 0
pgalloc_high 0
pgalloc_normal 721655
pgalloc_dma 46151
pgfree 768897
pgactivate 46217
pgdeactivate 12894
pgfault 566874
pgmajfault 2524
pgrefill_high 0
pgrefill_normal 51165
pgrefill_dma 18693
pgsteal_high 0
pgsteal_normal 83771
pgsteal_dma 20152
pgscan_kswapd_high 0
pgscan_kswapd_normal 91641
pgscan_kswapd_dma 22007
pgscan_direct_high 0
pgscan_direct_normal 0
pgscan_direct_dma 0
pginodesteal 0
slabs_scanned 53760
kswapd_steal 103923
kswapd_inodesteal 16533
pageoutrun 3709
allocstall 0
pgrotated 45

--Boundary-00=_r/kvBtNEuVqyy7A
Content-Type: text/plain;
  charset="iso-8859-1";
  name="vmstat.2.6.8.1.pre"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="vmstat.2.6.8.1.pre"

nr_dirty 49
nr_writeback 0
nr_unstable 0
nr_page_table_pages 558
nr_mapped 38552
nr_slab 4650
pgpgin 277610
pgpgout 30723
pswpin 0
pswpout 14
pgalloc_high 0
pgalloc_normal 505535
pgalloc_dma 31361
pgfree 538419
pgactivate 45364
pgdeactivate 23508
pgfault 558801
pgmajfault 2575
pgrefill_high 0
pgrefill_normal 63405
pgrefill_dma 17101
pgsteal_high 0
pgsteal_normal 31213
pgsteal_dma 3057
pgscan_kswapd_high 0
pgscan_kswapd_normal 29337
pgscan_kswapd_dma 3102
pgscan_direct_high 0
pgscan_direct_normal 8316
pgscan_direct_dma 990
pginodesteal 0
slabs_scanned 22702
kswapd_steal 26509
kswapd_inodesteal 25
pageoutrun 165
allocstall 183
pgrotated 43

--Boundary-00=_r/kvBtNEuVqyy7A
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="eatmemory.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="eatmemory.c"

/* eatmemory.c created sometime early 2003 by billy@gonoph.net */
/* released in the public domain for anyone silly enough to run it */
/* use at your own risk! */
#include <stdio.h>
#include <stdlib.h>
#ifdef POSIX
#include <sys/select.h>
#else
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>
#endif
#include <string.h>

const int CHUNK=1024*1024;

char **CreateLargeArray(unsigned long megs);
char **CreateLargeChunk(unsigned long chunks,char **largearray);

int main(int argc,char **argv)
{
  
  char **bigarray=NULL;
  unsigned long megabytes;
  unsigned long old_megabytes=0;
  unsigned long looper1;
  unsigned long long realbytes;
  fd_set empty;
  struct timeval waittv;

  printf("Enter Megabytes to chew: ");
  fscanf(stdin,"%lu",&megabytes);
  printf("\n");
  realbytes=megabytes*CHUNK;

  /* the memory eating portion was in a loop.
   * I've since removed the loop, but kept this
   * part in case anyone wants to put it back in */
  if (bigarray) {
    for(looper1=0;looper1<old_megabytes;looper1++) { free(bigarray[looper1]); bigarray[looper1]=0; }
    free(bigarray);
    bigarray=0;
  }
  old_megabytes=megabytes;
  /* end loop handling code */

  bigarray=CreateLargeArray(megabytes);	/* create my array of chunks */
  if (!bigarray) { exit(-1); }

  /* bzero seems faster than memset - I like it more than memset
   * still calloc appears faster on objects larger than 100kb 
   * probably due to mmaping from the OS, so this maybe OS dependant */
  bzero(bigarray,megabytes);

  if (!CreateLargeChunk(megabytes,bigarray)) { exit(-1); }	/* fill in the array with actual chunks */

  /* loop the memory to keep it out of swap
   * wait 100ms per chunk to keep machine from
   * freaking out with max processor usage -
   * especially if it starts to swap */
  for (;;)
  {
    for (looper1=0;looper1<megabytes;looper1++)
    {
      memset(bigarray[looper1],48+(512 % 10),CHUNK);	/* just picked something random to throw in there */
      FD_ZERO(&empty);
      waittv.tv_sec = 0;
      waittv.tv_usec = 100;
      select(0,&empty,&empty,&empty,&waittv);
    }
  }
  
  return(0);
}

char **CreateLargeArray(unsigned long megs)
{
  char **largearray;

  largearray=malloc(megs*sizeof(char*));

  if (!largearray)
  {
    fprintf(stderr,"[warn] Unable to malloc() %lu megabytes.\n",megs);
    perror("[error]");
    return(0);
  }
  return(largearray);
}

char **CreateLargeChunk(unsigned long chunks,char **largearray)
{
  unsigned long looper1;

  /* Loop the largearray and create the CHUNKS
   * I did it this way as in theory, this app
   * should be able to consume >4GB of memory. */
  for(looper1=0;looper1<chunks;looper1++)
  {
    largearray[looper1]=malloc((CHUNK)+1);
    if (!largearray[looper1])
    {
      fprintf(stderr,"[warn] Unable to malloc() %lu chunks.\n",chunks);
      perror("[error]");
      return(0);
    }
    /* set the memory to ascii(48) '0' */
    memset(largearray[looper1],'0',CHUNK);
  }
  return(largearray);
}

// vim: sw=2 cindent :

--Boundary-00=_r/kvBtNEuVqyy7A--

