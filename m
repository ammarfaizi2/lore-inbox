Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUGZLLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUGZLLQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 07:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265200AbUGZLLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 07:11:16 -0400
Received: from eik.ii.uib.no ([129.177.16.3]:58854 "EHLO eik.ii.uib.no")
	by vger.kernel.org with ESMTP id S265195AbUGZLKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 07:10:35 -0400
Date: Mon, 26 Jul 2004 13:10:32 +0200
From: Jan-Frode Myklebust <janfrode@parallab.uib.no>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOM-killer going crazy. (was: Re: memory not released after using cdrecord/cdrdao)
Message-ID: <20040726111032.GA2067@ii.uib.no>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	linux-kernel@vger.kernel.org
References: <20040725094605.GA18324@zombie.inka.de> <41045EBE.8080708@comcast.net> <20040726091004.GA32403@ii.uib.no> <4104E307.1070004@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4104E307.1070004@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 08:55:03PM +1000, Nick Piggin wrote:
> 
> Can you just check you CONFIG_SWAP is on and /proc/sys/vm/laptop_mode is 0,
> and that you have some swap enabled.

# grep CONFIG_SWAP .config
CONFIG_SWAP=y
# cat /proc/sys/vm/laptop_mode
0
# free
             total       used       free     shared    buffers     cached
Mem:       2074708    1223324     851384          0        296     258376
-/+ buffers/cache:     964652    1110056
Swap:      2040244          0    2040244


> If the problem persists, can you send a copy each of 
> /proc/sys/fs/dentry-state,
> /proc/slabinfo and /proc/vmstat before and after you run dsmc until it goes
> OOM please?

I turned of a option (MEMORYEFFICIENTBACKUP) in 'dsmc', and then it uses a bit 
more memory, and crashes quicker.

