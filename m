Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275140AbRIYSC7>; Tue, 25 Sep 2001 14:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275144AbRIYSCu>; Tue, 25 Sep 2001 14:02:50 -0400
Received: from [213.97.45.174] ([213.97.45.174]:261 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S275140AbRIYSCf>;
	Tue, 25 Sep 2001 14:02:35 -0400
Date: Tue, 25 Sep 2001 20:01:51 +0200 (CEST)
From: Pau Aliagas <linux4u@wanadoo.es>
X-X-Sender: <pau@pau.intranet.ct>
To: Rik van Riel <riel@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.9-ac15 painfully sluggish
In-Reply-To: <Pine.LNX.4.33L.0109251426310.26091-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0109251934420.1309-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, Rik van Riel wrote:

> > [pau@pau pau]$ vmstat -n 5
> >    procs                      memory    swap          io     system         cpu
> >  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
> >  2  6  1   2392   3040    476   9644   5   7   585    17  170   479  85   6   9
> >  2 12  0   2520   2800    408   9028  25  27  1425    35  208   184  92   6   2
> >  2  4  0   2596   2812    408   9500  15  22  1174    24  204   304  79   6  16
>
> Wow, these are a LOT of reads and a very small cache.

> Here things get "interesting" ...
>
> total memory:                               127 MB
> The memory taken by all your processes:      55 MB
> buffer + cache:                              10 MB
> -----------------------------------------------------
> missing:                                     62 MB
>
> It would be interesting to get a listing of /proc/slabinfo,
> in particular those lines which have a large number in the
> 4th or 5th column...

1. Before starting evolution:
slabinfo - version: 1.1
kmem_cache            59     68    112    2    2    1
ip_conntrack          11     33    352    3    3    1
ip_fib_hash           12    113     32    1    1    1
uhci_urb_priv          1     67     56    1    1    1
ip_mrt_cache           0      0     96    0    0    1
tcp_tw_bucket          1     40     96    1    1    1
tcp_bind_bucket       12    113     32    1    1    1
tcp_open_request       0      0     64    0    0    1
inet_peer_cache        1     59     64    1    1    1
ip_dst_cache          41    100    192    5    5    1
arp_cache              2     30    128    1    1    1
blkdev_requests      512    520     96   13   13    1
dnotify cache          0      0     20    0    0    1
file lock cache        4     42     92    1    1    1
fasync cache           1    202     16    1    1    1
uid_cache              7    113     32    1    1    1
skbuff_head_cache    129    240    160   10   10    1
sock                 300    333    832   37   37    2
sigqueue            1024   1044    132   36   36    1
kiobuf                 0      0   8768    0    0    4
cdev_cache            23    118     64    2    2    1
bdev_cache             6     59     64    1    1    1
mnt_cache             16     59     64    1    1    1
inode_cache         1036   2178    416  242  242    1
dentry_cache        1019   2730    128   91   91    1
dquot                  0      0    128    0    0    1
filp                3116   3120     96   78   78    1
names_cache            0      1   4096    0    1    1
buffer_head         3816   5240     96  131  131    1
mm_struct             83     96    160    4    4    1
vm_area_struct      4536   4897     64   83   83    1
fs_cache              82    118     64    2    2    1
files_cache           82     90    416   10   10    1
signal_act            87     90   1312   30   30    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             1      1  32768    1    1    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              6      6   8192    6    6    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096             33     33   4096   33   33    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048              7      8   2048    4    4    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             57     60   1024   15   15    1
size-512(DMA)          0      0    512    0    0    1
size-512              16     24    512    2    3    1
size-256(DMA)          0      0    256    0    0    1
size-256              21     30    256    2    2    1
size-128(DMA)          2     30    128    1    1    1
size-128             462    510    128   17   17    1
size-64(DMA)           0      0     64    0    0    1
size-64              242    295     64    5    5    1
size-32(DMA)           2    113     32    1    1    1
size-32              429   1017     32    9    9    1
evol

2.while starting evolution (evolution-pine-importer looks through MANY
pine mboxes to see if it can import them, more or less like updatedb that
ckecks all the files in the disc, so it looks like something related to
reading lots of files)

slabinfo - version: 1.1
kmem_cache            59     68    112    2    2    1
ip_conntrack           7     33    352    3    3    1
ip_fib_hash           12    113     32    1    1    1
uhci_urb_priv          1     67     56    1    1    1
ip_mrt_cache           0      0     96    0    0    1
tcp_tw_bucket          1     40     96    1    1    1
tcp_bind_bucket       12    113     32    1    1    1
tcp_open_request       0      0     64    0    0    1
inet_peer_cache        1     59     64    1    1    1
ip_dst_cache          55    100    192    5    5    1
arp_cache              2     30    128    1    1    1
blkdev_requests      512    520     96   13   13    1
dnotify cache          0      0     20    0    0    1
file lock cache        4     42     92    1    1    1
fasync cache           1    202     16    1    1    1
uid_cache              7    113     32    1    1    1
skbuff_head_cache    161    240    160   10   10    1
sock                 324    324    832   36   36    2
sigqueue            1024   1044    132   36   36    1
kiobuf                 0      0   8768    0    0    4
cdev_cache            21    118     64    2    2    1
bdev_cache             6     59     64    1    1    1
mnt_cache             16     59     64    1    1    1
inode_cache          994   2178    416  242  242    1
dentry_cache         984   2730    128   91   91    1
dquot                  0      0    128    0    0    1
filp                3116   3120     96   78   78    1
names_cache            1      4   4096    1    4    1
buffer_head         2229   3440     96   86   86    1
mm_struct             86     96    160    4    4    1
vm_area_struct      4929   4956     64   84   84    1
fs_cache              85    118     64    2    2    1
files_cache           85     90    416   10   10    1
signal_act            90     93   1312   31   31    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             1      2  32768    1    2    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              6      6   8192    6    6    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096             37     38   4096   37   38    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048              9     12   2048    5    6    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             57     60   1024   15   15    1
size-512(DMA)          0      0    512    0    0    1
size-512              20     32    512    4    4    1
size-256(DMA)          0      0    256    0    0    1
size-256              39     60    256    4    4    1
size-128(DMA)          2     30    128    1    1    1
size-128             503    570    128   19   19    1
size-64(DMA)           0      0     64    0    0    1
size-64              248    295     64    5    5    1
size-32(DMA)           2    113     32    1    1    1
size-32              442   1017     32    9    9    1

BTW, It has taken me more than 10 minutes to write this email and
evolution hasn't yet started.

3.last slabinfo (the disk still "plays")

slabinfo - version: 1.1
kmem_cache            59     68    112    2    2    1
ip_conntrack          10     22    352    2    2    1
ip_fib_hash           12    113     32    1    1    1
uhci_urb_priv          1     67     56    1    1    1
ip_mrt_cache           0      0     96    0    0    1
tcp_tw_bucket          1     40     96    1    1    1
tcp_bind_bucket       11    113     32    1    1    1
tcp_open_request       0      0     64    0    0    1
inet_peer_cache        2     59     64    1    1    1
ip_dst_cache          45    100    192    5    5    1
arp_cache              2     30    128    1    1    1
blkdev_requests      512    520     96   13   13    1
dnotify cache          0      0     20    0    0    1
file lock cache        9     42     92    1    1    1
fasync cache           1    202     16    1    1    1
uid_cache              7    113     32    1    1    1
skbuff_head_cache    129    264    160   11   11    1
sock                 344    351    832   39   39    2
sigqueue             433    435    132   15   15    1
kiobuf                 0      0   8768    0    0    4
cdev_cache            21    118     64    2    2    1
bdev_cache             6     59     64    1    1    1
mnt_cache             16     59     64    1    1    1
inode_cache         1023   2178    416  242  242    1
dentry_cache        1012   2730    128   91   91    1
dquot                  0      0    128    0    0    1
filp                3116   3120     96   78   78    1
names_cache            0      3   4096    0    3    1
buffer_head         2072   2520     96   63   63    1
mm_struct             84     96    160    4    4    1
vm_area_struct      5156   5251     64   89   89    1
fs_cache              83    118     64    2    2    1
files_cache           83     90    416   10   10    1
signal_act            88     93   1312   31   31    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             1      1  32768    1    1    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              6      6   8192    6    6    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096             33     34   4096   33   34    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048              7     10   2048    4    5    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             53     56   1024   14   14    1
size-512(DMA)          0      0    512    0    0    1
size-512              16     32    512    2    4    1
size-256(DMA)          0      0    256    0    0    1
size-256              21     30    256    2    2    1
size-128(DMA)          2     30    128    1    1    1
size-128             461    510    128   17   17    1
size-64(DMA)           0      0     64    0    0    1
size-64              249    295     64    5    5    1
size-32(DMA)           2    113     32    1    1    1
size-32              440   1017     32    9    9    1

While the disc is reading:
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 3 11  0   2492   2800    436   8300   9   8   610    14  160   308  89   6   6
 2  7  0   2412   3568    408   8232  20   2  1538     4  222   264  76   9  15
 1 10  0   2664   2800    432   9128   3  30  1388    40  212   201  89   8   3
 2  7  0   2616   3020    492   9360  26  25  1457    25  204   198  84   6  10
 4 10  0   2648   2800    420   8780   8   0  1377     6  201   233  88   7   4
 1 10  0   2528   2800    440   8736   9   0  1248     0  220   280  82   6  12
 1  6  1   2520   2800    448   8688   1   3  1350    30  212   230  75  12  13



Pau

