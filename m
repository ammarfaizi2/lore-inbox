Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267298AbUIOSJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267298AbUIOSJx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 14:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267313AbUIOSJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 14:09:28 -0400
Received: from c7ns3.center7.com ([216.250.142.14]:1164 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S267310AbUIOSH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 14:07:26 -0400
Message-ID: <41487CFA.5010002@drdos.com>
Date: Wed, 15 Sep 2004 11:33:46 -0600
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@drdos.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, jmerkey@galt.devicelogics.com,
       linux-kernel@vger.kernel.org, jmerkey@comcast.net
Subject: Re: 2.6.8.1 mempool subsystem sickness
References: <091420042058.15928.41475B8000002BA100003E382200763704970A059D0A0306@comcast.net> <4147555C.7010809@drdos.com> <414777EA.5080406@yahoo.com.au> <20040914223122.GA3325@galt.devicelogics.com> <41478419.3020606@yahoo.com.au> <41487B6D.1080202@drdos.com>
In-Reply-To: <41487B6D.1080202@drdos.com>
Content-Type: multipart/mixed;
 boundary="------------010408070702010601080600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010408070702010601080600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff V. Merkey wrote:

> Nick Piggin wrote:
>
>> jmerkey@galt.devicelogics.com wrote:
>>
>>> You bet.  Send them to me.  For some reason I am not able to post to 
>>> LKML again.
>>>
>>> Jeff
>>>
>> OK, this is against 2.6.9-rc2. Let me know how you go. Thanks
>>
>>  
>>
>
> Nick,
>
> The problem is corrected with this patch.  I am running with 3GB of 
> kernel memory
> and 1GB user space with the userspace splitting patch with very heavy 
> swapping
> and user space app activity and no failed allocations.  This patch 
> should be rolled
> into 2.6.9-rc2 since it fixes the problem.  With standard 3GB User/1GB 
> kernel
> address space, it also fixes the problems with X server running out of 
> memory
> and the apps crashing.
>
> Jeff
>
> Here's the stats from the test of the patch against 2.6.8-rc2 with the 
> patch applied
>
>


Attachments included.

Jeff


--------------010408070702010601080600
Content-Type: text/plain;
 name="proc.meminfo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc.meminfo"

MemTotal:      2983616 kB
MemFree:        576608 kB
Buffers:         42116 kB
Cached:          86000 kB
SwapCached:       2364 kB
Active:         133756 kB
Inactive:        25340 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      2983616 kB
LowFree:        576608 kB
SwapTotal:     1052248 kB
SwapFree:      1011856 kB
Dirty:            4136 kB
Writeback:           0 kB
Mapped:          35872 kB
Slab:          2239264 kB
Committed_AS:    97816 kB
PageTables:       1076 kB
VmallocTotal:   122824 kB
VmallocUsed:      2896 kB
VmallocChunk:   119604 kB

--------------010408070702010601080600
Content-Type: text/plain;
 name="proc.vmstat"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc.vmstat"

nr_dirty 1070
nr_writeback 0
nr_unstable 0
nr_page_table_pages 257
nr_mapped 5452
nr_slab 559846
pgpgin 259093865
pgpgout 68682338
pswpin 59363
pswpout 292378
pgalloc_high 0
pgalloc_normal 30770083
pgalloc_dma 2951033
pgfree 33868082
pgactivate 1505831
pgdeactivate 1709234
pgfault 64727816
pgmajfault 15099
pgrefill_high 0
pgrefill_normal 1685663
pgrefill_dma 1153475
pgsteal_high 0
pgsteal_normal 1043923
pgsteal_dma 424170
pgscan_kswapd_high 0
pgscan_kswapd_normal 1209615
pgscan_kswapd_dma 1983944
pgscan_direct_high 0
pgscan_direct_normal 206712
pgscan_direct_dma 9603
pginodesteal 11
slabs_scanned 342016
kswapd_steal 1298184
kswapd_inodesteal 9310
pageoutrun 2291
allocstall 4830
pgrotated 446422

--------------010408070702010601080600
Content-Type: text/plain;
 name="proc.slabinfo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc.slabinfo"

slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
bt_sock                3     10    384   10    1 : tunables   54   27    0 : slabdata      1      1      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12    0 : slabdata      4      4      0
rpc_tasks              8     15    256   15    1 : tunables  120   60    0 : slabdata      1      1      0
rpc_inode_cache        6      7    512    7    1 : tunables   54   27    0 : slabdata      1      1      0
ip_fib_hash           11    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
scsi_cmd_cache        52    110    384   10    1 : tunables   54   27    0 : slabdata      8     11      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    0 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    0 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    0 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    0 : slabdata      3      3      0
sgpool-8              97    217    128   31    1 : tunables  120   60    0 : slabdata      6      7      0
dm_tio                 0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
dm_io                  0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
uhci_urb_priv          0      0     44   88    1 : tunables  120   60    0 : slabdata      0      0      0
dn_fib_info_cache      0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
dn_dst_cache           0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
dn_neigh_cache         0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
decnet_socket_cache      0      0    768    5    1 : tunables   54   27    0 : slabdata      0      0      0
clip_arp_cache         0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
xfrm6_tunnel_spi       0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
fib6_nodes            13    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
ip6_dst_cache         51     90    256   15    1 : tunables  120   60    0 : slabdata      6      6      0
ndisc_cache            5     15    256   15    1 : tunables  120   60    0 : slabdata      1      1      0
raw6_sock              0      0    640    6    1 : tunables   54   27    0 : slabdata      0      0      0
udp6_sock              0      0    640    6    1 : tunables   54   27    0 : slabdata      0      0      0
tcp6_sock              5      7   1152    7    2 : tunables   24   12    0 : slabdata      1      1      0
unix_sock             50     50    384   10    1 : tunables   54   27    0 : slabdata      5      5      0
ip_mrt_cache           0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
tcp_tw_bucket          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
tcp_bind_bucket        8    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_open_request       0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
inet_peer_cache        1     61     64   61    1 : tunables  120   60    0 : slabdata      1      1      0
secpath_cache          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
xfrm_dst_cache         0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
ip_dst_cache          23     30    256   15    1 : tunables  120   60    0 : slabdata      2      2      0
arp_cache              1     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
raw4_sock              0      0    512    7    1 : tunables   54   27    0 : slabdata      0      0      0
udp_sock               3      7    512    7    1 : tunables   54   27    0 : slabdata      1      1      0
tcp_sock              20     20   1024    4    1 : tunables   54   27    0 : slabdata      5      5      0
flow_cache             0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
isofs_inode_cache      0      0    320   12    1 : tunables   54   27    0 : slabdata      0      0      0
fat_inode_cache        0      0    340   11    1 : tunables   54   27    0 : slabdata      0      0      0
ext2_inode_cache       0      0    400   10    1 : tunables   54   27    0 : slabdata      0      0      0
journal_handle        16    135     28  135    1 : tunables  120   60    0 : slabdata      1      1      0
journal_head         521    891     48   81    1 : tunables  120   60    0 : slabdata     11     11      0
revoke_table           4    290     12  290    1 : tunables  120   60    0 : slabdata      1      1      0
revoke_record          0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
ext3_inode_cache    7263   7263    440    9    1 : tunables   54   27    0 : slabdata    807    807      0
ext3_xattr             0      0     44   88    1 : tunables  120   60    0 : slabdata      0      0      0
reiser_inode_cache      0      0    368   11    1 : tunables   54   27    0 : slabdata      0      0      0
dquot                  0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_epi          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
kioctx                 0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
kiocb                  0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
dnotify_cache          1    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
fasync_cache           0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
shmem_inode_cache      4     10    384   10    1 : tunables   54   27    0 : slabdata      1      1      0
posix_timers_cache      0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache              9     61     64   61    1 : tunables  120   60    0 : slabdata      1      1      0
cfq_pool              64    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
crq_pool               0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
deadline_drq           0      0     48   81    1 : tunables  120   60    0 : slabdata      0      0      0
as_arq               135    195     60   65    1 : tunables  120   60    0 : slabdata      3      3      0
blkdev_ioc           109    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_queue          21     24    452    8    1 : tunables   54   27    0 : slabdata      3      3      0
blkdev_requests      122    182    152   26    1 : tunables  120   60    0 : slabdata      7      7      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    0 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : slabdata     52     52      0
biovec-64            257    260    768    5    1 : tunables   54   27    0 : slabdata     52     52      0
biovec-16         131340 131340    256   15    1 : tunables  120   60    0 : slabdata   8756   8756      0
biovec-4             305    305     64   61    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1             368    678     16  226    1 : tunables  120   60    0 : slabdata      3      3      0
bio               131396 131516     64   61    1 : tunables  120   60    0 : slabdata   2156   2156      0
file_lock_cache        6     45     88   45    1 : tunables  120   60    0 : slabdata      1      1      0
sock_inode_cache     100    100    384   10    1 : tunables   54   27    0 : slabdata     10     10      0
skbuff_head_cache   2130   2130    256   15    1 : tunables  120   60    0 : slabdata    142    142      0
sock                  30     30    384   10    1 : tunables   54   27    0 : slabdata      3      3      0
proc_inode_cache     435    481    308   13    1 : tunables   54   27    0 : slabdata     37     37      0
sigqueue              27     27    148   27    1 : tunables  120   60    0 : slabdata      1      1      0
radix_tree_node     7378   7378    276   14    1 : tunables   54   27    0 : slabdata    527    527      0
bdev_cache             8     14    512    7    1 : tunables   54   27    0 : slabdata      2      2      0
mnt_cache             21     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
inode_cache         3406   3406    292   13    1 : tunables   54   27    0 : slabdata    262    262      0
dentry_cache       15148  15148    140   28    1 : tunables  120   60    0 : slabdata    541    541      0
filp                 705    945    256   15    1 : tunables  120   60    0 : slabdata     63     63      0
names_cache           19     19   4096    1    1 : tunables   24   12    0 : slabdata     19     19      0
idr_layer_cache      100    116    136   29    1 : tunables  120   60    0 : slabdata      4      4      0
buffer_head        18041  67230     48   81    1 : tunables  120   60    0 : slabdata    830    830      0
mm_struct            102    102    640    6    1 : tunables   54   27    0 : slabdata     17     17      0
vm_area_struct      1831   2256     84   47    1 : tunables  120   60    0 : slabdata     48     48      0
fs_cache             119    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
files_cache           98     98    512    7    1 : tunables   54   27    0 : slabdata     14     14      0
signal_cache         155    155    128   31    1 : tunables  120   60    0 : slabdata      5      5      0
sighand_cache         89    115   1408    5    2 : tunables   24   12    0 : slabdata     23     23      0
task_struct           93    114   1360    3    1 : tunables   24   12    0 : slabdata     38     38      0
anon_vma             921   1221      8  407    1 : tunables  120   60    0 : slabdata      3      3      0
pgd                   73     73   4096    1    1 : tunables   24   12    0 : slabdata     73     73      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            2      2 131072    1   32 : tunables    8    4    0 : slabdata      2      2      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536         32834  32834  65536    1   16 : tunables    8    4    0 : slabdata  32834  32834      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             1      1  32768    1    8 : tunables    8    4    0 : slabdata      1      1      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             2      2  16384    1    4 : tunables    8    4    0 : slabdata      2      2      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192            124    128   8192    1    2 : tunables    8    4    0 : slabdata    124    128      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096           2095   2095   4096    1    1 : tunables   24   12    0 : slabdata   2095   2095      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048          32867  32868   2048    2    1 : tunables   24   12    0 : slabdata  16434  16434      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024            141    144   1024    4    1 : tunables   54   27    0 : slabdata     36     36      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512             200    560    512    8    1 : tunables   54   27    0 : slabdata     70     70      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256             189    480    256   15    1 : tunables  120   60    0 : slabdata     32     32      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
size-128            2181   2263    128   31    1 : tunables  120   60    0 : slabdata     73     73      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
size-64              921   1281     64   61    1 : tunables  120   60    0 : slabdata     21     21      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
size-32            52715  52955     32  119    1 : tunables  120   60    0 : slabdata    445    445      0
kmem_cache           124    124    128   31    1 : tunables  120   60    0 : slabdata      4      4      0

--------------010408070702010601080600--
