Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266851AbTAIRYx>; Thu, 9 Jan 2003 12:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266886AbTAIRYx>; Thu, 9 Jan 2003 12:24:53 -0500
Received: from zeus.kernel.org ([204.152.189.113]:12480 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S266851AbTAIRYu>;
	Thu, 9 Jan 2003 12:24:50 -0500
Message-ID: <3E1DAEAC.4060904@xmission.com>
Date: Thu, 09 Jan 2003 10:17:32 -0700
From: Chris Wood <cwood@xmission.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440)
References: <3E1A12B5.4020505@xmission.com> <3E1A16C5.87EDE35A@digeo.com>
In-Reply-To: <3E1A16C5.87EDE35A@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Chris Wood wrote:
> 
>>Due to kswapd problems in Redhat's 2.4.9 kernel, I have had to upgrade
>>to the 2.4.20 kernel with the IBM Summit Patches for our IBM x440.
>>...
>>16480 total                                      0.0138
>>   6383 .text.lock.swap                          110.0517
>>   4689 .text.lock.vmscan                         28.2470
>>   4486 shrink_cache                               4.6729
>>    168 rw_swap_page_base                          0.6176
>>    124 prune_icache                               0.5167
> 
> 
> With six gigs of memory, it looks like the VM has gone nuts
> trying to locate some reclaimable lowmem.
> 
> Suggest you send the contents of /proc/meminfo and /proc/slabinfo,
> captured during a period of misbehaviour.

The server ran fine for 3 days, so it took a bit to get this info.

Is there a list of which patches I can apply if I don't want to apply 
the entire 2.4.20aa1?  I'm nervous about breaking other things, but may 
give it a try anyway.

Thanks for the help!

Here is a /proc/meminfo when it is running fine:

         total:    used:    free:  shared: buffers:  cached:
Mem:  6356955136 6035910656 321044480        0 206626816 5301600256
Swap: 2146529280 41652224 2104877056
MemTotal:      6207964 kB
MemFree:        313520 kB
MemShared:           0 kB
Buffers:        201784 kB
Cached:        5171716 kB
SwapCached:       5628 kB
Active:        3667492 kB
Inactive:      1912544 kB
HighTotal:     5373660 kB
HighFree:       203952 kB
LowTotal:       834304 kB
LowFree:        109568 kB
SwapTotal:     2096220 kB
SwapFree:      2055544 kB

Here is a /proc/meminfo when it is having problems:

         total:    used:    free:  shared: buffers:  cached:
Mem:  6356955136 6337114112 19841024        0 369520640 5160353792
Swap: 2146529280 96501760 2050027520
MemTotal:      6207964 kB
MemFree:         19376 kB
MemShared:           0 kB
Buffers:        360860 kB
Cached:        5023300 kB
SwapCached:      16108 kB
Active:        2551264 kB
Inactive:      3291804 kB
HighTotal:     5373660 kB
HighFree:        15404 kB
LowTotal:       834304 kB
LowFree:          3972 kB
SwapTotal:     2096220 kB
SwapFree:      2001980 kB

Here is a /proc/slabinfo when it is fine:

