Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283581AbRLIQIr>; Sun, 9 Dec 2001 11:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283582AbRLIQIf>; Sun, 9 Dec 2001 11:08:35 -0500
Received: from nc-ashvl-66-169-84-151.charternc.net ([66.169.84.151]:6784 "EHLO
	orp.orf.cx") by vger.kernel.org with ESMTP id <S283581AbRLIQI2>;
	Sun, 9 Dec 2001 11:08:28 -0500
Message-Id: <200112091607.fB9G7mj01944@orp.orf.cx>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
To: Mike Galbraith <mikeg@wen-online.de>
Cc: "M.H.VanLeeuwen" <vanl@megsinet.net>, Mark Hahn <hahn@physics.mcmaster.ca>,
        Andrew Morton <akpm@zip.com.au>, Ken Brownfield <brownfld@irridia.com>,
        linux-kernel@vger.kernel.org
From: Leigh Orf <orf@mailbag.com>
Organization: Department of Tesselating Kumquats
X-URL: http://orf.cx
X-face: "(Qpt_9H~41JFy=C&/h^zmz6Dm6]1ZKLat1<W!0bNwz2!LxG-lZ=r@4Me&uUvG>-r\?<DcDb+Y'p'sCMJ
Subject: Re: 2.4.16 memory badness (fixed?)
In-Reply-To: Your message of "Sun, 09 Dec 2001 08:13:09 +0100."
             <Pine.LNX.4.33.0112090808250.6883-100000@mikeg.weiden.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 09 Dec 2001 11:07:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



In a personal email, Mike Galbraith wrote to me:

|   On Sat, 8 Dec 2001, Leigh Orf wrote:
|   
|   > inode_cache       439584 439586    512 62798 62798    1
|   > dentry_cache      454136 454200    128 15140 15140    1
|   
|   I'd try moving shrink_[id]cache_memory to the very top of vmscan.c::shrink_caches.
|   
|   	-Mike

Mike,

I tried what you suggested starting with a stock 2.4.16 kernel, and it
did fix the problem with 2.4.16 ENOMEM being returned.

Now with that change and after updatedb runs, here's what the memory
situation looks like. Note inode_cache and dentry_cache are almost
nothing. Dunno if that's a good thing or not, but I'd definitely
consider this for a patch.

home[1002]:/home/orf% free
             total       used       free     shared    buffers     cached
Mem:       1029828    1020316       9512          0     719596     145768
-/+ buffers/cache:     154952     874876
Swap:      2064344          0    2064344

home[1003]:/home/orf% cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  1054543872 1044979712  9564160        0 736870400 149282816
Swap: 2113888256        0 2113888256
MemTotal:      1029828 kB
MemFree:          9340 kB
MemShared:           0 kB
Buffers:        719600 kB
Cached:         145784 kB
SwapCached:          0 kB
Active:         462276 kB
Inactive:       481572 kB
HighTotal:      130992 kB
HighFree:         2044 kB
LowTotal:       898836 kB
LowFree:          7296 kB
SwapTotal:     2064344 kB
SwapFree:      2064344 kB

home[1001]:/home/orf% cat /proc/slabinfo
slabinfo - version: 1.1
kmem_cache            65     68    112    2    2    1
ip_conntrack          13     30    384    3    3    1
nfs_write_data         0      0    384    0    0    1
nfs_read_data          0      0    384    0    0    1
nfs_page               0      0    128    0    0    1
ip_fib_hash           10    112     32    1    1    1
urb_priv               0      0     64    0    0    1
clip_arp_cache         0      0    128    0    0    1
ip_mrt_cache           0      0    128    0    0    1
tcp_tw_bucket          0     30    128    0    1    1
tcp_bind_bucket        8    112     32    1    1    1
tcp_open_request       0      0    128    0    0    1
inet_peer_cache        1     59     64    1    1    1
ip_dst_cache          21     40    192    2    2    1
arp_cache              3     30    128    1    1    1
blkdev_requests      640    660    128   22   22    1
journal_head           0      0     48    0    0    1
revoke_table           0      0     12    0    0    1
revoke_record          0      0     32    0    0    1
dnotify cache          0      0     20    0    0    1
file lock cache        2     42     92    1    1    1
fasync cache           2    202     16    1    1    1
uid_cache              5    112     32    1    1    1
skbuff_head_cache    293    300    192   15   15    1
sock                 209    213   1280   70   71    1
sigqueue               2     29    132    1    1    1
cdev_cache            21    295     64    3    5    1
bdev_cache             8     59     64    1    1    1
mnt_cache             19     59     64    1    1    1
inode_cache         7151  16905    512 2412 2415    1
dentry_cache        3043  12630    128  421  421    1
dquot                  0      0    128    0    0    1
filp                1990   2010    128   67   67    1
names_cache            0      2   4096    0    2    1
buffer_head       220278 220350    128 7344 7345    1
mm_struct             64     80    192    4    4    1
vm_area_struct      2779   3180    128   93  106    1
fs_cache              63    118     64    2    2    1
files_cache           63     72    448    7    8    1
signal_act            71     72   1344   24   24    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             1      1  65536    1    1   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             1      1  32768    1    1    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             1      5  16384    1    5    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              4      5   8192    4    5    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096             72     78   4096   72   78    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             61     96   2048   32   48    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024           1475   2988   1024  532  747    1
size-512(DMA)          0      0    512    0    0    1
size-512            1650   4168    512  351  521    1
size-256(DMA)          0      0    256    0    0    1
size-256             486   2340    256   45  156    1
size-128(DMA)          2     30    128    1    1    1
size-128            3483  10050    128  230  335    1
size-64(DMA)           0      0     64    0    0    1
size-64             1792   3304     64   56   56    1
size-32(DMA)          34     59     64    1    1    1
size-32             4159  11092     64  159  188    1

Leigh Orf


