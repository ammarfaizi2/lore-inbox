Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289473AbSAJOqY>; Thu, 10 Jan 2002 09:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289474AbSAJOqQ>; Thu, 10 Jan 2002 09:46:16 -0500
Received: from mailgate.bodgit-n-scarper.com ([62.49.233.146]:18440 "HELO
	mould.bodgit-n-scarper.com") by vger.kernel.org with SMTP
	id <S289473AbSAJOp5>; Thu, 10 Jan 2002 09:45:57 -0500
Date: Thu, 10 Jan 2002 14:55:42 +0000
From: Matt Dainty <matt@bodgit-n-scarper.com>
To: linux-kernel@vger.kernel.org
Cc: Andreas Dilger <adilger@turbolabs.com>, Bruce Guenter <bruceg@em.ca>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Where's all my memory going?
Message-ID: <20020110145542.B2499@mould.bodgit-n-scarper.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andreas Dilger <adilger@turbolabs.com>,
	Bruce Guenter <bruceg@em.ca>, Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <E16OMpF-0001pj-00@the-village.bc.nu> <Pine.LNX.4.33L.0201092034590.2985-100000@imladris.surriel.com> <20020110024520.A29045@em.ca> <20020110030537.C771@lynx.adilger.int>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <20020110030537.C771@lynx.adilger.int>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 on i686 SMP (mould)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 10, 2002 at 03:05:38AM -0700, Andreas Dilger wrote:
> On Jan 10, 2002  02:45 -0600, Bruce Guenter wrote:
> > On Wed, Jan 09, 2002 at 08:36:13PM -0200, Rik van Riel wrote:
> > 
> > > Matt, do you see any suspiciously high numbers in
> > > /proc/slabinfo ?
> > 
> > What would be suspiciously high?  The four biggest numbers I see are:
> > 
> > inode_cache       139772 204760    480 25589 25595    1
> > dentry_cache      184024 326550    128 10885 10885    1
> > buffer_head       166620 220480     96 4487 5512    1
> > size-64           102388 174876     64 2964 2964    1

Pretty much the same as Bruce here, mostly same culprits anyway:

inode_cache        84352  90800    480 11340 11350    1 :  124   62
dentry_cache      240060 240060    128 8002 8002    1 :  252  126
buffer_head       215417 227760     96 5694 5694    1 :  252  126
size-32           209954 209954     32 1858 1858    1 :  252  126

> The other question would of course be whether we are calling into
> shrink_dcache_memory() enough, but that is an issue for Matt to
> see by testing "postal" with and without the patch, and keeping an
> eye on the slab caches.

Patch applied cleanly, and I redid the 'test'. I've attached the output
of free and /proc/slabinfo, *.1 is without patch, *.2 is with. In both
cases postal was left to run for about 35 minutes by which time it had
delivered around ~54000 messages locally.

Overall, with the patch, the large numbers in /proc/slabinfo are *still*
large, but not as large as without the patch. Overall memory usage still
seems similar.

Matt
-- 
"Phased plasma rifle in a forty-watt range?"
"Hey, just what you see, pal"

--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="before.1"

             total       used       free     shared    buffers     cached
Mem:       1029524     113744     915780          0      30988      32156
-/+ buffers/cache:      50600     978924
Swap:      2097136          0    2097136

slabinfo - version: 1.1 (SMP)
kmem_cache            64     64    244    4    4    1 :  252  126
devfsd_event         126    169     20    1    1    1 :  252  126
tcp_tw_bucket         40     40     96    1    1    1 :  252  126
tcp_bind_bucket      113    113     32    1    1    1 :  252  126
tcp_open_request      59     59     64    1    1    1 :  252  126
inet_peer_cache        0      0     64    0    0    1 :  252  126
ip_fib_hash          113    113     32    1    1    1 :  252  126
ip_dst_cache          96     96    160    4    4    1 :  252  126
arp_cache             30     30    128    1    1    1 :  252  126
blkdev_requests      800    800     96   20   20    1 :  252  126
journal_head         390    390     48    5    5    1 :  252  126
revoke_table         126    253     12    1    1    1 :  252  126
revoke_record          0      0     32    0    0    1 :  252  126
dnotify cache          0      0     20    0    0    1 :  252  126
file lock cache       42     42     92    1    1    1 :  252  126
fasync cache           0      0     16    0    0    1 :  252  126
uid_cache            113    113     32    1    1    1 :  252  126
skbuff_head_cache     96     96    160    4    4    1 :  252  126
sock                  18     18    832    2    2    2 :  124   62
sigqueue              29     29    132    1    1    1 :  252  126
cdev_cache           413    413     64    7    7    1 :  252  126
bdev_cache            59     59     64    1    1    1 :  252  126
mnt_cache             59     59     64    1    1    1 :  252  126
inode_cache        37352  37352    480 4669 4669    1 :  124   62
dentry_cache       47280  47280    128 1576 1576    1 :  252  126
dquot                  0      0    128    0    0    1 :  252  126
filp                 420    420    128   14   14    1 :  252  126
names_cache           21     21   4096   21   21    1 :   60   30
buffer_head        16060  17320     96  409  433    1 :  252  126
mm_struct             72     72    160    3    3    1 :  252  126
vm_area_struct       674    800     96   20   20    1 :  252  126
fs_cache             118    118     64    2    2    1 :  252  126
files_cache           63     63    416    7    7    1 :  124   62
signal_act            69     69   1312   23   23    1 :   60   30
size-131072(DMA)       0      0 131072    0    0   32 :    0    0
size-131072            0      0 131072    0    0   32 :    0    0
size-65536(DMA)        0      0  65536    0    0   16 :    0    0
size-65536             0      0  65536    0    0   16 :    0    0
size-32768(DMA)        0      0  32768    0    0    8 :    0    0
size-32768             0      0  32768    0    0    8 :    0    0
size-16384(DMA)        0      0  16384    0    0    4 :    0    0
size-16384             3      3  16384    3    3    4 :    0    0
size-8192(DMA)         0      0   8192    0    0    2 :    0    0
size-8192              2      3   8192    2    3    2 :    0    0
size-4096(DMA)         0      0   4096    0    0    1 :   60   30
size-4096             24     24   4096   24   24    1 :   60   30
size-2048(DMA)         0      0   2048    0    0    1 :   60   30
size-2048             78     78   2048   39   39    1 :   60   30
size-1024(DMA)         0      0   1024    0    0    1 :  124   62
size-1024             96     96   1024   24   24    1 :  124   62
size-512(DMA)          0      0    512    0    0    1 :  124   62
size-512             136    136    512   17   17    1 :  124   62
size-256(DMA)          0      0    256    0    0    1 :  252  126
size-256              45     45    256    3    3    1 :  252  126
size-128(DMA)          0      0    128    0    0    1 :  252  126
size-128            1170   1170    128   39   39    1 :  252  126
size-64(DMA)           0      0     64    0    0    1 :  252  126
size-64              236    236     64    4    4    1 :  252  126
size-32(DMA)           0      0     32    0    0    1 :  252  126
size-32             5424   5424     32   48   48    1 :  252  126

--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="after.1"

             total       used       free     shared    buffers     cached
Mem:       1029524     992848      36676          0      54296     139212
-/+ buffers/cache:     799340     230184
Swap:      2097136        116    2097020
slabinfo - version: 1.1 (SMP)
kmem_cache            64     64    244    4    4    1 :  252  126
devfsd_event           0      0     20    0    0    1 :  252  126
tcp_tw_bucket        134   1520     96   18   38    1 :  252  126
tcp_bind_bucket      113    113     32    1    1    1 :  252  126
tcp_open_request      59     59     64    1    1    1 :  252  126
inet_peer_cache        0      0     64    0    0    1 :  252  126
ip_fib_hash           14    113     32    1    1    1 :  252  126
ip_dst_cache          96     96    160    4    4    1 :  252  126
arp_cache              9     30    128    1    1    1 :  252  126
blkdev_requests      640    640     96   16   16    1 :  252  126
journal_head         372    624     48    7    8    1 :  252  126
revoke_table           1    253     12    1    1    1 :  252  126
revoke_record          0      0     32    0    0    1 :  252  126
dnotify cache          0      0     20    0    0    1 :  252  126
file lock cache       42     42     92    1    1    1 :  252  126
fasync cache           0      0     16    0    0    1 :  252  126
uid_cache            113    113     32    1    1    1 :  252  126
skbuff_head_cache    110    120    160    5    5    1 :  252  126
sock                  27     27    832    3    3    2 :  124   62
sigqueue              29     29    132    1    1    1 :  252  126
cdev_cache           358    413     64    7    7    1 :  252  126
bdev_cache            40     59     64    1    1    1 :  252  126
mnt_cache             19     59     64    1    1    1 :  252  126
inode_cache        84352  90800    480 11340 11350    1 :  124   62
dentry_cache      240060 240060    128 8002 8002    1 :  252  126
dquot                  0      0    128    0    0    1 :  252  126
filp                 477    480    128   16   16    1 :  252  126
names_cache           11     11   4096   11   11    1 :   60   30
buffer_head       215417 227760     96 5694 5694    1 :  252  126
mm_struct             96     96    160    4    4    1 :  252  126
vm_area_struct       668    920     96   22   23    1 :  252  126
fs_cache              69    118     64    2    2    1 :  252  126
files_cache           69     72    416    8    8    1 :  124   62
signal_act            75     75   1312   25   25    1 :   60   30
size-131072(DMA)       0      0 131072    0    0   32 :    0    0
size-131072            0      0 131072    0    0   32 :    0    0
size-65536(DMA)        0      0  65536    0    0   16 :    0    0
size-65536             0      0  65536    0    0   16 :    0    0
size-32768(DMA)        0      0  32768    0    0    8 :    0    0
size-32768             0      0  32768    0    0    8 :    0    0
size-16384(DMA)        0      0  16384    0    0    4 :    0    0
size-16384             3      3  16384    3    3    4 :    0    0
size-8192(DMA)         0      0   8192    0    0    2 :    0    0
size-8192              2      2   8192    2    2    2 :    0    0
size-4096(DMA)         0      0   4096    0    0    1 :   60   30
size-4096             26     26   4096   26   26    1 :   60   30
size-2048(DMA)         0      0   2048    0    0    1 :   60   30
size-2048             98     98   2048   49   49    1 :   60   30
size-1024(DMA)         0      0   1024    0    0    1 :  124   62
size-1024             96     96   1024   24   24    1 :  124   62
size-512(DMA)          0      0    512    0    0    1 :  124   62
size-512             136    136    512   17   17    1 :  124   62
size-256(DMA)          0      0    256    0    0    1 :  252  126
size-256              45     45    256    3    3    1 :  252  126
size-128(DMA)          0      0    128    0    0    1 :  252  126
size-128            1104   1230    128   41   41    1 :  252  126
size-64(DMA)           0      0     64    0    0    1 :  252  126
size-64              175    236     64    4    4    1 :  252  126
size-32(DMA)           0      0     32    0    0    1 :  252  126
size-32           209954 209954     32 1858 1858    1 :  252  126

--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="before.2"

             total       used       free     shared    buffers     cached
Mem:       1029524      37764     991760          0       1988      11008
-/+ buffers/cache:      24768    1004756
Swap:      2097136          0    2097136

slabinfo - version: 1.1 (SMP)
kmem_cache            64     64    244    4    4    1 :  252  126
devfsd_event         126    169     20    1    1    1 :  252  126
tcp_tw_bucket          0      0     96    0    0    1 :  252  126
tcp_bind_bucket      113    113     32    1    1    1 :  252  126
tcp_open_request      59     59     64    1    1    1 :  252  126
inet_peer_cache        0      0     64    0    0    1 :  252  126
ip_fib_hash          113    113     32    1    1    1 :  252  126
ip_dst_cache          24     24    160    1    1    1 :  252  126
arp_cache             30     30    128    1    1    1 :  252  126
blkdev_requests      800    800     96   20   20    1 :  252  126
journal_head          78     78     48    1    1    1 :  252  126
revoke_table         126    253     12    1    1    1 :  252  126
revoke_record          0      0     32    0    0    1 :  252  126
dnotify cache          0      0     20    0    0    1 :  252  126
file lock cache       42     42     92    1    1    1 :  252  126
fasync cache           0      0     16    0    0    1 :  252  126
uid_cache            113    113     32    1    1    1 :  252  126
skbuff_head_cache     96     96    160    4    4    1 :  252  126
sock                  18     18    832    2    2    2 :  124   62
sigqueue              29     29    132    1    1    1 :  252  126
cdev_cache           354    354     64    6    6    1 :  252  126
bdev_cache            59     59     64    1    1    1 :  252  126
mnt_cache             59     59     64    1    1    1 :  252  126
inode_cache         1160   1160    480  145  145    1 :  124   62
dentry_cache        1320   1320    128   44   44    1 :  252  126
dquot                  0      0    128    0    0    1 :  252  126
filp                 330    330    128   11   11    1 :  252  126
names_cache            7      7   4096    7    7    1 :   60   30
buffer_head         3440   3440     96   86   86    1 :  252  126
mm_struct             48     48    160    2    2    1 :  252  126
vm_area_struct       600    600     96   15   15    1 :  252  126
fs_cache              59     59     64    1    1    1 :  252  126
files_cache           54     54    416    6    6    1 :  124   62
signal_act            51     51   1312   17   17    1 :   60   30
size-131072(DMA)       0      0 131072    0    0   32 :    0    0
size-131072            0      0 131072    0    0   32 :    0    0
size-65536(DMA)        0      0  65536    0    0   16 :    0    0
size-65536             0      0  65536    0    0   16 :    0    0
size-32768(DMA)        0      0  32768    0    0    8 :    0    0
size-32768             0      0  32768    0    0    8 :    0    0
size-16384(DMA)        0      0  16384    0    0    4 :    0    0
size-16384             3      3  16384    3    3    4 :    0    0
size-8192(DMA)         0      0   8192    0    0    2 :    0    0
size-8192              2      3   8192    2    3    2 :    0    0
size-4096(DMA)         0      0   4096    0    0    1 :   60   30
size-4096             23     23   4096   23   23    1 :   60   30
size-2048(DMA)         0      0   2048    0    0    1 :   60   30
size-2048             76     76   2048   38   38    1 :   60   30
size-1024(DMA)         0      0   1024    0    0    1 :  124   62
size-1024             96     96   1024   24   24    1 :  124   62
size-512(DMA)          0      0    512    0    0    1 :  124   62
size-512             136    136    512   17   17    1 :  124   62
size-256(DMA)          0      0    256    0    0    1 :  252  126
size-256              45     45    256    3    3    1 :  252  126
size-128(DMA)          0      0    128    0    0    1 :  252  126
size-128             990    990    128   33   33    1 :  252  126
size-64(DMA)           0      0     64    0    0    1 :  252  126
size-64              177    177     64    3    3    1 :  252  126
size-32(DMA)           0      0     32    0    0    1 :  252  126
size-32              339    339     32    3    3    1 :  252  126

--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="after.2"

             total       used       free     shared    buffers     cached
Mem:       1029524     992708      36816          0      43792     144516
-/+ buffers/cache:     804400     225124
Swap:      2097136        116    2097020

slabinfo - version: 1.1 (SMP)
kmem_cache            64     64    244    4    4    1 :  252  126
devfsd_event           0      0     20    0    0    1 :  252  126
tcp_tw_bucket        219   1520     96   20   38    1 :  252  126
tcp_bind_bucket      113    113     32    1    1    1 :  252  126
tcp_open_request      59     59     64    1    1    1 :  252  126
inet_peer_cache        0      0     64    0    0    1 :  252  126
ip_fib_hash           14    113     32    1    1    1 :  252  126
ip_dst_cache          72     72    160    3    3    1 :  252  126
arp_cache             11     30    128    1    1    1 :  252  126
blkdev_requests      640    640     96   16   16    1 :  252  126
journal_head         246    624     48    7    8    1 :  252  126
revoke_table           1    253     12    1    1    1 :  252  126
revoke_record          0      0     32    0    0    1 :  252  126
dnotify cache          0      0     20    0    0    1 :  252  126
file lock cache       17     42     92    1    1    1 :  252  126
fasync cache           0      0     16    0    0    1 :  252  126
uid_cache             10    113     32    1    1    1 :  252  126
skbuff_head_cache    111    120    160    5    5    1 :  252  126
sock                  27     27    832    3    3    2 :  124   62
sigqueue              29     29    132    1    1    1 :  252  126
cdev_cache           348    354     64    6    6    1 :  252  126
bdev_cache            40     59     64    1    1    1 :  252  126
mnt_cache             19     59     64    1    1    1 :  252  126
inode_cache        55744  62440    480 7801 7805    1 :  124   62
dentry_cache      125400 125400    128 4180 4180    1 :  252  126
dquot                  0      0    128    0    0    1 :  252  126
filp                 468    480    128   16   16    1 :  252  126
names_cache           11     11   4096   11   11    1 :   60   30
buffer_head       223430 236160     96 5904 5904    1 :  252  126
mm_struct             72     72    160    3    3    1 :  252  126
vm_area_struct       754    880     96   22   22    1 :  252  126
fs_cache             118    118     64    2    2    1 :  252  126
files_cache           72     72    416    8    8    1 :  124   62
signal_act            75     75   1312   25   25    1 :   60   30
size-131072(DMA)       0      0 131072    0    0   32 :    0    0
size-131072            0      0 131072    0    0   32 :    0    0
size-65536(DMA)        0      0  65536    0    0   16 :    0    0
size-65536             0      0  65536    0    0   16 :    0    0
size-32768(DMA)        0      0  32768    0    0    8 :    0    0
size-32768             0      0  32768    0    0    8 :    0    0
size-16384(DMA)        0      0  16384    0    0    4 :    0    0
size-16384             3      3  16384    3    3    4 :    0    0
size-8192(DMA)         0      0   8192    0    0    2 :    0    0
size-8192              2      2   8192    2    2    2 :    0    0
size-4096(DMA)         0      0   4096    0    0    1 :   60   30
size-4096             27     27   4096   27   27    1 :   60   30
size-2048(DMA)         0      0   2048    0    0    1 :   60   30
size-2048             94     94   2048   47   47    1 :   60   30
size-1024(DMA)         0      0   1024    0    0    1 :  124   62
size-1024             96     96   1024   24   24    1 :  124   62
size-512(DMA)          0      0    512    0    0    1 :  124   62
size-512             136    136    512   17   17    1 :  124   62
size-256(DMA)          0      0    256    0    0    1 :  252  126
size-256              45     45    256    3    3    1 :  252  126
size-128(DMA)          0      0    128    0    0    1 :  252  126
size-128            1104   1230    128   41   41    1 :  252  126
size-64(DMA)           0      0     64    0    0    1 :  252  126
size-64              177    236     64    4    4    1 :  252  126
size-32(DMA)           0      0     32    0    0    1 :  252  126
size-32           100005 100005     32  885  885    1 :  252  126

--tjCHc7DPkfUGtrlw--
