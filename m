Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbULQR0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbULQR0k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 12:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbULQR0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 12:26:40 -0500
Received: from mpc-26.sohonet.co.uk ([193.203.82.251]:209 "EHLO
	moving-picture.com") by vger.kernel.org with ESMTP id S261877AbULQR0W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 12:26:22 -0500
Message-ID: <41C316BC.1020909@moving-picture.com>
Date: Fri, 17 Dec 2004 17:26:20 +0000
From: James Pearson <james-p@moving-picture.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040524
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Reducing inode cache usage on 2.4?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Disclaimer: This email and any attachments are confidential, may be legally
X-Disclaimer: privileged and intended solely for the use of addressee. If you
X-Disclaimer: are not the intended recipient of this message, any disclosure,
X-Disclaimer: copying, distribution or any action taken in reliance on it is
X-Disclaimer: strictly prohibited and may be unlawful. If you have received
X-Disclaimer: this message in error, please notify the sender and delete all
X-Disclaimer: copies from your system.
X-Disclaimer: 
X-Disclaimer: Email may be susceptible to data corruption, interception and
X-Disclaimer: unauthorised amendment, and we do not accept liability for any
X-Disclaimer: such corruption, interception or amendment or the consequences
X-Disclaimer: thereof.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an NFS server with 1Gb RAM running a 2.4.26 kernel with 2 XFS 
file systems with about 2 million files in total.

Occasionally I get reports that the server is 'sticky' (slow 
read/writes) and the inode cache appears to consume most of the 
available memory and doesn't appear to reduce - a typical /proc/slabinfo 
output is below.

If I run a simple application that grabs memory on the server, the inode 
and other caches are reduced and the server becomes more responsive 
(i.e. data rates to/from the server are restored to 'normal').

Is there anyway I can purge the cached inode data, or any kernel 
parameters I can tweak to limit the inode cache or flush it more frequently?

Or am I looking in completely the wrong place i.e. the inode cache is 
not the problem?

Thanks

James Pearson

/proc/slabinfo:

slabinfo - version: 1.1 (SMP)
kmem_cache           104    104    148    4    4    1 :  252  126
nfs_write_data         0      0    352    0    0    1 :  124   62
nfs_read_data          0      0    352    0    0    1 :  124   62
nfs_page               0      0     96    0    0    1 :  252  126
ip_fib_hash           10    226     32    2    2    1 :  252  126
clip_arp_cache         0      0    128    0    0    1 :  252  126
ip_mrt_cache           0      0     96    0    0    1 :  252  126
tcp_tw_bucket         40     40     96    1    1    1 :  252  126
tcp_bind_bucket      143    226     32    2    2    1 :  252  126
tcp_open_request      59     59     64    1    1    1 :  252  126
inet_peer_cache       55    236     64    4    4    1 :  252  126
ip_dst_cache         520    520    192   26   26    1 :  252  126
arp_cache             47    210    128    7    7    1 :  252  126
blkdev_requests     5120   5160     96  129  129    1 :  252  126
xfs_chashlist      35838  40560     20  240  240    1 :  252  126
xfs_ili             6664   8652    140  309  309    1 :  252  126
xfs_ifork              0      0     56    0    0    1 :  252  126
xfs_efi_item          15     15    260    1    1    1 :  124   62
xfs_efd_item          15     15    260    1    1    1 :  124   62
xfs_buf_item         130    130    148    5    5    1 :  252  126
xfs_dabuf            202    202     16    1    1    1 :  252  126
xfs_da_state           0      0    336    0    0    1 :  124   62
xfs_trans             81    143    596    9   11    2 :  124   62
xfs_inode         931428 931428    408 103492 103492    1 :  124   62
xfs_btree_cur         58     58    132    2    2    1 :  252  126
xfs_bmap_free_item    252    253     12    1    1    1 :  252  126
page_buf_t           200    200    192   10   10    1 :  252  126
linvfs_icache     931425 931425    352 84675 84675    1 :  124   62
dnotify_cache          0      0     20    0    0    1 :  252  126
file_lock_cache       80     80     96    2    2    1 :  252  126
fasync_cache           0      0     16    0    0    1 :  252  126
uid_cache              8    113     32    1    1    1 :  252  126
skbuff_head_cache    673    680    192   34   34    1 :  252  126
sock                  75     75   1216   25   25    1 :   60   30
sigqueue              58     58    132    2    2    1 :  252  126
kiobuf                 0      0     64    0    0    1 :  252  126
cdev_cache            11    177     64    3    3    1 :  252  126
bdev_cache             5    118     64    2    2    1 :  252  126
mnt_cache             19    177     64    3    3    1 :  252  126
inode_cache          217    217    512   31   31    1 :  124   62
dentry_cache      499222 518850    128 17295 17295    1 :  252  126
dquot                  0      0    128    0    0    1 :  252  126
filp                 486    600    128   20   20    1 :  252  126
names_cache            3      3   4096    3    3    1 :   60   30
buffer_head        31305  34400     96  860  860    1 :  252  126
mm_struct            120    120    160    5    5    1 :  252  126
vm_area_struct       861    880     96   22   22    1 :  252  126
fs_cache             177    177     64    3    3    1 :  252  126
files_cache           63     63    416    7    7    1 :  124   62
signal_act            72     72   1312   24   24    1 :   60   30
size-131072(DMA)       0      0 131072    0    0   32 :    0    0
size-131072            0      0 131072    0    0   32 :    0    0
size-65536(DMA)        0      0  65536    0    0   16 :    0    0
size-65536             0      0  65536    0    0   16 :    0    0
size-32768(DMA)        0      0  32768    0    0    8 :    0    0
size-32768            24     24  32768   24   24    8 :    0    0
size-16384(DMA)        0      0  16384    0    0    4 :    0    0
size-16384            16     18  16384   16   18    4 :    0    0
size-8192(DMA)         0      0   8192    0    0    2 :    0    0
size-8192              7      8   8192    7    8    2 :    0    0
size-4096(DMA)         0      0   4096    0    0    1 :   60   30
size-4096            385    385   4096  385  385    1 :   60   30
size-2048(DMA)         0      0   2048    0    0    1 :   60   30
size-2048           1952   1952   2048  976  976    1 :   60   30
size-1024(DMA)         0      0   1024    0    0    1 :  124   62
size-1024            476    476   1024  119  119    1 :  124   62
size-512(DMA)          0      0    512    0    0    1 :  124   62
size-512             344    344    512   43   43    1 :  124   62
size-256(DMA)          0      0    256    0    0    1 :  252  126
size-256             892   1335    256   89   89    1 :  252  126
size-128(DMA)          0      0    128    0    0    1 :  252  126
size-128            4087   8130    128  271  271    1 :  252  126
size-64(DMA)           0      0     64    0    0    1 :  252  126
size-64            65813  90683     64 1537 1537    1 :  252  126
size-32(DMA)           0      0     32    0    0    1 :  252  126
size-32           421038 421038     32 3726 3726    1 :  252  126

/proc/meminfo:

         total:    used:    free:  shared: buffers:  cached:
Mem:  1057779712 1034821632 22958080        0    36864 136249344
Swap: 2147459072  2015232 2145443840
MemTotal:      1032988 kB
MemFree:         22420 kB
MemShared:           0 kB
Buffers:            36 kB
Cached:         132032 kB
SwapCached:       1024 kB
Active:          29204 kB
Inactive:       113520 kB
HighTotal:      131072 kB
HighFree:         7864 kB
LowTotal:       901916 kB
LowFree:         14556 kB
SwapTotal:     2097128 kB
SwapFree:      2095160 kB

