Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVBSMig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVBSMig (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 07:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVBSMig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 07:38:36 -0500
Received: from salazar.rnl.ist.utl.pt ([193.136.164.251]:8162 "EHLO
	admin.rnl.ist.utl.pt") by vger.kernel.org with ESMTP
	id S261703AbVBSMiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 07:38:00 -0500
Message-ID: <42173323.5060807@arrakis.dhis.org>
Date: Sat, 19 Feb 2005 12:37:55 +0000
From: Pedro Venda <pjvenda@arrakis.dhis.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: possible leak in kernel 2.6.10-ac12
References: <4213D70F.20104@arrakis.dhis.org> <200502161835.26047.kernel-stuff@comcast.net>
In-Reply-To: <200502161835.26047.kernel-stuff@comcast.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Parag Warudkar wrote:
| On Wednesday 16 February 2005 06:28 pm, Pedro Venda wrote:
|
|>Having upgraded most of them to 2.6.10-ac12, one of them showed a linear
|>growth of used memory over the last 7 days, after the first 2.6.10-ac12
|>boot. It came to a point that it started swapping and the swap usage too
|>started to grow linearly.
|
|
| cat /proc/slabinfo please. I am also seeing similar symptoms (although that is
| with 2.6.11-rc4 there is a possibility of a common bug) here and I seem to
| have linearly growing size-64 in slabinfo.
|

hi

I've read the leak thread above possibly about this bug... AFAI read, there isn't
really a conclusion about this leak, right?

here goes the /proc/slabinfo for 2 days uptime:

admin proc # uptime
~ 12:29:18 up 2 days, 14:23,  2 users,  load average: 0.29, 0.38, 0.24
admin proc # cat slabinfo
slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs>
<num_slabs> <sharedavail>
ip_conntrack_expect      0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
ip_conntrack         230    820    384   10    1 : tunables   54   27    0 : slabdata     82     82      0
xfrm6_tunnel_spi       0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
fib6_nodes             8    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
ip6_dst_cache          6     15    256   15    1 : tunables  120   60    0 : slabdata      1      1      0
ndisc_cache            1     15    256   15    1 : tunables  120   60    0 : slabdata      1      1      0
rawv6_sock             3      6    640    6    1 : tunables   54   27    0 : slabdata      1      1      0
udpv6_sock             6      6    640    6    1 : tunables   54   27    0 : slabdata      1      1      0
tcpv6_sock            10     14   1152    7    2 : tunables   24   12    0 : slabdata      2      2      0
unix_sock            371    620    384   10    1 : tunables   54   27    0 : slabdata     62     62      0
tcp_tw_bucket         31     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_bind_bucket       81    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_open_request      16     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
inet_peer_cache        3     61     64   61    1 : tunables  120   60    0 : slabdata      1      1      0
secpath_cache          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
xfrm_dst_cache         0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
ip_fib_alias          10    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
ip_fib_hash           10    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
ip_dst_cache         193    285    256   15    1 : tunables  120   60    0 : slabdata     19     19      0
arp_cache              3     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
raw_sock               2      7    512    7    1 : tunables   54   27    0 : slabdata      1      1      0
udp_sock              14     14    512    7    1 : tunables   54   27    0 : slabdata      2      2      0
tcp_sock              21     52   1024    4    1 : tunables   54   27    0 : slabdata     13     13      0
flow_cache             0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
cfq_ioc_pool           0      0     24  156    1 : tunables  120   60    0 : slabdata      0      0      0
cfq_pool               0      0    104   38    1 : tunables  120   60    0 : slabdata      0      0      0
crq_pool               0      0     52   75    1 : tunables  120   60    0 : slabdata      0      0      0
deadline_drq           0      0     48   81    1 : tunables  120   60    0 : slabdata      0      0      0
as_arq               135    260     60   65    1 : tunables  120   60    0 : slabdata      4      4      0
mqueue_inode_cache      1      7    512    7    1 : tunables   54   27    0 : slabdata      1      1      0
udf_inode_cache        0      0    348   11    1 : tunables   54   27    0 : slabdata      0      0      0
ntfs_big_inode_cache      0      0    512    7    1 : tunables   54   27    0 : slabdata      0      0      0
ntfs_inode_cache       0      0    156   25    1 : tunables  120   60    0 : slabdata      0      0      0
ntfs_name_cache        0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
ntfs_attr_ctx_cache      0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
ntfs_index_ctx_cache      0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
devfsd_event           0      0     20  185    1 : tunables  120   60    0 : slabdata      0      0      0
isofs_inode_cache      0      0    320   12    1 : tunables   54   27    0 : slabdata      0      0      0
fat_inode_cache        0      0    348   11    1 : tunables   54   27    0 : slabdata      0      0      0
fat_cache              0      0     20  185    1 : tunables  120   60    0 : slabdata      0      0      0
ext2_inode_cache       0      0    420    9    1 : tunables   54   27    0 : slabdata      0      0      0
ext2_xattr             0      0     44   88    1 : tunables  120   60    0 : slabdata      0      0      0
journal_handle         0      0     20  185    1 : tunables  120   60    0 : slabdata      0      0      0
journal_head           0      0     48   81    1 : tunables  120   60    0 : slabdata      0      0      0
revoke_table           0      0     12  290    1 : tunables  120   60    0 : slabdata      0      0      0
revoke_record          0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
ext3_inode_cache       0      0    476    8    1 : tunables   54   27    0 : slabdata      0      0      0
ext3_xattr             0      0     44   88    1 : tunables  120   60    0 : slabdata      0      0      0
reiser_inode_cache   3620   5533    368   11    1 : tunables   54   27    0 : slabdata    503    503      0
dnotify_cache          0      0     20  185    1 : tunables  120   60    0 : slabdata      0      0      0
dquot                  0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_epi          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
kioctx                 0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
kiocb                  0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
fasync_cache           0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
shmem_inode_cache      4     10    384   10    1 : tunables   54   27    0 : slabdata      1      1      0
posix_timers_cache      0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache              5     61     64   61    1 : tunables  120   60    0 : slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    0 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    0 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    0 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    0 : slabdata      3      3      0
sgpool-8              32     62    128   31    1 : tunables  120   60    0 : slabdata      2      2      0
blkdev_ioc            74    312     24  156    1 : tunables  120   60    0 : slabdata      2      2      0
blkdev_queue           8     11    352   11    1 : tunables   54   27    0 : slabdata      1      1      0
blkdev_requests      136    196    140   28    1 : tunables  120   60    0 : slabdata      7      7      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    0 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    0 : slabdata     52     52      0
biovec-16            256    270    256   15    1 : tunables  120   60    0 : slabdata     18     18      0
biovec-4             256    305     64   61    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1          1989252 1989478     16  226    1 : tunables  120   60    0 : slabdata   8803   8803      0
bio               1989270 1989271     64   61    1 : tunables  120   60    0 : slabdata  32611  32611      0
file_lock_cache      176    270     88   45    1 : tunables  120   60    0 : slabdata      6      6      0
sock_inode_cache     423    710    384   10    1 : tunables   54   27    0 : slabdata     71     71      0
skbuff_head_cache    165    165    256   15    1 : tunables  120   60    0 : slabdata     11     11      0
sock                   4     10    384   10    1 : tunables   54   27    0 : slabdata      1      1      0
proc_inode_cache     686    923    308   13    1 : tunables   54   27    0 : slabdata     71     71      0
sigqueue               8     27    148   27    1 : tunables  120   60    0 : slabdata      1      1      0
radix_tree_node     4899   7854    276   14    1 : tunables   54   27    0 : slabdata    561    561      0
bdev_cache            14     14    512    7    1 : tunables   54   27    0 : slabdata      2      2      0
mnt_cache             18     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
inode_cache          697    754    292   13    1 : tunables   54   27    0 : slabdata     58     58      0
dentry_cache       10003  20300    136   29    1 : tunables  120   60    0 : slabdata    700    700      0
filp                3840   5220    256   15    1 : tunables  120   60    0 : slabdata    348    348      0
names_cache           18     18   4096    1    1 : tunables   24   12    0 : slabdata     18     18      0
idr_layer_cache       81     87    136   29    1 : tunables  120   60    0 : slabdata      3      3      0
buffer_head        31554  45684     48   81    1 : tunables  120   60    0 : slabdata    564    564      0
mm_struct            187    210    640    6    1 : tunables   54   27    0 : slabdata     35     35      0
vm_area_struct      7446   9259     84   47    1 : tunables  120   60    0 : slabdata    197    197      0
fs_cache             169    476     32  119    1 : tunables  120   60    0 : slabdata      4      4      0
files_cache          187    210    512    7    1 : tunables   54   27    0 : slabdata     30     30      0
signal_cache         178    270    256   15    1 : tunables  120   60    0 : slabdata     18     18      0
sighand_cache        185    210   1408    5    2 : tunables   24   12    0 : slabdata     42     42      0
task_struct          189    207   1248    3    1 : tunables   24   12    0 : slabdata     69     69      0
anon_vma            3946   9361      8  407    1 : tunables  120   60    0 : slabdata     23     23      0
pgd                  162    162   4096    1    1 : tunables   24   12    0 : slabdata    162    162      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192              1      1   8192    1    2 : tunables    8    4    0 : slabdata      1      1      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096            414    414   4096    1    1 : tunables   24   12    0 : slabdata    414    414      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048            100    122   2048    2    1 : tunables   24   12    0 : slabdata     61     61      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024            244    260   1024    4    1 : tunables   54   27    0 : slabdata     65     65      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512             165    192    512    8    1 : tunables   54   27    0 : slabdata     24     24      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256             330    330    256   15    1 : tunables  120   60    0 : slabdata     22     22      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
size-128            3863   4123    128   31    1 : tunables  120   60    0 : slabdata    133    133      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
size-64             4767   5368     64   61    1 : tunables  120   60    0 : slabdata     88     88      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
size-32             3728   5593     32  119    1 : tunables  120   60    0 : slabdata     47     47      0
kmem_cache           124    124    128   31    1 : tunables  120   60    0 : slabdata      4      4      0
admin proc #

regards,
pedro venda.
- --

Pedro João Lopes Venda
email: pjvenda < at > arrakis.dhis.org
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCFzMjeRy7HWZxjWERAqjKAJwILYhyoI/IfbKmWjfrkF2ZgSUmfQCg0jQJ
KwU6Z4/+hLa0ONF58kZ44GE=
=9shv
-----END PGP SIGNATURE-----
