Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVBGLBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVBGLBN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 06:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVBGLBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 06:01:13 -0500
Received: from relay.muni.cz ([147.251.4.35]:692 "EHLO tirith.ics.muni.cz")
	by vger.kernel.org with ESMTP id S261376AbVBGLAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 06:00:49 -0500
Date: Mon, 7 Feb 2005 12:00:30 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050207110030.GI24513@fi.muni.cz>
References: <20050121161959.GO3922@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121161959.GO3922@fi.muni.cz>
User-Agent: Mutt/1.4.1i
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

: I've been running 2.6.11-rc1 on my dual opteron Fedora Core 3 box for a week
: now, and I think there is a memory leak somewhere. I am measuring the
: size of active and inactive pages (from /proc/meminfo), and it seems
: that the count of sum (active+inactive) pages is decreasing. Please
: take look at the graphs at
: 
: http://www.linux.cz/stats/mrtg-rrd/vm_active.html

	Well, with Linus' patch to fs/pipe.c the situation seems to
improve a bit, but some leak is still there (look at the "monthly" graph
at the above URL). The server has been running 2.6.11-rc2 + patch to fs/pipe.c
for last 8 days. I am letting it run for a few more days in case you want
some debugging info from a live system. I am attaching my /proc/meminfo
and /proc/slabinfo.

-Yenya

