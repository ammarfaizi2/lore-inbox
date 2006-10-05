Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWJEIUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWJEIUx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 04:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWJEIUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 04:20:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:13770 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751322AbWJEIUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 04:20:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=VsC93tEPPhgqkkNC1Z0sjNdS5vasTWfk+GmSAghgAVo6SARtVFPoDx4xqUaNf7oZpAMCwxb4SkIb/5sOFYwLgJ6ekEl/Aq9ae1TS8BFCxWP8BU7Bup2D1RtS6hh/cENMCHdwbc0eyd3tuEp+L2K0IgSofXi2JdnUgM1oTq0nuDA=
Message-ID: <4524C05D.6080305@web.de>
Date: Thu, 05 Oct 2006 10:20:45 +0200
From: Markus Wenke <M.Wenke@web.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-AT; rv:1.8.0.6) Gecko/20060729 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: to many sockets ?
References: <4523CD4E.10806@web.de> <1159979587.25772.82.camel@localhost.localdomain> <4524B0E9.8010005@web.de> <200610050958.38036.dada1@cosmosbay.com>
In-Reply-To: <200610050958.38036.dada1@cosmosbay.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet schrieb:
> On Thursday 05 October 2006 09:14, Markus Wenke wrote:
>
>   
>> I tried the same scenario with SO_SNDBUF = SO_RCVBUF = 8k, so that the
>> max memory is ca. 2G
>> and the oom-killer kills my application at the same time (at 140000
>> connections).
>>
>> I can not see in the messages that the system is out of memory,
>> there is also no swap space used
>>
>> You can download my /var/log/messages at
>> http://hemaho.mine.nu/~biber/messages
>>
>> May you can give me a hint which line/value in the log shows me,
>> that the system is out of memory?
>>     
>
> I think you lack of LOWMEM, since you use a 32bits kernel.
>
> Could you post here the result of these commands when your system is using 
> more than 100.000 connections (and before the OOM :) )

Hi,

here the results with 130001 connetions
>
> cat /proc/meminfo
MemTotal:      3108372 kB
MemFree:       2114404 kB
Buffers:          5112 kB
Cached:          97804 kB
SwapCached:          0 kB
Active:         140552 kB
Inactive:        38948 kB
HighTotal:     2228160 kB
HighFree:      2048108 kB
LowTotal:       880212 kB
LowFree:         66296 kB
SwapTotal:     2104472 kB
SwapFree:      2104472 kB
Dirty:              52 kB
Writeback:           0 kB
AnonPages:       76532 kB
Mapped:           9180 kB
Slab:           282716 kB
PageTables:        592 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:   3658656 kB
Committed_AS:   157968 kB
VmallocTotal:   110584 kB
VmallocUsed:      9244 kB
VmallocChunk:   100676 kB