slabinfo - version: 1.1 (SMP)
kmem_cache            64     64    244    4    4    1 :  252  126
ip_fib_hash           14    224     32    2    2    1 :  252  126
ip_conntrack           0      0    384    0    0    1 :  124   62
urb_priv               0      0     64    0    0    1 :  252  126
journal_head        1141   5929     48   33   77    1 :  252  126
revoke_table           7    250     12    1    1    1 :  252  126
revoke_record        448    448     32    4    4    1 :  252  126
clip_arp_cache         0      0    128    0    0    1 :  252  126
ip_mrt_cache           0      0    128    0    0    1 :  252  126
tcp_tw_bucket        384    510    128   13   17    1 :  252  126
tcp_bind_bucket      442   1008     32    9    9    1 :  252  126
tcp_open_request     570    570    128   19   19    1 :  252  126
inet_peer_cache      232    232     64    4    4    1 :  252  126
ip_dst_cache         807   1185    256   79   79    1 :  252  126
arp_cache            354    480    128   16   16    1 :  252  126
blkdev_requests      768    810    128   27   27    1 :  252  126
dnotify_cache        500    664     20    4    4    1 :  252  126
file_lock_cache     1157   2120     96   53   53    1 :  252  126
fasync_cache         565    600     16    3    3    1 :  252  126
uid_cache            419    448     32    4    4    1 :  252  126
skbuff_head_cache    780   1410    256   65   94    1 :  252  126
sock                 426   1671   1280  288  557    1 :   60   30
sigqueue             725    725    132   25   25    1 :  252  126
kiobuf                 0      0     64    0    0    1 :  252  126
cdev_cache           703    870     64   15   15    1 :  252  126
bdev_cache             9    116     64    2    2    1 :  252  126
mnt_cache             18    116     64    2    2    1 :  252  126
inode_cache        50995  50995    512 7285 7285    1 :  124   62
dentry_cache       71760  71760    128 2392 2392    1 :  252  126
dquot                  0      0    128    0    0    1 :  252  126
filp               52314  52380    128 1746 1746    1 :  252  126
names_cache           28     28   4096   28   28    1 :   60   30
buffer_head       1342242 1486740    128 49558 49558    1 :  252  126
mm_struct            701   2355    256  155  157    1 :  252  126
vm_area_struct     11887  58530    128 1793 1951    1 :  252  126
fs_cache             831   2378     64   41   41    1 :  252  126
files_cache          597   2184    512  246  312    1 :  124   62
signal_act           501   2112   1408  168  192    4 :   60   30
pae_pgd              699   2378     64   41   41    1 :  252  126
size-131072(DMA)       0      0 131072    0    0   32 :    0    0
size-131072            0      0 131072    0    0   32 :    0    0
size-65536(DMA)        0      0  65536    0    0   16 :    0    0
size-65536             0      0  65536    0    0   16 :    0    0
size-32768(DMA)        0      0  32768    0    0    8 :    0    0
size-32768             1      5  32768    1    5    8 :    0    0
size-16384(DMA)        0      0  16384    0    0    4 :    0    0
size-16384             5     12  16384    5   12    4 :    0    0
size-8192(DMA)         0      0   8192    0    0    2 :    0    0
size-8192              5      7   8192    5    7    2 :    0    0
size-4096(DMA)         0      0   4096    0    0    1 :   60   30
size-4096            437   1127   4096  437 1127    1 :   60   30
size-2048(DMA)         0      0   2048    0    0    1 :   60   30
size-2048            314    434   2048  170  217    1 :   60   30
size-1024(DMA)         0      0   1024    0    0    1 :  124   62
size-1024            567   1464   1024  240  366    1 :  124   62
size-512(DMA)          0      0    512    0    0    1 :  124   62
size-512             906    968    512  120  121    1 :  124   62
size-256(DMA)          0      0    256    0    0    1 :  252  126
size-256            8724   8850    256  583  590    1 :  252  126
size-128(DMA)          2     60    128    2    2    1 :  252  126
size-128            3198   3450    128  114  115    1 :  252  126
size-64(DMA)           0      0    128    0    0    1 :  252  126
size-64             3486   4050    128  135  135    1 :  252  126
size-32(DMA)          34    116     64    2    2    1 :  252  126
size-32            22446  22446     64  387  387    1 :  252  126

Here is a /proc/slabinfo when it is having problems:

