Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266833AbUHOR6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266833AbUHOR6c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 13:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266835AbUHOR6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 13:58:32 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:16817 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S266833AbUHOR6W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 13:58:22 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Sun, 15 Aug 2004 13:58:19 -0400
User-Agent: KMail/1.6.82
Cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       marcelo.tosatti@cyclades.com, torvalds@osdl.org
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408150542.55953.gene.heskett@verizon.net> <20040815103127.2faa5be3.akpm@osdl.org>
In-Reply-To: <20040815103127.2faa5be3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408151358.19923.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.53.77] at Sun, 15 Aug 2004 12:58:20 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 August 2004 13:31, Andrew Morton wrote:
>Gene Heskett <gene.heskett@verizon.net> wrote:
>> ...
>>
>> Now, this mornings logwatch told me I should go look at the
>>  logs again, and I found this had occurred several hours earlier:
>>  -----------
>>  Aug 14 18:53:24 coyote kernel: Unable to handle kernel paging
>> request at virtual address 0058af03
>
>This oops is the _cause_ of the out-of-memory condition.  The
> oopsing process exitted while holding shrinker_sem, so slab will
> never again be shrunk.
>
>Any observed behaviour after an oops is almost always uninteresting,
> and usually misleading.

Okaaaay, now what. See my post of 10 minutes ago, this top "top" 
took a SIGABRT exit.  I posted the Oops, but now here is meminfo:

[root@coyote linux-2.6.8-rc4]# cat /proc/meminfo
MemTotal:      1035848 kB
MemFree:        238016 kB
Buffers:         98756 kB
Cached:         491324 kB
SwapCached:          0 kB
Active:         343340 kB
Inactive:       416908 kB
HighTotal:      131008 kB
HighFree:          252 kB
LowTotal:       904840 kB
LowFree:        237764 kB
SwapTotal:     3857104 kB
SwapFree:      3857104 kB
Dirty:              56 kB
Writeback:           0 kB
Mapped:         229924 kB
Slab:            27416 kB
Committed_AS:   333992 kB
PageTables:       3292 kB
VmallocTotal:   114680 kB
VmallocUsed:     19636 kB
VmallocChunk:    94936 kB

And slabinfo:

