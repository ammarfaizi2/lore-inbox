Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267157AbSLaFug>; Tue, 31 Dec 2002 00:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267158AbSLaFug>; Tue, 31 Dec 2002 00:50:36 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:33158 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S267157AbSLaFuc> convert rfc822-to-8bit;
	Tue, 31 Dec 2002 00:50:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: conman@kolivas.net,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] vm swappiness with contest
Date: Tue, 31 Dec 2002 16:58:30 +1100
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>
References: <200212271646.01487.conman@kolivas.net> <200212272100.44345.conman@kolivas.net> <200212281716.50535.conman@kolivas.net>
In-Reply-To: <200212281716.50535.conman@kolivas.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212311658.53118.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 28 Dec 2002 5:16 pm, Con Kolivas wrote:
> Is there something about the filesystem layer or elsewhere in the kernel
> that could decay or fragment over time that only a reboot can fix? This
> would seem to be a bad thing.

Ok Linus suggested I check slabinfo before and after.

I ran contest for a few days till I recreated the problem and it did recur. I 
don't know how to interpret the information so I'll just dump it here:

before:
slabinfo - version: 1.2
unix_sock              6     18    416    2    2    1 :  120   60
tcp_tw_bucket          0      0     96    0    0    1 :  248  124
tcp_bind_bucket        2    113     32    1    1    1 :  248  124
tcp_open_request       0      0     64    0    0    1 :  248  124
inet_peer_cache        1     59     64    1    1    1 :  248  124
secpath_cache          0      0     32    0    0    1 :  248  124
flow_cache             0      0     64    0    0    1 :  248  124
xfrm4_dst_cache        0      0    224    0    0    1 :  248  124
ip_fib_hash           10    113     32    1    1    1 :  248  124
ip_dst_cache          16     17    224    1    1    1 :  248  124
arp_cache              3     30    128    1    1    1 :  248  124
raw4_sock              0      0    416    0    0    1 :  120   60
udp_sock               0      0    448    0    0    1 :  120   60
tcp_sock               6      9    864    1    1    2 :  120   60
reiser_inode_cache      0      0    384    0    0    1 :  120   60
ext2_inode_cache       0      0    448    0    0    1 :  120   60
journal_head          70    312     48    4    4    1 :  248  124
revoke_table           6    253     12    1    1    1 :  248  124
revoke_record          0      0     32    0    0    1 :  248  124
ext3_inode_cache    1206   1206    448  134  134    1 :  120   60
ext3_xattr             0      0     44    0    0    1 :  248  124
eventpoll pwq          0      0     36    0    0    1 :  248  124
eventpoll epi          0      0     64    0    0    1 :  248  124
kioctx                 0      0    192    0    0    1 :  248  124
kiocb                  0      0    160    0    0    1 :  248  124
dnotify_cache          0      0     20    0    0    1 :  248  124
file_lock_cache        9     40     96    1    1    1 :  248  124
fasync_cache           0      0     16    0    0    1 :  248  124
shmem_inode_cache      3      9    416    1    1    1 :  120   60
uid_cache              1    113     32    1    1    1 :  248  124
deadline_drq         768    780     48   10   10    1 :  248  124
blkdev_requests      768    784    136   28   28    1 :  248  124
biovec-BIO_MAX_PAGES    256    260   3072   52   52    4 :   54   27
biovec-128           256    260   1536   52   52    2 :   54   27
biovec-64            256    260    768   52   52    1 :  120   60
biovec-16            256    260    192   13   13    1 :  248  124
biovec-4             256    295     64    5    5    1 :  248  124
biovec-1             263    808     16    4    4    1 :  248  124
bio                  263    413     64    7    7    1 :  248  124
sock_inode_cache      15     20    384    2    2    1 :  120   60
skbuff_head_cache    162    168    160    7    7    1 :  248  124
sock                   3     11    352    1    1    1 :  120   60
proc_inode_cache      77     77    352    7    7    1 :  120   60
sigqueue               7     29    132    1    1    1 :  248  124
radix_tree_node     1118   1125    260   75   75    1 :  120   60
cdev_cache           361    413     64    7    7    1 :  248  124
bdev_cache            10     40     96    1    1    1 :  248  124
mnt_cache             18     59     64    1    1    1 :  248  124
inode_cache          244    264    320   22   22    1 :  120   60
dentry_cache        2373   2376    160   99   99    1 :  248  124
filp                 210    210    128    7    7    1 :  248  124
names_cache            1      1   4096    1    1    1 :   54   27
buffer_head          964   1014     48   13   13    1 :  248  124
mm_struct             30     30    384    3    3    1 :  120   60
vm_area_struct       413    413     64    7    7    1 :  248  124
fs_cache              31     59     64    1    1    1 :  248  124
files_cache           18     18    416    2    2    1 :  120   60
signal_act            27     27   1344    9    9    1 :   54   27
task_struct           35     35   1536    7    7    2 :   54   27
pte_chain           1130   1130     32   10   10    1 :  248  124
mm_chain              16    338      8    1    1    1 :  248  124
size-131072(DMA)       0      0 131072    0    0   32 :    8    4
size-131072            0      0 131072    0    0   32 :    8    4
size-65536(DMA)        0      0  65536    0    0   16 :    8    4
size-65536             0      0  65536    0    0   16 :    8    4
size-32768(DMA)        0      0  32768    0    0    8 :    8    4
size-32768             0      0  32768    0    0    8 :    8    4
size-16384(DMA)        0      0  16384    0    0    4 :    8    4
size-16384             0      0  16384    0    0    4 :    8    4
size-8192(DMA)         0      0   8192    0    0    2 :    8    4
size-8192              7      7   8192    7    7    2 :    8    4
size-4096(DMA)         0      0   4096    0    0    1 :   54   27
size-4096             22     22   4096   22   22    1 :   54   27
size-2048(DMA)         0      0   2048    0    0    1 :   54   27
size-2048            108    108   2048   54   54    1 :   54   27
size-1024(DMA)         0      0   1024    0    0    1 :  120   60
size-1024             80     80   1024   20   20    1 :  120   60
size-512(DMA)          0      0    512    0    0    1 :  120   60
size-512              96     96    512   12   12    1 :  120   60
size-256(DMA)          0      0    256    0    0    1 :  248  124
size-256              52     60    256    4    4    1 :  248  124
size-192(DMA)          0      0    192    0    0    1 :  248  124
size-192              20     20    192    1    1    1 :  248  124
size-128(DMA)          0      0    128    0    0    1 :  248  124
size-128              41     60    128    2    2    1 :  248  124
size-96(DMA)           0      0     96    0    0    1 :  248  124
size-96              448    480     96   12   12    1 :  248  124
size-64(DMA)           0      0     64    0    0    1 :  248  124
size-64              177    177     64    3    3    1 :  248  124
size-32(DMA)           0      0     32    0    0    1 :  248  124
size-32              289    339     32    3    3    1 :  248  124
kmem_cache            99     99    116    3    3    1 :  248  124


