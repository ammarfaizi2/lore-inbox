Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVAWJMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVAWJMY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 04:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVAWJMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 04:12:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:29414 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261260AbVAWJMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 04:12:03 -0500
Date: Sun, 23 Jan 2005 10:11:54 +0100
From: Jens Axboe <axboe@suse.de>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: Jan Kasprzak <kas@fi.muni.cz>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050123091154.GC16648@suse.de>
References: <20050121161959.GO3922@fi.muni.cz> <1106360639.15804.1.camel@boxen>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <1106360639.15804.1.camel@boxen>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 22 2005, Alexander Nyberg wrote:
> fre 2005-01-21 klockan 17:19 +0100 skrev Jan Kasprzak:
> > 	Hi all,
> > 
> > I've been running 2.6.11-rc1 on my dual opteron Fedora Core 3 box for a week
> > now, and I think there is a memory leak somewhere. I am measuring the
> > size of active and inactive pages (from /proc/meminfo), and it seems
> > that the count of sum (active+inactive) pages is decreasing. Please
> > take look at the graphs at
> > 
> > http://www.linux.cz/stats/mrtg-rrd/vm_active.html
> > 
> > (especially the "monthly" graph) - I've booted 2.6.11-rc1 last Friday,
> > and since then the size of "inactive" pages is decreasing almost
> > constantly, while "active" is not increasing. The active+inactive
> > sum has been steady before, as you can see from both the monthly
> > and yearly graphs.
> > 
> > Now I am playing with 2.6.11-rc1-bk snapshots to see what happens.
> > I have been running 2.6.10-rc3 before. More info is available, please ask me.
> > The box runs 3ware 7506-8 controller with SW RAID-0, 1, and 5 volumes,
> > Tigon3 network card. The main load is FTP server, and there is also
> > a HTTP server and Qmail.
> 
> Others have seen this as well, the reports indicated that it takes a day
> or two before it becomes noticeable. When it happens next time please
> capture the output of /proc/meminfo and /proc/slabinfo.

This is after 2 days of uptime, the box is basically unusable.

-- 
Jens Axboe


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=meminfo

MemTotal:      1022372 kB
MemFree:         10024 kB
Buffers:          4664 kB
Cached:         121564 kB
SwapCached:      33636 kB
Active:         429544 kB
Inactive:       109512 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      1022372 kB
LowFree:         10024 kB
SwapTotal:     1116476 kB
SwapFree:       729056 kB
Dirty:             180 kB
Writeback:           0 kB
Mapped:         422216 kB
Slab:            42948 kB
CommitLimit:   1627660 kB
Committed_AS:  1134080 kB
PageTables:       7976 kB
VmallocTotal: 34359738367 kB
VmallocUsed:      1152 kB
VmallocChunk: 34359737171 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=slabinfo

slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
fat_inode_cache        0      0    592    6    1 : tunables   54   27    0 : slabdata      0      0      0
fat_cache              0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12    0 : slabdata      4      4      0
rpc_tasks              8     10    384   10    1 : tunables   54   27    0 : slabdata      1      1      0
rpc_inode_cache       10     10    768    5    1 : tunables   54   27    0 : slabdata      2      2      0
fib6_nodes             7     61     64   61    1 : tunables  120   60    0 : slabdata      1      1      0
ip6_dst_cache          7     12    320   12    1 : tunables   54   27    0 : slabdata      1      1      0
ndisc_cache            1     15    256   15    1 : tunables  120   60    0 : slabdata      1      1      0
rawv6_sock             3      4    960    4    1 : tunables   54   27    0 : slabdata      1      1      0
udpv6_sock             1      4    960    4    1 : tunables   54   27    0 : slabdata      1      1      0
tcpv6_sock             2      5   1600    5    2 : tunables   24   12    0 : slabdata      1      1      0
unix_sock            167    187    704   11    2 : tunables   54   27    0 : slabdata     17     17      0
tcp_tw_bucket          0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
tcp_bind_bucket       42    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_open_request       0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
inet_peer_cache        0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
ip_fib_alias          15    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
ip_fib_hash           15     61     64   61    1 : tunables  120   60    0 : slabdata      1      1      0
ip_dst_cache         110    130    384   10    1 : tunables   54   27    0 : slabdata     13     13      0
arp_cache              1     15    256   15    1 : tunables  120   60    0 : slabdata      1      1      0
raw_sock               3      5    768    5    1 : tunables   54   27    0 : slabdata      1      1      0
udp_sock              13     20    768    5    1 : tunables   54   27    0 : slabdata      4      4      0
tcp_sock              43     55   1408    5    2 : tunables   24   12    0 : slabdata     11     11      0
flow_cache             0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
uhci_urb_priv          3     45     88   45    1 : tunables  120   60    0 : slabdata      1      1      0
scsi_cmd_cache         7      7    512    7    1 : tunables   54   27    0 : slabdata      1      1      0
cfq_ioc_pool         615    615     96   41    1 : tunables  120   60    0 : slabdata     15     15      0
cfq_pool             137    140    192   20    1 : tunables  120   60    0 : slabdata      7      7      0
crq_pool             391    451     96   41    1 : tunables  120   60    0 : slabdata     11     11      0
deadline_drq           0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
as_arq                 0      0    112   35    1 : tunables  120   60    0 : slabdata      0      0      0
mqueue_inode_cache      1      9    832    9    2 : tunables   54   27    0 : slabdata      1      1      0
nfs_write_data        36     36    832    9    2 : tunables   54   27    0 : slabdata      4      4      0
nfs_read_data         32     35    768    5    1 : tunables   54   27    0 : slabdata      7      7      0
nfs_inode_cache        3      8    848    4    1 : tunables   54   27    0 : slabdata      2      2      0
nfs_page               0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
isofs_inode_cache      0      0    568    7    1 : tunables   54   27    0 : slabdata      0      0      0
hugetlbfs_inode_cache      1      7    520    7    1 : tunables   54   27    0 : slabdata      1      1      0
ext2_inode_cache       1      6    672    6    1 : tunables   54   27    0 : slabdata      1      1      0
ext2_xattr             0      0     88   45    1 : tunables  120   60    0 : slabdata      0      0      0
journal_handle         8    156     24  156    1 : tunables  120   60    0 : slabdata      1      1      0
journal_head          59    180     88   45    1 : tunables  120   60    0 : slabdata      4      4      0
revoke_table           8    225     16  225    1 : tunables  120   60    0 : slabdata      1      1      0
revoke_record          0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
ext3_inode_cache    8721  22905    776    5    1 : tunables   54   27    0 : slabdata   4581   4581      0
ext3_xattr             0      0     88   45    1 : tunables  120   60    0 : slabdata      0      0      0
dnotify_cache        112    192     40   96    1 : tunables  120   60    0 : slabdata      2      2      0
eventpoll_pwq          0      0     72   54    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_epi          0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
kioctx                 0      0    320   12    1 : tunables   54   27    0 : slabdata      0      0      0
kiocb                  0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
fasync_cache           1    156     24  156    1 : tunables  120   60    0 : slabdata      1      1      0
shmem_inode_cache     14     22    704   11    2 : tunables   54   27    0 : slabdata      2      2      0
posix_timers_cache      0      0    168   23    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache              4     61     64   61    1 : tunables  120   60    0 : slabdata      1      1      0
sgpool-128            32     32   4096    1    1 : tunables   24   12    0 : slabdata     32     32      0
sgpool-64             34     34   2048    2    1 : tunables   24   12    0 : slabdata     17     17      0
sgpool-32             36     36   1024    4    1 : tunables   54   27    0 : slabdata      9      9      0
sgpool-16             40     40    512    8    1 : tunables   54   27    0 : slabdata      5      5      0
sgpool-8              45     45    256   15    1 : tunables  120   60    0 : slabdata      3      3      0
blkdev_ioc           115    138     56   69    1 : tunables  120   60    0 : slabdata      2      2      0
blkdev_queue          74     78    640    6    1 : tunables   54   27    0 : slabdata     13     13      0
blkdev_requests      416    416    248   16    1 : tunables  120   60    0 : slabdata     26     26      0
biovec-(256)         256    256   4096    1    1 : tunables   24   12    0 : slabdata    256    256      0
biovec-128           272    284   2048    2    1 : tunables   24   12    0 : slabdata    137    142      0
biovec-64            260    264   1024    4    1 : tunables   54   27    0 : slabdata     66     66      0
biovec-16            270    270    256   15    1 : tunables  120   60    0 : slabdata     18     18      0
biovec-4             264    305     64   61    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1             360    900     16  225    1 : tunables  120   60    0 : slabdata      4      4      0
bio                  345    465    128   31    1 : tunables  120   60    0 : slabdata     15     15      0
file_lock_cache        2     26    152   26    1 : tunables  120   60    0 : slabdata      1      1      0
sock_inode_cache     236    252    640    6    1 : tunables   54   27    0 : slabdata     42     42      0
skbuff_head_cache    796    960    256   15    1 : tunables  120   60    0 : slabdata     64     64      0
sock                   5      7    576    7    1 : tunables   54   27    0 : slabdata      1      1      0
proc_inode_cache     191    427    552    7    1 : tunables   54   27    0 : slabdata     61     61      0
sigqueue              23     23    168   23    1 : tunables  120   60    0 : slabdata      1      1      0
radix_tree_node     2786   2996    536    7    1 : tunables   54   27    0 : slabdata    428    428      0
bdev_cache            10     10    704    5    1 : tunables   54   27    0 : slabdata      2      2      0
sysfs_dir_cache     2804   2867     64   61    1 : tunables  120   60    0 : slabdata     47     47      0
mnt_cache             27     40    192   20    1 : tunables  120   60    0 : slabdata      2      2      0
inode_cache         1068   1120    520    7    1 : tunables   54   27    0 : slabdata    160    160      0
dentry_cache        6300  46782    216   18    1 : tunables  120   60    0 : slabdata   2599   2599      0
filp                2955   3345    256   15    1 : tunables  120   60    0 : slabdata    223    223      0
names_cache           15     15   4096    1    1 : tunables   24   12    0 : slabdata     15     15      0
idr_layer_cache       63     70    528    7    1 : tunables   54   27    0 : slabdata     10     10      0
buffer_head         1276   3465     88   45    1 : tunables  120   60    0 : slabdata     77     77      0
mm_struct            104    105   1088    7    2 : tunables   24   12    0 : slabdata     15     15      0
vm_area_struct      7688   8360    176   22    1 : tunables  120   60    0 : slabdata    380    380      0
fs_cache             111    183     64   61    1 : tunables  120   60    0 : slabdata      3      3      0
files_cache          108    108    832    9    2 : tunables   54   27    0 : slabdata     12     12      0
signal_cache         135    135    448    9    1 : tunables   54   27    0 : slabdata     15     15      0
sighand_cache        117    117   2112    3    2 : tunables   24   12    0 : slabdata     39     39      0
task_struct          149    152   1728    4    2 : tunables   24   12    0 : slabdata     38     38      0
anon_vma            2143   2475     16  225    1 : tunables  120   60    0 : slabdata     11     11      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             2      2  65536    1   16 : tunables    8    4    0 : slabdata      2      2      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             2      2  16384    1    4 : tunables    8    4    0 : slabdata      2      2      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192             38     38   8192    1    2 : tunables    8    4    0 : slabdata     38     38      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096             86     86   4096    1    1 : tunables   24   12    0 : slabdata     86     86      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048            694    694   2048    2    1 : tunables   24   12    0 : slabdata    347    347      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024            384    384   1024    4    1 : tunables   54   27    0 : slabdata     96     96      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512             572    672    512    8    1 : tunables   54   27    0 : slabdata     84     84      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256              73     75    256   15    1 : tunables  120   60    0 : slabdata      5      5      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
size-192            1760   1760    192   20    1 : tunables  120   60    0 : slabdata     88     88      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
size-128            2269   2356    128   31    1 : tunables  120   60    0 : slabdata     76     76      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
size-64             1991   8357     64   61    1 : tunables  120   60    0 : slabdata    137    137      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
size-32             1131   1190     32  119    1 : tunables  120   60    0 : slabdata     10     10      0
kmem_cache           140    140    192   20    1 : tunables  120   60    0 : slabdata      7      7      0

--+HP7ph2BbKc20aGI--