[root@coyote linux-2.6.8-rc4]# cat /proc/slabinfo
slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
unix_sock            173    180    384   10    1 : tunables   54   27    0 : slabdata     18     18      0
tcp_tw_bucket          2     41     96   41    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_bind_bucket       21    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_open_request       0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
inet_peer_cache        0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
ip_fib_hash           10    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
ip_dst_cache          12     30    256   15    1 : tunables  120   60    0 : slabdata      2      2      0
arp_cache              3     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
raw4_sock              0      0    480    8    1 : tunables   54   27    0 : slabdata      0      0      0
udp_sock               2      8    480    8    1 : tunables   54   27    0 : slabdata      1      1      0
tcp_sock              31     32   1024    4    1 : tunables   54   27    0 : slabdata      8      8      0
flow_cache             0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
mqueue_inode_cache      1      8    480    8    1 : tunables   54   27    0 : slabdata      1      1      0
udf_inode_cache        0      0    352   11    1 : tunables   54   27    0 : slabdata      0      0      0
smb_request            0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
smb_inode_cache        2     12    320   12    1 : tunables   54   27    0 : slabdata      1      1      0
isofs_inode_cache      0      0    320   12    1 : tunables   54   27    0 : slabdata      0      0      0
fat_inode_cache        1     11    352   11    1 : tunables   54   27    0 : slabdata      1      1      0
ext2_inode_cache       0      0    416    9    1 : tunables   54   27    0 : slabdata      0      0      0
journal_handle         4    135     28  135    1 : tunables  120   60    0 : slabdata      1      1      0
journal_head          95    243     48   81    1 : tunables  120   60    0 : slabdata      3      3      0
revoke_table          12    290     12  290    1 : tunables  120   60    0 : slabdata      1      1      0
revoke_record          0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
ext3_inode_cache   20079  20088    448    9    1 : tunables   54   27    0 : slabdata   2232   2232      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_epi          0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
kioctx                 0      0    160   25    1 : tunables  120   60    0 : slabdata      0      0      0
kiocb                  0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
dnotify_cache        172    370     20  185    1 : tunables  120   60    0 : slabdata      2      2      0
file_lock_cache       43     43     92   43    1 : tunables  120   60    0 : slabdata      1      1      0
fasync_cache           2    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
shmem_inode_cache      5     10    384   10    1 : tunables   54   27    0 : slabdata      1      1      0
posix_timers_cache      0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache              7    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    0 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    0 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    0 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    0 : slabdata      3      3      0
sgpool-8              32     62    128   31    1 : tunables  120   60    0 : slabdata      2      2      0
cfq_pool              64    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
crq_pool               0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
deadline_drq           0      0     48   81    1 : tunables  120   60    0 : slabdata      0      0      0
as_arq                65     65     60   65    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_ioc            63    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_queue          12     18    448    9    1 : tunables   54   27    0 : slabdata      2      2      0
blkdev_requests       52     52    152   26    1 : tunables  120   60    0 : slabdata      2      2      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    0 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    0 : slabdata     52     52      0
biovec-16            256    260    192   20    1 : tunables  120   60    0 : slabdata     13     13      0
biovec-4             256    305     64   61    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1             318    452     16  226    1 : tunables  120   60    0 : slabdata      2      2      0
bio                  342    366     64   61    1 : tunables  120   60    0 : slabdata      6      6      0
sock_inode_cache     210    220    352   11    1 : tunables   54   27    0 : slabdata     20     20      0
skbuff_head_cache    250    325    160   25    1 : tunables  120   60    0 : slabdata     13     13      0
sock                   3     12    320   12    1 : tunables   54   27    0 : slabdata      1      1      0
proc_inode_cache     600    600    320   12    1 : tunables   54   27    0 : slabdata     50     50      0
sigqueue             117    135    148   27    1 : tunables  120   60    0 : slabdata      5      5      0
radix_tree_node     9073   9604    276   14    1 : tunables   54   27    0 : slabdata    686    686      0
bdev_cache            11     18    416    9    1 : tunables   54   27    0 : slabdata      2      2      0
mnt_cache             26     41     96   41    1 : tunables  120   60    0 : slabdata      1      1      0
inode_cache         2198   2198    288   14    1 : tunables   54   27    0 : slabdata    157    157      0
dentry_cache       33792  33796    140   28    1 : tunables  120   60    0 : slabdata   1207   1207      0
filp                2030   2125    160   25    1 : tunables  120   60    0 : slabdata     85     85      0
names_cache           16     16   4096    1    1 : tunables   24   12    0 : slabdata     16     16      0
idr_layer_cache       81     87    136   29    1 : tunables  120   60    0 : slabdata      3      3      0
buffer_head        76638  76707     48   81    1 : tunables  120   60    0 : slabdata    947    947      0
mm_struct             91     91    512    7    1 : tunables   54   27    0 : slabdata     13     13      0
vm_area_struct      7703   7896     84   47    1 : tunables  120   60    0 : slabdata    168    168      0
fs_cache             100    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
files_cache           90     90    416    9    1 : tunables   54   27    0 : slabdata     10     10      0
signal_cache         119    123     96   41    1 : tunables  120   60    0 : slabdata      3      3      0
sighand_cache        102    102   1312    3    1 : tunables   24   12    0 : slabdata     34     34      0
task_struct          110    110   1424    5    2 : tunables   24   12    0 : slabdata     22     22      0
anon_vma            1619   2035      8  407    1 : tunables  120   60    0 : slabdata      5      5      0
pgd                   87     87   4096    1    1 : tunables   24   12    0 : slabdata     87     87      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             1      1  65536    1   16 : tunables    8    4    0 : slabdata      1      1      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             4      4  16384    1    4 : tunables    8    4    0 : slabdata      4      4      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192             11     11   8192    1    2 : tunables    8    4    0 : slabdata     11     11      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096            180    180   4096    1    1 : tunables   24   12    0 : slabdata    180    180      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048            162    186   2048    2    1 : tunables   24   12    0 : slabdata     93     93      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024            124    124   1024    4    1 : tunables   54   27    0 : slabdata     31     31      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512             184    448    512    8    1 : tunables   54   27    0 : slabdata     56     56      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256             180    450    256   15    1 : tunables  120   60    0 : slabdata     30     30      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
size-192             100    100    192   20    1 : tunables  120   60    0 : slabdata      5      5      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
size-128            1174   1209    128   31    1 : tunables  120   60    0 : slabdata     39     39      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
size-64              915    915     64   61    1 : tunables  120   60    0 : slabdata     15     15      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
size-32             1369   1428     32  119    1 : tunables  120   60    0 : slabdata     12     12      0
kmem_cache           124    124    128   31    1 : tunables  120   60    0 : slabdata      4      4      0

And a dmesg after a dmesg -c: returns an empty file.

Next please?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
