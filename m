Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284586AbRLET2q>; Wed, 5 Dec 2001 14:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284598AbRLET2j>; Wed, 5 Dec 2001 14:28:39 -0500
Received: from ns1.calixo.net ([213.166.201.1]:60690 "EHLO ns1.rmcnet.fr")
	by vger.kernel.org with ESMTP id <S284586AbRLET22>;
	Wed, 5 Dec 2001 14:28:28 -0500
Date: Wed, 5 Dec 2001 20:28:17 +0100
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [solved in 17pre1aa1] Gradual VM-related freeze in 2.4.16,17-pre2 !
Message-ID: <20011205192817.GC10646@calixo.net>
In-Reply-To: <20011205055509.GB11283@calixo.net> <20011205094632.Q3447@athlon.random>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011205094632.Q3447@athlon.random>
User-Agent: Mutt/1.3.24i
X-Face: "99`N"mZV/:<T->OLp[>#d3R;u.!ivtwAEpIQDL8rD#;L3Wm)~^)Uv=#;S!LZf1y8oRY7J#JR\Lr{*4Cn*32C89ln>0~5~tm--}j%hvhj+vtW><xbwA=@G8M||zPV0-r`:6zhMqq+_OC_0W*-:Wxzm3%|A5EE}VFnIgRU=+,L-hGdM"j&l'_^zK+%MBOsdmi#e3(3fGg^SGM
From: Cyrille Chepelov <cyrille@chepelov.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Le mer, dÃ©c 05, 2001, à 09:46:32 +0100, Andrea Arcangeli a écrit:

> > Now, as soon as the system gets some use (inetd kicks exim in, one ssh
> > attempt, etc.), most processes go freeze themselves into 
> >   <shrink_caches +57/80>
> 
> I never reproduced anything wrong here, testing on highmem and non
> highmem. Just in case can you also reproduce with 2.4.17pre1aa1?


Here are the results; basically, I've pitted 2.4.17-pre2 against
2.4.17-pre2+pre1aa1. The short story is, pre1aa1 works great for the
workload I've thrown at it (Debian 'woody'; long netfilter rules;
console-only runlevel2; exim; apache; apt-get update && apt-get -uy
dist-upgrade; ssh; one updatedb ; top). pre2 doesn't
even make it to runlevel2 (I've made two tests with the "andrea" kernel, one
in single mode for comparison with "marcelo" kernel, one in normal
multi-user mode).

