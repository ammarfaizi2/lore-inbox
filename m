Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbVJZS4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbVJZS4B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 14:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbVJZS4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 14:56:01 -0400
Received: from new.email-server.info ([213.133.109.44]:19591 "EHLO
	hetzner.email-server.info") by vger.kernel.org with ESMTP
	id S964860AbVJZS4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 14:56:00 -0400
Message-ID: <435FD223.70904@mid.email-server.info>
Date: Wed, 26 Oct 2005 20:59:47 +0200
From: Alexander Skwar <listen@alexander.skwar.name>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050809)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailingliste <linux-kernel@vger.kernel.org>
Subject: Another report of "kernel BUG at mm/slab.c:2839!".
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Just like Anthony Martinez <pi <at> pihost.us> reported
at  2005-09-24 17:35:43, I'm also hitting kernel BUG at mm/slab.c:2839!.

I cannot really reproduce it. It just happens from
time to time.

[15:21:02 vz6tml@dewup-ww02:~] $ uname -a
Linux dewup-ww02 2.6.13-ck8.03.reiser-stat.megaraid_newgen.no-preempt #2 SMP Mon Oct 24 10:01:43 CEST 2005 i686 Intel(R) Xeon(TM) CPU 2.40GHz
GenuineIntel GNU/Linux

