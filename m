Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTENNzl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 09:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbTENNzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 09:55:41 -0400
Received: from ms-smtp-03.southeast.rr.com ([24.93.67.84]:55214 "EHLO
	ms-smtp-03.southeast.rr.com") by vger.kernel.org with ESMTP
	id S262251AbTENNze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 09:55:34 -0400
From: Boris Kurktchiev <techstuff@gmx.net>
Reply-To: techstuff@gmx.net
To: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: Posible memory leak!?
Date: Wed, 14 May 2003 10:12:53 -0400
User-Agent: KMail/1.5.1
References: <200305131415.37244.techstuff@gmx.net> <200305140650.h4E6oCu04880@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200305140650.h4E6oCu04880@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305141012.53779.techstuff@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 09:51:53  up 16:40,  1 user,  load average: 0.02, 0.02, 0.00
> 56 processes: 55 sleeping, 1 running, 0 zombie, 0 stopped
> CPU states:  0.2% user,  0.4% system,  0.0% nice,  0.0% iowait, 99.3% idle
> Mem:   124616k av,  114444k used,   10172k free,       0k shrd,       4k
> buff 53088k active,              46836k inactive
> Swap:   76792k av,    1804k used,   74988k free                   53632k
> cached
>
> Can you show "top b n1" (unabridged) and "cat /proc/meminfo", "cat
> /proc/slabinfo" of the "swap usage shoot up to 95%" event?

heh this is very interesting.... top b n1 reports this:
top - 10:08:24 up 16:36,  2 users,  load average: 0.16, 0.19, 0.08
Tasks:  62 total,   1 running,  60 sleeping,   0 stopped,   1 zombie
Cpu(s):  12.3% user,   5.1% system,   0.0% nice,  82.6% idle
Mem:    385904k total,   381572k used,     4332k free,   137244k buffers
Swap:   128512k total,    20012k used,   108500k free,   126168k cached

while gkrellm reports that my RAM used is 95MB. now this is interesting....

here is the /proc/meminfo:
        total:    used:    free:  shared: buffers:  cached:
Mem:  395165696 389582848  5582848        0 141422592 138055680
Swap: 131596288 20623360 110972928
MemTotal:       385904 kB
MemFree:          5452 kB
MemShared:           0 kB
Buffers:        138108 kB
Cached:         127324 kB
SwapCached:       7496 kB
Active:         181268 kB
Inactive:       132244 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       385904 kB
LowFree:          5452 kB
SwapTotal:      128512 kB
SwapFree:       108372 kB

and here is /proc/slabinfo:
slabinfo - version: 1.1
kmem_cache            57     72    108    2    2    1
ip_conntrack           3     24    320    1    2    1
tcp_tw_bucket          0     30    128    0    1    1
tcp_bind_bucket        4    112     32    1    1    1
tcp_open_request       0      0     64    0    0    1
inet_peer_cache        0      0     64    0    0    1
ip_fib_hash           14    112     32    1    1    1
ip_dst_cache          30     40    192    2    2    1
arp_cache              3     30    128    1    1    1
urb_priv               3     59     64    1    1    1
blkdev_requests     1024   1050    128   35   35    1
dnotify_cache        125    169     20    1    1    1
file_lock_cache        7     42     92    1    1    1
fasync_cache           1    202     16    1    1    1
uid_cache              1    112     32    1    1    1
skbuff_head_cache    128    220    192   11   11    1
sock                 117    145    768   26   29    1
sigqueue               0     29    132    0    1    1
kiobuf                 0      0     64    0    0    1
cdev_cache            19     59     64    1    1    1
bdev_cache             6     59     64    1    1    1
mnt_cache             19     59     64    1    1    1
inode_cache        45164  59479    512 8497 8497    1
dentry_cache       20481  62910    128 2097 2097    1
filp                1262   1290    128   43   43    1
names_cache            0      2   4096    0    2    1
buffer_head        94915  97440    128 3248 3248    1
mm_struct             47     60    192    3    3    1
vm_area_struct      2479   2910    128   90   97    1
fs_cache              46     59     64    1    1    1
files_cache           46     54    448    6    6    1
signal_act            51     57   1344   18   19    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             2      2  65536    2    2   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             4      4  32768    4    4    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             9     11  16384    9   11    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              5     20   8192    5   20    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096             79     95   4096   79   95    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             10     14   2048    5    7    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             70     96   1024   18   24    1
size-512(DMA)          0      0    512    0    0    1
size-512              65     80    512   10   10    1
size-256(DMA)          0      0    256    0    0    1
size-256              49     75    256    4    5    1
size-128(DMA)          2     30    128    1    1    1
size-128             883    930    128   30   31    1
size-64(DMA)           0      0     64    0    0    1
size-64             2791   2891     64   49   49    1
size-32(DMA)          36     59     64    1    1    1
size-32              414    472     64    8    8    1


