Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130485AbRD2RrB>; Sun, 29 Apr 2001 13:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131344AbRD2Rqv>; Sun, 29 Apr 2001 13:46:51 -0400
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:21774 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S130485AbRD2Rqg>;
	Sun, 29 Apr 2001 13:46:36 -0400
Date: Sun, 29 Apr 2001 19:46:31 +0200
From: Frank de Lange <frank@unternet.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Severe trashing in 2.4.4
Message-ID: <20010429194631.A11681@unternet.org>
In-Reply-To: <20010429181809.A10479@unternet.org> <Pine.GSO.4.21.0104291225130.2210-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0104291225130.2210-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Apr 29, 2001 at 12:27:29PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 12:27:29PM -0400, Alexander Viro wrote:
> What about /proc/slabinfo? Notice that 2.4.4 (and couple of the 2.4.4-pre)
> has a bug in prune_icache() that makes it underestimate the amount of
> freeable inodes.

Gotcha, wrt. slabinfo. Seems 2.4.4 (at least on my box) only knows how to
allocate skbuff_head_cache entries, not how to free them. Here's the last
/proc/slabinfo entry before I sysRQ'd the box:

slabinfo - version: 1.1 (SMP)
kmem_cache            68     68    232    4    4    1 :  252  126
nfs_read_data         10     10    384    1    1    1 :  124   62
nfs_write_data        10     10    384    1    1    1 :  124   62
nfs_page              40     40     96    1    1    1 :  252  126
urb_priv               1    113     32    1    1    1 :  252  126
uhci_desc           1074   1239     64   21   21    1 :  252  126
ip_mrt_cache           0      0     96    0    0    1 :  252  126
tcp_tw_bucket          0      0     96    0    0    1 :  252  126
tcp_bind_bucket       16    226     32    2    2    1 :  252  126
tcp_open_request       0      0     64    0    0    1 :  252  126
inet_peer_cache        1     59     64    1    1    1 :  252  126
ip_fib_hash           20    226     32    2    2    1 :  252  126
ip_dst_cache          13     48    160    2    2    1 :  252  126
arp_cache              2     60    128    2    2    1 :  252  126
blkdev_requests     1024   1040     96   26   26    1 :  252  126
dnotify cache          0      0     20    0    0    1 :  252  126
file lock cache      126    126     92    3    3    1 :  252  126
fasync cache           3    202     16    1    1    1 :  252  126
uid_cache              5    226     32    2    2    1 :  252  126
skbuff_head_cache 341136 341136    160 14214 14214    1 :  252  126
sock                 201    207    832   23   23    2 :  124   62
inode_cache          741   1640    480  205  205    1 :  124   62
bdev_cache             7     59     64    1    1    1 :  252  126
sigqueue              58     58    132    2    2    1 :  252  126
dentry_cache         790   3240    128  108  108    1 :  252  126
dquot                  0      0     96    0    0    1 :  252  126
filp                1825   1880     96   47   47    1 :  252  126
names_cache            9      9   4096    9    9    1 :   60   30
buffer_head          891   2880     96   72   72    1 :  252  126
mm_struct            180    180    128    6    6    1 :  252  126
vm_area_struct      4033   4248     64   72   72    1 :  252  126
fs_cache             207    236     64    4    4    1 :  252  126
files_cache          132    135    416   15   15    1 :  124   62
signal_act           108    111   1312   37   37    1 :   60   30
size-131072(DMA)       0      0 131072    0    0   32 :    0    0
size-131072            0      0 131072    0    0   32 :    0    0
size-65536(DMA)        0      0  65536    0    0   16 :    0    0
size-65536             0      0  65536    0    0   16 :    0    0
size-32768(DMA)        0      0  32768    0    0    8 :    0    0
size-32768             3      3  32768    3    3    8 :    0    0
size-16384(DMA)        0      0  16384    0    0    4 :    0    0
size-16384             8      9  16384    8    9    4 :    0    0
size-8192(DMA)         0      0   8192    0    0    2 :    0    0
size-8192              1      1   8192    1    1    2 :    0    0
size-4096(DMA)         0      0   4096    0    0    1 :   60   30
size-4096             73     73   4096   73   73    1 :   60   30
size-2048(DMA)         0      0   2048    0    0    1 :   60   30
size-2048          66338  66338   2048 33169 33169    1 :   60   30
size-1024(DMA)         0      0   1024    0    0    1 :  124   62
size-1024           6372   6372   1024 1593 1593    1 :  124   62
size-512(DMA)          0      0    512    0    0    1 :  124   62
size-512           22776  22776    512 2847 2847    1 :  124   62
size-256(DMA)          0      0    256    0    0    1 :  252  126
size-256           75300  75300    256 5020 5020    1 :  252  126
size-128(DMA)          0      0    128    0    0    1 :  252  126
size-128            1309   1410    128   47   47    1 :  252  126
size-64(DMA)           0      0     64    0    0    1 :  252  126
size-64             4838   4838     64   82   82    1 :  252  126
size-32(DMA)           0      0     32    0    0    1 :  252  126
size-32            33900  33900     32  300  300    1 :  252  126

>From the same moment, the contents of /proc/meminfo:

        total:    used:    free:  shared: buffers:  cached:
Mem:  262049792 260423680  1626112        0  1351680  6348800
Swap: 511926272 39727104 472199168
MemTotal:       255908 kB
MemFree:          1588 kB
MemShared:           0 kB
Buffers:          1320 kB
Cached:           6200 kB
Active:           2648 kB
Inact_dirty:      1260 kB
Inact_clean:      3604 kB
Inact_target:     3960 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255908 kB
LowFree:          1588 kB
SwapTotal:      499928 kB
SwapFree:       461132 kB

And to top-10 memury hogs:

 892 54696  2279 /usr/bin/X11/XFree86 -depth 16 -gamma 1.6 -auth /var/lib/gdm/:0
 632  2932 11363 ps -ax -o rss,vsz,pid,command
 600  8988  2785 gnome-terminal -t frank@behemoth.localnet
 368  7660  2685 multiload_applet --activate-goad-server multiload_applet --goad
 312  2100  4731 top
 308  7528  2675 gnomexmms --activate-goad-server gnomexmms --goad-fd 10
 244  7660  2701 multiload_applet --activate-goad-server multiload_applet --goad
 240  7436  2682 asclock_applet --activate-goad-server asclock_applet --goad-fd 
   4 11740  1110 /usr/sbin/mysqld --basedir=/ --datadir=/var/lib/mysql --user=my
   4 11740  1109 /usr/sbin/mysqld --basedir=/ --datadir=/var/lib/mysql --user=my

I've got a ton of logging from /proc/slabinfo, one entry a second. If someone
wants to peruse it, you can find it here:

 http://www.unternet.org/~frank/projects/linux2404/2404-meminfo/

 The .diff files are diffs between 'current' and 'previous' (one second
interval) snapshots. slabinfo and meminfo are self-explanatory I guess. The
'memhogs' entry is the top-10 memory users list for each second of logging.

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
