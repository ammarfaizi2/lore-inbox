Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266679AbUG0WkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266679AbUG0WkC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 18:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266676AbUG0WkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 18:40:02 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:53737 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266705AbUG0Wiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 18:38:51 -0400
Message-ID: <4106D978.7090008@comcast.net>
Date: Tue, 27 Jul 2004 18:38:48 -0400
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Jens Axboe <axboe@suse.de>, Jan-Frode Myklebust <janfrode@parallab.uib.no>,
       linux-kernel@vger.kernel.org
Subject: Re: OOM-killer going crazy.
References: <20040725094605.GA18324@zombie.inka.de> <41045EBE.8080708@comcast.net> <20040726091004.GA32403@ii.uib.no> <410500FD.8070206@comcast.net> <4105D7ED.5040206@yahoo.com.au> <20040727100724.GA11189@suse.de> <41065748.8050107@comcast.net> <41065902.20909@yahoo.com.au>
In-Reply-To: <41065902.20909@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Ed Sweetman wrote:
>
>> I tried it, i dont slow down or crash when burning the cd the first 
>> time. It's a small cd that doesn't take up my entire ram size, but 
>> the memory is still not freed. If i tried it again i would be 
>> rebooting right now.  I only have 70MB out of 650MB free after 
>> burning the cd.  Cache only takes up 122MB, and buf takes up 1MB.  
>> and i'm using 100MB of swap. I will run vmstat when i do it when i 
>> get home later today.
>> It's not so much that the kernel is leaking memory, I think it thinks 
>> it's handling a pointer to data it's supposed to write to disk, but 
>> it's writing the wrong data, either a slightly misaligned offset or 
>> mangled pointer because the audio cd did write but the audio it wrote 
>> is unintelligable.  It almost sort of sounds like it should but it's 
>> completely fubared.  And i've done this with swab on and off before 
>> thinking the drive automatically wrote audio with SWAB on and 
>> cdrecord's swab was countering it or something but that was not the 
>> case.  The audio source files were ripped from a cd using the same 
>> drive and they sound good on the harddrive.  The drive seems to have 
>> no real problem ripping audio. Just writing it.  Normal cds show no 
>> problem as i've previously mentioned.
>> If this is a vfs problem then i'd like to know what audio writing has 
>> to do with filesystems since it's raw data.  Even ignoring the mem 
>> leak problem that appears to manifest in different ways on different 
>> computers, this OOM situation only happens to me when burning audio 
>> cds, not data.
>>
>
> OK so it does sound like a different problem.
>
> I didn't follow your other thread closely... does /proc/slabinfo
> show any evidence of a leak?


Surprisingly no. You'd think that since the kernel is responsible for 
saying what memory can't be touched or swapped out it would have some 
sort of tag on the huge 600MB of ram I currently can't do anything with 
since i burned that audio cd but slabinfo doesn't seem to show anything 
about it. Maybe i'm reading it wrong.

