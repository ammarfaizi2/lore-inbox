Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbVIXR7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbVIXR7F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 13:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbVIXR7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 13:59:05 -0400
Received: from ms005msg.fastwebnet.it ([213.140.2.50]:18915 "EHLO
	ms005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932214AbVIXR7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 13:59:03 -0400
Date: Sat, 24 Sep 2005 19:58:48 +0200
From: Mattia Dongili <malattia@linux.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm1
Message-ID: <20050924175848.GD3586@inferi.kami.home>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050921222839.76c53ba1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050921222839.76c53ba1.akpm@osdl.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.14-rc2-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 10:28:39PM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm1/

Herm... running almost good :) I just got the below allocation failure
(including /proc/slabinfo and /proc/vmstat, useful? can provide more
info if happens again - ah, exim is just running for the local delivery
purpose only). I did see it previously in .14-rc1-mm1 only but I didn't
find time enough to report it properly.

Linux version 2.6.14-rc2-mm1-1 (mattia@inferi) (gcc version 4.0.1 (Debian 4.0.1-2)) #1 PREEMPT Fri Sep 23 20:56:05 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
 BIOS-e820: 000000000fef0000 - 000000000feff000 (ACPI data)
 BIOS-e820: 000000000feff000 - 000000000ff00000 (ACPI NVS)
 BIOS-e820: 000000000ff00000 - 000000000ff80000 (usable)
 BIOS-e820: 000000000ff80000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65408
  DMA zone: 4096 pages, LIFO batch:2
  DMA32 zone: 0 pages, LIFO batch:2
  Normal zone: 61312 pages, LIFO batch:32
  HighMem zone: 0 pages, LIFO batch:2
DMI present.
[...]
exim4: page allocation failure. order:1, mode:0x80000020
 [<c0143698>] __alloc_pages+0x328/0x450
 [<c0147150>] kmem_getpages+0x30/0xa0
 [<c01480cf>] cache_grow+0xbf/0x1f0
 [<c0148446>] cache_alloc_refill+0x246/0x280
 [<c0148793>] __kmalloc+0x73/0x80
 [<c0291cd8>] pskb_expand_head+0x58/0x150
 [<c0297143>] skb_checksum_help+0x103/0x120
 [<d0c6d1cc>] ip_nat_fn+0x1cc/0x240 [iptable_nat]
 [<d0c763e8>] ip_conntrack_in+0x188/0x2c0 [ip_conntrack]
 [<d0c6d45e>] ip_nat_local_fn+0x7e/0xc0 [iptable_nat]
 [<c02b2670>] dst_output+0x0/0x30
 [<c02b2670>] dst_output+0x0/0x30
 [<c02e7c2b>] nf_iterate+0x6b/0xa0
 [<c02b2670>] dst_output+0x0/0x30
 [<c02b2670>] dst_output+0x0/0x30
 [<c02e7cc4>] nf_hook_slow+0x64/0x140
 [<c02b2670>] dst_output+0x0/0x30
 [<c02b2670>] dst_output+0x0/0x30
 [<c02b35ae>] ip_queue_xmit+0x23e/0x550
 [<c02b2670>] dst_output+0x0/0x30
 [<c01e1b9a>] __copy_to_user_ll+0x4a/0x90
 [<c0293a6e>] memcpy_toiovec+0x6e/0x90
 [<c02c4c75>] tcp_cwnd_restart+0x35/0xf0
 [<c02c5276>] tcp_transmit_skb+0x426/0x780
 [<c02c332e>] tcp_rcv_established+0x6e/0x8c0
 [<c02c657d>] tcp_write_xmit+0x12d/0x3d0
 [<c02c6855>] __tcp_push_pending_frames+0x35/0xb0
 [<c02bad3c>] tcp_sendmsg+0xa3c/0xb50
 [<c028c67f>] sock_aio_write+0xcf/0x120
 [<c016029d>] do_sync_write+0xcd/0x130
 [<c0131ed0>] autoremove_wake_function+0x0/0x60
 [<c016047f>] vfs_write+0x17f/0x190
 [<c016055b>] sys_write+0x4b/0x80
 [<c01032a1>] syscall_call+0x7/0xb
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 12, batch 2 used:8
cpu 0 cold: low 0, high 4, batch 1 used:3
DMA32 per-cpu: empty
Normal per-cpu:
cpu 0 hot: low 0, high 192, batch 32 used:14
cpu 0 cold: low 0, high 64, batch 16 used:51
HighMem per-cpu: empty
Free pages:        4112kB (0kB HighMem)
Active:46238 inactive:10857 dirty:16 writeback:0 unstable:0 free:1028 slab:4078 mapped:39343 pagetables:316
DMA free:1224kB min:128kB low:160kB high:192kB active:6812kB inactive:3684kB present:16384kB pages_scanned:36 all_unreclaimable? no
lowmem_reserve[]: 0 0 239 239
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 239 239
Normal free:2888kB min:1916kB low:2392kB high:2872kB active:178140kB inactive:39744kB present:245248kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 300*4kB 1*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1224kB
DMA32: empty
Normal: 722*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 2888kB
HighMem: empty
Swap cache: add 33, delete 33, find 0/0, race 0+0
Free swap  = 248864kB
Total swap = 248996kB
Free swap:       248864kB
65408 pages of RAM
0 pages of HIGHMEM
1529 reserved pages
46307 pages shared
0 pages swap cached
16 pages dirty
0 pages writeback
39343 pages mapped
4078 pages slab
316 pages pagetables


  cat /proc/slabinfo
slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
nfs_write_data        36     36    448    9    1 : tunables   54   27    0 : slabdata      4      4      0
nfs_read_data         32     36    448    9    1 : tunables   54   27    0 : slabdata      4      4      0
nfs_inode_cache        3     14    560    7    1 : tunables   54   27    0 : slabdata      2      2      0
nfs_page               0      0     64   59    1 : tunables  120   60    0 : slabdata      0      0      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12    0 : slabdata      4      4      0
rpc_tasks              8     20    192   20    1 : tunables  120   60    0 : slabdata      1      1      0
rpc_inode_cache        8      9    416    9    1 : tunables   54   27    0 : slabdata      1      1      0
ip_conntrack_expect      0      0     96   40    1 : tunables  120   60    0 : slabdata      0      0      0
ip_conntrack           1     15    256   15    1 : tunables  120   60    0 : slabdata      1      1      0
scsi_cmd_cache         1     11    352   11    1 : tunables   54   27    0 : slabdata      1      1      0
d_cursor               0      0     64   59    1 : tunables  120   60    0 : slabdata      0      0      0
file_fsdata           71     75    256   15    1 : tunables  120   60    0 : slabdata      5      5      0
dentry_fsdata       2188   3658     64   59    1 : tunables  120   60    0 : slabdata     62     62      0
fq                     0      0     64   59    1 : tunables  120   60    0 : slabdata      0      0      0
jnode               1869   4480     96   40    1 : tunables  120   60    0 : slabdata    112    112      0
txn_handle             0      0     32  113    1 : tunables  120   60    0 : slabdata      0      0      0
txn_atom               1     15    256   15    1 : tunables  120   60    0 : slabdata      1      1      0
plugin_set            73    118     64   59    1 : tunables  120   60    0 : slabdata      2      2      0
znode               4704   7888    224   17    1 : tunables  120   60    0 : slabdata    464    464      0
reiser4_inode       4057   4144    512    7    1 : tunables   54   27    0 : slabdata    592    592      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    0 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    0 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    0 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    0 : slabdata      3      3      0
sgpool-8              32     60    128   30    1 : tunables  120   60    0 : slabdata      2      2      0
dm_tio                 0      0     16  203    1 : tunables  120   60    0 : slabdata      0      0      0
dm_io                  0      0     16  203    1 : tunables  120   60    0 : slabdata      0      0      0
uhci_urb_priv          1     92     40   92    1 : tunables  120   60    0 : slabdata      1      1      0
UNIX                  77     77    352   11    1 : tunables   54   27    0 : slabdata      7      7      0
tcp_bind_bucket       15    203     16  203    1 : tunables  120   60    0 : slabdata      1      1      0
inet_peer_cache        1     59     64   59    1 : tunables  120   60    0 : slabdata      1      1      0
ip_fib_alias           9    113     32  113    1 : tunables  120   60    0 : slabdata      1      1      0
ip_fib_hash            9    113     32  113    1 : tunables  120   60    0 : slabdata      1      1      0
ip_dst_cache          31     45    256   15    1 : tunables  120   60    0 : slabdata      3      3      0
arp_cache              3     30    128   30    1 : tunables  120   60    0 : slabdata      1      1      0
RAW                    2      9    448    9    1 : tunables   54   27    0 : slabdata      1      1      0
UDP                    8      9    448    9    1 : tunables   54   27    0 : slabdata      1      1      0
tw_sock_TCP            0      0     96   40    1 : tunables  120   60    0 : slabdata      0      0      0
request_sock_TCP       0      0     64   59    1 : tunables  120   60    0 : slabdata      0      0      0
TCP                   15     16    960    4    1 : tunables   54   27    0 : slabdata      4      4      0
cfq_ioc_pool           0      0     48   78    1 : tunables  120   60    0 : slabdata      0      0      0
cfq_pool               0      0     96   40    1 : tunables  120   60    0 : slabdata      0      0      0
crq_pool               0      0     44   84    1 : tunables  120   60    0 : slabdata      0      0      0
deadline_drq           0      0     48   78    1 : tunables  120   60    0 : slabdata      0      0      0
as_arq                24    189     60   63    1 : tunables  120   60    0 : slabdata      3      3      0
mqueue_inode_cache      1      7    512    7    1 : tunables   54   27    0 : slabdata      1      1      0
reiser_inode_cache    622   1450    392   10    1 : tunables   54   27    0 : slabdata    145    145      0
dnotify_cache          0      0     20  169    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_pwq          0      0     36  101    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_epi          0      0     96   40    1 : tunables  120   60    0 : slabdata      0      0      0
inotify_event_cache      0      0     28  127    1 : tunables  120   60    0 : slabdata      0      0      0
inotify_watch_cache      0      0     36  101    1 : tunables  120   60    0 : slabdata      0      0      0
kioctx                 0      0    160   24    1 : tunables  120   60    0 : slabdata      0      0      0
kiocb                  0      0    128   30    1 : tunables  120   60    0 : slabdata      0      0      0
fasync_cache           2    203     16  203    1 : tunables  120   60    0 : slabdata      1      1      0
shmem_inode_cache    748    756    408    9    1 : tunables   54   27    0 : slabdata     84     84      0
posix_timers_cache      0      0     96   40    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache              6     59     64   59    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_ioc            51    127     28  127    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_queue           2     10    380   10    1 : tunables   54   27    0 : slabdata      1      1      0
blkdev_requests       25     78    152   26    1 : tunables  120   60    0 : slabdata      3      3      0
biovec-(256)         260    260   3072    2    2 : tunables   24   12    0 : slabdata    130    130      0
biovec-128           264    265   1536    5    2 : tunables   24   12    0 : slabdata     53     53      0
biovec-64            272    275    768    5    1 : tunables   54   27    0 : slabdata     55     55      0
biovec-16            272    280    192   20    1 : tunables  120   60    0 : slabdata     14     14      0
biovec-4             272    295     64   59    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1             279    406     16  203    1 : tunables  120   60    0 : slabdata      2      2      0
bio                  279    354     64   59    1 : tunables  120   60    0 : slabdata      6      6      0
file_lock_cache       21     44     88   44    1 : tunables  120   60    0 : slabdata      1      1      0
sock_inode_cache     110    110    352   11    1 : tunables   54   27    0 : slabdata     10     10      0
skbuff_fclone_cache      0      0    320   12    1 : tunables   54   27    0 : slabdata      0      0      0
skbuff_head_cache    696    696    160   24    1 : tunables  120   60    0 : slabdata     29     29      0
acpi_operand         828    828     40   92    1 : tunables  120   60    0 : slabdata      9      9      0
acpi_parse_ext        61     84     44   84    1 : tunables  120   60    0 : slabdata      1      1      0
acpi_parse            41    127     28  127    1 : tunables  120   60    0 : slabdata      1      1      0
acpi_state            28     78     48   78    1 : tunables  120   60    0 : slabdata      1      1      0
proc_inode_cache     215    360    332   12    1 : tunables   54   27    0 : slabdata     30     30      0
sigqueue               4     26    148   26    1 : tunables  120   60    0 : slabdata      1      1      0
radix_tree_node     3568   4046    276   14    1 : tunables   54   27    0 : slabdata    289    289      0
bdev_cache             7      9    416    9    1 : tunables   54   27    0 : slabdata      1      1      0
sysfs_dir_cache     4059   4140     40   92    1 : tunables  120   60    0 : slabdata     45     45      0
mnt_cache             27     40     96   40    1 : tunables  120   60    0 : slabdata      1      1      0
inode_cache         1113   1272    316   12    1 : tunables   54   27    0 : slabdata    106    106      0
dentry_cache        5085   7569    136   29    1 : tunables  120   60    0 : slabdata    261    261      0
filp                1512   1632    160   24    1 : tunables  120   60    0 : slabdata     68     68      0
names_cache           11     11   4096    1    1 : tunables   24   12    0 : slabdata     11     11      0
idr_layer_cache       93    116    136   29    1 : tunables  120   60    0 : slabdata      4      4      0
buffer_head         3942  20592     48   78    1 : tunables  120   60    0 : slabdata    264    264      0
mm_struct             77     77    576    7    1 : tunables   54   27    0 : slabdata     11     11      0
vm_area_struct      3512   3740     88   44    1 : tunables  120   60    0 : slabdata     85     85      0
fs_cache              77    113     32  113    1 : tunables  120   60    0 : slabdata      1      1      0
files_cache           78     99    448    9    1 : tunables   54   27    0 : slabdata     11     11      0
signal_cache          99     99    352   11    1 : tunables   54   27    0 : slabdata      9      9      0
sighand_cache         84     84   1312    3    1 : tunables   24   12    0 : slabdata     28     28      0
task_struct           93     93   1328    3    1 : tunables   24   12    0 : slabdata     31     31      0
anon_vma            1504   1695      8  339    1 : tunables  120   60    0 : slabdata      5      5      0
pgd                   64     64   4096    1    1 : tunables   24   12    0 : slabdata     64     64      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             2      2  32768    1    8 : tunables    8    4    0 : slabdata      2      2      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192             95     95   8192    1    2 : tunables    8    4    0 : slabdata     95     95      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096            100    100   4096    1    1 : tunables   24   12    0 : slabdata    100    100      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048            310    328   2048    2    1 : tunables   24   12    0 : slabdata    164    164      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024            176    176   1024    4    1 : tunables   54   27    0 : slabdata     44     44      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512             624    624    512    8    1 : tunables   54   27    0 : slabdata     78     78      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256             150    150    256   15    1 : tunables  120   60    0 : slabdata     10     10      0
size-128(DMA)          0      0    128   30    1 : tunables  120   60    0 : slabdata      0      0      0
size-128            1702   1800    128   30    1 : tunables  120   60    0 : slabdata     60     60      0
size-64(DMA)           0      0     64   59    1 : tunables  120   60    0 : slabdata      0      0      0
size-32(DMA)           0      0     32  113    1 : tunables  120   60    0 : slabdata      0      0      0
size-64             2641   2891     64   59    1 : tunables  120   60    0 : slabdata     49     49      0
size-32             3020   3616     32  113    1 : tunables  120   60    0 : slabdata     32     32      0
kmem_cache           160    160     96   40    1 : tunables  120   60    0 : slabdata      4      4      0

  and 
  cat /proc/vmstat
nr_dirty 6
nr_writeback 0
nr_unstable 0
nr_page_table_pages 299
nr_mapped 39613
nr_slab 4128
pgpgin 853871
pgpgout 697604
pswpin 0
pswpout 33
pgalloc_high 0
pgalloc_normal 7729542
pgalloc_dma 739299
pgfree 8475900
pgactivate 194732
pgdeactivate 167948
pgfault 4652531
pgmajfault 2200
pgrefill_high 0
pgrefill_normal 921490
pgrefill_dma 53701
pgsteal_high 0
pgsteal_normal 225142
pgsteal_dma 32821
pgscan_kswapd_high 0
pgscan_kswapd_normal 218790
pgscan_kswapd_dma 31262
pgscan_direct_high 0
pgscan_direct_normal 63855
pgscan_direct_dma 10391
pginodesteal 888
slabs_scanned 1641984
kswapd_steal 196892
kswapd_inodesteal 17749
pageoutrun 5595
allocstall 1531
pgrotated 71
nr_bounce 0

-- 
mattia
:wq!