> cat /proc/slabinfo
slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> 
<pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata 
<active_slabs> <num_slabs> <sharedavail>
cifs_small_rq         45     45    448    9    1 : tunables   54   27    
8 : slabdata      5      5      0
cifs_request           6      6  16512    1    8 : tunables    8    4    
0 : slabdata      6      6      0
cifs_oplock_structs      0      0     32  113    1 : tunables  120   
60    8 : slabdata      0      0      0
cifs_mpx_ids           4     59     64   59    1 : tunables  120   60    
8 : slabdata      1      1      0
cifs_inode_cache      20     20    384   10    1 : tunables   54   27    
8 : slabdata      2      2      0
fib6_nodes             5    113     32  113    1 : tunables  120   60    
8 : slabdata      1      1      0
ip6_dst_cache          4     15    256   15    1 : tunables  120   60    
8 : slabdata      1      1      0
ndisc_cache            1     20    192   20    1 : tunables  120   60    
8 : slabdata      1      1      0
RAWv6                  5      6    640    6    1 : tunables   54   27    
8 : slabdata      1      1      0
UDPv6                  0      0    640    6    1 : tunables   54   27    
8 : slabdata      0      0      0
tw_sock_TCPv6          0      0    128   30    1 : tunables  120   60    
8 : slabdata      0      0      0
request_sock_TCPv6      0      0    128   30    1 : tunables  120   
60    8 : slabdata      0      0      0
TCPv6                  2      3   1280    3    1 : tunables   24   12    
8 : slabdata      1      1      0
ip_fib_alias          11    113     32  113    1 : tunables  120   60    
8 : slabdata      1      1      0
ip_fib_hash           11    113     32  113    1 : tunables  120   60    
8 : slabdata      1      1      0
dm_tio                 0      0     16  203    1 : tunables  120   60    
8 : slabdata      0      0      0
dm_io                  0      0     20  169    1 : tunables  120   60    
8 : slabdata      0      0      0
jbd_4k                 0      0   4096    1    1 : tunables   24   12    
8 : slabdata      0      0      0
scsi_cmd_cache         8     12    320   12    1 : tunables   54   27    
8 : slabdata      1      1      0
UNIX                 119    144    448    9    1 : tunables   54   27    
8 : slabdata     16     16      0
flow_cache             0      0    128   30    1 : tunables  120   60    
8 : slabdata      0      0      0
msi_cache              4    113     32  113    1 : tunables  120   60    
8 : slabdata      1      1      0
cfq_ioc_pool          25    168     92   42    1 : tunables  120   60    
8 : slabdata      4      4      0
cfq_pool              26    160     96   40    1 : tunables  120   60    
8 : slabdata      4      4      0
crq_pool              17     84     44   84    1 : tunables  120   60    
8 : slabdata      1      1      0
deadline_drq           0      0     44   84    1 : tunables  120   60    
8 : slabdata      0      0      0
as_arq                 0      0     56   67    1 : tunables  120   60    
8 : slabdata      0      0      0
mqueue_inode_cache      1      7    576    7    1 : tunables   54   
27    8 : slabdata      1      1      0
isofs_inode_cache      0      0    376   10    1 : tunables   54   27    
8 : slabdata      0      0      0
minix_inode_cache      0      0    412    9    1 : tunables   54   27    
8 : slabdata      0      0      0
ext2_inode_cache       0      0    484    8    1 : tunables   54   27    
8 : slabdata      0      0      0
ext2_xattr             0      0     48   78    1 : tunables  120   60    
8 : slabdata      0      0      0
journal_handle        16    169     20  169    1 : tunables  120   60    
8 : slabdata      1      1      0
journal_head          15    432     52   72    1 : tunables  120   60    
8 : slabdata      6      6      1
revoke_table           6    254     12  254    1 : tunables  120   60    
8 : slabdata      1      1      0
revoke_record          0      0     16  203    1 : tunables  120   60    
8 : slabdata      0      0      0
ext3_inode_cache    1990   1992    500    8    1 : tunables   54   27    
8 : slabdata    249    249      0
ext3_xattr             0      0     48   78    1 : tunables  120   60    
8 : slabdata      0      0      0
dnotify_cache          1    169     20  169    1 : tunables  120   60    
8 : slabdata      1      1      0
dquot                  0      0    128   30    1 : tunables  120   60    
8 : slabdata      0      0      0
eventpoll_pwq     130018 130088     36  101    1 : tunables  120   60    
8 : slabdata   1288   1288      0
eventpoll_epi     130018 130020    128   30    1 : tunables  120   60    
8 : slabdata   4334   4334      0
inotify_event_cache      0      0     28  127    1 : tunables  120   
60    8 : slabdata      0      0      0
inotify_watch_cache      1     92     40   92    1 : tunables  120   
60    8 : slabdata      1      1      0
kioctx                 0      0    192   20    1 : tunables  120   60    
8 : slabdata      0      0      0
kiocb                  0      0    128   30    1 : tunables  120   60    
8 : slabdata      0      0      0
fasync_cache           0      0     16  203    1 : tunables  120   60    
8 : slabdata      0      0      0
shmem_inode_cache    423    459    444    9    1 : tunables   54   27    
8 : slabdata     51     51      0
posix_timers_cache      0      0     88   44    1 : tunables  120   
60    8 : slabdata      0      0      0
uid_cache              5     59     64   59    1 : tunables  120   60    
8 : slabdata      1      1      0
ip_mrt_cache           0      0    128   30    1 : tunables  120   60    
8 : slabdata      0      0      0
tcp_bind_bucket       10    203     16  203    1 : tunables  120   60    
8 : slabdata      1      1      0
inet_peer_cache        0      0     64   59    1 : tunables  120   60    
8 : slabdata      0      0      0
secpath_cache          0      0     32  113    1 : tunables  120   60    
8 : slabdata      0      0      0
xfrm_dst_cache         0      0    320   12    1 : tunables   54   27    
8 : slabdata      0      0      0
ip_dst_cache          28     30    256   15    1 : tunables  120   60    
8 : slabdata      2      2      0
arp_cache              8     20    192   20    1 : tunables  120   60    
8 : slabdata      1      1      0
RAW                    3      7    512    7    1 : tunables   54   27    
8 : slabdata      1      1      0
UDP                    1      7    512    7    1 : tunables   54   27    
8 : slabdata      1      1      0
tw_sock_TCP           12     30    128   30    1 : tunables  120   60    
8 : slabdata      1      1      0
request_sock_TCP       2     59     64   59    1 : tunables  120   60    
8 : slabdata      1      1      0
TCP               130011 130011   1152    7    2 : tunables   24   12    
8 : slabdata  18573  18573      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    
8 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    
8 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    
8 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    
8 : slabdata      3      3      0
sgpool-8              40     60    128   30    1 : tunables  120   60    
8 : slabdata      2      2      0
scsi_io_context        0      0    104   37    1 : tunables  120   60    
8 : slabdata      0      0      0
blkdev_ioc            25    254     28  127    1 : tunables  120   60    
8 : slabdata      2      2      0
blkdev_queue          28     28    956    4    1 : tunables   54   27    
8 : slabdata      7      7      0
blkdev_requests       17     46    172   23    1 : tunables  120   60    
8 : slabdata      2      2      0
biovec-256            11     12   3072    2    2 : tunables   24   12    
8 : slabdata      6      6      0
biovec-128            15     15   1536    5    2 : tunables   24   12    
8 : slabdata      3      3      0
biovec-64             23     30    768    5    1 : tunables   54   27    
8 : slabdata      6      6      0
biovec-16             23     60    192   20    1 : tunables  120   60    
8 : slabdata      3      3      0
biovec-4              23     59     64   59    1 : tunables  120   60    
8 : slabdata      1      1      0
biovec-1              24    203     16  203    1 : tunables  120   60    
8 : slabdata      1      1      0
bio                  273    420    128   30    1 : tunables  120   60    
8 : slabdata     14     14      0
sock_inode_cache  130158 130158    448    9    1 : tunables   54   27    
8 : slabdata  14462  14462      0
skbuff_fclone_cache   60     60    384   10    1 : tunables   54   27    
8 : slabdata      6      6      0
skbuff_head_cache    260    260    192   20    1 : tunables  120   60    
8 : slabdata     13     13      0
file_lock_cache       16     40     96   40    1 : tunables  120   60    
8 : slabdata      1      1      0
Acpi-Operand        2175   2300     40   92    1 : tunables  120   60    
8 : slabdata     25     25      0
Acpi-ParseExt         16     84     44   84    1 : tunables  120   60    
8 : slabdata      1      1      0
Acpi-Parse            16    127     28  127    1 : tunables  120   60    
8 : slabdata      1      1      0
Acpi-State            76     84     44   84    1 : tunables  120   60    
8 : slabdata      1      1      0
Acpi-Namespace      1019   1183     20  169    1 : tunables  120   60    
8 : slabdata      7      7      0
delayacct_cache      107    312     48   78    1 : tunables  120   60    
8 : slabdata      4      4      0
taskstats_cache       19     53     72   53    1 : tunables  120   60    
8 : slabdata      1      1      0
proc_inode_cache     773    792    364   11    1 : tunables   54   27    
8 : slabdata     72     72      0
sigqueue              13     27    144   27    1 : tunables  120   60    
8 : slabdata      1      1      0
radix_tree_node     1613   1624    276   14    1 : tunables   54   27    
8 : slabdata    116    116      0
bdev_cache            10     14    512    7    1 : tunables   54   27    
8 : slabdata      2      2      0
sysfs_dir_cache     4319   4368     44   84    1 : tunables  120   60    
8 : slabdata     52     52      0
mnt_cache             23     30    128   30    1 : tunables  120   60    
8 : slabdata      1      1      0
inode_cache         2581   2596    348   11    1 : tunables   54   27    
8 : slabdata    236    236      0
dentry_cache      137114 137141    132   29    1 : tunables  120   60    
8 : slabdata   4729   4729      0
filp              130851 130880    192   20    1 : tunables  120   60    
8 : slabdata   6544   6544      0
names_cache            7      7   4096    1    1 : tunables   24   12    
8 : slabdata      7      7      0
idr_layer_cache      115    145    136   29    1 : tunables  120   60    
8 : slabdata      5      5      0
buffer_head         5265   5616     52   72    1 : tunables  120   60    
8 : slabdata     78     78      0
mm_struct             45    135    448    9    1 : tunables   54   27    
8 : slabdata     15     15      0
vm_area_struct      1428   2254     84   46    1 : tunables  120   60    
8 : slabdata     49     49      0
fs_cache              51    177     64   59    1 : tunables  120   60    
8 : slabdata      3      3      0
files_cache           46    140    384   10    1 : tunables   54   27    
8 : slabdata     14     14      0
signal_cache          84    160    384   10    1 : tunables   54   27    
8 : slabdata     16     16      0
sighand_cache         87    108   1344    3    1 : tunables   24   12    
8 : slabdata     36     36      0
task_struct          104    190   1392    5    2 : tunables   24   12    
8 : slabdata     38     38      0
anon_vma             588   1016     12  254    1 : tunables  120   60    
8 : slabdata      4      4      0
pgd                   38     38   4096    1    1 : tunables   24   12    
8 : slabdata     38     38      0
pid                  106    303     36  101    1 : tunables  120   60    
8 : slabdata      3      3      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    
0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    
0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    
0 : slabdata      0      0      0
size-65536             1      1  65536    1   16 : tunables    8    4    
0 : slabdata      1      1      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    
0 : slabdata      0      0      0
size-32768            17     17  32768    1    8 : tunables    8    4    
0 : slabdata     17     17      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    
0 : slabdata      0      0      0
size-16384             5      5  16384    1    4 : tunables    8    4    
0 : slabdata      5      5      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    
0 : slabdata      0      0      0
size-8192            100    108   8192    1    2 : tunables    8    4    
0 : slabdata    100    108      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    
8 : slabdata      0      0      0
size-4096             15     15   4096    1    1 : tunables   24   12    
8 : slabdata     15     15      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    
8 : slabdata      0      0      0
size-2048            296    296   2048    2    1 : tunables   24   12    
8 : slabdata    148    148      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    
8 : slabdata      0      0      0
size-1024            289    300   1024    4    1 : tunables   54   27    
8 : slabdata     75     75      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    
8 : slabdata      0      0      0
size-512             423    536    512    8    1 : tunables   54   27    
8 : slabdata     67     67      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    
8 : slabdata      0      0      0
size-256             510    525    256   15    1 : tunables  120   60    
8 : slabdata     35     35      0
size-128(DMA)          0      0    128   30    1 : tunables  120   60    
8 : slabdata      0      0      0
size-128            1161   1200    128   30    1 : tunables  120   60    
8 : slabdata     40     40      0
size-64(DMA)           0      0     64   59    1 : tunables  120   60    
8 : slabdata      0      0      0
size-32(DMA)           0      0     32  113    1 : tunables  120   60    
8 : slabdata      0      0      0
size-64             1215   1239     64   59    1 : tunables  120   60    
8 : slabdata     21     21      0
size-32             2963   3164     32  113    1 : tunables  120   60    
8 : slabdata     28     28      0
kmem_cache           137    138    640    6    1 : tunables   54   27    
8 : slabdata     23     23      0