# cat /proc/sys/fs/dentry-state /proc/slabinfo /proc/vmstat  ; dsmc incremental ; cat /proc/sys/fs/dentry-state /proc/slabinfo /proc/vmstat
644923  572300  45      0       0       0
slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
xfrm6_tunnel_spi       0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
fib6_nodes             7    119     32  119    1 : tunables  120   60    8 : slabdata      1      1      0
ip6_dst_cache          9     18    224   18    1 : tunables  120   60    8 : slabdata      1      1      0
ndisc_cache            1     25    160   25    1 : tunables  120   60    8 : slabdata      1      1      0
raw6_sock              0      0    672    6    1 : tunables   54   27    8 : slabdata      0      0      0
udp6_sock              0      0    640    6    1 : tunables   54   27    8 : slabdata      0      0      0
tcp6_sock             14     18   1184    6    2 : tunables   24   12    8 : slabdata      3      3      0
ip_fib_hash           18    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
ip_conntrack         494    516    320   12    1 : tunables   54   27    8 : slabdata     43     43      0
xfs_dqtrx              0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_dquots            32     36    336   12    1 : tunables   54   27    8 : slabdata      3      3      0
dm_tio                 0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
dm_io                  0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12    8 : slabdata      4      4      0
rpc_tasks              8     25    160   25    1 : tunables  120   60    8 : slabdata      1      1      0
rpc_inode_cache        6      9    448    9    1 : tunables   54   27    8 : slabdata      1      1      0
unix_sock             36     36    416    9    1 : tunables   54   27    8 : slabdata      4      4      0
ip_mrt_cache           0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
tcp_tw_bucket          3     31    128   31    1 : tunables  120   60    8 : slabdata      1      1      0
tcp_bind_bucket       21    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
tcp_open_request       2     41     96   41    1 : tunables  120   60    8 : slabdata      1      1      0
inet_peer_cache        8     61     64   61    1 : tunables  120   60    8 : slabdata      1      1      0
secpath_cache          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
xfrm_dst_cache         0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
ip_dst_cache          74    165    256   15    1 : tunables  120   60    8 : slabdata     11     11      0
arp_cache             75     75    160   25    1 : tunables  120   60    8 : slabdata      3      3      0
raw4_sock              0      0    512    7    1 : tunables   54   27    8 : slabdata      0      0      0
udp_sock              21     21    544    7    1 : tunables   54   27    8 : slabdata      3      3      0
tcp_sock              32     42   1056    7    2 : tunables   24   12    8 : slabdata      6      6      0
flow_cache             0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
qla2xxx_srbs         136    186    128   31    1 : tunables  120   60    8 : slabdata      5      6      0
scsi_cmd_cache         6     22    352   11    1 : tunables   54   27    8 : slabdata      2      2      0
mqueue_inode_cache      1      7    512    7    1 : tunables   54   27    8 : slabdata      1      1      0
xfs_acl                0      0    304   13    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_chashlist      39376  45695     20  185    1 : tunables  120   60    8 : slabdata    247    247      0
xfs_ili              219    476    140   28    1 : tunables  120   60    8 : slabdata     17     17      0
xfs_ifork              0      0     56   70    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_efi_item           0      0    260   15    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_efd_item           0      0    260   15    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_buf_item           0      0    148   27    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_dabuf              0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_da_state           0      0    336   12    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_trans              2     13    596   13    2 : tunables   54   27    8 : slabdata      1      1      0
xfs_inode         927591 980848    368   11    1 : tunables   54   27    8 : slabdata  89168  89168      0
xfs_btree_cur          0      0    140   28    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_bmap_free_item      0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_buf_t             40     60    256   15    1 : tunables  120   60    8 : slabdata      4      4      0
linvfs_icache     927591 980810    384   10    1 : tunables   54   27    8 : slabdata  98081  98081      0
nfs_write_data        36     36    448    9    1 : tunables   54   27    8 : slabdata      4      4      0
nfs_read_data         32     36    416    9    1 : tunables   54   27    8 : slabdata      4      4      0
nfs_inode_cache        0      0    608    6    1 : tunables   54   27    8 : slabdata      0      0      0
nfs_page               0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
isofs_inode_cache      0      0    352   11    1 : tunables   54   27    8 : slabdata      0      0      0
hugetlbfs_inode_cache      1     12    324   12    1 : tunables   54   27    8 : slabdata      1      1      0
ext2_inode_cache       0      0    480    8    1 : tunables   54   27    8 : slabdata      0      0      0
ext2_xattr             0      0     48   81    1 : tunables  120   60    8 : slabdata      0      0      0
journal_handle        24    135     28  135    1 : tunables  120   60    8 : slabdata      1      1      0
journal_head          32    324     48   81    1 : tunables  120   60    8 : slabdata      4      4      0
revoke_table           4    290     12  290    1 : tunables  120   60    8 : slabdata      1      1      0
revoke_record          0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
ext3_inode_cache     818   1096    480    8    1 : tunables   54   27    8 : slabdata    137    137      0
ext3_xattr             0      0     48   81    1 : tunables  120   60    8 : slabdata      0      0      0
dquot                  0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_epi          0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
kioctx                 0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
kiocb                  0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
dnotify_cache          0      0     20  185    1 : tunables  120   60    8 : slabdata      0      0      0
file_lock_cache       69     82     96   41    1 : tunables  120   60    8 : slabdata      2      2      0
fasync_cache           0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
shmem_inode_cache     21     36    448    9    1 : tunables   54   27    8 : slabdata      4      4      0
posix_timers_cache      0      0    104   38    1 : tunables  120   60    8 : slabdata      0      0      0
uid_cache              4    119     32  119    1 : tunables  120   60    8 : slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    8 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    8 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    8 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    8 : slabdata      3      3      0
sgpool-8              48     62    128   31    1 : tunables  120   60    8 : slabdata      2      2      0
cfq_pool              64    119     32  119    1 : tunables  120   60    8 : slabdata      1      1      0
crq_pool               0      0     40   96    1 : tunables  120   60    8 : slabdata      0      0      0
deadline_drq           0      0     52   75    1 : tunables  120   60    8 : slabdata      0      0      0
as_arq                37    122     64   61    1 : tunables  120   60    8 : slabdata      2      2      0
blkdev_ioc            71    185     20  185    1 : tunables  120   60    8 : slabdata      1      1      0
blkdev_queue          32     32    464    8    1 : tunables   54   27    8 : slabdata      4      4      0
blkdev_requests       50    100    160   25    1 : tunables  120   60    8 : slabdata      4      4      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    8 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    8 : slabdata     52     52      0
biovec-64            258    260    768    5    1 : tunables   54   27    8 : slabdata     52     52      0
biovec-16            256    260    192   20    1 : tunables  120   60    8 : slabdata     13     13      0
biovec-4             256    305     64   61    1 : tunables  120   60    8 : slabdata      5      5      0
biovec-1             277    452     16  226    1 : tunables  120   60    8 : slabdata      2      2      0
bio                  266    369     96   41    1 : tunables  120   60    8 : slabdata      8      9      0
sock_inode_cache      90     90    384   10    1 : tunables   54   27    8 : slabdata      9      9      0
skbuff_head_cache    457    660    192   20    1 : tunables  120   60    8 : slabdata     33     33      0
sock                   3     11    352   11    1 : tunables   54   27    8 : slabdata      1      1      0
proc_inode_cache     576    616    352   11    1 : tunables   54   27    8 : slabdata     56     56      0
sigqueue              16     27    148   27    1 : tunables  120   60    8 : slabdata      1      1      0
radix_tree_node     6769   6818    276   14    1 : tunables   54   27    8 : slabdata    487    487      0
bdev_cache            14     27    448    9    1 : tunables   54   27    8 : slabdata      3      3      0
mnt_cache             30     41     96   41    1 : tunables  120   60    8 : slabdata      1      1      0
inode_cache         1481   1485    352   11    1 : tunables   54   27    8 : slabdata    135    135      0
dentry_cache      645063 703566    144   27    1 : tunables  120   60    8 : slabdata  26058  26058      0
filp                 857    900    160   25    1 : tunables  120   60    8 : slabdata     36     36      0
names_cache           21     21   4096    1    1 : tunables   24   12    8 : slabdata     21     21      0
idr_layer_cache       69     87    136   29    1 : tunables  120   60    8 : slabdata      3      3      0
buffer_head         5110   9600     52   75    1 : tunables  120   60    8 : slabdata    128    128      0
mm_struct             72     77    544    7    1 : tunables   54   27    8 : slabdata     11     11      0
vm_area_struct      1937   1974     84   47    1 : tunables  120   60    8 : slabdata     42     42      0
fs_cache              89    183     64   61    1 : tunables  120   60    8 : slabdata      3      3      0
files_cache           73     81    416    9    1 : tunables   54   27    8 : slabdata      9      9      0
signal_cache         123    164     96   41    1 : tunables  120   60    8 : slabdata      4      4      0
sighand_cache        108    108   1312    3    1 : tunables   24   12    8 : slabdata     36     36      0
task_struct          123    130   1440    5    2 : tunables   24   12    8 : slabdata     26     26      0
anon_vma             812   1160     12  290    1 : tunables  120   60    8 : slabdata      4      4      0
pgd                   57     57   4096    1    1 : tunables   24   12    8 : slabdata     57     57      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             2      2  16384    1    4 : tunables    8    4    0 : slabdata      2      2      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192              7      7   8192    1    2 : tunables    8    4    0 : slabdata      7      7      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    8 : slabdata      0      0      0
size-4096            458    458   4096    1    1 : tunables   24   12    8 : slabdata    458    458      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    8 : slabdata      0      0      0
size-2048            205    212   2048    2    1 : tunables   24   12    8 : slabdata    106    106      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    8 : slabdata      0      0      0
size-1024            188    188   1024    4    1 : tunables   54   27    8 : slabdata     47     47      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    8 : slabdata      0      0      0
size-512             363   1336    512    8    1 : tunables   54   27    8 : slabdata    167    167      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
size-256             343   1230    256   15    1 : tunables  120   60    8 : slabdata     82     82      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
size-192           13208  14100    192   20    1 : tunables  120   60    8 : slabdata    705    705      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
size-128           10775  12276    128   31    1 : tunables  120   60    8 : slabdata    396    396      0
size-96(DMA)           0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
size-96            18193  20910     96   41    1 : tunables  120   60    8 : slabdata    510    510      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
size-64            71339  95770     64   61    1 : tunables  120   60    8 : slabdata   1570   1570      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    8 : slabdata      0      0      0
size-32             3469   4403     32  119    1 : tunables  120   60    8 : slabdata     37     37      0
kmem_cache           175    175    160   25    1 : tunables  120   60    8 : slabdata      7      7      0
nr_dirty 7
nr_writeback 0
nr_unstable 0
nr_page_table_pages 184
nr_mapped 6676
nr_slab 219569
pgpgin 10457106
pgpgout 4609136
pswpin 0
pswpout 0
pgalloc_high 3300613
pgalloc_normal 122918151
pgalloc_dma 2598782
pgfree 129043476
pgactivate 1736104
pgdeactivate 1494127
pgfault 3833745
pgmajfault 829
pgrefill_high 0
pgrefill_normal 1481727
pgrefill_dma 12400
pgsteal_high 0
pgsteal_normal 2209866
pgsteal_dma 29734
pgscan_kswapd_high 0
pgscan_kswapd_normal 2076562
pgscan_kswapd_dma 31042
pgscan_direct_high 0
pgscan_direct_normal 636887
pgscan_direct_dma 10854
pginodesteal 36508
slabs_scanned 56099472
kswapd_steal 1783428
kswapd_inodesteal 317433
pageoutrun 12166
allocstall 12962
pgrotated 14968
Tivoli Storage Manager
Command Line Backup/Archive Client Interface - Version 5, Release 1, Level 6.0
(C) Copyright IBM Corporation 1990, 2003 All Rights Reserved.
 