After:
unix_sock              3     18    416    2    2    1 :  120   60
tcp_tw_bucket          0      0     96    0    0    1 :  248  124
tcp_bind_bucket        2    113     32    1    1    1 :  248  124
tcp_open_request       0      0     64    0    0    1 :  248  124
inet_peer_cache        0      0     64    0    0    1 :  248  124
secpath_cache          0      0     32    0    0    1 :  248  124
flow_cache             0      0     64    0    0    1 :  248  124
xfrm4_dst_cache        0      0    224    0    0    1 :  248  124
ip_fib_hash           10    113     32    1    1    1 :  248  124
ip_dst_cache          23     51    224    3    3    1 :  248  124
arp_cache              1     30    128    1    1    1 :  248  124
raw4_sock              0      0    416    0    0    1 :  120   60
udp_sock               0      0    448    0    0    1 :  120   60
tcp_sock               6      9    864    1    1    2 :  120   60
reiser_inode_cache      0      0    384    0    0    1 :  120   60
ext2_inode_cache       0      0    448    0    0    1 :  120   60
journal_head         113   2028     48   26   26    1 :  248  124
revoke_table           6    253     12    1    1    1 :  248  124
revoke_record          0      0     32    0    0    1 :  248  124
ext3_inode_cache    1361   2277    448  253  253    1 :  120   60
ext3_xattr             0      0     44    0    0    1 :  248  124
eventpoll pwq          0      0     36    0    0    1 :  248  124
eventpoll epi          0      0     64    0    0    1 :  248  124
kioctx                 0      0    192    0    0    1 :  248  124
kiocb                  0      0    160    0    0    1 :  248  124
dnotify_cache          0      0     20    0    0    1 :  248  124
file_lock_cache       10     40     96    1    1    1 :  248  124
fasync_cache           0      0     16    0    0    1 :  248  124
shmem_inode_cache      3      9    416    1    1    1 :  120   60
uid_cache              0      0     32    0    0    1 :  248  124
deadline_drq         768    780     48   10   10    1 :  248  124
blkdev_requests      768    784    136   28   28    1 :  248  124
biovec-BIO_MAX_PAGES    256    260   3072   52   52    4 :   54   27
biovec-128           256    260   1536   52   52    2 :   54   27
biovec-64            256    260    768   52   52    1 :  120   60
biovec-16            256    260    192   13   13    1 :  248  124
biovec-4             256    295     64    5    5    1 :  248  124
biovec-1             333    404     16    2    2    1 :  248  124
bio                  295    295     64    5    5    1 :  248  124
sock_inode_cache      13     20    384    2    2    1 :  120   60
skbuff_head_cache    232    288    160   12   12    1 :  248  124
sock                   3     11    352    1    1    1 :  120   60
proc_inode_cache      72     88    352    8    8    1 :  120   60
sigqueue              13     29    132    1    1    1 :  248  124
radix_tree_node     2039   2460    260  164  164    1 :  120   60
cdev_cache            12    118     64    2    2    1 :  248  124
bdev_cache            10     40     96    1    1    1 :  248  124
mnt_cache             18     59     64    1    1    1 :  248  124
inode_cache          244    264    320   22   22    1 :  120   60
dentry_cache        2214   5016    160  209  209    1 :  248  124
filp                 775    780    128   26   26    1 :  248  124
names_cache            1      1   4096    1    1    1 :   54   27
buffer_head        46507  58500     48  750  750    1 :  248  124
mm_struct             30     30    384    3    3    1 :  120   60
vm_area_struct       415    944     64   16   16    1 :  248  124
fs_cache              30    118     64    2    2    1 :  248  124
files_cache           27     27    416    3    3    1 :  120   60
signal_act            27     27   1344    9    9    1 :   54   27
task_struct           40     40   1536    8    8    2 :   54   27
pte_chain            415   1808     32   16   16    1 :  248  124
mm_chain             125    338      8    1    1    1 :  248  124
size-131072(DMA)       0      0 131072    0    0   32 :    8    4
size-131072            0      0 131072    0    0   32 :    8    4
size-65536(DMA)        0      0  65536    0    0   16 :    8    4
size-65536             0      0  65536    0    0   16 :    8    4
size-32768(DMA)        0      0  32768    0    0    8 :    8    4
size-32768             0      0  32768    0    0    8 :    8    4
size-16384(DMA)        0      0  16384    0    0    4 :    8    4
size-16384             0      0  16384    0    0    4 :    8    4
size-8192(DMA)         0      0   8192    0    0    2 :    8    4
size-8192              7      7   8192    7    7    2 :    8    4
size-4096(DMA)         0      0   4096    0    0    1 :   54   27
size-4096             22     22   4096   22   22    1 :   54   27
size-2048(DMA)         0      0   2048    0    0    1 :   54   27
size-2048            106    106   2048   53   53    1 :   54   27
size-1024(DMA)         0      0   1024    0    0    1 :  120   60
size-1024             84     84   1024   21   21    1 :  120   60
size-512(DMA)          0      0    512    0    0    1 :  120   60
size-512             144    144    512   18   18    1 :  120   60
size-256(DMA)          0      0    256    0    0    1 :  248  124
size-256              73     75    256    5    5    1 :  248  124
size-192(DMA)          0      0    192    0    0    1 :  248  124
size-192              20     20    192    1    1    1 :  248  124
size-128(DMA)          0      0    128    0    0    1 :  248  124
size-128              41     60    128    2    2    1 :  248  124
size-96(DMA)           0      0     96    0    0    1 :  248  124
size-96              436    480     96   12   12    1 :  248  124
size-64(DMA)           0      0     64    0    0    1 :  248  124
size-64              183    236     64    4    4    1 :  248  124
size-32(DMA)           0      0     32    0    0    1 :  248  124
size-32              246    904     32    8    8    1 :  248  124
kmem_cache            99     99    116    3    3    1 :  248  124

The biggest change I can see is buffer head.

The machine has been kept online in that state so I can extract more info if 
needed.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+ETIGF6dfvkL3i1gRAqjpAKCjxltSBwAus/RkLC+E32ZpI0GAYACgldf8
qgYP9oNr0nrco1oCQm8Wakg=
=Uj/q
-----END PGP SIGNATURE-----
