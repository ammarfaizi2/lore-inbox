Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbVKWBBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbVKWBBc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 20:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbVKWBBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 20:01:32 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:19891 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1030291AbVKWBBb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 20:01:31 -0500
Date: Wed, 23 Nov 2005 02:01:22 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14 kswapd eating too much CPU
Message-ID: <20051123010122.GA7573@fi.muni.cz>
References: <20051122125959.GR16080@fi.muni.cz> <20051122163550.160e4395.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122163550.160e4395.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
: Jan Kasprzak <kas@fi.muni.cz> wrote:
: >
: > I have noticed that on my system kswapd eats too much CPU time every two
: > hours or so. This started when I upgraded this server to 2.6.14.2 (was 2.6.13.2
: > before), and added another 4 GB of memory (to the total of 8GB).
: 
: Next time it happens, please gather some memory info (while it's happening):
: 
: 	cat /proc/meminfo

# cat /proc/meminfo
MemTotal:      8174528 kB
MemFree:         33312 kB
Buffers:         33472 kB
Cached:        7565188 kB
SwapCached:          0 kB
Active:        2457564 kB
Inactive:      5469168 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      8174528 kB
LowFree:         33312 kB
SwapTotal:    14651256 kB
SwapFree:     14650616 kB
Dirty:           67136 kB
Writeback:           0 kB
Mapped:         348848 kB
Slab:           159900 kB
CommitLimit:  18738520 kB
Committed_AS:   746976 kB
PageTables:      15596 kB
VmallocTotal: 34359738367 kB
VmallocUsed:      9500 kB
VmallocChunk: 34359728803 kB

: 	cat /proc/vmstat

# cat /proc/vmstat
nr_dirty 15117
nr_writeback 0
nr_unstable 0
nr_page_table_pages 3975
nr_mapped 88352
nr_slab 39997
pgpgin 4793492568
pgpgout 470966429
pswpin 0
pswpout 160
pgalloc_high 0
pgalloc_normal 2450703504
pgalloc_dma 982887145
pgfree 3433597403
pgactivate 368526738
pgdeactivate 334812475
pgfault 1595083992
pgmajfault 64619
pgrefill_high 0
pgrefill_normal 533924428
pgrefill_dma 1995932
pgsteal_high 0
pgsteal_normal 923247535
pgsteal_dma 0
pgscan_kswapd_high 0
pgscan_kswapd_normal 940269891
pgscan_kswapd_dma 0
pgscan_direct_high 0
pgscan_direct_normal 13837131
pgscan_direct_dma 0
pginodesteal 11216563
slabs_scanned 160160350534400
kswapd_steal 909876526
kswapd_inodesteal 305039060
pageoutrun 30139677
allocstall 4067783
pgrotated 1198
nr_bounce 0

: 	cat /proc/slabinfo

# cat /proc/slabinfo
slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
nfsd4_delegations      0      0    656    6    1 : tunables   54   27    8 : slabdata      0      0      0
nfsd4_stateids         0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
nfsd4_files            0      0     72   53    1 : tunables  120   60    8 : slabdata      0      0      0
nfsd4_stateowners      0      0    424    9    1 : tunables   54   27    8 : slabdata      0      0      0
raid5/md5            256    260   1424    5    2 : tunables   24   12    8 : slabdata     52     52      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12    8 : slabdata      4      4      0
rpc_tasks              8     10    384   10    1 : tunables   54   27    8 : slabdata      1      1      0
rpc_inode_cache        8      8    832    4    1 : tunables   54   27    8 : slabdata      2      2      0
fib6_nodes            33    118     64   59    1 : tunables  120   60    8 : slabdata      2      2      0
ip6_dst_cache         26     36    320   12    1 : tunables   54   27    8 : slabdata      3      3      0
ndisc_cache            3     30    256   15    1 : tunables  120   60    8 : slabdata      2      2      0
RAWv6                  4      4    896    4    1 : tunables   54   27    8 : slabdata      1      1      0
UDPv6                  1      4    896    4    1 : tunables   54   27    8 : slabdata      1      1      0
tw_sock_TCPv6          0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
request_sock_TCPv6      0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
TCPv6                 13     15   1536    5    2 : tunables   24   12    8 : slabdata      3      3      0
UNIX                 460    654    640    6    1 : tunables   54   27    8 : slabdata    109    109      0
tcp_bind_bucket      233   2800     32  112    1 : tunables  120   60    8 : slabdata     25     25      0
inet_peer_cache       32    177     64   59    1 : tunables  120   60    8 : slabdata      3      3      0
ip_fib_alias          20    118     64   59    1 : tunables  120   60    8 : slabdata      2      2      0
ip_fib_hash           17    118     64   59    1 : tunables  120   60    8 : slabdata      2      2      0
ip_dst_cache         985   1776    320   12    1 : tunables   54   27    8 : slabdata    148    148      0
arp_cache              8     30    256   15    1 : tunables  120   60    8 : slabdata      2      2      0
RAW                    3     11    704   11    2 : tunables   54   27    8 : slabdata      1      1      0
UDP                   35     40    768    5    1 : tunables   54   27    8 : slabdata      8      8      0
tw_sock_TCP          174    640    192   20    1 : tunables  120   60    8 : slabdata     32     32      0
request_sock_TCP      48     60    128   30    1 : tunables  120   60    8 : slabdata      2      2      0
TCP                  333    525   1408    5    2 : tunables   24   12    8 : slabdata    105    105      0
dm_tio                 0      0     24  144    1 : tunables  120   60    8 : slabdata      0      0      0
dm_io                  0      0     32  112    1 : tunables  120   60    8 : slabdata      0      0      0
scsi_cmd_cache        74    168    512    7    1 : tunables   54   27    8 : slabdata     19     24     30
cfq_ioc_pool           0      0     96   40    1 : tunables  120   60    8 : slabdata      0      0      0
cfq_pool               0      0    160   24    1 : tunables  120   60    8 : slabdata      0      0      0
crq_pool               0      0     88   44    1 : tunables  120   60    8 : slabdata      0      0      0
deadline_drq           0      0     96   40    1 : tunables  120   60    8 : slabdata      0      0      0
as_arq               159    408    112   34    1 : tunables  120   60    8 : slabdata     11     12      5
xfs_acl                0      0    304   13    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_chashlist       4965   8512     32  112    1 : tunables  120   60    8 : slabdata     76     76      0
xfs_ili              213    260    192   20    1 : tunables  120   60    8 : slabdata     13     13      0
xfs_ifork              0      0     64   59    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_efi_item           0      0    352   11    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_efd_item           0      0    360   11    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_buf_item          74     84    184   21    1 : tunables  120   60    8 : slabdata      4      4      0
xfs_dabuf             52    288     24  144    1 : tunables  120   60    8 : slabdata      2      2      0
xfs_da_state           6     16    488    8    1 : tunables   54   27    8 : slabdata      2      2      0
xfs_trans              6     45    872    9    2 : tunables   54   27    8 : slabdata      3      5      0
xfs_inode          31498  31577    528    7    1 : tunables   54   27    8 : slabdata   4511   4511      0
xfs_btree_cur         13     40    192   20    1 : tunables  120   60    8 : slabdata      2      2      0
xfs_bmap_free_item      2    144     24  144    1 : tunables  120   60    8 : slabdata      1      1      0
xfs_buf               88     99    408    9    1 : tunables   54   27    8 : slabdata     11     11      0
xfs_ioend             32     54    144   27    1 : tunables  120   60    8 : slabdata      2      2      0
xfs_vnode          31498  31572    648    6    1 : tunables   54   27    8 : slabdata   5262   5262      0
nfs_write_data        36     36    832    9    2 : tunables   54   27    8 : slabdata      4      4      0
nfs_read_data         32     35    768    5    1 : tunables   54   27    8 : slabdata      7      7      0
nfs_inode_cache      184    184    992    4    1 : tunables   54   27    8 : slabdata     46     46      0
nfs_page               0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
isofs_inode_cache     10     12    648    6    1 : tunables   54   27    8 : slabdata      2      2      0
journal_handle        81    288     24  144    1 : tunables  120   60    8 : slabdata      2      2      0
journal_head         681   1160     96   40    1 : tunables  120   60    8 : slabdata     29     29    384
revoke_table           6    202     16  202    1 : tunables  120   60    8 : slabdata      1      1      0
revoke_record          0      0     32  112    1 : tunables  120   60    8 : slabdata      0      0      0
ext3_inode_cache    3542   3805    808    5    1 : tunables   54   27    8 : slabdata    761    761      0
ext3_xattr             0      0     88   44    1 : tunables  120   60    8 : slabdata      0      0      0
dnotify_cache          1     92     40   92    1 : tunables  120   60    8 : slabdata      1      1      0
dquot                  0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_pwq          0      0     72   53    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_epi          0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
inotify_event_cache      0      0     40   92    1 : tunables  120   60    8 : slabdata      0      0      0
inotify_watch_cache      0      0     64   59    1 : tunables  120   60    8 : slabdata      0      0      0
kioctx                 0      0    320   12    1 : tunables   54   27    8 : slabdata      0      0      0
kiocb                  0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
fasync_cache           0      0     24  144    1 : tunables  120   60    8 : slabdata      0      0      0
shmem_inode_cache    818    825    808    5    1 : tunables   54   27    8 : slabdata    165    165      0
posix_timers_cache      0      0    168   23    1 : tunables  120   60    8 : slabdata      0      0      0
uid_cache             47    118     64   59    1 : tunables  120   60    8 : slabdata      2      2      0
sgpool-128            32     32   4096    1    1 : tunables   24   12    8 : slabdata     32     32      0
sgpool-64             32     32   2048    2    1 : tunables   24   12    8 : slabdata     16     16      0
sgpool-32             65    120   1024    4    1 : tunables   54   27    8 : slabdata     22     30      3
sgpool-16             36     40    512    8    1 : tunables   54   27    8 : slabdata      5      5      0
sgpool-8             109    195    256   15    1 : tunables  120   60    8 : slabdata     13     13      1
blkdev_ioc           231    469     56   67    1 : tunables  120   60    8 : slabdata      7      7      0
blkdev_queue          80     88    712   11    2 : tunables   54   27    8 : slabdata      8      8      0
blkdev_requests      283    375    264   15    1 : tunables   54   27    8 : slabdata     22     25    216
biovec-(256)         260    260   4096    1    1 : tunables   24   12    8 : slabdata    260    260      0
biovec-128           264    264   2048    2    1 : tunables   24   12    8 : slabdata    132    132      0
biovec-64            304    380   1024    4    1 : tunables   54   27    8 : slabdata     81     95      3
biovec-16            285    300    256   15    1 : tunables  120   60    8 : slabdata     20     20      0
biovec-4             284    354     64   59    1 : tunables  120   60    8 : slabdata      6      6      0
biovec-1             841   4040     16  202    1 : tunables  120   60    8 : slabdata     20     20    480
bio                  870   2430    128   30    1 : tunables  120   60    8 : slabdata     79     81    480
file_lock_cache       38     48    160   24    1 : tunables  120   60    8 : slabdata      2      2      0
sock_inode_cache     832   1250    704    5    1 : tunables   54   27    8 : slabdata    250    250      0
skbuff_fclone_cache   4963   7224    448    8    1 : tunables   54   27    8 : slabdata    903    903    162
skbuff_head_cache    542    675    256   15    1 : tunables  120   60    8 : slabdata     45     45      0
acpi_operand        1028   1060     72   53    1 : tunables  120   60    8 : slabdata     20     20      0
acpi_parse_ext         0      0     64   59    1 : tunables  120   60    8 : slabdata      0      0      0
acpi_parse             0      0     40   92    1 : tunables  120   60    8 : slabdata      0      0      0
acpi_state             0      0     88   44    1 : tunables  120   60    8 : slabdata      0      0      0
proc_inode_cache     910    954    632    6    1 : tunables   54   27    8 : slabdata    159    159     20
sigqueue              10     46    168   23    1 : tunables  120   60    8 : slabdata      2      2      0
radix_tree_node    70767  79870    536    7    1 : tunables   54   27    8 : slabdata  11410  11410      0
bdev_cache            55     56    832    4    1 : tunables   54   27    8 : slabdata     14     14      0
sysfs_dir_cache     3346   3445     72   53    1 : tunables  120   60    8 : slabdata     65     65      0
mnt_cache             39     60    192   20    1 : tunables  120   60    8 : slabdata      3      3      0
inode_cache         1164   1224    600    6    1 : tunables   54   27    8 : slabdata    204    204      0
dentry_cache       44291  48569    224   17    1 : tunables  120   60    8 : slabdata   2857   2857     51
filp                3106   5955    256   15    1 : tunables  120   60    8 : slabdata    397    397     48
names_cache            6      6   4096    1    1 : tunables   24   12    8 : slabdata      6      6      0
idr_layer_cache       90     98    528    7    1 : tunables   54   27    8 : slabdata     14     14      0
buffer_head       218819 233948     88   44    1 : tunables  120   60    8 : slabdata   5317   5317      0
mm_struct            272    483   1152    7    2 : tunables   24   12    8 : slabdata     69     69      3
vm_area_struct     17201  26670    184   21    1 : tunables  120   60    8 : slabdata   1270   1270    480
fs_cache             267    708     64   59    1 : tunables  120   60    8 : slabdata     12     12      0
files_cache          290    440    896    4    1 : tunables   54   27    8 : slabdata    110    110      0
signal_cache         343    546    640    6    1 : tunables   54   27    8 : slabdata     91     91      0
sighand_cache        316    423   2112    3    2 : tunables   24   12    8 : slabdata    141    141      3
task_struct          333    492   1728    4    2 : tunables   24   12    8 : slabdata    123    123      3
anon_vma            1474   3168     24  144    1 : tunables  120   60    8 : slabdata     22     22     12
shared_policy_node      0      0     56   67    1 : tunables  120   60    8 : slabdata      0      0      0
numa_policy           36    404     16  202    1 : tunables  120   60    8 : slabdata      2      2      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768            20     20  32768    1    8 : tunables    8    4    0 : slabdata     20     20      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             1      1  16384    1    4 : tunables    8    4    0 : slabdata      1      1      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192             36     37   8192    1    2 : tunables    8    4    0 : slabdata     36     37      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    8 : slabdata      0      0      0
size-4096            353    357   4096    1    1 : tunables   24   12    8 : slabdata    353    357     15
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    8 : slabdata      0      0      0
size-2048            978    988   2048    2    1 : tunables   24   12    8 : slabdata    492    494      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    8 : slabdata      0      0      0
size-1024           5016   5800   1024    4    1 : tunables   54   27    8 : slabdata   1450   1450    189
size-512(DMA)          0      0    512    8    1 : tunables   54   27    8 : slabdata      0      0      0
size-512             720    776    512    8    1 : tunables   54   27    8 : slabdata     97     97      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
size-256              88    135    256   15    1 : tunables  120   60    8 : slabdata      9      9      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
size-192            1786   2600    192   20    1 : tunables  120   60    8 : slabdata    130    130      0
size-128(DMA)          0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
size-64(DMA)           0      0     64   59    1 : tunables  120   60    8 : slabdata      0      0      0
size-64            18281  33158     64   59    1 : tunables  120   60    8 : slabdata    562    562      0
size-32(DMA)           0      0     32  112    1 : tunables  120   60    8 : slabdata      0      0      0
size-128            5450   9180    128   30    1 : tunables  120   60    8 : slabdata    306    306      1
size-32              950   1232     32  112    1 : tunables  120   60    8 : slabdata     11     11      0
kmem_cache           156    156    640    6    1 : tunables   54   27    8 : slabdata     26     26      0

: 	dmesg -c > /dev/null
: 	echo m > /proc/sysrq-trigger
: 	dmesg

	I don't have sysrq compiled in, sorry. I will recompile/boot
a new kernel maybe tomorrow.

	I have found that this two-hour period of system time peaks is from
a cron job which does a full-text indexing of the archive of the mailing
list I run - so access to many small files (mailing list posts), and update
to the large "inverted index" database. However - this time I have also
kswapd0 with 95% CPU, and the next ~50% is proftpd on the other CPU in the
"R" state, which cannot be killed even with SIGKILL:

top - 01:56:18 up 9 days,  4:00,  2 users,  load average: 4.91, 4.46, 5.71
Tasks: 310 total,  12 running, 298 sleeping,   0 stopped,   0 zombie
Cpu(s):  3.8% us, 73.8% sy,  2.2% ni,  1.5% id, 17.1% wa,  0.2% hi,  1.5% si
Mem:   8174528k total,  8144104k used,    30424k free,    33552k buffers
Swap: 14651256k total,      640k used, 14650616k free,  7570548k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
   16 root      15   0     0    0    0 R 91.8  0.0   1628:43 kswapd0
25345 ftp       22   5 12448 3988  872 R 49.4  0.0  14:30.79 proftpd
21680 apache    17   0 28448 9220 2260 R  2.7  0.1   0:01.39 ezarchive.fcgi
 1449 rsyncd    35  19 19836  11m  948 S  2.3  0.1   9:35.26 rsync
24152 rsyncd    34  19 12764 4568  936 R  1.7  0.1   0:31.54 rsync
30811 rsyncd    35  19 10424 1664  896 S  1.7  0.0   0:13.97 rsync

	Hope this helps,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
> Specs are a basis for _talking_about_ things. But they are _not_ a basis <
> for implementing software.                              --Linus Torvalds <
