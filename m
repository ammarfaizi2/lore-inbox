Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129712AbRC3BD2>; Thu, 29 Mar 2001 20:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129719AbRC3BDL>; Thu, 29 Mar 2001 20:03:11 -0500
Received: from server1.cosmoslink.net ([208.179.167.101]:17757 "EHLO
	server1.cosmoslink.net") by vger.kernel.org with ESMTP
	id <S129712AbRC3BCw>; Thu, 29 Mar 2001 20:02:52 -0500
Message-ID: <024801c0ab59$76350880$bba6b3d0@Toshiba>
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
To: "Linus Torvalds" <torvalds@transmeta.com>,
   "Jamey Hicks" <jamey@crl.dec.com>, <linux-kernel@vger.kernel.org>
Cc: "Stephen L Johnson" <sjohnson@monsters.org>,
   "Jaswinder Singh" <jaswinder.singh@3disystems.com>
Subject: Fw: Memory leak in the ramfs file system
Date: Mon, 12 Mar 2001 17:03:48 -0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0245_01C0AB16.67DF6DE0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-Mimeole: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0245_01C0AB16.67DF6DE0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I am sorry, i am sending this mail again because earlier my Computer's time
was not set properly.

Jaswinder

----- Original Message -----
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
To: <linux-kernel@vger.kernel.org>; "Linus Torvalds"
<torvalds@transmeta.com>; "Jamey Hicks" <jamey@crl.dec.com>
Cc: "Stephen L Johnson" <sjohnson@monsters.org>; "Jaswinder Singh"
<jaswinder.singh@3disystems.com>
Sent: Monday, June 12, 2000 12:50 PM
Subject: Re: Memory leak in the ramfs file system


> Dear Linus,
>
>
> > What does /proc/slabinfo say? The most likely leak is a dentry leak or
> > an inode leak, and both of those should be fairly easy to see in the
> > slab info (dentry_cache and inode_cache respectively).
> >
>
> I am attaching details before and during  my application .
>
> Mainly changes are in dentry_cache and inode_cache , but i am attaching
> whole /proc/slabinfo for your reference.
>
>
> > Obviously, it could be a data page leak too, but such a leak should be
> > easy to see by creating a few big files and deleting them..
> >
> > Linus
>
> I am also facing one more problem with ramfs.
>
> du and df shows 0 , so i am also attaching its output.
>
> Thanks for your help,
>
> Best Regards,
>
> Jaswinder.
> --
> These are my opinions not 3Di.
>
>
>
>

------=_NextPart_000_0245_01C0AB16.67DF6DE0
Content-Type: text/plain;
	name="beforeapp.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="beforeapp.txt"

Before my Application Start
---------------------------
(none):/mnt/ramfs/root# cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  31571968 18669568 12902400        0    24576 12156928
Swap:        0        0        0
MemTotal:        30832 kB
MemFree:         12600 kB
MemShared:           0 kB
Buffers:            24 kB
Cached:          11872 kB
Active:           4456 kB
Inact_dirty:       508 kB
Inact_clean:      6932 kB
Inact_target:        8 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        30832 kB
LowFree:         12600 kB
SwapTotal:           0 kB
SwapFree:            0 kB
(none):/mnt/ramfs/root# free
             total       used       free     shared    buffers     cached
Mem:         30832      18284      12548          0         24      11916
-/+ buffers/cache:       6344      24488
Swap:            0          0          0
(none):/mnt/ramfs/root# cat /proc/slabinfo 
slabinfo - version: 1.1
kmem_cache            53     78    100    2    2    1
tcp_tw_bucket          0     40     96    0    1    1
tcp_bind_bucket        5    113     32    1    1    1
tcp_open_request       0     59     64    0    1    1
inet_peer_cache        0      0     64    0    0    1
ip_fib_hash            8    113     32    1    1    1
ip_dst_cache          11     24    160    1    1    1
arp_cache              2     30    128    1    1    1
blkdev_requests      256    280     96    7    7    1
dnotify cache          0      0     20    0    0    1
file lock cache        0     42     92    0    1    1
fasync cache           2    202     16    1    1    1
uid_cache              1    113     32    1    1    1
skbuff_head_cache     84    120    160    4    5    1
sock                  30     35    800    6    7    1
inode_cache         2218   2220    384  222  222    1
bdev_cache            48     59     64    1    1    1
sigqueue               0     29    132    0    1    1
kiobuf                 0      0    128    0    0    1
dentry_cache        2351   2370    128   79   79    1
filp                 125    160     96    4    4    1
names_cache            0      2   4096    0    2    1
buffer_head            9     40     96    1    1    1
mm_struct             13     24    160    1    1    1
vm_area_struct       268    354     64    5    6    1
fs_cache              12     59     64    1    1    1
files_cache           12     18    416    2    2    1
signal_act            14     15   1312    5    5    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             1      1  32768    1    1    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              0      0   8192    0    0    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096              3      4   4096    3    4    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048              6      8   2048    3    4    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024              9     16   1024    3    4    1
size-512(DMA)          0      0    512    0    0    1
size-512              23     32    512    3    4    1
size-256(DMA)          0      0    256    0    0    1
size-256              20     60    256    2    4    1
size-128(DMA)          0      0    128    0    0    1
size-128             366    450    128   13   15    1
size-64(DMA)           0      0     64    0    0    1
size-64               43     59     64    1    1    1
size-32(DMA)           0      0     32    0    0    1
size-32              116    226     32    2    2    1

------=_NextPart_000_0245_01C0AB16.67DF6DE0
Content-Type: text/plain;
	name="duringapp.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="duringapp.txt"

when my Application is running : i am able to take only 11 slabinfo =
details then my machine hanged
------------------------------
(none):/mnt/ramfs/root# free
             total       used       free     shared    buffers     =
cached
Mem:         30832      20792      10040          0         24      =
13992
-/+ buffers/cache:       6776      24056
Swap:            0          0          0
(none):/mnt/ramfs/root# cat /proc/slabinfo=20
slabinfo - version: 1.1
kmem_cache            53     78    100    2    2    1
tcp_tw_bucket          0     40     96    0    1    1
tcp_bind_bucket        6    113     32    1    1    1
tcp_open_request       0     59     64    0    1    1
inet_peer_cache        0      0     64    0    0    1
ip_fib_hash            8    113     32    1    1    1
ip_dst_cache           9     24    160    1    1    1
arp_cache              2     30    128    1    1    1
blkdev_requests      256    280     96    7    7    1
dnotify cache          0      0     20    0    0    1
file lock cache        0     42     92    0    1    1
fasync cache           2    202     16    1    1    1
uid_cache              1    113     32    1    1    1
skbuff_head_cache     84    120    160    4    5    1
sock                  31     35    800    7    7    1
inode_cache         3439   3440    384  344  344    1
bdev_cache            48     59     64    1    1    1
sigqueue               0     29    132    0    1    1
kiobuf                 0      0    128    0    0    1
dentry_cache        3573   3600    128  120  120    1
filp                 127    160     96    4    4    1
names_cache            0      2   4096    0    2    1
buffer_head            9     40     96    1    1    1
mm_struct             14     24    160    1    1    1
vm_area_struct       279    354     64    5    6    1
fs_cache              13     59     64    1    1    1
files_cache           13     18    416    2    2    1
signal_act            15     18   1312    5    6    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             1      1  32768    1    1    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              0      0   8192    0    0    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096              4      4   4096    4    4    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             30     30   2048   15   15    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024              9     20   1024    3    5    1
size-512(DMA)          0      0    512    0    0    1
size-512              23     32    512    3    4    1
size-256(DMA)          0      0    256    0    0    1
size-256              20     60    256    2    4    1
size-128(DMA)          0      0    128    0    0    1
size-128             366    450    128   13   15    1
size-64(DMA)           0      0     64    0    0    1
size-64               44     59     64    1    1    1
size-32(DMA)           0      0     32    0    0    1
size-32              127    226     32    2    2    1
(none):/mnt/ramfs/root# cat /proc/slabinfo=20
slabinfo - version: 1.1
kmem_cache            53     78    100    2    2    1
tcp_tw_bucket          0     40     96    0    1    1
tcp_bind_bucket        6    113     32    1    1    1
tcp_open_request       0     59     64    0    1    1
inet_peer_cache        0      0     64    0    0    1
ip_fib_hash            8    113     32    1    1    1
ip_dst_cache           9     24    160    1    1    1
arp_cache              2     30    128    1    1    1
blkdev_requests      256    280     96    7    7    1
dnotify cache          0      0     20    0    0    1
file lock cache        0     42     92    0    1    1
fasync cache           2    202     16    1    1    1
uid_cache              1    113     32    1    1    1
skbuff_head_cache     84    120    160    4    5    1
sock                  31     35    800    7    7    1
inode_cache         3809   3810    384  381  381    1
bdev_cache            48     59     64    1    1    1
sigqueue               0     29    132    0    1    1
kiobuf                 0      0    128    0    0    1
dentry_cache        3943   3960    128  132  132    1
filp                 127    160     96    4    4    1
names_cache            0      2   4096    0    2    1
buffer_head            9     40     96    1    1    1
mm_struct             14     24    160    1    1    1
vm_area_struct       279    354     64    5    6    1
fs_cache              13     59     64    1    1    1
files_cache           13     18    416    2    2    1
signal_act            15     18   1312    5    6    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             1      1  32768    1    1    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              0      0   8192    0    0    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096              4      4   4096    4    4    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             30     30   2048   15   15    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024              9     20   1024    3    5    1
size-512(DMA)          0      0    512    0    0    1
size-512              23     32    512    3    4    1
size-256(DMA)          0      0    256    0    0    1
size-256              20     60    256    2    4    1
size-128(DMA)          0      0    128    0    0    1
size-128             366    450    128   13   15    1
size-64(DMA)           0      0     64    0    0    1
size-64               44     59     64    1    1    1
size-32(DMA)           0      0     32    0    0    1
size-32              127    226     32    2    2    1
(none):/mnt/ramfs/root# cat /proc/slabinfo=20
slabinfo - version: 1.1
kmem_cache            53     78    100    2    2    1
tcp_tw_bucket          0     40     96    0    1    1
tcp_bind_bucket        6    113     32    1    1    1
tcp_open_request       0     59     64    0    1    1
inet_peer_cache        0      0     64    0    0    1
ip_fib_hash            8    113     32    1    1    1
ip_dst_cache           9     24    160    1    1    1
arp_cache              2     30    128    1    1    1
blkdev_requests      256    280     96    7    7    1
dnotify cache          0      0     20    0    0    1
file lock cache        0     42     92    0    1    1
fasync cache           2    202     16    1    1    1
uid_cache              1    113     32    1    1    1
skbuff_head_cache     84    120    160    4    5    1
sock                  31     35    800    7    7    1
inode_cache         4194   4200    384  420  420    1
bdev_cache            48     59     64    1    1    1
sigqueue               0     29    132    0    1    1
kiobuf                 0      0    128    0    0    1
dentry_cache        4328   4350    128  145  145    1
filp                 127    160     96    4    4    1
names_cache            0      2   4096    0    2    1
buffer_head            9     40     96    1    1    1
mm_struct             14     24    160    1    1    1
vm_area_struct       279    354     64    5    6    1
fs_cache              13     59     64    1    1    1
files_cache           13     18    416    2    2    1
signal_act            15     18   1312    5    6    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             1      1  32768    1    1    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              0      0   8192    0    0    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096              4      4   4096    4    4    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             30     32   2048   15   16    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024              9     20   1024    3    5    1
size-512(DMA)          0      0    512    0    0    1
size-512              23     32    512    3    4    1
size-256(DMA)          0      0    256    0    0    1
size-256              20     60    256    2    4    1
size-128(DMA)          0      0    128    0    0    1
size-128             366    450    128   13   15    1
size-64(DMA)           0      0     64    0    0    1
size-64               44     59     64    1    1    1
size-32(DMA)           0      0     32    0    0    1
size-32              128    226     32    2    2    1
(none):/mnt/ramfs/root# cat /proc/slabinfo=20
slabinfo - version: 1.1
kmem_cache            53     78    100    2    2    1
tcp_tw_bucket          0     40     96    0    1    1
tcp_bind_bucket        6    113     32    1    1    1
tcp_open_request       0     59     64    0    1    1
inet_peer_cache        0      0     64    0    0    1
ip_fib_hash            8    113     32    1    1    1
ip_dst_cache           9     24    160    1    1    1
arp_cache              2     30    128    1    1    1
blkdev_requests      256    280     96    7    7    1
dnotify cache          0      0     20    0    0    1
file lock cache        0     42     92    0    1    1
fasync cache           2    202     16    1    1    1
uid_cache              1    113     32    1    1    1
skbuff_head_cache     84    120    160    4    5    1
sock                  31     35    800    7    7    1
inode_cache         4506   4510    384  451  451    1
bdev_cache            48     59     64    1    1    1
sigqueue               0     29    132    0    1    1
kiobuf                 0      0    128    0    0    1
dentry_cache        4640   4650    128  155  155    1
filp                 127    160     96    4    4    1
names_cache            0      2   4096    0    2    1
buffer_head            9     40     96    1    1    1
mm_struct             14     24    160    1    1    1
vm_area_struct       279    354     64    5    6    1
fs_cache              13     59     64    1    1    1
files_cache           13     18    416    2    2    1
signal_act            15     18   1312    5    6    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             1      1  32768    1    1    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              0      0   8192    0    0    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096              4      4   4096    4    4    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             30     32   2048   15   16    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024              9     20   1024    3    5    1
size-512(DMA)          0      0    512    0    0    1
size-512              24     32    512    3    4    1
size-256(DMA)          0      0    256    0    0    1
size-256              20     60    256    2    4    1
size-128(DMA)          0      0    128    0    0    1
size-128             366    450    128   13   15    1
size-64(DMA)           0      0     64    0    0    1
size-64               44     59     64    1    1    1
size-32(DMA)           0      0     32    0    0    1
size-32              128    226     32    2    2    1
(none):/mnt/ramfs/root# cat /proc/slabinfo=20
slabinfo - version: 1.1
kmem_cache            53     78    100    2    2    1
tcp_tw_bucket          0     40     96    0    1    1
tcp_bind_bucket        6    113     32    1    1    1
tcp_open_request       0     59     64    0    1    1
inet_peer_cache        0      0     64    0    0    1
ip_fib_hash            8    113     32    1    1    1
ip_dst_cache           9     24    160    1    1    1
arp_cache              2     30    128    1    1    1
blkdev_requests      256    280     96    7    7    1
dnotify cache          0      0     20    0    0    1
file lock cache        0     42     92    0    1    1
fasync cache           2    202     16    1    1    1
uid_cache              1    113     32    1    1    1
skbuff_head_cache     84    120    160    4    5    1
sock                  31     35    800    7    7    1
inode_cache         4896   4900    384  490  490    1
bdev_cache            48     59     64    1    1    1
sigqueue               0     29    132    0    1    1
kiobuf                 0      0    128    0    0    1
dentry_cache        5030   5040    128  168  168    1
filp                 127    160     96    4    4    1
names_cache            0      2   4096    0    2    1
buffer_head            9     40     96    1    1    1
mm_struct             14     24    160    1    1    1
vm_area_struct       279    354     64    5    6    1
fs_cache              13     59     64    1    1    1
files_cache           13     18    416    2    2    1
signal_act            15     18   1312    5    6    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             1      1  32768    1    1    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              0      0   8192    0    0    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096              4      4   4096    4    4    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             30     32   2048   15   16    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024              9     20   1024    3    5    1
size-512(DMA)          0      0    512    0    0    1
size-512              23     32    512    3    4    1
size-256(DMA)          0      0    256    0    0    1
size-256              20     60    256    2    4    1
size-128(DMA)          0      0    128    0    0    1
size-128             366    450    128   13   15    1
size-64(DMA)           0      0     64    0    0    1
size-64               44     59     64    1    1    1
size-32(DMA)           0      0     32    0    0    1
size-32              128    226     32    2    2    1
(none):/mnt/ramfs/root# cat /proc/slabinfo=20
slabinfo - version: 1.1
kmem_cache            53     78    100    2    2    1
tcp_tw_bucket          0     40     96    0    1    1
tcp_bind_bucket        6    113     32    1    1    1
tcp_open_request       0     59     64    0    1    1
inet_peer_cache        0      0     64    0    0    1
ip_fib_hash            8    113     32    1    1    1
ip_dst_cache           9     24    160    1    1    1
arp_cache              2     30    128    1    1    1
blkdev_requests      256    280     96    7    7    1
dnotify cache          0      0     20    0    0    1
file lock cache        0     42     92    0    1    1
fasync cache           2    202     16    1    1    1
uid_cache              1    113     32    1    1    1
skbuff_head_cache     84    120    160    4    5    1
sock                  31     35    800    7    7    1
inode_cache         5306   5310    384  531  531    1
bdev_cache            48     59     64    1    1    1
sigqueue               0     29    132    0    1    1
kiobuf                 0      0    128    0    0    1
dentry_cache        5440   5460    128  182  182    1
filp                 127    160     96    4    4    1
names_cache            0      2   4096    0    2    1
buffer_head            9     40     96    1    1    1
mm_struct             14     24    160    1    1    1
vm_area_struct       279    354     64    5    6    1
fs_cache              13     59     64    1    1    1
files_cache           13     18    416    2    2    1
signal_act            15     18   1312    5    6    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             1      1  32768    1    1    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              0      0   8192    0    0    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096              4      4   4096    4    4    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             30     32   2048   15   16    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024              9     20   1024    3    5    1
size-512(DMA)          0      0    512    0    0    1
size-512              23     32    512    3    4    1
size-256(DMA)          0      0    256    0    0    1
size-256              20     60    256    2    4    1
size-128(DMA)          0      0    128    0    0    1
size-128             366    450    128   13   15    1
size-64(DMA)           0      0     64    0    0    1
size-64               44     59     64    1    1    1
size-32(DMA)           0      0     32    0    0    1
size-32              128    226     32    2    2    1
(none):/mnt/ramfs/root# cat /proc/slabinfo=20
slabinfo - version: 1.1
kmem_cache            53     78    100    2    2    1
tcp_tw_bucket          0     40     96    0    1    1
tcp_bind_bucket        6    113     32    1    1    1
tcp_open_request       0     59     64    0    1    1
inet_peer_cache        0      0     64    0    0    1
ip_fib_hash            8    113     32    1    1    1
ip_dst_cache           9     24    160    1    1    1
arp_cache              2     30    128    1    1    1
blkdev_requests      256    280     96    7    7    1
dnotify cache          0      0     20    0    0    1
file lock cache        0     42     92    0    1    1
fasync cache           2    202     16    1    1    1
uid_cache              1    113     32    1    1    1
skbuff_head_cache     84    120    160    4    5    1
sock                  31     35    800    7    7    1
inode_cache         5702   5710    384  571  571    1
bdev_cache            48     59     64    1    1    1
sigqueue               0     29    132    0    1    1
kiobuf                 0      0    128    0    0    1
dentry_cache        5836   5850    128  195  195    1
filp                 127    160     96    4    4    1
names_cache            0      2   4096    0    2    1
buffer_head            9     40     96    1    1    1
mm_struct             14     24    160    1    1    1
vm_area_struct       279    354     64    5    6    1
fs_cache              13     59     64    1    1    1
files_cache           13     18    416    2    2    1
signal_act            15     18   1312    5    6    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             1      1  32768    1    1    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              0      0   8192    0    0    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096              4      4   4096    4    4    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             30     32   2048   16   16    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024              9     20   1024    3    5    1
size-512(DMA)          0      0    512    0    0    1
size-512              23     32    512    3    4    1
size-256(DMA)          0      0    256    0    0    1
size-256              20     60    256    2    4    1
size-128(DMA)          0      0    128    0    0    1
size-128             366    450    128   13   15    1
size-64(DMA)           0      0     64    0    0    1
size-64               44     59     64    1    1    1
size-32(DMA)           0      0     32    0    0    1
size-32              128    226     32    2    2    1
(none):/mnt/ramfs/root# cat /proc/slabinfo=20
slabinfo - version: 1.1
kmem_cache            53     78    100    2    2    1
tcp_tw_bucket          0     40     96    0    1    1
tcp_bind_bucket        6    113     32    1    1    1
tcp_open_request       0     59     64    0    1    1
inet_peer_cache        0      0     64    0    0    1
ip_fib_hash            8    113     32    1    1    1
ip_dst_cache           9     24    160    1    1    1
arp_cache              2     30    128    1    1    1
blkdev_requests      256    280     96    7    7    1
dnotify cache          0      0     20    0    0    1
file lock cache        0     42     92    0    1    1
fasync cache           2    202     16    1    1    1
uid_cache              1    113     32    1    1    1
skbuff_head_cache     84    120    160    4    5    1
sock                  31     35    800    7    7    1
inode_cache         4994   5780    384  578  578    1
bdev_cache            48     59     64    1    1    1
sigqueue               0     29    132    0    1    1
kiobuf                 0      0    128    0    0    1
dentry_cache        4893   5820    128  194  194    1
filp                 127    160     96    4    4    1
names_cache            0      2   4096    0    2    1
buffer_head           13     40     96    1    1    1
mm_struct             14     24    160    1    1    1
vm_area_struct       279    354     64    5    6    1
fs_cache              13     59     64    1    1    1
files_cache           13     18    416    2    2    1
signal_act            15     18   1312    5    6    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             1      1  32768    1    1    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              0      0   8192    0    0    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096              4      4   4096    4    4    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             30     32   2048   15   16    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024              9     20   1024    3    5    1
size-512(DMA)          0      0    512    0    0    1
size-512              23     32    512    3    4    1
size-256(DMA)          0      0    256    0    0    1
size-256              20     60    256    2    4    1
size-128(DMA)          0      0    128    0    0    1
size-128             366    450    128   13   15    1
size-64(DMA)           0      0     64    0    0    1
size-64               44     59     64    1    1    1
size-32(DMA)           0      0     32    0    0    1
size-32              113    226     32    2    2    1
(none):/mnt/ramfs/root# cat /proc/slabinfo=20
slabinfo - version: 1.1
kmem_cache            53     78    100    2    2    1
tcp_tw_bucket          0     40     96    0    1    1
tcp_bind_bucket        6    113     32    1    1    1
tcp_open_request       0     59     64    0    1    1
inet_peer_cache        0      0     64    0    0    1
ip_fib_hash            8    113     32    1    1    1
ip_dst_cache           9     24    160    1    1    1
arp_cache              2     30    128    1    1    1
blkdev_requests      256    280     96    7    7    1
dnotify cache          0      0     20    0    0    1
file lock cache        0     42     92    0    1    1
fasync cache           2    202     16    1    1    1
uid_cache              1    113     32    1    1    1
skbuff_head_cache     84    120    160    4    5    1
sock                  31     35    800    7    7    1
inode_cache         5268   5780    384  578  578    1
bdev_cache            48     59     64    1    1    1
sigqueue               0     29    132    0    1    1
kiobuf                 0      0    128    0    0    1
dentry_cache        5266   5820    128  194  194    1
filp                 127    160     96    4    4    1
names_cache            0      2   4096    0    2    1
buffer_head           13     40     96    1    1    1
mm_struct             14     24    160    1    1    1
vm_area_struct       279    354     64    5    6    1
fs_cache              13     59     64    1    1    1
files_cache           13     18    416    2    2    1
signal_act            15     18   1312    5    6    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             1      1  32768    1    1    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              0      0   8192    0    0    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096              4      4   4096    4    4    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             30     32   2048   15   16    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024              9     20   1024    3    5    1
size-512(DMA)          0      0    512    0    0    1
size-512              23     32    512    3    4    1
size-256(DMA)          0      0    256    0    0    1
size-256              20     60    256    2    4    1
size-128(DMA)          0      0    128    0    0    1
size-128             366    450    128   13   15    1
size-64(DMA)           0      0     64    0    0    1
size-64               44     59     64    1    1    1
size-32(DMA)           0      0     32    0    0    1
size-32              113    226     32    2    2    1
(none):/mnt/ramfs/root# cat /proc/slabinfo=20
slabinfo - version: 1.1
kmem_cache            53     78    100    2    2    1
tcp_tw_bucket          0      0     96    0    0    1
tcp_bind_bucket        6    113     32    1    1    1
tcp_open_request       0     59     64    0    1    1
inet_peer_cache        0      0     64    0    0    1
ip_fib_hash            8    113     32    1    1    1
ip_dst_cache           9     24    160    1    1    1
arp_cache              2     30    128    1    1    1
blkdev_requests      256    280     96    7    7    1
dnotify cache          0      0     20    0    0    1
file lock cache        0      0     92    0    0    1
fasync cache           2    202     16    1    1    1
uid_cache              1    113     32    1    1    1
skbuff_head_cache     84    120    160    4    5    1
sock                  31     35    800    7    7    1
inode_cache         5624   5780    384  578  578    1
bdev_cache            48     59     64    1    1    1
sigqueue               0     29    132    0    1    1
kiobuf                 0      0    128    0    0    1
dentry_cache        5618   5820    128  194  194    1
filp                 127    160     96    4    4    1
names_cache            0      2   4096    0    2    1
buffer_head           17     40     96    1    1    1
mm_struct             14     24    160    1    1    1
vm_area_struct       279    354     64    5    6    1
fs_cache              13     59     64    1    1    1
files_cache           13     18    416    2    2    1
signal_act            15     18   1312    5    6    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             1      1  32768    1    1    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              0      0   8192    0    0    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096              4      4   4096    4    4    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             30     32   2048   15   16    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024              9     20   1024    3    5    1
size-512(DMA)          0      0    512    0    0    1
size-512              23     32    512    3    4    1
size-256(DMA)          0      0    256    0    0    1
size-256              20     60    256    2    4    1
size-128(DMA)          0      0    128    0    0    1
size-128             366    450    128   13   15    1
size-64(DMA)           0      0     64    0    0    1
size-64               44     59     64    1    1    1
size-32(DMA)           0      0     32    0    0    1
size-32              113    226     32    2    2    1
(none):/mnt/ramfs/root# cat /proc/slabinfo=20
slabinfo - version: 1.1
kmem_cache            53     78    100    2    2    1
tcp_tw_bucket          0      0     96    0    0    1
tcp_bind_bucket        6    113     32    1    1    1
tcp_open_request       0     59     64    0    1    1
inet_peer_cache        0      0     64    0    0    1
ip_fib_hash            8    113     32    1    1    1
ip_dst_cache           9     24    160    1    1    1
arp_cache              2     30    128    1    1    1
blkdev_requests      256    280     96    7    7    1
dnotify cache          0      0     20    0    0    1
file lock cache        0      0     92    0    0    1
fasync cache           2    202     16    1    1    1
uid_cache              1    113     32    1    1    1
skbuff_head_cache     84    120    160    4    5    1
sock                  31     35    800    7    7    1
inode_cache         5727   5780    384  578  578    1
bdev_cache            48     59     64    1    1    1
sigqueue               0     29    132    0    1    1
kiobuf                 0      0    128    0    0    1
dentry_cache        5721   5820    128  194  194    1
filp                 127    160     96    4    4    1
names_cache            0      2   4096    0    2    1
buffer_head           21     40     96    1    1    1
mm_struct             14     24    160    1    1    1
vm_area_struct       279    354     64    5    6    1
fs_cache              13     59     64    1    1    1
files_cache           13     18    416    2    2    1
signal_act            15     15   1312    5    5    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             1      1  32768    1    1    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              0      0   8192    0    0    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096              4      4   4096    4    4    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             30     32   2048   15   16    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024              9     20   1024    3    5    1
size-512(DMA)          0      0    512    0    0    1
size-512              23     32    512    3    4    1
size-256(DMA)          0      0    256    0    0    1
size-256              20     60    256    2    4    1
size-128(DMA)          0      0    128    0    0    1
size-128             366    450    128   13   15    1
size-64(DMA)           0      0     64    0    0    1
size-64               44     59     64    1    1    1
size-32(DMA)           0      0     32    0    0    1
size-32              113    226     32    2    2    1

Linux hanged here 
------=_NextPart_000_0245_01C0AB16.67DF6DE0
Content-Type: text/plain;
	name="dfdu.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dfdu.txt"

(none):/mnt/ramfs/root# df -h /mnt/ramfs/
Filesystem            Size  Used Avail Use% Mounted on
ramfs                    0     0     0   -  /mnt/ramfs
(none):/mnt/ramfs/root# du /mnt/ramfs/
0       /mnt/ramfs/var/modules
0       /mnt/ramfs/var/run
0       /mnt/ramfs/var/local
0       /mnt/ramfs/var/lock
0       /mnt/ramfs/var/tmp
0       /mnt/ramfs/var/log
0       /mnt/ramfs/var
0       /mnt/ramfs/tmp/.X11-unix
0       /mnt/ramfs/tmp
0       /mnt/ramfs/root/.classifiers
0       /mnt/ramfs/root
0       /mnt/ramfs/home/guest
0       /mnt/ramfs/home/ppp
0       /mnt/ramfs/home
0       /mnt/ramfs/etc/pcmcia/cis
0       /mnt/ramfs/etc/pcmcia
0       /mnt/ramfs/etc/wlan
0       /mnt/ramfs/etc/rc2.d
0       /mnt/ramfs/etc/cron.daily
0       /mnt/ramfs/etc/rc6.d
0       /mnt/ramfs/etc/alternatives
0       /mnt/ramfs/etc/modutils/arch
0       /mnt/ramfs/etc/modutils
0       /mnt/ramfs/etc/sysconfig
0       /mnt/ramfs/etc/rc.boot
0       /mnt/ramfs/etc/rc5.d
0       /mnt/ramfs/etc/irda
0       /mnt/ramfs/etc/rc0.d
0       /mnt/ramfs/etc/cron.d
0       /mnt/ramfs/etc/rcS.d
0       /mnt/ramfs/etc/rc4.d
0       /mnt/ramfs/etc/rc1.d
0       /mnt/ramfs/etc/apt
0       /mnt/ramfs/etc/skel
0       /mnt/ramfs/etc/default
0       /mnt/ramfs/etc/init.d
0       /mnt/ramfs/etc/rc3.d
0       /mnt/ramfs/etc/rc.d/init.d
0       /mnt/ramfs/etc/rc.d
0       /mnt/ramfs/etc/ppp
0       /mnt/ramfs/etc
0       /mnt/ramfs
(none):/mnt/ramfs/root#
------=_NextPart_000_0245_01C0AB16.67DF6DE0--

