Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262017AbSIYQJU>; Wed, 25 Sep 2002 12:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262018AbSIYQJU>; Wed, 25 Sep 2002 12:09:20 -0400
Received: from h24-87-160-169.vn.shawcable.net ([24.87.160.169]:44162 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S262017AbSIYQJS>;
	Wed, 25 Sep 2002 12:09:18 -0400
Date: Wed, 25 Sep 2002 09:14:31 -0700
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: [2.5.38] file_lock_cache leak
Message-ID: <20020925161431.GA13576@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering why my box was getting slower and slower... :)
I'm running galeon, mutt, rxvts, etc... Nothing very special.

file_lock_cache   1568120 1568120     96 39203 39203    1 :  252  126

...Entire slabinfo:

slabinfo - version: 1.1 (SMP)
kmem_cache           102    102    228    6    6    1 :  252  126
ip_fib_hash            9    113     32    1    1    1 :  252  126
ip_conntrack           0      0    320    0    0    1 :  124   62
unix_sock             50     50    384    5    5    1 :  124   62
tcp_tw_bucket          0      0     96    0    0    1 :  252  126
tcp_bind_bucket       15    113     32    1    1    1 :  252  126
tcp_open_request       0      0     64    0    0    1 :  252  126
inet_peer_cache        1     59     64    1    1    1 :  252  126
ip_dst_cache          14     60    192    3    3    1 :  252  126
arp_cache              2     30    128    1    1    1 :  252  126
raw4_sock              0      0    384    0    0    1 :  124   62
udp_sock               9     10    384    1    1    1 :  124   62
tcp_sock              26     30    800    6    6    1 :  124   62
uhci_urb_priv          1     63     60    1    1    1 :  252  126
sgpool-MAX_PHYS_SEGMENTS     32     32   2048   16   16    1 :   60   30
sgpool-64             32     32   1024    8    8    1 :  124   62
sgpool-32             32     32    512    4    4    1 :  124   62
sgpool-16             32     45    256    3    3    1 :  252  126
sgpool-8              32     60    128    2    2    1 :  252  126
blkdev_requests     1536   1590    128   53   53    1 :  252  126
udf_inode_cache        0      0    384    0    0    1 :  124   62
smb_request            0      0    256    0    0    1 :  252  126
smb_inode_cache        0      0    352    0    0    1 :  124   62
nfs_write_data         0      0    352    0    0    1 :  124   62
nfs_read_data          0      0    352    0    0    1 :  124   62
nfs_inode_cache        5     49    512    1    7    1 :  124   62
nfs_page               0      0     96    0    0    1 :  252  126
isofs_inode_cache      0      0    320    0    0    1 :  124   62
fat_inode_cache        0      0    352    0    0    1 :  124   62
minix_inode_cache      0      0    384    0    0    1 :  124   62
ext2_inode_cache       1      9    416    1    1    1 :  124   62
journal_head          78     78     48    1    1    1 :  252  126
revoke_table           2    253     12    1    1    1 :  252  126
revoke_record          0      0     32    0    0    1 :  252  126
ext3_inode_cache     476   1404    448  148  156    1 :  124   62
kioctx                 0      0    128    0    0    1 :  252  126
kiocb                  0      0    128    0    0    1 :  252  126
dnotify cache          0      0     20    0    0    1 :  252  126
file_lock_cache   1568760 1568760     96 39219 39219    1 :  252  126
fasync_cache           2    202     16    1    1    1 :  252  126
biovec-BIO_MAX_PAGES    256    260   3072   52   52    4 :   60   30
biovec-128           256    260   1536   52   52    2 :   60   30
biovec-64            256    260    768   52   52    1 :  124   62
biovec-16            260    260    192   13   13    1 :  252  126
biovec-4             257    295     64    5    5    1 :  252  126
biovec-1             480    606     16    3    3    1 :  252  126
bio                  464    590     64   10   10    1 :  252  126
shmem_inode_cache      3     18    416    2    2    1 :  124   62
uid_cache              4    113     32    1    1    1 :  252  126
sock_inode_cache     121    121    352   11   11    1 :  124   62
skbuff_head_cache    198    312    160   13   13    1 :  252  126
sock                   2     12    320    1    1    1 :  124   62
proc_inode_cache     353    492    320   41   41    1 :  124   62
sigqueue              29     29    132    1    1    1 :  252  126
radix_tree_node     1638   2353    288  181  181    1 :  124   62
cdev_cache            47    177     64    3    3    1 :  252  126
bdev_cache             7     40     96    1    1    1 :  252  126
mnt_cache             17     59     64    1    1    1 :  252  126
inode_cache          248    252    320   21   21    1 :  124   62
dentry_cache        1134   3180    128  106  106    1 :  252  126
filp                1033   1050    128   35   35    1 :  252  126
names_cache            1      2   4096    1    2    1 :   60   30
buffer_head          835   3666     48   47   47    1 :  252  126
mm_struct             66     78    288    6    6    1 :  124   62
vm_area_struct      1521   2080     96   52   52    1 :  252  126
fs_cache              64    118     64    2    2    1 :  252  126
files_cache           64     72    416    8    8    1 :  124   62
signal_act            84     84   1344   28   28    1 :   60   30
task_struct          100    117   1760   13   13    4 :   60   30
pte_chain           7490  13786     32  122  122    1 :  252  126
size-131072 (DMA)      0      0 131072    0    0   32 :    0    0
size-131072            0      0 131072    0    0   32 :    0    0
size-65536 (DMA)       0      0  65536    0    0   16 :    0    0
size-65536             8      8  65536    8    8   16 :    0    0
size-32768 (DMA)       0      0  32768    0    0    8 :    0    0
size-32768             0      0  32768    0    0    8 :    0    0
size-16384 (DMA)       0      0  16384    0    0    4 :    0    0
size-16384             1      3  16384    1    3    4 :    0    0
size-8192 (DMA)        0      0   8192    0    0    2 :    0    0
size-8192              4      5   8192    4    5    2 :    0    0
size-4096 (DMA)        0      0   4096    0    0    1 :   60   30
size-4096             83     83   4096   83   83    1 :   60   30
size-2048 (DMA)        0      0   2048    0    0    1 :   60   30
size-2048             94     94   2048   47   47    1 :   60   30
size-1024 (DMA)        0      0   1024    0    0    1 :  124   62
size-1024            100    100   1024   25   25    1 :  124   62
size-512 (DMA)         0      0    512    0    0    1 :  124   62
size-512             128    128    512   16   16    1 :  124   62
size-256 (DMA)         0      0    256    0    0    1 :  252  126
size-256              75     75    256    5    5    1 :  252  126
size-192 (DMA)         0      0    192    0    0    1 :  252  126
size-192             100    100    192    5    5    1 :  252  126
size-128 (DMA)         0      0    128    0    0    1 :  252  126
size-128             237    240    128    8    8    1 :  252  126
size-96 (DMA)          0      0     96    0    0    1 :  252  126
size-96             1080   1080     96   27   27    1 :  252  126
size-64 (DMA)          0      0     64    0    0    1 :  252  126
size-64              406    826     64   14   14    1 :  252  126
size-32 (DMA)          0      0     32    0    0    1 :  252  126
size-32             1093   3729     32   33   33    1 :  252  126

             total       used       free     shared    buffers     cached
Mem:        256260     252852       3408          0        764      11196
-/+ buffers/cache:     240892      15368
Swap:       265064      93616     171448

Since writing this email, it's already up to 1574920...

Simon-

[        Simon Kirby        ][        Network Operations        ]
[     sim@netnation.com     ][     NetNation Communications     ]
[  Opinions expressed are not necessarily those of my employer. ]
