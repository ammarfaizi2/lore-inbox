Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbVH3UsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbVH3UsE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 16:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVH3UsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 16:48:04 -0400
Received: from unicorn.rentec.com ([216.223.240.9]:32206 "EHLO
	unicorn.rentec.com") by vger.kernel.org with ESMTP id S932457AbVH3UsC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 16:48:02 -0400
X-Rentec: external
Message-ID: <4314C5FC.1080203@rentec.com>
Date: Tue, 30 Aug 2005 16:47:56 -0400
From: Wolfgang Wander <wwc@rentec.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wolfgang Wander <wwc@rentec.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13 (and before) OOM-Killer activated with plenty of memory
 available
References: <17172.42641.717816.742862@gargle.gargle.HOWL>
In-Reply-To: <17172.42641.717816.742862@gargle.gargle.HOWL>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Logged: Logged by unicorn.rentec.com as j7UKlvrJ023560 at Tue Aug 30 16:47:58 2005
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about that - brown paper bag time...

swappiness was (coming from 2.6.8) still set to 0.  As usual setting it back to its default of 60
fixes the problem...

Would it be worthwhile to include the swappiness value in the OOM-killer's report?

             Wolfgang

Wolfgang Wander wrote:
> Something still seems not right with the OOM handling.
> 
> The appended program forks 5 children, allocating 1GB each.  Running
> this on a 4GB RAM Intel32 machine that also has 11GB swap available
> causes an OOM killer activation killing off one of the memory hungry
> kids. (A 4GB AMD64 machine with 11GB swap seems to be fine though).
> 
> /proc/sys/vm/overcommit_memory is already set to 2.
> 
> It should be noted that 2.4 kernels do not exhibit any problems with
> this test case.
> 
>    Thanks for any feedback - I'm willing to test out anything you
>    throw my way ;-)
> 
>                    Wolfgang
> 
> 
> 
> ----------------------------------------------------------------------
> Aug 30 14:27:42 monstert01 kernel: oom-killer: gfp_mask=0x80d2, order=0
> Aug 30 14:27:42 monstert01 kernel: Mem-info:
> Aug 30 14:27:42 monstert01 kernel: DMA per-cpu:
> Aug 30 14:27:42 monstert01 kernel: cpu 0 hot: low 2, high 6, batch 1 used:5
> Aug 30 14:27:42 monstert01 kernel: cpu 0 cold: low 0, high 2, batch 1 used:0
> Aug 30 14:27:42 monstert01 kernel: cpu 1 hot: low 2, high 6, batch 1 used:1
> Aug 30 14:27:42 monstert01 kernel: cpu 1 cold: low 0, high 2, batch 1 used:0
> Aug 30 14:27:42 monstert01 kernel: Normal per-cpu:
> Aug 30 14:27:42 monstert01 kernel: cpu 0 hot: low 62, high 186, batch 31 used:92
> Aug 30 14:27:42 monstert01 kernel: cpu 0 cold: low 0, high 62, batch 31 used:37
> Aug 30 14:27:42 monstert01 kernel: cpu 1 hot: low 62, high 186, batch 31 used:84
> Aug 30 14:27:42 monstert01 kernel: cpu 1 cold: low 0, high 62, batch 31 used:51
> Aug 30 14:27:42 monstert01 kernel: HighMem per-cpu:
> Aug 30 14:27:43 monstert01 kernel: cpu 0 hot: low 62, high 186, batch 31 used:92
> Aug 30 14:27:43 monstert01 kernel: cpu 0 cold: low 0, high 62, batch 31 used:44
> Aug 30 14:27:43 monstert01 kernel: cpu 1 hot: low 62, high 186, batch 31 used:92
> Aug 30 14:27:43 monstert01 kernel: cpu 1 cold: low 0, high 62, batch 31 used:61
> Aug 30 14:27:43 monstert01 kernel: Free pages:      116436kB (496kB HighMem)
> Aug 30 14:27:43 monstert01 kernel: Active:925586 inactive:55824 dirty:0 writeback:10969 unstable:0 free:29109 slab:4733 mapped:968758 pagetables:2181
> Aug 30 14:27:43 monstert01 kernel: DMA free:12152kB min:68kB low:84kB high:100kB active:0kB inactive:0kB present:16384kB pages_scanned:1516 all_unreclaimable? yes
> Aug 30 14:27:43 monstert01 kernel: lowmem_reserve[]: 0 880 4015
> Aug 30 14:27:43 monstert01 kernel: Normal free:103788kB min:3756kB low:4692kB high:5632kB active:508888kB inactive:223296kB present:901120kB pages_scanned:94265 all_unreclaimable? no
> Aug 30 14:27:43 monstert01 kernel: lowmem_reserve[]: 0 0 25087
> Aug 30 14:27:43 monstert01 kernel: HighMem free:496kB min:512kB low:640kB high:768kB active:3193456kB inactive:0kB present:3211200kB pages_scanned:3688714 all_unreclaimable? yes
> Aug 30 14:27:43 monstert01 kernel: lowmem_reserve[]: 0 0 0
> Aug 30 14:27:43 monstert01 kernel: DMA: 2*4kB 4*8kB 3*16kB 3*32kB 3*64kB 2*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 2*4096kB = 12152kB
> Aug 30 14:27:43 monstert01 kernel: Normal: 1*4kB 1*8kB 0*16kB 1*32kB 1*64kB 0*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 25*4096kB = 103788kB
> Aug 30 14:27:43 monstert01 kernel: HighMem: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 496kB
> Aug 30 14:27:43 monstert01 kernel: Swap cache: add 554996, delete 543480, find 129437/164972, race 0+0
> Aug 30 14:27:43 monstert01 kernel: Free swap  = 11391916kB
> Aug 30 14:27:43 monstert01 kernel: Total swap = 11537968kB
> Aug 30 14:27:43 monstert01 kernel: Free swap:       11391916kB
> Aug 30 14:27:43 monstert01 kernel: 1032176 pages of RAM
> Aug 30 14:27:43 monstert01 kernel: 802800 pages of HIGHMEM
> Aug 30 14:27:43 monstert01 kernel: 10366 reserved pages
> Aug 30 14:27:43 monstert01 kernel: 10135 pages shared
> Aug 30 14:27:43 monstert01 kernel: 11516 pages swap cached
> Aug 30 14:27:43 monstert01 kernel: 0 pages dirty
> Aug 30 14:27:43 monstert01 kernel: 14169 pages writeback
> Aug 30 14:27:43 monstert01 kernel: 965539 pages mapped
> Aug 30 14:27:43 monstert01 kernel: 4817 pages slab
> Aug 30 14:27:43 monstert01 kernel: 2182 pages pagetables
> Aug 30 14:27:43 monstert01 kernel: Out of Memory: Killed process 7457 (oomme).
> ----------------------------------------------------------------------
> 
> Seems like the program runs out of HighMem, /proc/slabinfo is appended
> (right after the OOM) anyhow:
> ----------------------------------------------------------------------
> slabinfo - version: 2.1
> # name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
> fib6_nodes             5    119     32  119    1 : tunables  120   60    8 : slabdata      1      1      0
> ip6_dst_cache          4     18    224   18    1 : tunables  120   60    8 : slabdata      1      1      0
> ndisc_cache            1     25    160   25    1 : tunables  120   60    8 : slabdata      1      1      0
> RAWv6                  4      6    640    6    1 : tunables   54   27    8 : slabdata      1      1      0
> UDPv6                  2      6    608    6    1 : tunables   54   27    8 : slabdata      1      1      0
> request_sock_TCPv6      0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
> TCPv6                 12     14   1120    7    2 : tunables   24   12    8 : slabdata      2      2      0
> ip_fib_alias          10    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
> ip_fib_hash           10    119     32  119    1 : tunables  120   60    8 : slabdata      1      1      0
> xfs_acl                0      0    304   13    1 : tunables   54   27    8 : slabdata      0      0      0
> xfs_chashlist          0      0     20  185    1 : tunables  120   60    8 : slabdata      0      0      0
> xfs_ili                0      0    140   28    1 : tunables  120   60    8 : slabdata      0      0      0
> xfs_ifork              0      0     56   70    1 : tunables  120   60    8 : slabdata      0      0      0
> xfs_efi_item           0      0    260   15    1 : tunables   54   27    8 : slabdata      0      0      0
> xfs_efd_item           0      0    260   15    1 : tunables   54   27    8 : slabdata      0      0      0
> xfs_buf_item           0      0    148   27    1 : tunables  120   60    8 : slabdata      0      0      0
> xfs_dabuf              0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
> xfs_da_state           0      0    336   12    1 : tunables   54   27    8 : slabdata      0      0      0
> xfs_trans              0      0    596   13    2 : tunables   54   27    8 : slabdata      0      0      0
> xfs_inode              0      0    368   11    1 : tunables   54   27    8 : slabdata      0      0      0
> xfs_btree_cur          0      0    140   28    1 : tunables  120   60    8 : slabdata      0      0      0
> xfs_bmap_free_item      0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
> xfs_buf                0      0    224   18    1 : tunables  120   60    8 : slabdata      0      0      0
> linvfs_icache          0      0    388   10    1 : tunables   54   27    8 : slabdata      0      0      0
> dm_tio               256    452     16  226    1 : tunables  120   60    8 : slabdata      2      2      0
> dm_io                256    452     16  226    1 : tunables  120   60    8 : slabdata      2      2      0
> reiser_inode_cache  12588  14832    436    9    1 : tunables   54   27    8 : slabdata   1648   1648    216
> scsi_cmd_cache        88     88    352   11    1 : tunables   54   27    8 : slabdata      8      8     27
> sgpool-128            72     72   2560    3    2 : tunables   24   12    8 : slabdata     24     24     24
> sgpool-64             42     42   1280    3    1 : tunables   24   12    8 : slabdata     14     14      0
> sgpool-32             39     42    640    6    1 : tunables   54   27    8 : slabdata      7      7      0
> sgpool-16             35     36    320   12    1 : tunables   54   27    8 : slabdata      3      3      0
> sgpool-8             100    100    160   25    1 : tunables  120   60    8 : slabdata      4      4      0
> clip_arp_cache         0      0    160   25    1 : tunables  120   60    8 : slabdata      0      0      0
> rpc_buffers            8      8   2048    2    1 : tunables   24   12    8 : slabdata      4      4      0
> rpc_tasks             20     20    192   20    1 : tunables  120   60    8 : slabdata      1      1      0
> rpc_inode_cache       12     16    480    8    1 : tunables   54   27    8 : slabdata      2      2      0
> UNIX                  26     45    416    9    1 : tunables   54   27    8 : slabdata      5      5      0
> ip_mrt_cache           0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
> tcp_tw_bucket          2     31    128   31    1 : tunables  120   60    8 : slabdata      1      1      0
> tcp_bind_bucket       22    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
> inet_peer_cache        2     61     64   61    1 : tunables  120   60    8 : slabdata      1      1      0
> secpath_cache          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
> xfrm_dst_cache         0      0    288   14    1 : tunables   54   27    8 : slabdata      0      0      0
> ip_dst_cache          44     45    256   15    1 : tunables  120   60    8 : slabdata      3      3      0
> arp_cache              5     25    160   25    1 : tunables  120   60    8 : slabdata      1      1      0
> RAW                    3      8    480    8    1 : tunables   54   27    8 : slabdata      1      1      0
> UDP                    9     16    480    8    1 : tunables   54   27    8 : slabdata      2      2      0
> request_sock_TCP       0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
> TCP                   19     20   1024    4    1 : tunables   54   27    8 : slabdata      5      5      0
> flow_cache             0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
> cfq_ioc_pool           0      0     48   81    1 : tunables  120   60    8 : slabdata      0      0      0
> cfq_pool               0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
> crq_pool               0      0     48   81    1 : tunables  120   60    8 : slabdata      0      0      0
> deadline_drq           0      0     52   75    1 : tunables  120   60    8 : slabdata      0      0      0
> as_arq               183    183     64   61    1 : tunables  120   60    8 : slabdata      3      3     60
> mqueue_inode_cache      1      7    544    7    1 : tunables   54   27    8 : slabdata      1      1      0
> nfs_direct_cache       0      0     44   88    1 : tunables  120   60    8 : slabdata      0      0      0
> nfs_write_data        36     36    448    9    1 : tunables   54   27    8 : slabdata      4      4      0
> nfs_read_data         32     36    448    9    1 : tunables   54   27    8 : slabdata      4      4      0
> nfs_inode_cache      979   1032    604    6    1 : tunables   54   27    8 : slabdata    172    172      0
> nfs_page               0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
> isofs_inode_cache      0      0    384   10    1 : tunables   54   27    8 : slabdata      0      0      0
> minix_inode_cache      0      0    420    9    1 : tunables   54   27    8 : slabdata      0      0      0
> hugetlbfs_inode_cache      1     11    356   11    1 : tunables   54   27    8 : slabdata      1      1      0
> ext2_inode_cache       0      0    492    8    1 : tunables   54   27    8 : slabdata      0      0      0
> ext2_xattr             0      0     48   81    1 : tunables  120   60    8 : slabdata      0      0      0
> dnotify_cache          0      0     20  185    1 : tunables  120   60    8 : slabdata      0      0      0
> dquot                  0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
> eventpoll_pwq          0      0     36  107    1 : tunables  120   60    8 : slabdata      0      0      0
> eventpoll_epi          0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
> inotify_event_cache      0      0     28  135    1 : tunables  120   60    8 : slabdata      0      0      0
> inotify_watch_cache      0      0     36  107    1 : tunables  120   60    8 : slabdata      0      0      0
> kioctx                 0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
> kiocb                  0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
> fasync_cache           0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
> shmem_inode_cache      6      8    452    8    1 : tunables   54   27    8 : slabdata      1      1      0
> posix_timers_cache      0      0    100   39    1 : tunables  120   60    8 : slabdata      0      0      0
> uid_cache              4     61     64   61    1 : tunables  120   60    8 : slabdata      1      1      0
> blkdev_ioc            65    135     28  135    1 : tunables  120   60    8 : slabdata      1      1      0
> blkdev_queue          32     40    396   10    1 : tunables   54   27    8 : slabdata      4      4      0
> blkdev_requests      200    200    160   25    1 : tunables  120   60    8 : slabdata      8      8     60
> biovec-(256)         260    260   3072    2    2 : tunables   24   12    8 : slabdata    130    130      0
> biovec-128           264    265   1536    5    2 : tunables   24   12    8 : slabdata     53     53      0
> biovec-64            275    275    768    5    1 : tunables   54   27    8 : slabdata     55     55      0
> biovec-16            300    300    192   20    1 : tunables  120   60    8 : slabdata     15     15      0
> biovec-4             288    305     64   61    1 : tunables  120   60    8 : slabdata      5      5      0
> biovec-1             890   2034     16  226    1 : tunables  120   60    8 : slabdata      9      9    480
> bio                  859   1435     96   41    1 : tunables  120   60    8 : slabdata     31     35    480
> file_lock_cache        3     43     92   43    1 : tunables  120   60    8 : slabdata      1      1      0
> sock_inode_cache      83     90    416    9    1 : tunables   54   27    8 : slabdata     10     10      0
> skbuff_head_cache    180    200    192   20    1 : tunables  120   60    8 : slabdata     10     10      0
> proc_inode_cache     359    710    372   10    1 : tunables   54   27    8 : slabdata     71     71      0
> sigqueue              29     54    148   27    1 : tunables  120   60    8 : slabdata      2      2      0
> radix_tree_node      802   1064    276   14    1 : tunables   54   27    8 : slabdata     76     76      0
> bdev_cache             8     16    480    8    1 : tunables   54   27    8 : slabdata      2      2      0
> sysfs_dir_cache     3165   3264     40   96    1 : tunables  120   60    8 : slabdata     34     34      0
> mnt_cache             31     41     96   41    1 : tunables  120   60    8 : slabdata      1      1      0
> inode_cache         1053   1265    356   11    1 : tunables   54   27    8 : slabdata    115    115      0
> dentry_cache        8657  16520    140   28    1 : tunables  120   60    8 : slabdata    590    590    480
> filp                 950    950    160   25    1 : tunables  120   60    8 : slabdata     38     38      0
> names_cache            3      3   4096    1    1 : tunables   24   12    8 : slabdata      3      3      0
> idr_layer_cache      113    116    136   29    1 : tunables  120   60    8 : slabdata      4      4      0
> buffer_head          588   1650     52   75    1 : tunables  120   60    8 : slabdata     22     22      0
> mm_struct             96    102    608    6    1 : tunables   54   27    8 : slabdata     17     17      0
> vm_area_struct      1944   2537     92   43    1 : tunables  120   60    8 : slabdata     59     59      0
> fs_cache              53    244     64   61    1 : tunables  120   60    8 : slabdata      4      4      0
> files_cache           54    108    416    9    1 : tunables   54   27    8 : slabdata     12     12      0
> signal_cache          84    143    352   11    1 : tunables   54   27    8 : slabdata     13     13      0
> sighand_cache         82    108   1312    3    1 : tunables   24   12    8 : slabdata     36     36      0
> task_struct           89    108   1312    3    1 : tunables   24   12    8 : slabdata     36     36      0
> anon_vma             896   1160     12  290    1 : tunables  120   60    8 : slabdata      4      4      0
> pgd                  129    238     32  119    1 : tunables  120   60    8 : slabdata      2      2      0
> pmd                  165    165   4096    1    1 : tunables   24   12    8 : slabdata    165    165      0
> size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
> size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
> size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
> size-65536             0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
> size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
> size-32768             9      9  32768    1    8 : tunables    8    4    0 : slabdata      9      9      0
> size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
> size-16384             3      3  16384    1    4 : tunables    8    4    0 : slabdata      3      3      0
> size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
> size-8192             90     90   8192    1    2 : tunables    8    4    0 : slabdata     90     90      0
> size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    8 : slabdata      0      0      0
> size-4096             70     70   4096    1    1 : tunables   24   12    8 : slabdata     70     70      0
> size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    8 : slabdata      0      0      0
> size-2048            182    188   2048    2    1 : tunables   24   12    8 : slabdata     94     94      0
> size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    8 : slabdata      0      0      0
> size-1024            207    252   1024    4    1 : tunables   54   27    8 : slabdata     63     63      0
> size-512(DMA)          0      0    512    8    1 : tunables   54   27    8 : slabdata      0      0      0
> size-512             352    352    512    8    1 : tunables   54   27    8 : slabdata     44     44     27
> size-256(DMA)          0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
> size-256             222    225    256   15    1 : tunables  120   60    8 : slabdata     15     15      0
> size-128(DMA)          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
> size-128            1674   1705    128   31    1 : tunables  120   60    8 : slabdata     55     55      0
> size-64(DMA)           0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
> size-64              566    732     64   61    1 : tunables  120   60    8 : slabdata     12     12      0
> size-32(DMA)           0      0     32  119    1 : tunables  120   60    8 : slabdata      0      0      0
> size-32             2200   2380     32  119    1 : tunables  120   60    8 : slabdata     20     20      0
> kmem_cache           144    144    640    6    1 : tunables   54   27    8 : slabdata     24     24      0
> ----------------------------------------------------------------------
> 
> source code for oomme.c
> ----------------------------------------------------------------------
> #include <stdlib.h>
> #include <string.h>
> #include <signal.h>
> #include <unistd.h>
> #include <stdio.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> 
> void
> allocmore()
> {
>   char *list[10];
>   int i;
>   int j;
> 
>   for( i = 0; i < sizeof(list)/sizeof(list[0]); ++i ) {
>     list[i] = calloc(100000000,1);
>   }
>   for( j = 0; j < 2; ++j ) {
>     for( i = 0; i < sizeof(list)/sizeof(list[0]); ++i ) {
>       memset(list[i], 1, 100000000);
>       sleep(1);
>     }
>   }
>   exit(0);
> }
> 
> 
> long children[5];
> 
> void
> ackthem(int n)
> {
>   int status;
>   pid_t victim;
>   int i;
>   int rem = 0;
> 
>   victim = wait( &status);
> 
>   int sig = WIFSIGNALED(status) ? WTERMSIG(status) : 0;
>   
>   for( i = 0; i < sizeof(children)/sizeof(children[0]); ++i ) {
>     if( children[i] == victim ) 
>       children[i] = -sig;
>     if( children[i] > 0 )
>       rem ++;
>   }
> 
>   if( victim >= 0 ) {
>     if( WIFSIGNALED(status) ) {
>       printf("child %d died with %d (rem: %d)\n",victim,sig,rem);
>       system("cat /proc/slabinfo");
>     } else 
>       printf("child %d exited (rem %d)\n", victim, rem);
>   }
>     
> }
> 
> void
> goodparent(void)
> {
>   int i;
>   int alive;
>   for( i = 0; i < sizeof(children)/sizeof(children[0]); ++i ) {
>     children[i] = fork();
>     if( children[i] == 0 ) {
>       allocmore();
>     } 
>   }
> 
>   do {
>     alive = 0;
>     for( i = 0; i < sizeof(children)/sizeof(children[0]); ++i )
>       if( children[i] > 0 )
> 	++alive;
>     if( alive ) {
>       ackthem(0);
>       --alive;
>     }
>   } while(alive);
> }
> 
> int
> main()
> {
>   goodparent();
>   return 0;
> }
> ----------------------------------------------------------------------
> 
> $ zgrep MEM /proc/config.gz 
> CONFIG_SHMEM=y
> # CONFIG_TINY_SHMEM is not set
> # CONFIG_NOHIGHMEM is not set
> # CONFIG_HIGHMEM4G is not set
> CONFIG_HIGHMEM64G=y
> CONFIG_HIGHMEM=y
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_FLATMEM_MANUAL=y
> # CONFIG_DISCONTIGMEM_MANUAL is not set
> # CONFIG_SPARSEMEM_MANUAL is not set
> CONFIG_FLATMEM=y
> CONFIG_FLAT_NODE_MEM_MAP=y
> CONFIG_BLK_DEV_UMEM=m
> CONFIG_W1_SMEM=m
> CONFIG_SND_DEBUG_MEMORY=y
> # CONFIG_DEBUG_HIGHMEM is not set
> 
> ----------------------------------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