[15:21:30 vz6tml@dewup-ww02:~] $ cat /proc/version
Linux version 2.6.13-ck8.03.reiser-stat.megaraid_newgen.no-preempt (root@dewup-ww02) (gcc-Version 3.4.4 (Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8))
#2 SMP Mon Oct 24
10:01:43 CEST 2005
[15:21:33 vz6tml@dewup-ww02:~] $ cat /proc/slabinfo
slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata
<active_slabs> <num_slabs>
<sharedavail>
nfs_write_data        36     42    512    7    1 : tunables   54   27    8 : slabdata      6      6      0
nfs_read_data         32     35    512    7    1 : tunables   54   27    8 : slabdata      5      5      0
nfs_inode_cache     1358   1362    660    6    1 : tunables   54   27    8 : slabdata    227    227      0
nfs_page               0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
nfsd4_delegations      0      0    596   13    2 : tunables   54   27    8 : slabdata      0      0      0
nfsd4_stateids         0      0     72   55    1 : tunables  120   60    8 : slabdata      0      0      0
nfsd4_files            0      0     36  107    1 : tunables  120   60    8 : slabdata      0      0      0
nfsd4_stateowners      0      0    344   11    1 : tunables   54   27    8 : slabdata      0      0      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12    8 : slabdata      4      4      0
rpc_tasks              8     15    256   15    1 : tunables  120   60    8 : slabdata      1      1      0
rpc_inode_cache        8     14    512    7    1 : tunables   54   27    8 : slabdata      2      2      0
ext3_inode_cache       6     14    524    7    1 : tunables   54   27    8 : slabdata      2      2      0
ext3_xattr             0      0     44   88    1 : tunables  120   60    8 : slabdata      0      0      0
journal_handle         0      0     20  185    1 : tunables  120   60    8 : slabdata      0      0      0
journal_head           0      0     52   75    1 : tunables  120   60    8 : slabdata      0      0      0
revoke_table           6    290     12  290    1 : tunables  120   60    8 : slabdata      1      1      0
revoke_record          0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
unionfs_dentry      3226   3240     48   81    1 : tunables  120   60    8 : slabdata     40     40      0
unionfs_inode_cache   2874   2889    420    9    1 : tunables   54   27    8 : slabdata    321    321      0
unionfs_filldir        0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
UNIX                 328    329    512    7    1 : tunables   54   27    8 : slabdata     47     47      0
tcp_tw_bucket          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
tcp_bind_bucket       45    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
inet_peer_cache        4     61     64   61    1 : tunables  120   60    8 : slabdata      1      1      0
ip_fib_alias          10    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
ip_fib_hash           10    119     32  119    1 : tunables  120   60    8 : slabdata      1      1      0
ip_dst_cache          40     60    256   15    1 : tunables  120   60    8 : slabdata      4      4      0
arp_cache              4     15    256   15    1 : tunables  120   60    8 : slabdata      1      1      0
RAW                    5      7    512    7    1 : tunables   54   27    8 : slabdata      1      1      0
UDP                   18     28    512    7    1 : tunables   54   27    8 : slabdata      4      4      0
request_sock_TCP       0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
TCP                   51     56   1024    4    1 : tunables   54   27    8 : slabdata     14     14      0
dm-snapshot-in       128    162     48   81    1 : tunables  120   60    8 : slabdata      2      2      0
dm-snapshot-ex         0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
dm_tio              4608   4746     16  226    1 : tunables  120   60    8 : slabdata     21     21      0
dm_io               4608   4746     16  226    1 : tunables  120   60    8 : slabdata     21     21      0
scsi_cmd_cache         1     10    384   10    1 : tunables   54   27    8 : slabdata      1      1      0
cfq_ioc_pool          66    162     48   81    1 : tunables  120   60    8 : slabdata      2      2      0
cfq_pool              66    123     96   41    1 : tunables  120   60    8 : slabdata      3      3      0
crq_pool             488    616     44   88    1 : tunables  120   60    8 : slabdata      7      7      0
mqueue_inode_cache      1      6    640    6    1 : tunables   54   27    8 : slabdata      1      1      0
xfs_acl                0      0    304   13    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_chashlist        968   1110     20  185    1 : tunables  120   60    8 : slabdata      6      6      0
xfs_ili                3     28    140   28    1 : tunables  120   60    8 : slabdata      1      1      0
xfs_ifork              0      0     56   70    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_efi_item           0      0    260   15    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_efd_item           0      0    260   15    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_buf_item           0      0    148   27    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_dabuf              0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_da_state           0      0    336   12    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_trans              0      0    596   13    2 : tunables   54   27    8 : slabdata      0      0      0
xfs_inode           8206   8217    368   11    1 : tunables   54   27    8 : slabdata    747    747      0
xfs_btree_cur          0      0    132   30    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_bmap_free_item      0      0     12  290    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_buf               80    108    224   18    1 : tunables  120   60    8 : slabdata      6      6      0
linvfs_icache       8206   8220    400   10    1 : tunables   54   27    8 : slabdata    822    822      0
cifs_small_rq         30     30    256   15    1 : tunables  120   60    8 : slabdata      2      2      0
cifs_request           4      4  16640    1    8 : tunables    8    4    0 : slabdata      4      4      0
cifs_oplock_structs      0      0     32  119    1 : tunables  120   60    8 : slabdata      0      0      0
cifs_mpx_ids           3     61     64   61    1 : tunables  120   60    8 : slabdata      1      1      0
cifs_inode_cache       0      0    404   10    1 : tunables   54   27    8 : slabdata      0      0      0
ext2_inode_cache       1      8    504    8    1 : tunables   54   27    8 : slabdata      1      1      0
ext2_xattr             0      0     44   88    1 : tunables  120   60    8 : slabdata      0      0      0
reiser_inode_cache   3621   3627    448    9    1 : tunables   54   27    8 : slabdata    403    403      0
dnotify_cache          2    185     20  185    1 : tunables  120   60    8 : slabdata      1      1      0
eventpoll_pwq          2    107     36  107    1 : tunables  120   60    8 : slabdata      1      1      0
eventpoll_epi          2     31    128   31    1 : tunables  120   60    8 : slabdata      1      1      0
inotify_event_cache      0      0     28  135    1 : tunables  120   60    8 : slabdata      0      0      0
inotify_watch_cache     86    214     36  107    1 : tunables  120   60    8 : slabdata      2      2      0
kioctx                 0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
kiocb                  0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
fasync_cache           0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
shmem_inode_cache    742    760    464    8    1 : tunables   54   27    8 : slabdata     95     95      0
swapped_entry          0      0     12  290    1 : tunables  120   60    8 : slabdata      0      0      0
posix_timers_cache      0      0    100   39    1 : tunables  120   60    8 : slabdata      0      0      0
uid_cache             10     61     64   61    1 : tunables  120   60    8 : slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    8 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    8 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    8 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    8 : slabdata      3      3      0
sgpool-8              32     62    128   31    1 : tunables  120   60    8 : slabdata      2      2      0
blkdev_ioc            66    135     28  135    1 : tunables  120   60    8 : slabdata      1      1      0
blkdev_queue         148    160    396   10    1 : tunables   54   27    8 : slabdata     16     16      0
blkdev_requests      488    494    152   26    1 : tunables  120   60    8 : slabdata     19     19      0
biovec-(256)         260    260   3072    2    2 : tunables   24   12    8 : slabdata    130    130      0
biovec-128           264    265   1536    5    2 : tunables   24   12    8 : slabdata     53     53      0
biovec-64            272    275    768    5    1 : tunables   54   27    8 : slabdata     55     55      0
biovec-16            272    285    256   15    1 : tunables  120   60    8 : slabdata     19     19      0
biovec-4             272    305     64   61    1 : tunables  120   60    8 : slabdata      5      5      0
biovec-1             272    452     16  226    1 : tunables  120   60    8 : slabdata      2      2      0
bio                  272    310    128   31    1 : tunables  120   60    8 : slabdata     10     10      0
file_lock_cache       34     86     92   43    1 : tunables  120   60    8 : slabdata      2      2      0
sock_inode_cache     418    427    512    7    1 : tunables   54   27    8 : slabdata     61     61      0
skbuff_head_cache    417    690    256   15    1 : tunables  120   60    8 : slabdata     46     46      0
proc_inode_cache    1340   1340    384   10    1 : tunables   54   27    8 : slabdata    134    134      0
sigqueue              90    135    148   27    1 : tunables  120   60    8 : slabdata      5      5      0
radix_tree_node     4392   4410    276   14    1 : tunables   54   27    8 : slabdata    315    315      0
bdev_cache            32     42    512    7    1 : tunables   54   27    8 : slabdata      6      6      0
sysfs_dir_cache     2495   2592     40   96    1 : tunables  120   60    8 : slabdata     27     27      0
mnt_cache             45     62    128   31    1 : tunables  120   60    8 : slabdata      2      2      0
inode_cache         2194   2211    368   11    1 : tunables   54   27    8 : slabdata    201    201      0
dentry_cache       30828  30828    140   28    1 : tunables  120   60    8 : slabdata   1101   1101      0
filp                3255   3255    256   15    1 : tunables  120   60    8 : slabdata    217    217      0
names_cache           18     18   4096    1    1 : tunables   24   12    8 : slabdata     18     18      0
idr_layer_cache      112    116    136   29    1 : tunables  120   60    8 : slabdata      4      4      0
buffer_head         3153   3159     48   81    1 : tunables  120   60    8 : slabdata     39     39      0
mm_struct            105    108    640    6    1 : tunables   54   27    8 : slabdata     18     18      0
vm_area_struct      5806   5940     88   45    1 : tunables  120   60    8 : slabdata    132    132     15
fs_cache             128    183     64   61    1 : tunables  120   60    8 : slabdata      3      3      0
files_cache          107    112    512    7    1 : tunables   54   27    8 : slabdata     16     16      0
signal_cache         240    240    384   10    1 : tunables   54   27    8 : slabdata     24     24      0
sighand_cache        140    140   1408    5    2 : tunables   24   12    8 : slabdata     28     28      0
task_struct          231    231   1280    3    1 : tunables   24   12    8 : slabdata     77     77      0
anon_vma            2340   2610     12  290    1 : tunables  120   60    8 : slabdata      9      9      0
pgd                   91     91   4096    1    1 : tunables   24   12    8 : slabdata     91     91      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            1      1 131072    1   32 : tunables    8    4    0 : slabdata      1      1      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             3      3  65536    1   16 : tunables    8    4    0 : slabdata      3      3      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768            66     66  32768    1    8 : tunables    8    4    0 : slabdata     66     66      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384            13     21  16384    1    4 : tunables    8    4    0 : slabdata     13     21      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192             26     28   8192    1    2 : tunables    8    4    0 : slabdata     26     28      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    8 : slabdata      0      0      0
size-4096            685    685   4096    1    1 : tunables   24   12    8 : slabdata    685    685      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    8 : slabdata      0      0      0
size-2048            174    174   2048    2    1 : tunables   24   12    8 : slabdata     87     87      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    8 : slabdata      0      0      0
size-1024            268    288   1024    4    1 : tunables   54   27    8 : slabdata     72     72      3
size-512(DMA)          0      0    512    8    1 : tunables   54   27    8 : slabdata      0      0      0
size-512             615    656    512    8    1 : tunables   54   27    8 : slabdata     82     82     27
size-256(DMA)          0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
size-256             510    510    256   15    1 : tunables  120   60    8 : slabdata     34     34      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
size-128            1798   1798    128   31    1 : tunables  120   60    8 : slabdata     58     58      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
size-64             3476   3477     64   61    1 : tunables  120   60    8 : slabdata     57     57      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    8 : slabdata      0      0      0
size-32             9642   9758     32  119    1 : tunables  120   60    8 : slabdata     82     82      3
kmem_cache           150    150    256   15    1 : tunables  120   60    8 : slabdata     10     10      0


