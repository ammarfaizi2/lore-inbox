Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161209AbWKFJAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161209AbWKFJAE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 04:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbWKFJAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 04:00:04 -0500
Received: from qb-out-0506.google.com ([72.14.204.227]:12818 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161209AbWKFJAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 04:00:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AqG4PdzuYBQpZP1jJ+AZtu01wwJpPcBg86hDWN2QtRQDkZM/dXhJMYxFnmfjRJ58wYeMJz674pdUxS/a2fXZgdxyKifYFCCuKfioWNc9nuPnjhXTzlCthikXIXTAD2h2fieqH3PBZgW451UeDIuKEaxSWBtzLEyqFphmg3BnN+E=
Message-ID: <f55850a70611060059p28d6baeco9f6f0c0f81b54ba6@mail.gmail.com>
Date: Mon, 6 Nov 2006 16:59:25 +0800
From: "Zhao Xiaoming" <xiaoming.nj@gmail.com>
To: "Eric Dumazet" <dada1@cosmosbay.com>
Subject: Re: ZONE_NORMAL memory exhausted by 4000 TCP sockets
Cc: linux-kernel@vger.kernel.org, "Linux Netdev List" <netdev@vger.kernel.org>
In-Reply-To: <454EE580.5040506@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f55850a70611052207j384e1d3flaf40bb9dd74df7c5@mail.gmail.com>
	 <454EE580.5040506@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/11/6, Eric Dumazet <dada1@cosmosbay.com>:
> We dont know. You might post some data so that we can have some ideas.
>
> Also, these kind of question is better handled by linux netdev mailing list,
> so I added a CC to this list.
>
> cat /proc/slabinfo
> cat /proc/meminfo
> cat /proc/net/sockstat
> cat /proc/buddyinfo
>
>
> TCP stack is one thing, but other things may consume ram on your kernel.
>
> Also, kernel memory allocation might use twice the ram you intend to use
> because of power of two alignments.
>
> Are you using iptables connection tracking ?
>
> If you plan to use a lot of RAM in kernel, why dont you use a 64 bits kernel,
> so that all ram is available for kernel, not only 900 MB ?
>
> Eric
>
>
Thank you again for your help. To have more detailed statistic data, I
did another round of test and gathered some data.  I give the overall
description here and detailed /proc/net/sockstat, /proc/meminfo,
/proc/slabinfo and /proc/buddyinfo follows.
=====================================================
                           slab mem cost        tcp mem pages       lowmem free
with traffic:             254668KB                 34693
      38772KB
without traffic:       104080KB                           1
       702652KB
=====================================================

detailed info:
>>>>>>>>>>during the test (with traffic):>>>>>>>>>>>>>
[root@nj-research-nas-box ~]# cat /proc/net/sockstat
sockets: used 12058
TCP: inuse 4007 orphan 0 tw 0 alloc 4010 mem 34693
UDP: inuse 4
RAW: inuse 0
FRAG: inuse 0 memory 0
[root@nj-research-nas-box ~]# cat /proc/meminfo
MemTotal:      4136580 kB
MemFree:       3169160 kB
Buffers:         42092 kB
Cached:          20048 kB
SwapCached:          0 kB
Active:         146808 kB
Inactive:        35492 kB
HighTotal:     3276160 kB
HighFree:      3130388 kB
LowTotal:       860420 kB
LowFree:         38772 kB
SwapTotal:     2031608 kB
SwapFree:      2031608 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:         127720 kB
Slab:           254668 kB
CommitLimit:   4099896 kB
Committed_AS:   367784 kB
PageTables:       1696 kB
VmallocTotal:   116728 kB
VmallocUsed:      3876 kB
VmallocChunk:   110548 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB
[root@nj-research-nas-box ~]# cat /proc/slabinfo
slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab>
<pagesperslab> : tunables <limit> <batchcount> <sharedfactor> :
slabdata <active_slabs> <num_slabs> <sharedavail>
ip_conntrack_expect      0      0     92   42    1 : tunables  120
60    8 : slabdata      0      0      0
ip_conntrack        4049   4352    228   17    1 : tunables  120   60
  8 : slabdata    256    256      0
bridge_fdb_cache       6     59     64   59    1 : tunables  120   60
  8 : slabdata      1      1      0
fib6_nodes             7    113     32  113    1 : tunables  120   60
  8 : slabdata      1      1      0
ip6_dst_cache         10     30    256   15    1 : tunables  120   60
  8 : slabdata      2      2      0
ndisc_cache            1     20    192   20    1 : tunables  120   60
  8 : slabdata      1      1      0
RAWv6                  7     10    768    5    1 : tunables   54   27
  8 : slabdata      2      2      0
UDPv6                  0      0    704   11    2 : tunables   54   27
  8 : slabdata      0      0      0
tw_sock_TCPv6          0      0    128   30    1 : tunables  120   60
  8 : slabdata      0      0      0
request_sock_TCPv6      0      0    128   30    1 : tunables  120   60
   8 : slabdata      0      0      0
TCPv6                  3      3   1344    3    1 : tunables   24   12
  8 : slabdata      1      1      0
cifs_small_rq         30     36    448    9    1 : tunables   54   27
  8 : slabdata      4      4      0
cifs_request           4      4  16512    1    8 : tunables    8    4
  0 : slabdata      4      4      0
cifs_oplock_structs      0      0     32  113    1 : tunables  120
60    8 : slabdata      0      0      0
cifs_mpx_ids           3     59     64   59    1 : tunables  120   60
  8 : slabdata      1      1      0
cifs_inode_cache       0      0    496    8    1 : tunables   54   27
  8 : slabdata      0      0      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12
  8 : slabdata      4      4      0
rpc_tasks              8     20    192   20    1 : tunables  120   60
  8 : slabdata      1      1      0
rpc_inode_cache        6      7    576    7    1 : tunables   54   27
  8 : slabdata      1      1      0
ip_fib_alias           9    113     32  113    1 : tunables  120   60
  8 : slabdata      1      1      0
ip_fib_hash            9    113     32  113    1 : tunables  120   60
  8 : slabdata      1      1      0
uhci_urb_priv          0      0     40   92    1 : tunables  120   60
  8 : slabdata      0      0      0
dm-snapshot-in       128    134     56   67    1 : tunables  120   60
  8 : slabdata      2      2      0
dm-snapshot-ex         0      0     24  145    1 : tunables  120   60
  8 : slabdata      0      0      0
ext3_inode_cache    8275  18378    640    6    1 : tunables   54   27
  8 : slabdata   3063   3063      0
ext3_xattr             1     78     48   78    1 : tunables  120   60
  8 : slabdata      1      1      0
journal_handle        18    169     20  169    1 : tunables  120   60
  8 : slabdata      1      1      0
journal_head          19     72     52   72    1 : tunables  120   60
  8 : slabdata      1      1      0
revoke_table           4    254     12  254    1 : tunables  120   60
  8 : slabdata      1      1      0
revoke_record          0      0     16  203    1 : tunables  120   60
  8 : slabdata      0      0      0
dm_tio               525    609     16  203    1 : tunables  120   60
  8 : slabdata      3      3      0
dm_io                525    676     20  169    1 : tunables  120   60
  8 : slabdata      4      4      0
scsi_cmd_cache         3     10    384   10    1 : tunables   54   27
  8 : slabdata      1      1      0
sgpool-128            32     33   2560    3    2 : tunables   24   12
  8 : slabdata     11     11      0
sgpool-64             32     33   1280    3    1 : tunables   24   12
  8 : slabdata     11     11      0
sgpool-32             32     36    640    6    1 : tunables   54   27
  8 : slabdata      6      6      0
sgpool-16             32     36    320   12    1 : tunables   54   27
  8 : slabdata      3      3      0
sgpool-8              34     40    192   20    1 : tunables  120   60
  8 : slabdata      2      2      0
scsi_io_context        0      0    104   37    1 : tunables  120   60
  8 : slabdata      0      0      0
UNIX                  23     77    576    7    1 : tunables   54   27
  8 : slabdata     11     11      0
ip_mrt_cache           0      0    128   30    1 : tunables  120   60
  8 : slabdata      0      0      0
tcp_bind_bucket     2025   2233     16  203    1 : tunables  120   60
  8 : slabdata     11     11      0
inet_peer_cache        1     59     64   59    1 : tunables  120   60
  8 : slabdata      1      1      0
secpath_cache          0      0    128   30    1 : tunables  120   60
  8 : slabdata      0      0      0
xfrm_dst_cache         0      0    320   12    1 : tunables   54   27
  8 : slabdata      0      0      0
ip_dst_cache          11     30    256   15    1 : tunables  120   60
  8 : slabdata      2      2      0
arp_cache              3     20    192   20    1 : tunables  120   60
  8 : slabdata      1      1      0
RAW                    5      6    640    6    1 : tunables   54   27
  8 : slabdata      1      1      0
UDP                    4     18    640    6    1 : tunables   54   27
  8 : slabdata      3      3      0
tw_sock_TCP            0      0    128   30    1 : tunables  120   60
  8 : slabdata      0      0      0
request_sock_TCP       2     59     64   59    1 : tunables  120   60
  8 : slabdata      1      1      0
TCP                 4029   4044   1280    3    1 : tunables   24   12
  8 : slabdata   1348   1348      0
flow_cache             0      0    128   30    1 : tunables  120   60
  8 : slabdata      0      0      0
msi_cache              8      8   3840    1    1 : tunables   24   12
  8 : slabdata      8      8      0
cfq_ioc_pool           0      0     48   78    1 : tunables  120   60
  8 : slabdata      0      0      0
cfq_pool               0      0     96   40    1 : tunables  120   60
  8 : slabdata      0      0      0
crq_pool               0      0     48   78    1 : tunables  120   60
  8 : slabdata      0      0      0
deadline_drq           0      0     52   72    1 : tunables  120   60
  8 : slabdata      0      0      0
as_arq                12    118     64   59    1 : tunables  120   60
  8 : slabdata      2      2      0
mqueue_inode_cache      1     11    704   11    2 : tunables   54   27
   8 : slabdata      1      1      0
isofs_inode_cache      0      0    488    8    1 : tunables   54   27
  8 : slabdata      0      0      0
hugetlbfs_inode_cache      1      8    460    8    1 : tunables   54
27    8 : slabdata      1      1      0
ext2_inode_cache       0      0    620    6    1 : tunables   54   27
  8 : slabdata      0      0      0
ext2_xattr             0      0     48   78    1 : tunables  120   60
  8 : slabdata      0      0      0
dnotify_cache          1    169     20  169    1 : tunables  120   60
  8 : slabdata      1      1      0
dquot                  0      0    192   20    1 : tunables  120   60
  8 : slabdata      0      0      0
eventpoll_pwq          1    101     36  101    1 : tunables  120   60
  8 : slabdata      1      1      0
eventpoll_epi          1     30    128   30    1 : tunables  120   60
  8 : slabdata      1      1      0
inotify_event_cache      0      0     28  127    1 : tunables  120
60    8 : slabdata      0      0      0
inotify_watch_cache      0      0     36  101    1 : tunables  120
60    8 : slabdata      0      0      0
kioctx                 0      0    256   15    1 : tunables  120   60
  8 : slabdata      0      0      0
kiocb                  0      0    128   30    1 : tunables  120   60
  8 : slabdata      0      0      0
fasync_cache           0      0     16  203    1 : tunables  120   60
  8 : slabdata      0      0      0
shmem_inode_cache    252    273    568    7    1 : tunables   54   27
  8 : slabdata     39     39      0
posix_timers_cache      0      0    112   35    1 : tunables  120   60
   8 : slabdata      0      0      0
uid_cache              7     59     64   59    1 : tunables  120   60
  8 : slabdata      1      1      0
blkdev_ioc            22    254     28  127    1 : tunables  120   60
  8 : slabdata      2      2      0
blkdev_queue          22     28    976    4    1 : tunables   54   27
  8 : slabdata      7      7      0
blkdev_requests       12     44    176   22    1 : tunables  120   60
  8 : slabdata      2      2      0
biovec-(256)         260    260   3072    2    2 : tunables   24   12
  8 : slabdata    130    130      0
biovec-128           264    270   1536    5    2 : tunables   24   12
  8 : slabdata     54     54      0
biovec-64            272    275    768    5    1 : tunables   54   27
  8 : slabdata     55     55      0
biovec-16            272    280    192   20    1 : tunables  120   60
  8 : slabdata     14     14      0
biovec-4             272    295     64   59    1 : tunables  120   60
  8 : slabdata      5      5      0
biovec-1             288    406     16  203    1 : tunables  120   60
  8 : slabdata      2      2      0
bio                  272    300    128   30    1 : tunables  120   60
  8 : slabdata     10     10      0
sock_inode_cache   12082  12120    512    8    1 : tunables   54   27
  8 : slabdata   1515   1515      0
skbuff_fclone_cache   5211   6210    384   10    1 : tunables   54
27    8 : slabdata    621    621    189
skbuff_head_cache 106780 113080    192   20    1 : tunables  120   60
  8 : slabdata   5654   5654      0
file_lock_cache       37     37    104   37    1 : tunables  120   60
  8 : slabdata      1      1      0
acpi_operand         579    644     40   92    1 : tunables  120   60
  8 : slabdata      7      7      0
acpi_parse_ext         0      0     44   84    1 : tunables  120   60
  8 : slabdata      0      0      0
acpi_parse             0      0     28  127    1 : tunables  120   60
  8 : slabdata      0      0      0
acpi_state             0      0     48   78    1 : tunables  120   60
  8 : slabdata      0      0      0
proc_inode_cache     296    504    476    8    1 : tunables   54   27
  8 : slabdata     63     63      0
sigqueue               5     54    144   27    1 : tunables  120   60
  8 : slabdata      2      2      0
radix_tree_node     2397  12264    276   14    1 : tunables   54   27
  8 : slabdata    876    876      0
bdev_cache            22     42    640    6    1 : tunables   54   27
  8 : slabdata      7      7      0
sysfs_dir_cache     3645   3680     40   92    1 : tunables  120   60
  8 : slabdata     40     40      0
mnt_cache             28     60    128   30    1 : tunables  120   60
  8 : slabdata      2      2      0
inode_cache          817   1048    460    8    1 : tunables   54   27
  8 : slabdata    131    131      0
dentry_cache       10991  44361    144   27    1 : tunables  120   60
  8 : slabdata   1643   1643      0
filp                4777   4860    192   20    1 : tunables  120   60
  8 : slabdata    243    243     60
names_cache            1      1   4096    1    1 : tunables   24   12
  8 : slabdata      1      1      0
avc_node              31     72     52   72    1 : tunables  120   60
  8 : slabdata      1      1      0
key_jar               14     30    128   30    1 : tunables  120   60
  8 : slabdata      1      1      0
idr_layer_cache      117    174    136   29    1 : tunables  120   60
  8 : slabdata      6      6      0
buffer_head        10552  22104     52   72    1 : tunables  120   60
  8 : slabdata    307    307      0
mm_struct             62     98    512    7    1 : tunables   54   27
  8 : slabdata     14     14      0
vm_area_struct     21346  21504     92   42    1 : tunables  120   60
  8 : slabdata    512    512      0
fs_cache              63    295     64   59    1 : tunables  120   60
  8 : slabdata      5      5      0
files_cache           63    117    448    9    1 : tunables   54   27
  8 : slabdata     13     13      0
signal_cache         109    160    384   10    1 : tunables   54   27
  8 : slabdata     16     16      0
sighand_cache        104    129   1344    3    1 : tunables   24   12
  8 : slabdata     43     43      0
task_struct        10095  10095   1360    3    1 : tunables   24   12
  8 : slabdata   3365   3365      0
anon_vma             693   1015     24  145    1 : tunables  120   60
  8 : slabdata      7      7      0
pgd                   65    339     32  113    1 : tunables  120   60
  8 : slabdata      3      3      0
pmd                  138    138   4096    1    1 : tunables   24   12
  8 : slabdata    138    138      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4
  0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4
  0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4
  0 : slabdata      0      0      0
size-65536             2      2  65536    1   16 : tunables    8    4
  0 : slabdata      2      2      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4
  0 : slabdata      0      0      0
size-32768             2      2  32768    1    8 : tunables    8    4
  0 : slabdata      2      2      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4
  0 : slabdata      0      0      0
size-16384             0      0  16384    1    4 : tunables    8    4
  0 : slabdata      0      0      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4
  0 : slabdata      0      0      0
size-8192              4      4   8192    1    2 : tunables    8    4
  0 : slabdata      4      4      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12
  8 : slabdata      0      0      0
size-4096          10148  10148   4096    1    1 : tunables   24   12
  8 : slabdata  10148  10148      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12
  8 : slabdata      0      0      0
size-2048            144    144   2048    2    1 : tunables   24   12
  8 : slabdata     72     72      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27
  8 : slabdata      0      0      0
size-1024         106994 112672   1024    4    1 : tunables   54   27
  8 : slabdata  28168  28168      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27
  8 : slabdata      0      0      0
size-512            5722   7184    512    8    1 : tunables   54   27
  8 : slabdata    898    898    189
size-256(DMA)          0      0    256   15    1 : tunables  120   60
  8 : slabdata      0      0      0
size-256             378    390    256   15    1 : tunables  120   60
  8 : slabdata     26     26      0
size-128(DMA)          0      0    128   30    1 : tunables  120   60
  8 : slabdata      0      0      0
size-64(DMA)           0      0     64   59    1 : tunables  120   60
  8 : slabdata      0      0      0
size-32(DMA)           0      0     32  113    1 : tunables  120   60
  8 : slabdata      0      0      0
size-32            28024  28024     32  113    1 : tunables  120   60
  8 : slabdata    248    248    180
size-128            1621   1800    128   30    1 : tunables  120   60
  8 : slabdata     60     60      0
size-64           162644 200128     64   59    1 : tunables  120   60
  8 : slabdata   3392   3392      0
kmem_cache           165    165    256   15    1 : tunables  120   60
  8 : slabdata     11     11      0
[root@nj-research-nas-box ~]# cat /proc/buddyinfo
Node 0, zone      DMA    490    202     23      0      1      1      1
     0      1      1      0
Node 0, zone   Normal   2199   5197    505     39      2      0      1
     0      1      0      0
Node 0, zone  HighMem      1   1028    866    485    293    128     47
    38     25     25    718

>>>>>>>>>>>>>after the test (without traffic)>>>>>>>>>>>>>>>>>
[root@nj-research-nas-box ~]# cat /proc/net/sockstat
sockets: used 10058
TCP: inuse 7 orphan 0 tw 0 alloc 10 mem 1
UDP: inuse 4
RAW: inuse 0
FRAG: inuse 0 memory 0
[root@nj-research-nas-box ~]# cat /proc/meminfo
MemTotal:      4136580 kB
MemFree:       3806132 kB
Buffers:         39196 kB
Cached:          20084 kB
SwapCached:          0 kB
Active:         172524 kB
Inactive:        34140 kB
HighTotal:     3276160 kB
HighFree:      3103480 kB
LowTotal:       860420 kB
LowFree:        702652 kB
SwapTotal:     2031608 kB
SwapFree:      2031608 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:         154996 kB
Slab:           104080 kB
CommitLimit:   4099896 kB
Committed_AS:   367676 kB
PageTables:       1696 kB
VmallocTotal:   116728 kB
VmallocUsed:      3876 kB
VmallocChunk:   110548 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB
[root@nj-research-nas-box ~]# cat /proc/slabinfo
slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab>
<pagesperslab> : tunables <limit> <batchcount> <sharedfactor> :
slabdata <active_slabs> <num_slabs> <sharedavail>
ip_conntrack_expect      0      0     92   42    1 : tunables  120
60    8 : slabdata      0      0      0
ip_conntrack           4     51    228   17    1 : tunables  120   60
  8 : slabdata      3      3      0
bridge_fdb_cache       7     59     64   59    1 : tunables  120   60
  8 : slabdata      1      1      0
fib6_nodes             7    113     32  113    1 : tunables  120   60
  8 : slabdata      1      1      0
ip6_dst_cache         10     30    256   15    1 : tunables  120   60
  8 : slabdata      2      2      0
ndisc_cache            1     20    192   20    1 : tunables  120   60
  8 : slabdata      1      1      0
RAWv6                  7     10    768    5    1 : tunables   54   27
  8 : slabdata      2      2      0
UDPv6                  0      0    704   11    2 : tunables   54   27
  8 : slabdata      0      0      0
tw_sock_TCPv6          0      0    128   30    1 : tunables  120   60
  8 : slabdata      0      0      0
request_sock_TCPv6      0      0    128   30    1 : tunables  120   60
   8 : slabdata      0      0      0
TCPv6                  3      3   1344    3    1 : tunables   24   12
  8 : slabdata      1      1      0
cifs_small_rq         30     36    448    9    1 : tunables   54   27
  8 : slabdata      4      4      0
cifs_request           4      4  16512    1    8 : tunables    8    4
  0 : slabdata      4      4      0
cifs_oplock_structs      0      0     32  113    1 : tunables  120
60    8 : slabdata      0      0      0
cifs_mpx_ids           3     59     64   59    1 : tunables  120   60
  8 : slabdata      1      1      0
cifs_inode_cache       0      0    496    8    1 : tunables   54   27
  8 : slabdata      0      0      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12
  8 : slabdata      4      4      0
rpc_tasks              8     20    192   20    1 : tunables  120   60
  8 : slabdata      1      1      0
rpc_inode_cache        6      7    576    7    1 : tunables   54   27
  8 : slabdata      1      1      0
ip_fib_alias           9    113     32  113    1 : tunables  120   60
  8 : slabdata      1      1      0
ip_fib_hash            9    113     32  113    1 : tunables  120   60
  8 : slabdata      1      1      0
uhci_urb_priv          0      0     40   92    1 : tunables  120   60
  8 : slabdata      0      0      0
dm-snapshot-in       128    134     56   67    1 : tunables  120   60
  8 : slabdata      2      2      0
dm-snapshot-ex         0      0     24  145    1 : tunables  120   60
  8 : slabdata      0      0      0
ext3_inode_cache    6611  16482    640    6    1 : tunables   54   27
  8 : slabdata   2747   2747      0
ext3_xattr             1     78     48   78    1 : tunables  120   60
  8 : slabdata      1      1      0
journal_handle        24    169     20  169    1 : tunables  120   60
  8 : slabdata      1      1      0
journal_head          11     72     52   72    1 : tunables  120   60
  8 : slabdata      1      1      0
revoke_table           4    254     12  254    1 : tunables  120   60
  8 : slabdata      1      1      0
revoke_record          0      0     16  203    1 : tunables  120   60
  8 : slabdata      0      0      0
dm_tio               516    609     16  203    1 : tunables  120   60
  8 : slabdata      3      3      0
dm_io                516    676     20  169    1 : tunables  120   60
  8 : slabdata      4      4      0
scsi_cmd_cache        10     10    384   10    1 : tunables   54   27
  8 : slabdata      1      1      0
sgpool-128            32     33   2560    3    2 : tunables   24   12
  8 : slabdata     11     11      0
sgpool-64             32     33   1280    3    1 : tunables   24   12
  8 : slabdata     11     11      0
sgpool-32             32     36    640    6    1 : tunables   54   27
  8 : slabdata      6      6      0
sgpool-16             32     36    320   12    1 : tunables   54   27
  8 : slabdata      3      3      0
sgpool-8              40     40    192   20    1 : tunables  120   60
  8 : slabdata      2      2      0
scsi_io_context        0      0    104   37    1 : tunables  120   60
  8 : slabdata      0      0      0
UNIX                  23     77    576    7    1 : tunables   54   27
  8 : slabdata     11     11      0
ip_mrt_cache           0      0    128   30    1 : tunables  120   60
  8 : slabdata      0      0      0
tcp_bind_bucket        8    203     16  203    1 : tunables  120   60
  8 : slabdata      1      1      0
inet_peer_cache        1     59     64   59    1 : tunables  120   60
  8 : slabdata      1      1      0
secpath_cache          0      0    128   30    1 : tunables  120   60
  8 : slabdata      0      0      0
xfrm_dst_cache         0      0    320   12    1 : tunables   54   27
  8 : slabdata      0      0      0
ip_dst_cache          12     30    256   15    1 : tunables  120   60
  8 : slabdata      2      2      0
arp_cache              3     20    192   20    1 : tunables  120   60
  8 : slabdata      1      1      0
RAW                    5      6    640    6    1 : tunables   54   27
  8 : slabdata      1      1      0
UDP                    4     18    640    6    1 : tunables   54   27
  8 : slabdata      3      3      0
tw_sock_TCP            0      0    128   30    1 : tunables  120   60
  8 : slabdata      0      0      0
request_sock_TCP       0      0     64   59    1 : tunables  120   60
  8 : slabdata      0      0      0
TCP                    7     12   1280    3    1 : tunables   24   12
  8 : slabdata      4      4      0
flow_cache             0      0    128   30    1 : tunables  120   60
  8 : slabdata      0      0      0
msi_cache              8      8   3840    1    1 : tunables   24   12
  8 : slabdata      8      8      0
cfq_ioc_pool           0      0     48   78    1 : tunables  120   60
  8 : slabdata      0      0      0
cfq_pool               0      0     96   40    1 : tunables  120   60
  8 : slabdata      0      0      0
crq_pool               0      0     48   78    1 : tunables  120   60
  8 : slabdata      0      0      0
deadline_drq           0      0     52   72    1 : tunables  120   60
  8 : slabdata      0      0      0
as_arq                13    118     64   59    1 : tunables  120   60
  8 : slabdata      2      2      0
mqueue_inode_cache      1     11    704   11    2 : tunables   54   27
   8 : slabdata      1      1      0
isofs_inode_cache      0      0    488    8    1 : tunables   54   27
  8 : slabdata      0      0      0
hugetlbfs_inode_cache      1      8    460    8    1 : tunables   54
27    8 : slabdata      1      1      0
ext2_inode_cache       0      0    620    6    1 : tunables   54   27
  8 : slabdata      0      0      0
ext2_xattr             0      0     48   78    1 : tunables  120   60
  8 : slabdata      0      0      0
dnotify_cache          1    169     20  169    1 : tunables  120   60
  8 : slabdata      1      1      0
dquot                  0      0    192   20    1 : tunables  120   60
  8 : slabdata      0      0      0
eventpoll_pwq          1    101     36  101    1 : tunables  120   60
  8 : slabdata      1      1      0
eventpoll_epi          1     30    128   30    1 : tunables  120   60
  8 : slabdata      1      1      0
inotify_event_cache      0      0     28  127    1 : tunables  120
60    8 : slabdata      0      0      0
inotify_watch_cache      0      0     36  101    1 : tunables  120
60    8 : slabdata      0      0      0
kioctx                 0      0    256   15    1 : tunables  120   60
  8 : slabdata      0      0      0
kiocb                  0      0    128   30    1 : tunables  120   60
  8 : slabdata      0      0      0
fasync_cache           0      0     16  203    1 : tunables  120   60
  8 : slabdata      0      0      0
shmem_inode_cache    252    273    568    7    1 : tunables   54   27
  8 : slabdata     39     39      0
posix_timers_cache      0      0    112   35    1 : tunables  120   60
   8 : slabdata      0      0      0
uid_cache              7     59     64   59    1 : tunables  120   60
  8 : slabdata      1      1      0
blkdev_ioc            22    254     28  127    1 : tunables  120   60
  8 : slabdata      2      2      0
blkdev_queue          22     28    976    4    1 : tunables   54   27
  8 : slabdata      7      7      0
blkdev_requests       13     44    176   22    1 : tunables  120   60
  8 : slabdata      2      2      0
biovec-(256)         260    260   3072    2    2 : tunables   24   12
  8 : slabdata    130    130      0
biovec-128           264    270   1536    5    2 : tunables   24   12
  8 : slabdata     54     54      0
biovec-64            272    275    768    5    1 : tunables   54   27
  8 : slabdata     55     55      0
biovec-16            272    280    192   20    1 : tunables  120   60
  8 : slabdata     14     14      0
biovec-4             272    295     64   59    1 : tunables  120   60
  8 : slabdata      5      5      0
biovec-1             286    406     16  203    1 : tunables  120   60
  8 : slabdata      2      2      0
bio                  300    300    128   30    1 : tunables  120   60
  8 : slabdata     10     10      0
sock_inode_cache   10059  11712    512    8    1 : tunables   54   27
  8 : slabdata   1464   1464      0
skbuff_fclone_cache     10     10    384   10    1 : tunables   54
27    8 : slabdata      1      1      0
skbuff_head_cache    825   9840    192   20    1 : tunables  120   60
  8 : slabdata    492    492      0
file_lock_cache       13     37    104   37    1 : tunables  120   60
  8 : slabdata      1      1      0
acpi_operand         579    644     40   92    1 : tunables  120   60
  8 : slabdata      7      7      0
acpi_parse_ext         0      0     44   84    1 : tunables  120   60
  8 : slabdata      0      0      0
acpi_parse             0      0     28  127    1 : tunables  120   60
  8 : slabdata      0      0      0
acpi_state             0      0     48   78    1 : tunables  120   60
  8 : slabdata      0      0      0
proc_inode_cache     326    504    476    8    1 : tunables   54   27
  8 : slabdata     63     63      0
sigqueue               4     54    144   27    1 : tunables  120   60
  8 : slabdata      2      2      0
radix_tree_node     2283  12264    276   14    1 : tunables   54   27
  8 : slabdata    876    876      0
bdev_cache            22     42    640    6    1 : tunables   54   27
  8 : slabdata      7      7      0
sysfs_dir_cache     3645   3680     40   92    1 : tunables  120   60
  8 : slabdata     40     40      0
mnt_cache             28     60    128   30    1 : tunables  120   60
  8 : slabdata      2      2      0
inode_cache          817   1048    460    8    1 : tunables   54   27
  8 : slabdata    131    131      0
dentry_cache        5144  29268    144   27    1 : tunables  120   60
  8 : slabdata   1084   1084      0
filp                 825   2160    192   20    1 : tunables  120   60
  8 : slabdata    108    108    104
names_cache            3      4   4096    1    1 : tunables   24   12
  8 : slabdata      3      4      0
avc_node              31     72     52   72    1 : tunables  120   60
  8 : slabdata      1      1      0
key_jar               14     30    128   30    1 : tunables  120   60
  8 : slabdata      1      1      0
idr_layer_cache      117    174    136   29    1 : tunables  120   60
  8 : slabdata      6      6      0
buffer_head         9838  21888     52   72    1 : tunables  120   60
  8 : slabdata    304    304      0
mm_struct             76     98    512    7    1 : tunables   54   27
  8 : slabdata     14     14      0
vm_area_struct     21343  21504     92   42    1 : tunables  120   60
  8 : slabdata    512    512      0
fs_cache              63    295     64   59    1 : tunables  120   60
  8 : slabdata      5      5      0
files_cache           64    117    448    9    1 : tunables   54   27
  8 : slabdata     13     13      0
signal_cache         110    160    384   10    1 : tunables   54   27
  8 : slabdata     16     16      0
sighand_cache        104    129   1344    3    1 : tunables   24   12
  8 : slabdata     43     43      0
task_struct        10095  10095   1360    3    1 : tunables   24   12
  8 : slabdata   3365   3365      0
anon_vma             692   1015     24  145    1 : tunables  120   60
  8 : slabdata      7      7      0
pgd                   63    339     32  113    1 : tunables  120   60
  8 : slabdata      3      3      0
pmd                  138    138   4096    1    1 : tunables   24   12
  8 : slabdata    138    138      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4
  0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4
  0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4
  0 : slabdata      0      0      0
size-65536             2      2  65536    1   16 : tunables    8    4
  0 : slabdata      2      2      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4
  0 : slabdata      0      0      0
size-32768             2      2  32768    1    8 : tunables    8    4
  0 : slabdata      2      2      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4
  0 : slabdata      0      0      0
size-16384             0      0  16384    1    4 : tunables    8    4
  0 : slabdata      0      0      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4
  0 : slabdata      0      0      0
size-8192              4      4   8192    1    2 : tunables    8    4
  0 : slabdata      4      4      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12
  8 : slabdata      0      0      0
size-4096          10149  10149   4096    1    1 : tunables   24   12
  8 : slabdata  10149  10149      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12
  8 : slabdata      0      0      0
size-2048            144    144   2048    2    1 : tunables   24   12
  8 : slabdata     72     72      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27
  8 : slabdata      0      0      0
size-1024           1027   2608   1024    4    1 : tunables   54   27
  8 : slabdata    652    652      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27
  8 : slabdata      0      0      0
size-512             534    576    512    8    1 : tunables   54   27
  8 : slabdata     72     72      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60
  8 : slabdata      0      0      0
size-256             376    390    256   15    1 : tunables  120   60
  8 : slabdata     26     26      0
size-128(DMA)          0      0    128   30    1 : tunables  120   60
  8 : slabdata      0      0      0
size-64(DMA)           0      0     64   59    1 : tunables  120   60
  8 : slabdata      0      0      0
size-32(DMA)           0      0     32  113    1 : tunables  120   60
  8 : slabdata      0      0      0
size-32            23722  25199     32  113    1 : tunables  120   60
  8 : slabdata    223    223      0
size-128            1664   1800    128   30    1 : tunables  120   60
  8 : slabdata     60     60      0
size-64            24367 151335     64   59    1 : tunables  120   60
  8 : slabdata   2565   2565      0
kmem_cache           165    165    256   15    1 : tunables  120   60
  8 : slabdata     11     11      0
[root@nj-research-nas-box ~]# cat /proc/buddyinfo
Node 0, zone      DMA     65     57     58     43     28     20      5
     1      1      1      0
Node 0, zone   Normal  10782   7077   4643   3291   2087   1177    368
    58      3      0      0
Node 0, zone  HighMem      0      1    225    485    293    128     47
    38     25     25    718