> cat /proc/net/sockstat
sockets: used 130143
TCP: inuse 130009 orphan 0 tw 11 alloc 130011 mem 30
UDP: inuse 1
RAW: inuse 0
FRAG: inuse 0 memory 0

> cat /proc/net/stat/rt_cache
entries  in_hit in_slow_tot in_slow_mc in_no_route in_brd in_martian_dst 
in_martian_src  out_hit out_slow_tot out_slow_mc  gc_total gc_ignored 
gc_goal_miss gc_dst_overflow in_hlist_search out_hlist_search
0000001a  00072721 00000021 00000000 00000000 00000005 00000000 
00000000  0001e1b9 0000000c 00000000 00000000 00000000 00000000 00000000 
00000000 0000005e
0000001a  0006e116 00000017 00000000 00000000 00000003 00000000 
00000000  000216d2 00000005 00000000 00000000 00000000 00000000 00000000 
00000000 00000031

> cat /proc/buddyinfo
Node 0, zone      DMA      3      2      2      2      3      3      
1      1      1      1      2
Node 0, zone   Normal      0     12      2      0      1      0      
0      0      0      0     13
Node 0, zone  HighMem   1088    355    145     44     11      6      
1      0      0      0    497

> grep . /proc/sys/net/ipv4/*
/proc/sys/net/ipv4/icmp_echo_ignore_all:0
/proc/sys/net/ipv4/icmp_echo_ignore_broadcasts:1
/proc/sys/net/ipv4/icmp_errors_use_inbound_ifaddr:0
/proc/sys/net/ipv4/icmp_ignore_bogus_error_responses:1
/proc/sys/net/ipv4/icmp_ratelimit:250
/proc/sys/net/ipv4/icmp_ratemask:6168
/proc/sys/net/ipv4/igmp_max_memberships:20
/proc/sys/net/ipv4/igmp_max_msf:10
/proc/sys/net/ipv4/inet_peer_gc_maxtime:120
/proc/sys/net/ipv4/inet_peer_gc_mintime:10
/proc/sys/net/ipv4/inet_peer_maxttl:600
/proc/sys/net/ipv4/inet_peer_minttl:120
/proc/sys/net/ipv4/inet_peer_threshold:65664
/proc/sys/net/ipv4/ip_default_ttl:64
/proc/sys/net/ipv4/ip_dynaddr:0
/proc/sys/net/ipv4/ip_forward:0
/proc/sys/net/ipv4/ip_local_port_range:32768    61000
/proc/sys/net/ipv4/ip_no_pmtu_disc:0
/proc/sys/net/ipv4/ip_nonlocal_bind:0
/proc/sys/net/ipv4/ipfrag_high_thresh:262144
/proc/sys/net/ipv4/ipfrag_low_thresh:196608
/proc/sys/net/ipv4/ipfrag_max_dist:64
/proc/sys/net/ipv4/ipfrag_secret_interval:600
/proc/sys/net/ipv4/ipfrag_time:30
/proc/sys/net/ipv4/tcp_abc:0
/proc/sys/net/ipv4/tcp_abort_on_overflow:0
/proc/sys/net/ipv4/tcp_adv_win_scale:2
/proc/sys/net/ipv4/tcp_app_win:31
/proc/sys/net/ipv4/tcp_base_mss:512
/proc/sys/net/ipv4/tcp_congestion_control:reno
/proc/sys/net/ipv4/tcp_dma_copybreak:4096
/proc/sys/net/ipv4/tcp_dsack:1
/proc/sys/net/ipv4/tcp_ecn:0
/proc/sys/net/ipv4/tcp_fack:1
/proc/sys/net/ipv4/tcp_fin_timeout:60
/proc/sys/net/ipv4/tcp_frto:0
/proc/sys/net/ipv4/tcp_keepalive_intvl:75
/proc/sys/net/ipv4/tcp_keepalive_probes:9
/proc/sys/net/ipv4/tcp_keepalive_time:7200
/proc/sys/net/ipv4/tcp_low_latency:0
/proc/sys/net/ipv4/tcp_max_orphans:32768
/proc/sys/net/ipv4/tcp_max_syn_backlog:1024
/proc/sys/net/ipv4/tcp_max_tw_buckets:180000
/proc/sys/net/ipv4/tcp_mem:98304        131072  196608
/proc/sys/net/ipv4/tcp_moderate_rcvbuf:1
/proc/sys/net/ipv4/tcp_mtu_probing:0
/proc/sys/net/ipv4/tcp_no_metrics_save:0
/proc/sys/net/ipv4/tcp_orphan_retries:0
/proc/sys/net/ipv4/tcp_reordering:3
/proc/sys/net/ipv4/tcp_retrans_collapse:1
/proc/sys/net/ipv4/tcp_retries1:3
/proc/sys/net/ipv4/tcp_retries2:15
/proc/sys/net/ipv4/tcp_rfc1337:0
/proc/sys/net/ipv4/tcp_rmem:4096        87380   4194304
/proc/sys/net/ipv4/tcp_sack:1
/proc/sys/net/ipv4/tcp_slow_start_after_idle:1
/proc/sys/net/ipv4/tcp_stdurg:0
/proc/sys/net/ipv4/tcp_syn_retries:5
/proc/sys/net/ipv4/tcp_synack_retries:5
/proc/sys/net/ipv4/tcp_syncookies:1
/proc/sys/net/ipv4/tcp_timestamps:1
/proc/sys/net/ipv4/tcp_tso_win_divisor:3
/proc/sys/net/ipv4/tcp_tw_recycle:0
/proc/sys/net/ipv4/tcp_tw_reuse:0
/proc/sys/net/ipv4/tcp_window_scaling:1
/proc/sys/net/ipv4/tcp_wmem:4096        16384   4194304
/proc/sys/net/ipv4/tcp_workaround_signed_windows:0

> grep . /proc/sys/net/ipv4/route/*
/proc/sys/net/ipv4/route/error_burst:1250
/proc/sys/net/ipv4/route/error_cost:250
/proc/sys/net/ipv4/route/gc_elasticity:8
/proc/sys/net/ipv4/route/gc_interval:60
/proc/sys/net/ipv4/route/gc_min_interval:0
/proc/sys/net/ipv4/route/gc_min_interval_ms:500
/proc/sys/net/ipv4/route/gc_thresh:32768
/proc/sys/net/ipv4/route/gc_timeout:300
/proc/sys/net/ipv4/route/max_delay:10
/proc/sys/net/ipv4/route/max_size:524288
/proc/sys/net/ipv4/route/min_adv_mss:256
/proc/sys/net/ipv4/route/min_delay:2
/proc/sys/net/ipv4/route/min_pmtu:552
/proc/sys/net/ipv4/route/mtu_expires:600
/proc/sys/net/ipv4/route/redirect_load:5
/proc/sys/net/ipv4/route/redirect_number:9
/proc/sys/net/ipv4/route/redirect_silence:5120
/proc/sys/net/ipv4/route/secret_interval:600



Markus