Incidentally, I perceive a much better performance with 2.4.17-pre2+pre1aa1
than with 2.4.13-ac8 (Rik's VM).

	-- Cyrille

-- 
Grumpf.


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="report.txt"
Content-Transfer-Encoding: 8bit

--- andrea-free --- :
             total       used       free     shared    buffers     cached
Mem:          6540       6352        188          0        640       3720
-/+ buffers/cache:       1992       4548
Swap:       294328         88     294240
--- andrea-mem --- :
        total:    used:    free:  shared: buffers:  cached:
Mem:   6696960  6496256   200704        0   643072  3919872
Swap: 301391872    90112 301301760
MemTotal:         6540 kB
MemFree:           196 kB
MemShared:           0 kB
Buffers:           628 kB
Cached:           3740 kB
SwapCached:         88 kB
Active:           3236 kB
Inactive:         1808 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:         6540 kB
LowFree:           196 kB
SwapTotal:      294328 kB
SwapFree:       294240 kB
--- andrea-multi-free --- :
             total       used       free     shared    buffers     cached
Mem:          6540       6376        164          0        344       2504
-/+ buffers/cache:       3528       3012
Swap:       294328       1992     292336
--- andrea-multi-mem --- :
        total:    used:    free:  shared: buffers:  cached:
Mem:   6696960  6524928   172032        0   352256  3469312
Swap: 301391872  2039808 299352064
MemTotal:         6540 kB
MemFree:           168 kB
MemShared:           0 kB
Buffers:           344 kB
Cached:           2512 kB
SwapCached:        876 kB
Active:           3236 kB
Inactive:         1224 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:         6540 kB
LowFree:           168 kB
SwapTotal:      294328 kB
SwapFree:       292336 kB
--- andrea-multi-slab --- :
slabinfo - version: 1.1
kmem_cache            61     70    112    2    2    1
ip_conntrack          14     22    352    2    2    1
ip_fib_hash           13    203     16    1    1    1
fib6_nodes             7    113     32    1    1    1
ip6_dst_cache         12     20    192    1    1    1
ndisc_cache            1     30    128    1    1    1
tcp_tw_bucket          1     30    128    1    1    1
tcp_bind_bucket        3    203     16    1    1    1
tcp_open_request       0      0     96    0    0    1
inet_peer_cache        2     78     48    1    1    1
ip_dst_cache          24     24    160    1    1    1
arp_cache              3     35    112    1    1    1
blkdev_requests       64     80     96    2    2    1
journal_head           8     78     48    1    1    1
revoke_table           2    254     12    1    1    1
revoke_record          0      0     16    0    0    1
dnotify cache          0      0     20    0    0    1
file lock cache        1     42     92    1    1    1
fasync cache           0      0     16    0    0    1
uid_cache              1    113     32    1    1    1
skbuff_head_cache     12     24    160    1    1    1
sock                  16     20    928    4    5    1
sigqueue               0     29    132    0    1    1
cdev_cache             9     78     48    1    1    1
bdev_cache             3     59     64    1    1    1
mnt_cache             12     59     64    1    1    1
inode_cache          288    376    480   47   47    1
dentry_cache         240    455    112   13   13    1
filp                 167    175    112    5    5    1
names_cache            0      1   4096    0    1    1
buffer_head          845   1320     96   33   33    1
mm_struct             18     27    144    1    1    1
vm_area_struct       435    480     80   10   10    1
fs_cache              17     78     48    1    1    1
files_cache           17     27    416    2    3    1
signal_act            21     27   1296    7    9    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             0      0  32768    0    0    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              0      0   8192    0    0    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096             14     15   4096   14   15    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             11     12   2048    6    6    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             15     16   1024    4    4    1
size-512(DMA)          0      0    512    0    0    1
size-512              24     32    512    3    4    1
size-256(DMA)          0      0    256    0    0    1
size-256              19     30    256    2    2    1
size-128(DMA)          0      0    128    0    0    1
size-128             596    630    128   21   21    1
size-64(DMA)           0      0     64    0    0    1
size-64               77    118     64    2    2    1
size-32(DMA)           0      0     32    0    0    1
size-32              158    226     32    2    2    1
--- andrea-slab --- :
slabinfo - version: 1.1
kmem_cache            60     70    112    2    2    1
ip_fib_hash           13    203     16    1    1    1
fib6_nodes             7    113     32    1    1    1
ip6_dst_cache         12     20    192    1    1    1
ndisc_cache            1     30    128    1    1    1
tcp_tw_bucket          1     30    128    1    1    1
tcp_bind_bucket        1    203     16    1    1    1
tcp_open_request       0      0     96    0    0    1
inet_peer_cache        1     78     48    1    1    1
ip_dst_cache          28     48    160    2    2    1
arp_cache              4     35    112    1    1    1
blkdev_requests       64     80     96    2    2    1
journal_head          29     78     48    1    1    1
revoke_table           2    254     12    1    1    1
revoke_record          0      0     16    0    0    1
dnotify cache          0      0     20    0    0    1
file lock cache        0     42     92    0    1    1
fasync cache           0      0     16    0    0    1
uid_cache              0      0     32    0    0    1
skbuff_head_cache      4     24    160    1    1    1
sock                   9     12    928    3    3    1
sigqueue               0     29    132    0    1    1
cdev_cache             7     78     48    1    1    1
bdev_cache             3     59     64    1    1    1
mnt_cache             12     59     64    1    1    1
inode_cache          381    384    480   48   48    1
dentry_cache         394    420    112   12   12    1
filp                  41     70    112    2    2    1
names_cache            0      2   4096    0    2    1
buffer_head         1185   1240     96   31   31    1
mm_struct              5     27    144    1    1    1
vm_area_struct        68    144     80    2    3    1
fs_cache               4     78     48    1    1    1
files_cache            4      9    416    1    1    1
signal_act             8     15   1296    3    5    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             0      0  32768    0    0    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              0      0   8192    0    0    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096              1      3   4096    1    3    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             11     14   2048    6    7    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             15     16   1024    4    4    1
size-512(DMA)          0      0    512    0    0    1
size-512              19     24    512    3    3    1
size-256(DMA)          0      0    256    0    0    1
size-256              19     30    256    2    2    1
size-128(DMA)          0      0    128    0    0    1
size-128             598    600    128   20   20    1
size-64(DMA)           0      0     64    0    0    1
size-64               63    118     64    2    2    1
size-32(DMA)           0      0     32    0    0    1
size-32              148    226     32    2    2    1
--- andrea-uname --- :
Linux
--- marcelo-free --- :
             total       used       free     shared    buffers     cached
Mem:          6560       6364        196          0        464       3920
-/+ buffers/cache:       1980       4580
Swap:       294328          0     294328
--- marcelo-lockup --- :
Warning (compare_maps): 8390 symbol ei_open not found in /lib/modules/2.4.17-pre2/kernel/drivers/net/8390.o.  Ignoring /lib/modules/2.4.17-pre2/kernel/drivers/net/8390.o entry
Warning (compare_maps): 8390 symbol ei_tx_timeout not found in /lib/modules/2.4.17-pre2/kernel/drivers/net/8390.o.  Ignoring /lib/modules/2.4.17-pre2/kernel/drivers/net/8390.o entry
Warning (compare_maps): 8390 symbol ethdev_init not found in /lib/modules/2.4.17-pre2/kernel/drivers/net/8390.o.  Ignoring /lib/modules/2.4.17-pre2/kernel/drivers/net/8390.o entry
Call Trace: [<c0126257>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c0126256 <shrink_caches+56/80>


219 warnings and 5 errors issued.  Results may not be reliable.
--- marcelo-mem --- :
        total:    used:    free:  shared: buffers:  cached:
Mem:   6717440  6500352   217088        0   479232  4009984
Swap: 301391872        0 301391872
MemTotal:         6560 kB
MemFree:           212 kB
MemShared:           0 kB
Buffers:           468 kB
Cached:           3916 kB
SwapCached:          0 kB
Active:           3444 kB
Inactive:         1612 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:         6560 kB
LowFree:           212 kB
SwapTotal:      294328 kB
SwapFree:       294328 kB
--- marcelo-slab --- :
slabinfo - version: 1.1
kmem_cache            60     70    112    2    2    1
ip_fib_hash           13    203     16    1    1    1
fib6_nodes             7    113     32    1    1    1
ip6_dst_cache         12     20    192    1    1    1
ndisc_cache            1     30    128    1    1    1
tcp_tw_bucket          0      0    128    0    0    1
tcp_bind_bucket        0    203     16    0    1    1
tcp_open_request       0      0     96    0    0    1
inet_peer_cache        1     78     48    1    1    1
ip_dst_cache          29     48    160    2    2    1
arp_cache              3     35    112    1    1    1
blkdev_requests       64     96     80    2    2    1
journal_head          12     78     48    1    1    1
revoke_table           2    254     12    1    1    1
revoke_record          0      0     16    0    0    1
dnotify cache          0      0     20    0    0    1
file lock cache        0     42     92    0    1    1
fasync cache           0      0     16    0    0    1
uid_cache              0      0     32    0    0    1
skbuff_head_cache     18     24    160    1    1    1
sock                   9     12    912    3    3    1
sigqueue               0     29    132    0    1    1
cdev_cache             7     78     48    1    1    1
bdev_cache             3     59     64    1    1    1
mnt_cache             12     59     64    1    1    1
inode_cache          379    384    480   48   48    1
dentry_cache         374    420    112   12   12    1
filp                  41     70    112    2    2    1
names_cache            0      2   4096    0    2    1
buffer_head         1165   1240     96   31   31    1
mm_struct              5     27    144    1    1    1
vm_area_struct        68    144     80    2    3    1
fs_cache               4     78     48    1    1    1
files_cache            4      9    416    1    1    1
signal_act             8     12   1296    3    4    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             0      0  32768    0    0    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              0      0   8192    0    0    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096              1      3   4096    1    3    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             11     12   2048    6    6    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             15     16   1024    4    4    1
size-512(DMA)          0      0    512    0    0    1
size-512              19     24    512    3    3    1
size-256(DMA)          0      0    256    0    0    1
size-256              19     45    256    2    3    1
size-128(DMA)          0      0    128    0    0    1
size-128             589    600    128   20   20    1
size-64(DMA)           0      0     64    0    0    1
size-64               63    118     64    2    2    1
size-32(DMA)           0      0     32    0    0    1
size-32              151    226     32    2    2    1
--- marcelo-uname --- :
Linux traminer 2.4.17-pre2 #1 mer déc 5 14:17:58 CET 2001 i486 unknown

--Nq2Wo0NMKNjxTN9z--
