Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWCNVOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWCNVOW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWCNVOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:14:22 -0500
Received: from smtp.uaf.edu ([137.229.34.30]:6410 "EHLO smtp.uaf.edu")
	by vger.kernel.org with ESMTP id S932458AbWCNVOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:14:21 -0500
From: Joshua Kugler <joshua.kugler@uaf.edu>
Organization: UAF Center for Distance Education - IT
To: linux-kernel@vger.kernel.org
Subject: Re: OOM kiler/load problems with RAID/LVM and AoE
Date: Tue, 14 Mar 2006 12:14:11 -0900
User-Agent: KMail/1.7.2
Cc: Lee Revell <rlrevell@joe-job.com>, sah@coraid.com
References: <200603131602.03886.joshua.kugler@uaf.edu> <1142298998.13256.76.camel@mindpipe>
In-Reply-To: <1142298998.13256.76.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603141214.11394.joshua.kugler@uaf.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 March 2006 16:16, Lee Revell wrote:
> You'll have to try the latest kernel, 2.6.15.x or the latest 2.6.16
> release candidate.

OK, compiled and booted with 2.6.16-rc5

On Monday 13 March 2006 21:53, Andrew Morton wrote:
> It it happens again, please get it to the stage where it's close
> to going oom, then capture:
>
> - The contents of /proc/meminfo
> - the contents of /proc/slabinfo
> - the oom-killer message (if poss)

This time around it seems OOM kiler didn't fire off, but bonnie "died," that 
is, went to 0% CPU, and one CPU when to 100% wa (the other one is 100% idle), 
there is no I/O going on (the Etherdrive units are showing no activity).  
BUT! There is still the issue of massive load.  Right now top, which is still 
running, shows load at 33.42, 29.33, 20.28.

Next stop: take out the LVM layer and make a direct RAID1 device since md now 
supports components > 2TB.  I'll report those results as well.

Here is a recent output of meminfo and slabinfo for what it's worth:

MemTotal:      8252100 kB
MemFree:       7197868 kB
Buffers:             0 kB
Cached:         974740 kB
SwapCached:          0 kB
Active:          39124 kB
Inactive:       963964 kB
HighTotal:     7405504 kB
HighFree:      6395892 kB
LowTotal:       846596 kB
LowFree:        801976 kB
SwapTotal:     4393736 kB
SwapFree:      4391136 kB
Dirty:              16 kB
Writeback:           0 kB
Mapped:          36688 kB
Slab:            35344 kB
CommitLimit:   4393736 kB
Committed_AS:   101672 kB
PageTables:       1588 kB
VmallocTotal:   118776 kB
VmallocUsed:      8280 kB
VmallocChunk:   110172 kB

slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> 
<pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata 
<active_slabs> <num_slabs> <sharedavail>
aoe_bufs              16     78     48   78    1 : tunables  120   60    8 : 
slabdata      1      1      0
fib6_nodes             9    113     32  113    1 : tunables  120   60    8 : 
slabdata      1      1      0
ip6_dst_cache         10     15    256   15    1 : tunables  120   60    8 : 
slabdata      1      1      0
ndisc_cache            1     20    192   20    1 : tunables  120   60    8 : 
slabdata      1      1      0
RAWv6                  5      6    640    6    1 : tunables   54   27    8 : 
slabdata      1      1      0
UDPv6                  1      6    640    6    1 : tunables   54   27    8 : 
slabdata      1      1      0
tw_sock_TCPv6          0      0    128   30    1 : tunables  120   60    8 : 
slabdata      0      0      0
request_sock_TCPv6      0      0    128   30    1 : tunables  120   60    8 : 
slabdata      0      0      0
TCPv6                 11     12   1216    3    1 : tunables   24   12    8 : 
slabdata      4      4      0
ip_conntrack_expect      0      0     84   46    1 : tunables  120   60    8 : 
slabdata      0      0      0
ip_conntrack          10     40    192   20    1 : tunables  120   60    8 : 
slabdata      2      2      0
ip_fib_alias           9    113     32  113    1 : tunables  120   60    8 : 
slabdata      1      1      0
ip_fib_hash            9    113     32  113    1 : tunables  120   60    8 : 
slabdata      1      1      0
dm_tio              4608   4669     16  203    1 : tunables  120   60    8 : 
slabdata     23     23      0
dm_io               4608   4732     20  169    1 : tunables  120   60    8 : 
slabdata     28     28      0
xfs_acl                0      0    304   13    1 : tunables   54   27    8 : 
slabdata      0      0      0
xfs_chashlist        167    845     20  169    1 : tunables  120   60    8 : 
slabdata      5      5      0
xfs_ili               93    252    140   28    1 : tunables  120   60    8 : 
slabdata      9      9      0
xfs_ifork              0      0     56   67    1 : tunables  120   60    8 : 
slabdata      0      0      0
xfs_efi_item           0      0    260   15    1 : tunables   54   27    8 : 
slabdata      0      0      0
xfs_efd_item           0      0    260   15    1 : tunables   54   27    8 : 
slabdata      0      0      0
xfs_buf_item           0      0    148   26    1 : tunables  120   60    8 : 
slabdata      0      0      0
xfs_dabuf              0      0     16  203    1 : tunables  120   60    8 : 
slabdata      0      0      0
xfs_da_state           0      0    336   11    1 : tunables   54   27    8 : 
slabdata      0      0      0
xfs_trans              1     13    596   13    2 : tunables   54   27    8 : 
slabdata      1      1      0
xfs_inode            403   1320    368   10    1 : tunables   54   27    8 : 
slabdata    132    132      0
xfs_btree_cur          0      0    140   28    1 : tunables  120   60    8 : 
slabdata      0      0      0
xfs_bmap_free_item      0      0     16  203    1 : tunables  120   60    8 : 
slabdata      0      0      0
xfs_buf               62    108    220   18    1 : tunables  120   60    8 : 
slabdata      6      6      0
xfs_ioend             32     44     88   44    1 : tunables  120   60    8 : 
slabdata      1      1      0
xfs_vnode            403   1269    408    9    1 : tunables   54   27    8 : 
slabdata    141    141      0
scsi_cmd_cache         4     10    384   10    1 : tunables   54   27    8 : 
slabdata      1      1      0
sgpool-128            32     33   2560    3    2 : tunables   24   12    8 : 
slabdata     11     11      0
sgpool-64             32     33   1280    3    1 : tunables   24   12    8 : 
slabdata     11     11      0
sgpool-32             32     36    640    6    1 : tunables   54   27    8 : 
slabdata      6      6      0
sgpool-16             32     36    320   12    1 : tunables   54   27    8 : 
slabdata      3      3      0
sgpool-8              32     40    192   20    1 : tunables  120   60    8 : 
slabdata      2      2      0
scsi_io_context        0      0    104   37    1 : tunables  120   60    8 : 
slabdata      0      0      0
UNIX                  21     60    384   10    1 : tunables   54   27    8 : 
slabdata      6      6      0
ip_mrt_cache           0      0    128   30    1 : tunables  120   60    8 : 
slabdata      0      0      0
tcp_bind_bucket        8    203     16  203    1 : tunables  120   60    8 : 
slabdata      1      1      0
inet_peer_cache        0      0     64   59    1 : tunables  120   60    8 : 
slabdata      0      0      0
secpath_cache          0      0    128   30    1 : tunables  120   60    8 : 
slabdata      0      0      0
xfrm_dst_cache         0      0    320   12    1 : tunables   54   27    8 : 
slabdata      0      0      0
ip_dst_cache          16     45    256   15    1 : tunables  120   60    8 : 
slabdata      3      3      0
arp_cache              1     20    192   20    1 : tunables  120   60    8 : 
slabdata      1      1      0
RAW                    3      7    512    7    1 : tunables   54   27    8 : 
slabdata      1      1      0
UDP                    9     14    512    7    1 : tunables   54   27    8 : 
slabdata      2      2      0
tw_sock_TCP            0      0    128   30    1 : tunables  120   60    8 : 
slabdata      0      0      0
request_sock_TCP       0      0     64   59    1 : tunables  120   60    8 : 
slabdata      0      0      0
TCP                    7     14   1088    7    2 : tunables   24   12    8 : 
slabdata      2      2      0
flow_cache             0      0    128   30    1 : tunables  120   60    8 : 
slabdata      0      0      0
cfq_ioc_pool           0      0     48   78    1 : tunables  120   60    8 : 
slabdata      0      0      0
cfq_pool               0      0     96   40    1 : tunables  120   60    8 : 
slabdata      0      0      0
crq_pool               0      0     48   78    1 : tunables  120   60    8 : 
slabdata      0      0      0
deadline_drq           0      0     52   72    1 : tunables  120   60    8 : 
slabdata      0      0      0
as_arq                20     59     64   59    1 : tunables  120   60    8 : 
slabdata      1      1      0
mqueue_inode_cache      1      7    576    7    1 : tunables   54   27    8 : 
slabdata      1      1      0
ext2_inode_cache       0      0    512    8    1 : tunables   54   27    8 : 
slabdata      0      0      0
ext2_xattr             0      0     48   78    1 : tunables  120   60    8 : 
slabdata      0      0      0
dnotify_cache          0      0     20  169    1 : tunables  120   60    8 : 
slabdata      0      0      0
dquot                  0      0    128   30    1 : tunables  120   60    8 : 
slabdata      0      0      0
eventpoll_pwq          0      0     36  101    1 : tunables  120   60    8 : 
slabdata      0      0      0
eventpoll_epi          0      0    128   30    1 : tunables  120   60    8 : 
slabdata      0      0      0
inotify_event_cache      0      0     28  127    1 : tunables  120   60    8 : 
slabdata      0      0      0
inotify_watch_cache      1    101     36  101    1 : tunables  120   60    8 : 
slabdata      1      1      0
kioctx                 0      0    192   20    1 : tunables  120   60    8 : 
slabdata      0      0      0
kiocb                  0      0    128   30    1 : tunables  120   60    8 : 
slabdata      0      0      0
fasync_cache           0      0     16  203    1 : tunables  120   60    8 : 
slabdata      0      0      0
shmem_inode_cache   4174   4176    472    8    1 : tunables   54   27    8 : 
slabdata    522    522      0
posix_timers_cache      0      0    100   39    1 : tunables  120   60    8 : 
slabdata      0      0      0
uid_cache              4     59     64   59    1 : tunables  120   60    8 : 
slabdata      1      1      0
blkdev_ioc            33    127     28  127    1 : tunables  120   60    8 : 
slabdata      1      1      0
blkdev_queue          54     56    940    4    1 : tunables   54   27    8 : 
slabdata     14     14      0
blkdev_requests       20     22    176   22    1 : tunables  120   60    8 : 
slabdata      1      1      0
biovec-(256)         260    260   3072    2    2 : tunables   24   12    8 : 
slabdata    130    130      0
biovec-128           264    265   1536    5    2 : tunables   24   12    8 : 
slabdata     53     53      0
biovec-64            272    290    768    5    1 : tunables   54   27    8 : 
slabdata     58     58      0
biovec-16            272    300    192   20    1 : tunables  120   60    8 : 
slabdata     15     15      0
biovec-4             272    295     64   59    1 : tunables  120   60    8 : 
slabdata      5      5      0
biovec-1             272    406     16  203    1 : tunables  120   60    8 : 
slabdata      2      2      0
bio                  272    300    128   30    1 : tunables  120   60    8 : 
slabdata     10     10      0
sock_inode_cache      73     90    448    9    1 : tunables   54   27    8 : 
slabdata     10     10      0
skbuff_fclone_cache     43     60    384   10    1 : tunables   54   27    8 : 
slabdata      6      6     13
skbuff_head_cache   1254   1320    192   20    1 : tunables  120   60    8 : 
slabdata     66     66      0
file_lock_cache       18     42     92   42    1 : tunables  120   60    8 : 
slabdata      1      1      0
proc_inode_cache     523    550    392   10    1 : tunables   54   27    8 : 
slabdata     55     55      0
sigqueue              75    135    144   27    1 : tunables  120   60    8 : 
slabdata      5      5      0
radix_tree_node     4079   4256    276   14    1 : tunables   54   27    8 : 
slabdata    304    304      0
bdev_cache            36     42    512    7    1 : tunables   54   27    8 : 
slabdata      6      6      0
sysfs_dir_cache     4822   4876     40   92    1 : tunables  120   60    8 : 
slabdata     53     53      0
mnt_cache             25     30    128   30    1 : tunables  120   60    8 : 
slabdata      1      1      0
inode_cache         1159   1280    376   10    1 : tunables   54   27    8 : 
slabdata    128    128      0
dentry_cache        6289  10208    132   29    1 : tunables  120   60    8 : 
slabdata    352    352      0
filp                1480   1480    192   20    1 : tunables  120   60    8 : 
slabdata     74     74    300
names_cache           18     18   4096    1    1 : tunables   24   12    8 : 
slabdata     18     18      0
key_jar                8     30    128   30    1 : tunables  120   60    8 : 
slabdata      1      1      0
idr_layer_cache      115    116    136   29    1 : tunables  120   60    8 : 
slabdata      4      4      0
buffer_head       240959 240984     52   72    1 : tunables  120   60    8 : 
slabdata   3347   3347      0
mm_struct            144    144    448    9    1 : tunables   54   27    8 : 
slabdata     16     16      0
vm_area_struct      3693   3738     92   42    1 : tunables  120   60    8 : 
slabdata     89     89      0
fs_cache             236    236     64   59    1 : tunables  120   60    8 : 
slabdata      4      4      0
files_cache          162    162    448    9    1 : tunables   54   27    8 : 
slabdata     18     18      0
signal_cache         190    190    384   10    1 : tunables   54   27    8 : 
slabdata     19     19      0
sighand_cache        177    177   1344    3    1 : tunables   24   12    8 : 
slabdata     59     59      0
task_struct          180    180   1328    3    1 : tunables   24   12    8 : 
slabdata     60     60      0
anon_vma             936   1016     12  254    1 : tunables  120   60    8 : 
slabdata      4      4      0
pgd                  226    226     32  113    1 : tunables  120   60    8 : 
slabdata      2      2      0
pmd                  279    279   4096    1    1 : tunables   24   12    8 : 
slabdata    279    279      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : 
slabdata      0      0      0
size-131072            1      1 131072    1   32 : tunables    8    4    0 : 
slabdata      1      1      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : 
slabdata      0      0      0
size-65536             4      4  65536    1   16 : tunables    8    4    0 : 
slabdata      4      4      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : 
slabdata      0      0      0
size-32768            50     50  32768    1    8 : tunables    8    4    0 : 
slabdata     50     50      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : 
slabdata      0      0      0
size-16384            18     18  16384    1    4 : tunables    8    4    0 : 
slabdata     18     18      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : 
slabdata      0      0      0
size-8192            181    181   8192    1    2 : tunables    8    4    0 : 
slabdata    181    181      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    8 : 
slabdata      0      0      0
size-4096            879    879   4096    1    1 : tunables   24   12    8 : 
slabdata    879    879      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    8 : 
slabdata      0      0      0
size-2048            566    582   2048    2    1 : tunables   24   12    8 : 
slabdata    291    291      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    8 : 
slabdata      0      0      0
size-1024            324    324   1024    4    1 : tunables   54   27    8 : 
slabdata     81     81      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    8 : 
slabdata      0      0      0
size-512             448    448    512    8    1 : tunables   54   27    8 : 
slabdata     56     56      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    8 : 
slabdata      0      0      0
size-256             240    240    256   15    1 : tunables  120   60    8 : 
slabdata     16     16      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    8 : 
slabdata      0      0      0
size-192             756    760    192   20    1 : tunables  120   60    8 : 
slabdata     38     38      0
size-128(DMA)          0      0    128   30    1 : tunables  120   60    8 : 
slabdata      0      0      0
size-128             426    510    128   30    1 : tunables  120   60    8 : 
slabdata     17     17      0
size-96(DMA)           0      0    128   30    1 : tunables  120   60    8 : 
slabdata      0      0      0
size-96              869    930    128   30    1 : tunables  120   60    8 : 
slabdata     31     31      0
size-64(DMA)           0      0     64   59    1 : tunables  120   60    8 : 
slabdata      0      0      0
size-32(DMA)           0      0     32  113    1 : tunables  120   60    8 : 
slabdata      0      0      0
size-64             2525   3127     64   59    1 : tunables  120   60    8 : 
slabdata     53     53      0
size-32             3390   3390     32  113    1 : tunables  120   60    8 : 
slabdata     30     30      0
kmem_cache           165    165    256   15    1 : tunables  120   60    8 : 
slabdata     11     11      0

j----- k-----

-- 
Joshua Kugler                 PGP Key: http://pgp.mit.edu/
CDE System Administrator             ID 0xDB26D7CE
http://distance.uaf.edu/