# cat /proc/meminfo
MemTotal:      4045168 kB
MemFree:         59396 kB
Buffers:         17812 kB
Cached:        2861648 kB
SwapCached:          0 kB
Active:         827700 kB
Inactive:      2239752 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      4045168 kB
LowFree:         59396 kB
SwapTotal:    14651256 kB
SwapFree:     14650584 kB
Dirty:            1616 kB
Writeback:           0 kB
Mapped:         206540 kB
Slab:           861176 kB
CommitLimit:  16673840 kB
Committed_AS:   565684 kB
PageTables:      20812 kB
VmallocTotal: 34359738367 kB
VmallocUsed:      7400 kB
VmallocChunk: 34359730867 kB
# cat /proc/slabinfo
slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
raid5/md5            256    260   1416    5    2 : tunables   24   12    8 : slabdata     52     52      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12    8 : slabdata      4      4      0
rpc_tasks             12     20    384   10    1 : tunables   54   27    8 : slabdata      2      2      0
rpc_inode_cache        8     10    768    5    1 : tunables   54   27    8 : slabdata      2      2      0
fib6_nodes            27     61     64   61    1 : tunables  120   60    8 : slabdata      1      1      0
ip6_dst_cache         17     36    320   12    1 : tunables   54   27    8 : slabdata      3      3      0
ndisc_cache            2     30    256   15    1 : tunables  120   60    8 : slabdata      2      2      0
rawv6_sock             4      4   1024    4    1 : tunables   54   27    8 : slabdata      1      1      0
udpv6_sock             1      4    960    4    1 : tunables   54   27    8 : slabdata      1      1      0
tcpv6_sock             8      8   1664    4    2 : tunables   24   12    8 : slabdata      2      2      0
unix_sock            567    650    768    5    1 : tunables   54   27    8 : slabdata    130    130      0
tcp_tw_bucket        445    920    192   20    1 : tunables  120   60    8 : slabdata     46     46      0
tcp_bind_bucket      389   2261     32  119    1 : tunables  120   60    8 : slabdata     19     19      0
tcp_open_request     135    310    128   31    1 : tunables  120   60    8 : slabdata     10     10      0
inet_peer_cache       32     62    128   31    1 : tunables  120   60    8 : slabdata      2      2      0
ip_fib_alias          20    119     32  119    1 : tunables  120   60    8 : slabdata      1      1      0
ip_fib_hash           18     61     64   61    1 : tunables  120   60    8 : slabdata      1      1      0
ip_dst_cache        1738   2060    384   10    1 : tunables   54   27    8 : slabdata    206    206      0
arp_cache              8     30    256   15    1 : tunables  120   60    8 : slabdata      2      2      0
raw_sock               3      9    832    9    2 : tunables   54   27    8 : slabdata      1      1      0
udp_sock              45     45    832    9    2 : tunables   54   27    8 : slabdata      5      5      0
tcp_sock             431    600   1472    5    2 : tunables   24   12    8 : slabdata    120    120      0
flow_cache             0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
dm_tio                 0      0     24  156    1 : tunables  120   60    8 : slabdata      0      0      0
dm_io                  0      0     32  119    1 : tunables  120   60    8 : slabdata      0      0      0
scsi_cmd_cache       261    315    512    7    1 : tunables   54   27    8 : slabdata     45     45    216
cfq_ioc_pool           0      0     48   81    1 : tunables  120   60    8 : slabdata      0      0      0
cfq_pool               0      0    176   22    1 : tunables  120   60    8 : slabdata      0      0      0
crq_pool               0      0    104   38    1 : tunables  120   60    8 : slabdata      0      0      0
deadline_drq           0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
as_arq               580    700    112   35    1 : tunables  120   60    8 : slabdata     20     20    432
xfs_acl                0      0    304   13    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_chashlist        380   4879     32  119    1 : tunables  120   60    8 : slabdata     41     41     30
xfs_ili               15    120    192   20    1 : tunables  120   60    8 : slabdata      6      6      0
xfs_ifork              0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_efi_item           0      0    352   11    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_efd_item           0      0    360   11    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_buf_item           5     21    184   21    1 : tunables  120   60    8 : slabdata      1      1      0
xfs_dabuf             10    156     24  156    1 : tunables  120   60    8 : slabdata      1      1      0
xfs_da_state           2      8    488    8    1 : tunables   54   27    8 : slabdata      1      1      0
xfs_trans              1      9    872    9    2 : tunables   54   27    8 : slabdata      1      1      0
xfs_inode            500    959    528    7    1 : tunables   54   27    8 : slabdata    137    137      0
xfs_btree_cur          2     20    192   20    1 : tunables  120   60    8 : slabdata      1      1      0
xfs_bmap_free_item      0      0     24  156    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_buf_t             44     72    448    9    1 : tunables   54   27    8 : slabdata      8      8      0
linvfs_icache        499    792    600    6    1 : tunables   54   27    8 : slabdata    132    132      0
nfs_write_data        36     36    832    9    2 : tunables   54   27    8 : slabdata      4      4      0
nfs_read_data         32     35    768    5    1 : tunables   54   27    8 : slabdata      7      7      0
nfs_inode_cache       28     72    952    4    1 : tunables   54   27    8 : slabdata     10     18      5
nfs_page               2     31    128   31    1 : tunables  120   60    8 : slabdata      1      1      0
isofs_inode_cache     10     12    600    6    1 : tunables   54   27    8 : slabdata      2      2      0
journal_handle        96    156     24  156    1 : tunables  120   60    8 : slabdata      1      1      0
journal_head         324    630     88   45    1 : tunables  120   60    8 : slabdata     14     14     60
revoke_table           6    225     16  225    1 : tunables  120   60    8 : slabdata      1      1      0
revoke_record          0      0     32  119    1 : tunables  120   60    8 : slabdata      0      0      0
ext3_inode_cache     829   1150    816    5    1 : tunables   54   27    8 : slabdata    230    230     54
ext3_xattr             0      0     88   45    1 : tunables  120   60    8 : slabdata      0      0      0
dnotify_cache          1     96     40   96    1 : tunables  120   60    8 : slabdata      1      1      0
dquot                  0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_pwq          0      0     72   54    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_epi          0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
kioctx                 0      0    384   10    1 : tunables   54   27    8 : slabdata      0      0      0
kiocb                  0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
fasync_cache           0      0     24  156    1 : tunables  120   60    8 : slabdata      0      0      0
shmem_inode_cache    847    855    760    5    1 : tunables   54   27    8 : slabdata    171    171      0
posix_timers_cache      0      0    176   22    1 : tunables  120   60    8 : slabdata      0      0      0
uid_cache             17    122     64   61    1 : tunables  120   60    8 : slabdata      2      2      0
sgpool-128            32     32   4096    1    1 : tunables   24   12    8 : slabdata     32     32      0
sgpool-64             32     32   2048    2    1 : tunables   24   12    8 : slabdata     16     16      0
sgpool-32            140    140   1024    4    1 : tunables   54   27    8 : slabdata     35     35     76
sgpool-16             77     88    512    8    1 : tunables   54   27    8 : slabdata     11     11      0
sgpool-8             405    405    256   15    1 : tunables  120   60    8 : slabdata     27     27    284
blkdev_ioc           259    480     40   96    1 : tunables  120   60    8 : slabdata      5      5      0
blkdev_queue          80     84    680    6    1 : tunables   54   27    8 : slabdata     14     14      0
blkdev_requests      628    688    248   16    1 : tunables  120   60    8 : slabdata     43     43    480
biovec-(256)         256    256   4096    1    1 : tunables   24   12    8 : slabdata    256    256      0
biovec-128           256    256   2048    2    1 : tunables   24   12    8 : slabdata    128    128      0
biovec-64            358    380   1024    4    1 : tunables   54   27    8 : slabdata     95     95     54
biovec-16            270    300    256   15    1 : tunables  120   60    8 : slabdata     20     20      0
biovec-4             342    366     64   61    1 : tunables  120   60    8 : slabdata      6      6      0
biovec-1          5506200 5506200     16  225    1 : tunables  120   60    8 : slabdata  24472  24472    240
bio               5506189 5506189    128   31    1 : tunables  120   60    8 : slabdata 177619 177619    180
file_lock_cache       35     75    160   25    1 : tunables  120   60    8 : slabdata      3      3      0
sock_inode_cache    1069   1368    640    6    1 : tunables   54   27    8 : slabdata    228    228      0
skbuff_head_cache   5738   7185    256   15    1 : tunables  120   60    8 : slabdata    479    479    360
sock                   4     12    640    6    1 : tunables   54   27    8 : slabdata      2      2      0
proc_inode_cache     222    483    584    7    1 : tunables   54   27    8 : slabdata     69     69    183
sigqueue              23     23    168   23    1 : tunables  120   60    8 : slabdata      1      1      0
radix_tree_node    18317  21476    536    7    1 : tunables   54   27    8 : slabdata   3068   3068     27
bdev_cache            55     60    768    5    1 : tunables   54   27    8 : slabdata     12     12      0
sysfs_dir_cache     3112   3172     64   61    1 : tunables  120   60    8 : slabdata     52     52      0
mnt_cache             37     60    192   20    1 : tunables  120   60    8 : slabdata      3      3      0
inode_cache         1085   1134    552    7    1 : tunables   54   27    8 : slabdata    162    162      0
dentry_cache        4510  12410    224   17    1 : tunables  120   60    8 : slabdata    730    730    404
filp                2970   4380    256   15    1 : tunables  120   60    8 : slabdata    292    292     30
names_cache           25     25   4096    1    1 : tunables   24   12    8 : slabdata     25     25      0
idr_layer_cache       75     77    528    7    1 : tunables   54   27    8 : slabdata     11     11      0
buffer_head         6061  22770     88   45    1 : tunables  120   60    8 : slabdata    506    506      0
mm_struct            319    455   1152    7    2 : tunables   24   12    8 : slabdata     65     65      0
vm_area_struct     18395  30513    184   21    1 : tunables  120   60    8 : slabdata   1453   1453    420
fs_cache             367    793     64   61    1 : tunables  120   60    8 : slabdata     13     13      0
files_cache          332    513    832    9    2 : tunables   54   27    8 : slabdata     57     57      0
signal_cache         379    549    448    9    1 : tunables   54   27    8 : slabdata     61     61      0
sighand_cache        350    420   2112    3    2 : tunables   24   12    8 : slabdata    140    140      6
task_struct          378    460   1744    4    2 : tunables   24   12    8 : slabdata    115    115      6
anon_vma            1098   2340     24  156    1 : tunables  120   60    8 : slabdata     15     15      0
shared_policy_node      0      0     56   69    1 : tunables  120   60    8 : slabdata      0      0      0
numa_policy           33    225     16  225    1 : tunables  120   60    8 : slabdata      1      1      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768            19     19  32768    1    8 : tunables    8    4    0 : slabdata     19     19      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             2      2  16384    1    4 : tunables    8    4    0 : slabdata      2      2      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192             33     35   8192    1    2 : tunables    8    4    0 : slabdata     33     35      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    8 : slabdata      0      0      0
size-4096            146    146   4096    1    1 : tunables   24   12    8 : slabdata    146    146      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    8 : slabdata      0      0      0
size-2048            526    546   2048    2    1 : tunables   24   12    8 : slabdata    273    273     88
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    8 : slabdata      0      0      0
size-1024           5533   6100   1024    4    1 : tunables   54   27    8 : slabdata   1525   1525    189
size-512(DMA)          0      0    512    8    1 : tunables   54   27    8 : slabdata      0      0      0
size-512             409    480    512    8    1 : tunables   54   27    8 : slabdata     60     60     27
size-256(DMA)          0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
size-256              97    105    256   15    1 : tunables  120   60    8 : slabdata      7      7      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
size-192            1747   2240    192   20    1 : tunables  120   60    8 : slabdata    112    112      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
size-128            2858   4495    128   31    1 : tunables  120   60    8 : slabdata    145    145     30
size-64(DMA)           0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
size-64             4595  23302     64   61    1 : tunables  120   60    8 : slabdata    382    382     60
size-32(DMA)           0      0     32  119    1 : tunables  120   60    8 : slabdata      0      0      0
size-32             1888   2142     32  119    1 : tunables  120   60    8 : slabdata     18     18      0
kmem_cache           150    150    256   15    1 : tunables  120   60    8 : slabdata     10     10      0
#

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
