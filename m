Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285161AbRL2S0S>; Sat, 29 Dec 2001 13:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285186AbRL2SZ7>; Sat, 29 Dec 2001 13:25:59 -0500
Received: from smtp-out.Austria.EU.net ([193.154.160.117]:6274 "EHLO
	dakiya.austria.eu.net") by vger.kernel.org with ESMTP
	id <S285161AbRL2SZv>; Sat, 29 Dec 2001 13:25:51 -0500
Subject: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
From: Harald Holzer <harald.holzer@eunet.at>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 29 Dec 2001 19:18:17 +0100
Message-Id: <1009649897.12942.2.camel@hh2.hhhome.at>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are there some i686 SMP systems with more then 12 GB ram out there ?

Is there a known problem with 2.4.x kernel and such systems ?

I have the following problem:

A Intel SRPM8 Server with 32 GB ram and RH 7.2 and kernel 2.4.17 on it.
After doing a lot of disc access the system slows down and the oom
killer begins his work. (only after running some cp processes.)
Because the system is running out of low memory.

Disable the oom killer has no affect, the low memory is going to 0
and the system dies.

It looks like as the buffer_heads would fill the low memory up,
whether there is sufficient memory available or not, as long as
there is sufficient high memory for caching.

Any ideas ?

Here some information from /proc/meminfo and /proc/slabinfo some
seconds before dying:

        total:    used:    free:  shared: buffers:  cached:
Mem:  33781227520 10787348480 22993879040        0 21807104 10447962112
Swap:        0        0        0
MemTotal:     32989480 kB
MemFree:      22454960 kB
MemShared:           0 kB
Buffers:         21296 kB
Cached:       10203088 kB
SwapCached:          0 kB
Active:          27248 kB
Inact_dirty:  10206312 kB
Inact_clean:         0 kB
Inact_target:  2046712 kB
HighTotal:    32636928 kB
HighFree:     22424128 kB
LowTotal:       352552 kB
LowFree:         30832 kB
SwapTotal:           0 kB
SwapFree:            0 kB

slabinfo - version: 1.1 (statistics) (SMP)
kmem_cache           112    112    284    8    8    1 :    112     112     8    0    0 :  124   62 :     12      9      0      0
ip_fib_hash          145    145     24    1    1    1 :    145     145     1    0    0 :  252  126 :      8      3      0      0
urb_priv               0      0     56    0    0    1 :      0       0     0    0    0 :  252  126 :      0      0      0      0
journal_head         755  11591     56   49  173    1 :  11591 1255589   173    0    0 :  252  126 : 1271927  10219 1272001   9959
revoke_table         169    169     20    1    1    1 :    169     169     1    0    0 :  252  126 :      0      3      0      0
revoke_record        126    145     24    1    1    1 :    126     126     1    0    0 :  252  126 :      2      2      3      0
clip_arp_cache         0      0    124    0    0    1 :      0       0     0    0    0 :  252  126 :      0      0      0      0
ip_mrt_cache           0      0     84    0    0    1 :      0       0     0    0    0 :  252  126 :      0      0      0      0
tcp_tw_bucket          0      0    128    0    0    1 :      0       0     0    0    0 :  252  126 :      0      0      0      0
tcp_bind_bucket      561    580     24    4    4    1 :    561     561     4    0    0 :  252  126 :      4     11      0      0
tcp_open_request     252    252     92    6    6    1 :    252     252     6    0    0 :  252  126 :      0     12      6      0
inet_peer_cache        0      0     48    0    0    1 :      0       0     0    0    0 :  252  126 :      0      0      0      0
ip_dst_cache         176    176    176    8    8    1 :    176     176     8    0    0 :  252  126 :     40     16     22      0
arp_cache             64     64    120    2    2    1 :     64      64     2    0    0 :  252  126 :      0      4      1      0
blkdev_requests     1056   1056     88   24   24    1 :   1056    1056    24    0    0 :  252  126 :   1128     48    256      0
dnotify cache          0      0     28    0    0    1 :      0       0     0    0    0 :  252  126 :      0      0      0      0
file lock cache      312    312    100    8    8    1 :    312     312     8    0    0 :  252  126 :  19870     16  19876      0
fasync cache           0      0     24    0    0    1 :      0       0     0    0    0 :  252  126 :      0      0      0      0
uid_cache            339    339     32    3    3    1 :    339     339     3    0    0 :  252  126 :      1      6      1      0
skbuff_head_cache   2438   2438    168  106  106    1 :   2438    3950   106    0    0 :  252  126 :   3943    224   3035     12
sock                 129    129   1280   43   43    1 :    129     189    43    0    0 :   60   30 :    435     87    443      2
sigqueue             252    252    140    9    9    1 :    252     252     9    0    0 :  252  126 :   1111     18   1118      0
cdev_cache           702    702     48    9    9    1 :    702     702     9    0    0 :  252  126 :    145     18      5      0
bdev_cache           354    354     64    6    6    1 :    354     354     6    0    0 :  252  126 :     20     12     23      0
mnt_cache            224    224     68    4    4    1 :    224     224     4    0    0 :  252  126 :      7      7      2      0
inode_cache         2224   2224    488  278  278    1 :   3872    4638   486    0    0 :  124   62 :  73933    984  72421     23
dentry_cache        2732   3828    116  116  116    1 :   5181    7701   157    0    0 :  252  126 :  76421    333  74349     21
dquot                  0      0    112    0    0    1 :      0       0     0    0    0 :  252  126 :      0      0      0      0
filp                 578    578    112   17   17    1 :    578     578    17    0    0 :  252  126 :    397     34      0      0
names_cache           18     18   4096   18   18    1 :     18      18    18    0    0 :   60   30 :  66979     36  66997      0
buffer_head       2557740 2559882    104 69151 69186    1 : 2559882 3919926 69186    0    0 :  252  126 : 5029666 149166 2542612  10811
mm_struct            216    216    144    8    8    1 :    216     216     8    0    0 :  252  126 :   1345     16   1317      0
vm_area_struct      1724   1850     76   37   37    1 :   1850    7772    37    0    0 :  252  126 :  53909    121  53030     48
fs_cache             588    588     44    7    7    1 :    588     588     7    0    0 :  252  126 :   1347     13   1320      0
files_cache          171    171    424   19   19    1 :    171     171    19    0    0 :  124   62 :   1335     37   1320      0
signal_act           162    162   1312   54   54    1 :    162     162    54    0    0 :   60   30 :   1305    103   1317      0
pae_pgd              791    791     32    7    7    1 :    791     791     7    0    0 :  252  126 :   1346     14   1317      0
size-131072(DMA)       0      0 131072    0    0   32 :      0       0     0    0    0 :    0    0 :      0      0      0      0
size-131072            0      0 131072    0    0   32 :      0       0     0    0    0 :    0    0 :      0      0      0      0
size-65536(DMA)        0      0  65536    0    0   16 :      0       0     0    0    0 :    0    0 :      0      0      0      0
size-65536             0      0  65536    0    0   16 :      0       0     0    0    0 :    0    0 :      0      0      0      0
size-32768(DMA)        0      0  32768    0    0    8 :      0       0     0    0    0 :    0    0 :      0      0      0      0
size-32768             1      1  32768    1    1    8 :      1       2     1    0    0 :    0    0 :      0      0      0      0
size-16384(DMA)        1      1  16384    1    1    4 :      1       1     1    0    0 :    0    0 :      0      0      0      0
size-16384             1      1  16384    1    1    4 :      1       1     1    0    0 :    0    0 :      0      0      0      0
size-8192(DMA)         0      0   8192    0    0    2 :      0       0     0    0    0 :    0    0 :      0      0      0      0
size-8192              2      3   8192    2    3    2 :      3      41     3    0    0 :    0    0 :      0      0      0      0
size-4096(DMA)         0      0   4096    0    0    1 :      0       0     0    0    0 :   60   30 :      0      0      0      0
size-4096            207    237   4096  207  237    1 :    237     597   237    0    0 :   60   30 :    750    486    946     13
size-2048(DMA)         0      0   2048    0    0    1 :      0       0     0    0    0 :   60   30 :      0      0      0      0
size-2048            368    428   2048  194  214    1 :    428    2198   214    0    0 :   60   30 :   3169    487   3326     61
size-1024(DMA)         0      0   1024    0    0    1 :      0       0     0    0    0 :  124   62 :      0      0      0      0
size-1024            448    448   1024  112  112    1 :    448     448   112    0    0 :  124   62 :   1012    157    890      0
size-512(DMA)          0      0    512    0    0    1 :      0       0     0    0    0 :  124   62 :      0      0      0      0
size-512             520    520    512   65   65    1 :    520     520    65    0    0 :  124   62 :    460    115    116      0
size-256(DMA)          0      0    264    0    0    1 :      0       0     0    0    0 :  124   62 :      0      0      0      0
size-256             630    630    264   42   42    1 :    630     940    42    0    0 :  124   62 :   5914     82   5810      5
size-128(DMA)         28     28    136    1    1    1 :     28      28     1    0    0 :  252  126 :      0      2      0      0
size-128             868    868    136   31   31    1 :    868     869    31    0    0 :  252  126 :   2589     45   2374      0
size-64(DMA)           0      0     72    0    0    1 :      0       0     0    0    0 :  252  126 :      0      0      0      0
size-64              583    583     72   11   11    1 :    583     583    11    0    0 :  252  126 :   1200     19    975      0
size-32(DMA)          92     92     40    1    1    1 :     92      92     1    0    0 :  252  126 :     16      2      0      0
size-32             1384   2392     40   22   26    1 :   2392    2526    26    0    0 :  252  126 : 2569647     52 2568729      9

Regards,
Harald Holzer