slabinfo - version: 1.1 (SMP)
kmem_cache            64     64    244    4    4    1 :  252  126
ip_fib_hash           14    224     32    2    2    1 :  252  126
ip_conntrack           0      0    384    0    0    1 :  124   62
urb_priv               0      0     64    0    0    1 :  252  126
journal_head        1660   3773     48   49   49    1 :  252  126
revoke_table           7    250     12    1    1    1 :  252  126
revoke_record          0      0     32    0    0    1 :  252  126
clip_arp_cache         0      0    128    0    0    1 :  252  126
ip_mrt_cache           0      0    128    0    0    1 :  252  126
tcp_tw_bucket        148    150    128    5    5    1 :  252  126
tcp_bind_bucket      696    896     32    8    8    1 :  252  126
tcp_open_request     120    120    128    4    4    1 :  252  126
inet_peer_cache      107    232     64    4    4    1 :  252  126
ip_dst_cache         960    960    256   64   64    1 :  252  126
arp_cache            232    360    128   12   12    1 :  252  126
blkdev_requests      768    810    128   27   27    1 :  252  126
dnotify_cache        238    332     20    2    2    1 :  252  126
file_lock_cache     1776   2040     96   51   51    1 :  252  126
fasync_cache         273    400     16    2    2    1 :  252  126
uid_cache            501    560     32    5    5    1 :  252  126
skbuff_head_cache    685   1020    256   68   68    1 :  252  126
sock                1095   1095   1280  365  365    1 :   60   30
sigqueue             203    203    132    7    7    1 :  252  126
kiobuf                 0      0     64    0    0    1 :  252  126
cdev_cache           725    754     64   13   13    1 :  252  126
bdev_cache             9    116     64    2    2    1 :  252  126
mnt_cache             18    116     64    2    2    1 :  252  126
inode_cache        13808  20755    512 2965 2965    1 :  124   62
dentry_cache        5976  14070    128  469  469    1 :  252  126
dquot                  0      0    128    0    0    1 :  252  126
filp               52314  52380    128 1746 1746    1 :  252  126
names_cache            8      8   4096    8    8    1 :   60   30
buffer_head       1335952 1470150    128 49005 49005    1 :  252  126
mm_struct           1620   1620    256  108  108    1 :  252  126
vm_area_struct     39180  39180    128 1306 1306    1 :  252  126
fs_cache            1815   1972     64   34   34    1 :  252  126
files_cache         1477   1477    512  211  211    1 :  124   62
signal_act          1430   1430   1408  130  130    4 :   60   30
pae_pgd             1798   1798     64   31   31    1 :  252  126
size-131072(DMA)       0      0 131072    0    0   32 :    0    0
size-131072            0      0 131072    0    0   32 :    0    0
size-65536(DMA)        0      0  65536    0    0   16 :    0    0
size-65536             0      0  65536    0    0   16 :    0    0
size-32768(DMA)        0      0  32768    0    0    8 :    0    0
size-32768             1      1  32768    1    1    8 :    0    0
size-16384(DMA)        0      0  16384    0    0    4 :    0    0
size-16384             5      5  16384    5    5    4 :    0    0
size-8192(DMA)         0      0   8192    0    0    2 :    0    0
size-8192              5      5   8192    5    5    2 :    0    0
size-4096(DMA)         0      0   4096    0    0    1 :   60   30
size-4096            981   1011   4096  981 1011    1 :   60   30
size-2048(DMA)         0      0   2048    0    0    1 :   60   30
size-2048            312    342   2048  167  171    1 :   60   30
size-1024(DMA)         0      0   1024    0    0    1 :  124   62
size-1024           1080   1080   1024  270  270    1 :  124   62
size-512(DMA)          0      0    512    0    0    1 :  124   62
size-512             832    832    512  104  104    1 :  124   62
size-256(DMA)          0      0    256    0    0    1 :  252  126
size-256            8550   8550    256  570  570    1 :  252  126
size-128(DMA)          2     60    128    2    2    1 :  252  126
size-128            2850   2850    128   95   95    1 :  252  126
size-64(DMA)           0      0    128    0    0    1 :  252  126
size-64             2591   4200    128  140  140    1 :  252  126
size-32(DMA)          34    116     64    2    2    1 :  252  126
size-32             2536   7134     64  123  123    1 :  252  126

> 
> Then please apply 
> http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20aa1.bz2
> and send a report on the outcome.