Here's my excerpt from my syslog:

Oct 26 14:12:24 dewup-ww02 ------------[ cut here ]------------
Oct 26 14:12:24 dewup-ww02 kernel BUG at mm/slab.c:2839!
Oct 26 14:12:24 dewup-ww02 invalid operand: 0000 [#1]
Oct 26 14:12:24 dewup-ww02 SMP
Oct 26 14:12:24 dewup-ww02 Modules linked in: nfs autofs4 nfsd lockd nfs_acl sunrpc e1000 ext3 jbd unionfs
Oct 26 14:12:24 dewup-ww02 CPU:    0
Oct 26 14:12:24 dewup-ww02 EIP:    0060:[<c0142ae4>]    Not tainted VLI
Oct 26 14:12:24 dewup-ww02 EFLAGS: 00010002   (2.6.13-ck8.03.reiser-stat.megaraid_newgen.no-preempt)
Oct 26 14:12:24 dewup-ww02 EIP is at cache_reap+0x1e1/0x1ee
Oct 26 14:12:24 dewup-ww02 eax: 00000001   ebx: eed4fb40   ecx: c31bf080   edx: d4d9f8a0
Oct 26 14:12:24 dewup-ww02 esi: c31bd380   edi: 00000001   ebp: c31bd420   esp: c31e2f2c
Oct 26 14:12:24 dewup-ww02 ds: 007b   es: 007b   ss: 0068
Oct 26 14:12:24 dewup-ww02 Process events/0 (pid: 6, threadinfo=c31e2000 task=c31e1a20)
Oct 26 14:12:24 dewup-ww02 Stack: c31bd3f8 c31bd450 00000296 00000000 c31e0000 c3014c84 00000297 c012acf1
Oct 26 14:12:24 dewup-ww02 00000000 00000000 c301b520 c31e0020 c31e000c c31e0014 c0142903 c3014c80
Oct 26 14:12:24 dewup-ww02 c31e2000 ffffffff ffffffff 00000001 00000000 c0117af2 00010000 00000000
Oct 26 14:12:24 dewup-ww02 Call Trace:
Oct 26 14:12:24 dewup-ww02 [<c012acf1>] worker_thread+0x1b0/0x23a
Oct 26 14:12:24 dewup-ww02 [<c0142903>] cache_reap+0x0/0x1ee                                                                Oct 26 14:12:24 dewup-ww02
[<c0117af2>]
default_wake_function+0x0/0xc
Oct 26 14:12:24 dewup-ww02 [<c0117af2>] default_wake_function+0x0/0xc
Oct 26 14:12:24 dewup-ww02 [<c0117c6f>] complete+0x40/0x55
Oct 26 14:12:24 dewup-ww02 [<c012ab41>] worker_thread+0x0/0x23a
Oct 26 14:12:24 dewup-ww02 [<c012e972>] kthread+0xa0/0xd4
Oct 26 14:12:24 dewup-ww02 [<c012e8d2>] kthread+0x0/0xd4
Oct 26 14:12:24 dewup-ww02 [<c010101d>] kernel_thread_helper+0x5/0xb
Oct 26 14:12:24 dewup-ww02 Code: 5d c3 b8 00 f0 ff ff 21 e0 8b 48 10 8d 91 d0 07 00 00 b8 20 6d 45 c0 03 04 8d 20 a0 45 c0 e8 dc 87 fe ff 83 c4 0c 5b
5e 5f 5d c3 <0f> 0b 17
0b 4a 63 35 c0 e9 0a ff ff ff 57 89 c7 56 53 8b 1a 8b

Alexander Skwar
-- 
Men of quality are not afraid of women for equality.
