Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbSJLXRH>; Sat, 12 Oct 2002 19:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261373AbSJLXRH>; Sat, 12 Oct 2002 19:17:07 -0400
Received: from smtp.comcast.net ([24.153.64.2]:33998 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S261371AbSJLXRF>;
	Sat, 12 Oct 2002 19:17:05 -0400
Date: Sat, 12 Oct 2002 19:22:50 -0400
From: Tom Vier <tmv@comcast.net>
Subject: 2.4.19 OOM killer triggered
To: linux-kernel@vger.kernel.org
Reply-to: Tom Vier <tmv@comcast.net>
Message-id: <20021012232250.GB9237@yzero>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it was triggered during a cronjob that includes an rsync from one fs to
another (both reiserfs, the source is md0) and has thousands of hardlinks,
and a daily incremental tar of the whole fs (except for the dir with all
the hardlinks).

the good news is it killed an unneeded proc, the bad news is i have 190megs
of swap and only 6megs used. also, the used+shared is WAY higher than
normal. i don't know what's using all that ram (i have a half gig). usually,
most of my ram is buffers and cache.

the following info is from several hours after the cron run, but at least
shows the strange used+shared:

Oct 12 06:19:31 zero kernel: Out of Memory: Killed process 260 (xfs-xtt).

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0   5848  10672 139048  39192   2   3    26    22   14    24  99   1   0

        total:    used:    free:  shared: buffers:  cached:
Mem:  526098432 520478720  5619712        0 136224768 49987584
Swap: 201277440  5988352 195289088
MemTotal:       513768 kB
MemFree:          5488 kB
MemShared:           0 kB
Buffers:        133032 kB
Cached:          47208 kB
SwapCached:       1608 kB
Active:          90616 kB
Inactive:        96032 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513768 kB
LowFree:          5488 kB
SwapTotal:      196560 kB
SwapFree:       190712 kB

slabinfo - version: 1.1
kmem_cache            53     94    168    2    2    1
tcp_tw_bucket          0     61    128    0    1    1
tcp_bind_bucket        4    226     32    1    1    1
tcp_open_request       0      0     96    0    0    1
inet_peer_cache        0      0     96    0    0    1
ip_fib_hash            9    226     32    1    1    1
ip_dst_cache          15     35    224    1    1    1
arp_cache              2     41    192    1    1    1
blkdev_requests      768    784    160   16   16    1
devfsd_event           0      0     32    0    0    1
dnotify cache          0      0     40    0    0    1
file lock cache        6     49    160    1    1    1
fasync cache           0      0     24    0    0    1
uid_cache              5    119     64    1    1    1
skbuff_head_cache     93     93    256    3    3    1
sock                  23     28   1152    4    4    1
sigqueue               0     58    136    0    1    1
cdev_cache          1239   1309     64   11   11    1
bdev_cache           286    324     96    4    4    1
mnt_cache             15     61    128    1    1    1
inode_cache       300042 300050    768 30005 30005    1
dentry_cache      247084 295979    192 7219 7219    1
filp                 345    369    192    9    9    1
names_cache            0      2   4096    0    1    1
buffer_head        43938  49938    192 1217 1218    1
mm_struct             27     62    256    2    2    1
vm_area_struct       554    735    160   15   15    1
fs_cache              26    119     64    1    1    1
files_cache           26     36    832    4    4    1
signal_act            31     42   2080    6    6    2
size-131072(DMA)       0      0 131072    0    0   16
size-131072            0      0 131072    0    0   16
size-65536(DMA)        0      0  65536    0    0    8
size-65536             1      1  65536    1    1    8
size-32768(DMA)        0      0  32768    0    0    4
size-32768             6      6  32768    6    6    4
size-16384(DMA)        0      0  16384    0    0    2
size-16384             2      2  16384    2    2    2
size-8192(DMA)         0      0   8192    0    0    1
size-8192              9      9   8192    9    9    1
size-4096(DMA)         0      0   4096    0    0    1
size-4096             37     38   4096   19   19    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             61     64   2048   16   16    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024            160    160   1024   20   20    1
size-512(DMA)          0      0    512    0    0    1
size-512              44     60    512    3    4    1
size-256(DMA)          0      0    256    0    0    1
size-256            2079   2108    256   68   68    1
size-128(DMA)          0      0    128    0    0    1
size-128             277    488    128    8    8    1
size-64(DMA)           0      0     64    0    0    1
size-64            40760  49266     64  414  414    1

     64k: PID     1 (/lib/ld-2.2.5.so)
    184k: PID    25 (/lib/ld-2.2.5.so)
     96k: PID   199 (/lib/ld-2.2.5.so)
    984k: PID   202 (/lib/ld-2.2.5.so)
     88k: PID   219 (/lib/ld-2.2.5.so)
     40k: PID   220 (/lib/ld-2.2.5.so)
     40k: PID   223 (/lib/ld-2.2.5.so)
     40k: PID   224 (/lib/ld-2.2.5.so)
   6304k: PID   225 (/lib/ld-2.2.5.so)
   1424k: PID   229 (/lib/ld-2.2.5.so)
     48k: PID   230 (/lib/ld-2.2.5.so)
   6304k: PID   232 (/lib/ld-2.2.5.so)
   6304k: PID   233 (/lib/ld-2.2.5.so)
   6304k: PID   235 (/lib/ld-2.2.5.so)
   6304k: PID   236 (/lib/ld-2.2.5.so)
     56k: PID   247 (/lib/ld-2.2.5.so)
    144k: PID   250 (/lib/ld-2.2.5.so)
    328k: PID   256 (/lib/ld-2.2.5.so)
     88k: PID   285 (/lib/ld-2.2.5.so)
    304k: PID   288 (/lib/ld-2.2.5.so)
    384k: PID   291 (/lib/ld-2.2.5.so)
    680k: PID   456 (/lib/ld-2.2.5.so)
   1112k: PID   457 (/lib/ld-2.2.5.so)
    216k: PID   458 (/usr/local/bin/dnetc)
    192k: PID   576 (/lib/ld-2.2.5.so)
    304k: PID  1698 (/lib/ld-2.2.5.so)
    320k: PID  2691 (/lib/ld-2.2.5.so)
    320k: PID  2693 (/lib/ld-2.2.5.so)
    304k: PID  2696 (/lib/ld-2.2.5.so)
    336k: PID  2714 (/lib/ld-2.2.5.so)
    120k: PID  2777 (/lib/ld-2.2.5.so)
     64k: /lib/libwrap.so.0.7.6 256
    296k: /usr/bin/fetchmail 291
    424k: /lib/libncurses.so.5.2 456 457 576 1698 2691 2693 2696 2714
      8k: /usr/bin/memstat 2777
    256k: /lib/libreadline.so.4.2 576
   1616k: /usr/bin/BitchX 457
     48k: /usr/sbin/cron 288
     24k: /usr/sbin/atd 285
    568k: /usr/local/bin/dnetc 458
     64k: /usr/sbin/ippl 225 232 233 235 236
     64k: /lib/libpam.so.0.72 256 288 456 2714
    112k: /sbin/devfsd 25
     64k: /lib/libpopt.so.0.0.0 250
    232k: /usr/sbin/ntpd 576
    472k: /usr/bin/screen 456 2714
    304k: /usr/bin/rsync 250
     24k: /sbin/powstatd 247
    128k: /usr/lib/libz.so.1.1.4 256
     32k: /sbin/klogd 202
     40k: /sbin/syslogd 199
    880k: /bin/bash 1698 2691 2693 2696
   1248k: /usr/lib/libcrypto.so.0.9.6 256
    472k: /usr/sbin/sshd 256
     48k: /sbin/init 1
    120k: /lib/ld-2.2.5.so 1 25 199 202 219 220 223 224 225 229 230 232 233 ...
   1536k: /lib/libc-2.2.5.so 1 25 199 202 219 220 223 224 225 229 230 232 23...
     88k: /lib/libcrypt-2.2.5.so 256 288 291 456 457 2714
     64k: /lib/libdl-2.2.5.so 25 256 288 456 457 1698 2691 2693 2696 2714
    576k: /lib/libm-2.2.5.so 457 576
    176k: /lib/libnsl-2.2.5.so 25 225 232 233 235 236 256 285 288 291 456 45...
    120k: /lib/libnss_compat-2.2.5.so 25 225 232 233 235 236 256 285 288 291...
     80k: /lib/libnss_dns-2.2.5.so 291 457
     64k: /lib/libnss_files-2.2.5.so 199 225 232 233 235 236 291 457
    144k: /lib/libresolv-2.2.5.so 250 291 457
     64k: /lib/libutil-2.2.5.so 256 456 2714
    184k: /lib/libpthread-0.9.so 225 232 233 235 236
     80k: /usr/bin/svscan 219
     24k: /usr/bin/supervise 223 224
     96k: /usr/bin/multilog 220 230
    128k: /usr/bin/dnscache 229
--------
  50768k

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0xE6CB97DA