# name            <active_objs> <num_objs> <objsize> <objperslab> 
<pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata 
<active_slabs> <num_slabs> <sharedavail>
ext2_inode_cache      11     18    416    9    1 : tunables   54   27    
0 : slabdata      2      2      0
ext2_xattr             0      0     44   88    1 : tunables  120   60    
0 : slabdata      0      0      0
smb_request            0      0    256   15    1 : tunables  120   60    
0 : slabdata      0      0      0
smb_inode_cache        0      0    320   12    1 : tunables   54   27    
0 : slabdata      0      0      0
unix_sock             47     50    384   10    1 : tunables   54   27    
0 : slabdata      5      5      0
tcp_tw_bucket          0      0     96   41    1 : tunables  120   60    
0 : slabdata      0      0      0
tcp_bind_bucket       16    226     16  226    1 : tunables  120   60    
0 : slabdata      1      1      0
tcp_open_request       0      0     64   61    1 : tunables  120   60    
0 : slabdata      0      0      0
inet_peer_cache        0      0     64   61    1 : tunables  120   60    
0 : slabdata      0      0      0
ip_fib_hash           10    226     16  226    1 : tunables  120   60    
0 : slabdata      1      1      0
ip_dst_cache          21     30    256   15    1 : tunables  120   60    
0 : slabdata      2      2      0
arp_cache              2     31    128   31    1 : tunables  120   60    
0 : slabdata      1      1      0
raw4_sock              0      0    480    8    1 : tunables   54   27    
0 : slabdata      0      0      0
udp_sock               1      8    480    8    1 : tunables   54   27    
0 : slabdata      1      1      0
tcp_sock              28     28    992    4    1 : tunables   54   27    
0 : slabdata      7      7      0
flow_cache             0      0     96   41    1 : tunables  120   60    
0 : slabdata      0      0      0
uhci_urb_priv          1     88     44   88    1 : tunables  120   60    
0 : slabdata      1      1      0
mqueue_inode_cache      1      8    480    8    1 : tunables   54   
27    0 : slabdata      1      1      0
journal_handle         2    135     28  135    1 : tunables  120   60    
0 : slabdata      1      1      0
journal_head          29    162     48   81    1 : tunables  120   60    
0 : slabdata      2      2      0
revoke_table          12    290     12  290    1 : tunables  120   60    
0 : slabdata      1      1      0
revoke_record          0      0     16  226    1 : tunables  120   60    
0 : slabdata      0      0      0
ext3_inode_cache     829   1752    480    8    1 : tunables   54   27    
0 : slabdata    219    219      0
ext3_xattr             0      0     44   88    1 : tunables  120   60    
0 : slabdata      0      0      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    
0 : slabdata      0      0      0
eventpoll_epi          0      0     96   41    1 : tunables  120   60    
0 : slabdata      0      0      0
kioctx                 0      0    160   25    1 : tunables  120   60    
0 : slabdata      0      0      0
kiocb                  0      0     96   41    1 : tunables  120   60    
0 : slabdata      0      0      0
dnotify_cache          0      0     20  185    1 : tunables  120   60    
0 : slabdata      0      0      0
file_lock_cache       41     41     96   41    1 : tunables  120   60    
0 : slabdata      1      1      0
fasync_cache           2    226     16  226    1 : tunables  120   60    
0 : slabdata      1      1      0
shmem_inode_cache     11     18    416    9    1 : tunables   54   27    
0 : slabdata      2      2      0
posix_timers_cache      0      0     96   41    1 : tunables  120   
60    0 : slabdata      0      0      0
uid_cache              4    119     32  119    1 : tunables  120   60    
0 : slabdata      1      1      0
cfq_pool              64    119     32  119    1 : tunables  120   60    
0 : slabdata      1      1      0
crq_pool               0      0     36  107    1 : tunables  120   60    
0 : slabdata      0      0      0
deadline_drq           0      0     48   81    1 : tunables  120   60    
0 : slabdata      0      0      0
as_arq                20     65     60   65    1 : tunables  120   60    
0 : slabdata      1      1      0
blkdev_ioc            67    185     20  185    1 : tunables  120   60    
0 : slabdata      1      1      0
blkdev_queue          19     24    452    8    1 : tunables   54   27    
0 : slabdata      3      3      0
blkdev_requests       19     26    152   26    1 : tunables  120   60    
0 : slabdata      1      1      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    
0 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    
0 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    
0 : slabdata     52     52      0
biovec-16            256    260    192   20    1 : tunables  120   60    
0 : slabdata     13     13      0
biovec-4             256    305     64   61    1 : tunables  120   60    
0 : slabdata      5      5      0
biovec-1             264    452     16  226    1 : tunables  120   60    
0 : slabdata      2      2      0
bio                  264    305     64   61    1 : tunables  120   60    
0 : slabdata      5      5      0
sock_inode_cache      94     99    352   11    1 : tunables   54   27    
0 : slabdata      9      9      0
skbuff_head_cache    230    350    160   25    1 : tunables  120   60    
0 : slabdata     14     14      0
sock                   2     12    320   12    1 : tunables   54   27    
0 : slabdata      1      1      0
proc_inode_cache      51    156    320   12    1 : tunables   54   27    
0 : slabdata     13     13      0
sigqueue              16     27    148   27    1 : tunables  120   60    
0 : slabdata      1      1      0
radix_tree_node     2148   2254    276   14    1 : tunables   54   27    
0 : slabdata    161    161      0
bdev_cache            12     18    416    9    1 : tunables   54   27    
0 : slabdata      2      2      0
mnt_cache             23     41     96   41    1 : tunables  120   60    
0 : slabdata      1      1      0
inode_cache          522    528    320   12    1 : tunables   54   27    
0 : slabdata     44     44      0
dentry_cache        1642   4592    140   28    1 : tunables  120   60    
0 : slabdata    164    164      0
filp                1430   1450    160   25    1 : tunables  120   60    
0 : slabdata     58     58      0
names_cache            6      6   4096    1    1 : tunables   24   12    
0 : slabdata      6      6      0
idr_layer_cache       86     87    136   29    1 : tunables  120   60    
0 : slabdata      3      3      0
buffer_head        26173  28593     48   81    1 : tunables  120   60    
0 : slabdata    353    353      0
mm_struct             70     70    512    7    1 : tunables   54   27    
0 : slabdata     10     10      0
vm_area_struct      3212   3525     84   47    1 : tunables  120   60    
0 : slabdata     75     75      0
fs_cache              72    119     32  119    1 : tunables  120   60    
0 : slabdata      1      1      0
files_cache           63     63    416    9    1 : tunables   54   27    
0 : slabdata      7      7      0
signal_cache          82     82     96   41    1 : tunables  120   60    
0 : slabdata      2      2      0
sighand_cache         75     75   1312    3    1 : tunables   24   12    
0 : slabdata     25     25      0
task_struct          100    100   1440    5    2 : tunables   24   12    
0 : slabdata     20     20      0
anon_vma            1602   2035      8  407    1 : tunables  120   60    
0 : slabdata      5      5      0
pgd                   59     59   4096    1    1 : tunables   24   12    
0 : slabdata     59     59      0
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
size-32768             0      0  32768    1    8 : tunables    8    4    
0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    
0 : slabdata      0      0      0
size-16384             3      3  16384    1    4 : tunables    8    4    
0 : slabdata      3      3      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    
0 : slabdata      0      0      0
size-8192            103    103   8192    1    2 : tunables    8    4    
0 : slabdata    103    103      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    
0 : slabdata      0      0      0
size-4096             62     62   4096    1    1 : tunables   24   12    
0 : slabdata     62     62      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    
0 : slabdata      0      0      0
size-2048            160    160   2048    2    1 : tunables   24   12    
0 : slabdata     80     80      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    
0 : slabdata      0      0      0
size-1024             89     92   1024    4    1 : tunables   54   27    
0 : slabdata     23     23      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    
0 : slabdata      0      0      0
size-512             262    456    512    8    1 : tunables   54   27    
0 : slabdata     57     57      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    
0 : slabdata      0      0      0
size-256             172    345    256   15    1 : tunables  120   60    
0 : slabdata     23     23      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    
0 : slabdata      0      0      0
size-192             160    160    192   20    1 : tunables  120   60    
0 : slabdata      8      8      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    
0 : slabdsize-128            1744   1829    128   31    1 : tunables  
120   60    0 : slabdata     59     59      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    
0 : slabdata      0      0      0
size-64             2673   3416     64   61    1 : tunables  120   60    
0 : slabdata     56     56      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    
0 : slabdata      0      0      0
size-32             2321   2380     32  119    1 : tunables  120   60    
0 : slabdata     20     20      0
kmem_cache           124    124    128   31    1 : tunables  120   60    
0 : slabdata      4      4      0
ata      0      0      0