Node Name: BCCSFS
Session established with server TSM: Solaris 7/8
  Server Version 5, Release 1, Level 6.5
  Server date/time: 07/26/2004 13:02:47  Last access: 07/26/2004 13:01:56
 
 
Incremental backup of volume '/etc/'
 
Incremental backup of volume '/export/homebccs/'
 
Incremental backup of volume '/export/homebccs1/'
 
Incremental backup of volume '/export/netbccs/'
 
Incremental backup of volume '/export/local/'
ANS1898I ***** Processed       500 files *****
ANS1898I ***** Processed     1,000 files *****
Terminated
570734  495922  45      0       0       0
slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
xfrm6_tunnel_spi       0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
fib6_nodes             7    119     32  119    1 : tunables  120   60    8 : slabdata      1      1      0
ip6_dst_cache          9     18    224   18    1 : tunables  120   60    8 : slabdata      1      1      0
ndisc_cache            1     25    160   25    1 : tunables  120   60    8 : slabdata      1      1      0
raw6_sock              0      0    672    6    1 : tunables   54   27    8 : slabdata      0      0      0
udp6_sock              0      0    640    6    1 : tunables   54   27    8 : slabdata      0      0      0
tcp6_sock             14     18   1184    6    2 : tunables   24   12    8 : slabdata      3      3      0
ip_fib_hash           18    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
ip_conntrack         499    516    320   12    1 : tunables   54   27    8 : slabdata     43     43      0
xfs_dqtrx              0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_dquots            32     36    336   12    1 : tunables   54   27    8 : slabdata      3      3      0
dm_tio                 0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
dm_io                  0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12    8 : slabdata      4      4      0
rpc_tasks              8     25    160   25    1 : tunables  120   60    8 : slabdata      1      1      0
rpc_inode_cache        6      9    448    9    1 : tunables   54   27    8 : slabdata      1      1      0
unix_sock             18     36    416    9    1 : tunables   54   27    8 : slabdata      4      4      0
ip_mrt_cache           0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
tcp_tw_bucket          3     31    128   31    1 : tunables  120   60    8 : slabdata      1      1      0
tcp_bind_bucket       25    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
tcp_open_request       0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
inet_peer_cache        8     61     64   61    1 : tunables  120   60    8 : slabdata      1      1      0
secpath_cache          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
xfrm_dst_cache         0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
ip_dst_cache          69    165    256   15    1 : tunables  120   60    8 : slabdata     11     11      0
arp_cache             65     75    160   25    1 : tunables  120   60    8 : slabdata      3      3      0
raw4_sock              0      0    512    7    1 : tunables   54   27    8 : slabdata      0      0      0
udp_sock              14     21    544    7    1 : tunables   54   27    8 : slabdata      3      3      0
tcp_sock              35     42   1056    7    2 : tunables   24   12    8 : slabdata      6      6      0
flow_cache             0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
qla2xxx_srbs         145    155    128   31    1 : tunables  120   60    8 : slabdata      5      5      0
scsi_cmd_cache        22     22    352   11    1 : tunables   54   27    8 : slabdata      2      2      0
mqueue_inode_cache      1      7    512    7    1 : tunables   54   27    8 : slabdata      1      1      0
xfs_acl                0      0    304   13    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_chashlist      37540  45695     20  185    1 : tunables  120   60    8 : slabdata    247    247    480
xfs_ili              219    476    140   28    1 : tunables  120   60    8 : slabdata     17     17      0
xfs_ifork              0      0     56   70    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_efi_item           0      0    260   15    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_efd_item           0      0    260   15    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_buf_item           0      0    148   27    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_dabuf              0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_da_state           0      0    336   12    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_trans             13     13    596   13    2 : tunables   54   27    8 : slabdata      1      1      0
xfs_inode         828633 980507    368   11    1 : tunables   54   27    8 : slabdata  89137  89137    216
xfs_btree_cur          0      0    140   28    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_bmap_free_item      0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_buf_t             57     60    256   15    1 : tunables  120   60    8 : slabdata      4      4      0
linvfs_icache     828629 980220    384   10    1 : tunables   54   27    8 : slabdata  98022  98022    216
nfs_write_data        36     36    448    9    1 : tunables   54   27    8 : slabdata      4      4      0
nfs_read_data         32     36    416    9    1 : tunables   54   27    8 : slabdata      4      4      0
nfs_inode_cache        0      0    608    6    1 : tunables   54   27    8 : slabdata      0      0      0
nfs_page               0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
isofs_inode_cache      0      0    352   11    1 : tunables   54   27    8 : slabdata      0      0      0
hugetlbfs_inode_cache      1     12    324   12    1 : tunables   54   27    8 : slabdata      1      1      0
ext2_inode_cache       0      0    480    8    1 : tunables   54   27    8 : slabdata      0      0      0
ext2_xattr             0      0     48   81    1 : tunables  120   60    8 : slabdata      0      0      0
journal_handle        24    135     28  135    1 : tunables  120   60    8 : slabdata      1      1      0
journal_head         242    324     48   81    1 : tunables  120   60    8 : slabdata      4      4      0
revoke_table           4    290     12  290    1 : tunables  120   60    8 : slabdata      1      1      0
revoke_record          0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
ext3_inode_cache    1488   1488    480    8    1 : tunables   54   27    8 : slabdata    186    186      0
ext3_xattr             0      0     48   81    1 : tunables  120   60    8 : slabdata      0      0      0
dquot                  0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_epi          0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
kioctx                 0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
kiocb                  0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
dnotify_cache          0      0     20  185    1 : tunables  120   60    8 : slabdata      0      0      0
file_lock_cache       21     82     96   41    1 : tunables  120   60    8 : slabdata      2      2      0
fasync_cache           0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
shmem_inode_cache     20     36    448    9    1 : tunables   54   27    8 : slabdata      4      4      0
posix_timers_cache      0      0    104   38    1 : tunables  120   60    8 : slabdata      0      0      0
uid_cache              3    119     32  119    1 : tunables  120   60    8 : slabdata      1      1      0
sgpool-128            33     34   2048    2    1 : tunables   24   12    8 : slabdata     17     17      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    8 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    8 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    8 : slabdata      3      3      0
sgpool-8              62     62    128   31    1 : tunables  120   60    8 : slabdata      2      2      0
cfq_pool              64    119     32  119    1 : tunables  120   60    8 : slabdata      1      1      0
crq_pool               0      0     40   96    1 : tunables  120   60    8 : slabdata      0      0      0
deadline_drq           0      0     52   75    1 : tunables  120   60    8 : slabdata      0      0      0
as_arq               152    183     64   61    1 : tunables  120   60    8 : slabdata      3      3     30
blkdev_ioc            83    185     20  185    1 : tunables  120   60    8 : slabdata      1      1      0
blkdev_queue          32     32    464    8    1 : tunables   54   27    8 : slabdata      4      4      0
blkdev_requests      150    150    160   25    1 : tunables  120   60    8 : slabdata      6      6      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    8 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    8 : slabdata     52     52      0
biovec-64            260    260    768    5    1 : tunables   54   27    8 : slabdata     52     52      0
biovec-16            256    260    192   20    1 : tunables  120   60    8 : slabdata     13     13      0
biovec-4             273    305     64   61    1 : tunables  120   60    8 : slabdata      5      5      0
biovec-1             448    452     16  226    1 : tunables  120   60    8 : slabdata      2      2     60
bio                  410    410     96   41    1 : tunables  120   60    8 : slabdata     10     10     60
sock_inode_cache      78     90    384   10    1 : tunables   54   27    8 : slabdata      9      9      0
skbuff_head_cache    457    660    192   20    1 : tunables  120   60    8 : slabdata     33     33      0
sock                   3     11    352   11    1 : tunables   54   27    8 : slabdata      1      1      0
proc_inode_cache     581    616    352   11    1 : tunables   54   27    8 : slabdata     56     56      0
sigqueue               6     27    148   27    1 : tunables  120   60    8 : slabdata      1      1      0
radix_tree_node     6888   6888    276   14    1 : tunables   54   27    8 : slabdata    492    492     27
bdev_cache            14     27    448    9    1 : tunables   54   27    8 : slabdata      3      3      0
mnt_cache             30     41     96   41    1 : tunables  120   60    8 : slabdata      1      1      0
inode_cache         1482   1485    352   11    1 : tunables   54   27    8 : slabdata    135    135      0
dentry_cache      571383 703458    144   27    1 : tunables  120   60    8 : slabdata  26054  26054    480
filp                 857    900    160   25    1 : tunables  120   60    8 : slabdata     36     36      0
names_cache           23     23   4096    1    1 : tunables   24   12    8 : slabdata     23     23      0
idr_layer_cache       69     87    136   29    1 : tunables  120   60    8 : slabdata      3      3      0
buffer_head         5402   9600     52   75    1 : tunables  120   60    8 : slabdata    128    128    120
mm_struct             77     77    544    7    1 : tunables   54   27    8 : slabdata     11     11      0
vm_area_struct      1913   1974     84   47    1 : tunables  120   60    8 : slabdata     42     42      0
fs_cache              75    183     64   61    1 : tunables  120   60    8 : slabdata      3      3      0
files_cache           59     81    416    9    1 : tunables   54   27    8 : slabdata      9      9      0
signal_cache         110    164     96   41    1 : tunables  120   60    8 : slabdata      4      4      0
sighand_cache        103    108   1312    3    1 : tunables   24   12    8 : slabdata     36     36      0
task_struct          117    130   1440    5    2 : tunables   24   12    8 : slabdata     26     26      0
anon_vma             788   1160     12  290    1 : tunables  120   60    8 : slabdata      4      4      0
pgd                   57     57   4096    1    1 : tunables   24   12    8 : slabdata     57     57      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             2      2  16384    1    4 : tunables    8    4    0 : slabdata      2      2      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192              7      7   8192    1    2 : tunables    8    4    0 : slabdata      7      7      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    8 : slabdata      0      0      0
size-4096            482    482   4096    1    1 : tunables   24   12    8 : slabdata    482    482     24
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    8 : slabdata      0      0      0
size-2048            206    212   2048    2    1 : tunables   24   12    8 : slabdata    106    106      6
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    8 : slabdata      0      0      0
size-1024            188    188   1024    4    1 : tunables   54   27    8 : slabdata     47     47      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    8 : slabdata      0      0      0
size-512             363   1336    512    8    1 : tunables   54   27    8 : slabdata    167    167      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
size-256             358   1230    256   15    1 : tunables  120   60    8 : slabdata     82     82      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
size-192           12878  14100    192   20    1 : tunables  120   60    8 : slabdata    705    705    480
size-128(DMA)          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
size-128           10671  12276    128   31    1 : tunables  120   60    8 : slabdata    396    396    330
size-96(DMA)           0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
size-96            17860  20910     96   41    1 : tunables  120   60    8 : slabdata    510    510    480
size-64(DMA)           0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
size-64            66057  95770     64   61    1 : tunables  120   60    8 : slabdata   1570   1570    480
size-32(DMA)           0      0     32  119    1 : tunables  120   60    8 : slabdata      0      0      0
size-32             3469   4403     32  119    1 : tunables  120   60    8 : slabdata     37     37      0
kmem_cache           175    175    160   25    1 : tunables  120   60    8 : slabdata      7      7      0
nr_dirty 2
nr_writeback 0
nr_unstable 0
nr_page_table_pages 184
nr_mapped 6676
nr_slab 219558
pgpgin 10459226
pgpgout 4610264
pswpin 0
pswpout 0
pgalloc_high 3302227
pgalloc_normal 122926982
pgalloc_dma 2598793
pgfree 129053912
pgactivate 1774683
pgdeactivate 1532657
pgfault 3836188
pgmajfault 829
pgrefill_high 0
pgrefill_normal 1520257
pgrefill_dma 12400
pgsteal_high 0
pgsteal_normal 2210379
pgsteal_dma 29734
pgscan_kswapd_high 0
pgscan_kswapd_normal 2084649
pgscan_kswapd_dma 31042
pgscan_direct_high 0
pgscan_direct_normal 671488
pgscan_direct_dma 10854
pginodesteal 36536
slabs_scanned 56443602
kswapd_steal 1783794
kswapd_inodesteal 317433
pageoutrun 12197
allocstall 13108
pgrotated 15029




  -jf
