Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267665AbUHPOP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267665AbUHPOP0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 10:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267658AbUHPOPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 10:15:23 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:13742 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S267674AbUHPONl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 10:13:41 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Mon, 16 Aug 2004 10:13:38 -0400
User-Agent: KMail/1.6.82
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408160803.15206.vda@port.imtp.ilyichevsk.odessa.ua> <200408160232.52158.gene.heskett@verizon.net>
In-Reply-To: <200408160232.52158.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408161013.38430.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [151.205.63.91] at Mon, 16 Aug 2004 09:13:39 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 August 2004 02:32, Gene Heskett wrote:
>On Monday 16 August 2004 01:03, Denis Vlasenko wrote:
>>On Sunday 15 August 2004 23:33, Gene Heskett wrote:
>>> On Sunday 15 August 2004 15:57, Denis Vlasenko wrote:

[...]

>>> >Gene, you should have stopped using preempt/smp and sound
>>> > modules in an attempt to narrow down the bug. We already kinda
>>> > determined that you are experiencing random memory corruption,
>>> > but hardware was tested and seems to be ok. It's software,
>>> > then. Preempt/smp bug or buggy driver are prime suspects.
>>>
>>> Ok, non-preempt is building.  Will reboot to it when the build is
>>> done.
>>
>>Do not load sound modules too please, unless you absolutely need
>> sound.
>
>One thing at a time I think.  Thats major surgery on modprobe.conf
> to disable that, plus a chkconfig alsasound off.
>
>I've noticed that with preempt off, my kde curser motions are back
> to using the mouse if I want to move it more than a word or so to
> hit a typu and fix it.  Its an effect that comes and goes, often in
> the same message reply.  X is running at -1 I think.  Other than
> that (knock on wood) its running ok so far, but only 9h50m uptime.
[...]
With PREEMPT off, and a 16 hour uptime, I am suddenly nearly out of
memory again. As an additional tool, I had started ksysguard for its
gfx memory display and set it for a 1 minute update interval.  When 
I awoke again, the memory panel was 100% blue since some major event,
I assume logrotate by cron, ran but hadn't quite scrolled off screen.

However, there is no swapping yet, and nothing unusual in the log.
Here are /proc/meminfo:
MemTotal:      1035956 kB
MemFree:         14036 kB
Buffers:        181044 kB
Cached:         114024 kB
SwapCached:          0 kB
Active:         277684 kB
Inactive:       148840 kB
HighTotal:      131008 kB
HighFree:         9408 kB
LowTotal:       904948 kB
LowFree:          4628 kB
SwapTotal:     3857104 kB
SwapFree:      3857104 kB
Dirty:              12 kB
Writeback:           0 kB
Mapped:         202108 kB
Slab:           584876 kB
Committed_AS:   276216 kB
PageTables:       3340 kB
VmallocTotal:   114680 kB
VmallocUsed:     19876 kB
VmallocChunk:    94640 kB

and /proc/slabinfo:
slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
unix_sock            200    200    384   10    1 : tunables   54   27    0 : slabdata     20     20      0
tcp_tw_bucket          0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
tcp_bind_bucket       35    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_open_request       0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
inet_peer_cache        0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
ip_fib_hash           10    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
ip_dst_cache          15     15    256   15    1 : tunables  120   60    0 : slabdata      1      1      0
arp_cache              3     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
raw4_sock              0      0    480    8    1 : tunables   54   27    0 : slabdata      0      0      0
udp_sock               2      8    480    8    1 : tunables   54   27    0 : slabdata      1      1      0
tcp_sock              32     32   1024    4    1 : tunables   54   27    0 : slabdata      8      8      0
flow_cache             0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
mqueue_inode_cache      1      8    480    8    1 : tunables   54   27    0 : slabdata      1      1      0
udf_inode_cache        0      0    352   11    1 : tunables   54   27    0 : slabdata      0      0      0
smb_request            0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
smb_inode_cache        2     12    320   12    1 : tunables   54   27    0 : slabdata      1      1      0
isofs_inode_cache      0      0    320   12    1 : tunables   54   27    0 : slabdata      0      0      0
fat_inode_cache        4     22    352   11    1 : tunables   54   27    0 : slabdata      2      2      0
ext2_inode_cache       0      0    416    9    1 : tunables   54   27    0 : slabdata      0      0      0
journal_handle         8    135     28  135    1 : tunables  120   60    0 : slabdata      1      1      0
journal_head        1114   3888     48   81    1 : tunables  120   60    0 : slabdata     48     48      0
revoke_table          12    290     12  290    1 : tunables  120   60    0 : slabdata      1      1      0
revoke_record          0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
ext3_inode_cache  1000246 1020249    448    9    1 : tunables   54   27    0 : slabdata 113361 113361      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_epi          0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
kioctx                 0      0    160   25    1 : tunables  120   60    0 : slabdata      0      0      0
kiocb                  0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
dnotify_cache        172    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
file_lock_cache       43     43     92   43    1 : tunables  120   60    0 : slabdata      1      1      0
fasync_cache           2    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
shmem_inode_cache      6     10    384   10    1 : tunables   54   27    0 : slabdata      1      1      0
posix_timers_cache      0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache              7    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    0 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    0 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    0 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    0 : slabdata      3      3      0
sgpool-8              32     62    128   31    1 : tunables  120   60    0 : slabdata      2      2      0
cfq_pool              64    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
crq_pool               0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
deadline_drq           0      0     48   81    1 : tunables  120   60    0 : slabdata      0      0      0
as_arq                65     65     60   65    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_ioc            73    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_queue          12     18    448    9    1 : tunables   54   27    0 : slabdata      2      2      0
blkdev_requests       52     52    152   26    1 : tunables  120   60    0 : slabdata      2      2      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    0 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    0 : slabdata     52     52      0
biovec-16            256    260    192   20    1 : tunables  120   60    0 : slabdata     13     13      0
biovec-4             256    305     64   61    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1             320    452     16  226    1 : tunables  120   60    0 : slabdata      2      2      0
bio                  319    366     64   61    1 : tunables  120   60    0 : slabdata      6      6      0
sock_inode_cache     242    242    352   11    1 : tunables   54   27    0 : slabdata     22     22      0
skbuff_head_cache    235    450    160   25    1 : tunables  120   60    0 : slabdata     18     18      0
sock                   3     12    320   12    1 : tunables   54   27    0 : slabdata      1      1      0
proc_inode_cache     571    600    320   12    1 : tunables   54   27    0 : slabdata     50     50      0
sigqueue             108    108    148   27    1 : tunables  120   60    0 : slabdata      4      4      0
radix_tree_node    10212  21182    276   14    1 : tunables   54   27    0 : slabdata   1513   1513      0
bdev_cache            11     18    416    9    1 : tunables   54   27    0 : slabdata      2      2      0
mnt_cache             26     41     96   41    1 : tunables  120   60    0 : slabdata      1      1      0
inode_cache         2371   2380    288   14    1 : tunables   54   27    0 : slabdata    170    170      0
dentry_cache      718370 781704    140   28    1 : tunables  120   60    0 : slabdata  27918  27918      0
filp                2145   2300    160   25    1 : tunables  120   60    0 : slabdata     92     92      0
names_cache           17     17   4096    1    1 : tunables   24   12    0 : slabdata     17     17      0
idr_layer_cache       81     87    136   29    1 : tunables  120   60    0 : slabdata      3      3      0
buffer_head        51836  80919     48   81    1 : tunables  120   60    0 : slabdata    999    999      0
mm_struct             98     98    512    7    1 : tunables   54   27    0 : slabdata     14     14      0
vm_area_struct      7852   8272     84   47    1 : tunables  120   60    0 : slabdata    176    176      0
fs_cache             103    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
files_cache           99     99    416    9    1 : tunables   54   27    0 : slabdata     11     11      0
signal_cache         123    123     96   41    1 : tunables  120   60    0 : slabdata      3      3      0
sighand_cache        111    111   1312    3    1 : tunables   24   12    0 : slabdata     37     37      0
task_struct          115    120   1424    5    2 : tunables   24   12    0 : slabdata     24     24      0
anon_vma            1796   2035      8  407    1 : tunables  120   60    0 : slabdata      5      5      0
pgd                   90     90   4096    1    1 : tunables   24   12    0 : slabdata     90     90      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             1      1  65536    1   16 : tunables    8    4    0 : slabdata      1      1      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384            10     10  16384    1    4 : tunables    8    4    0 : slabdata     10     10      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192              9      9   8192    1    2 : tunables    8    4    0 : slabdata      9      9      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096            191    191   4096    1    1 : tunables   24   12    0 : slabdata    191    191      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048            172    192   2048    2    1 : tunables   24   12    0 : slabdata     96     96      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024            145    164   1024    4    1 : tunables   54   27    0 : slabdata     41     41      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512             184    448    512    8    1 : tunables   54   27    0 : slabdata     56     56      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256             165    435    256   15    1 : tunables  120   60    0 : slabdata     29     29      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
size-192             120    120    192   20    1 : tunables  120   60    0 : slabdata      6      6      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
size-128            1231   1271    128   31    1 : tunables  120   60    0 : slabdata     41     41      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
size-64            32409  33123     64   61    1 : tunables  120   60    0 : slabdata    543    543      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
size-32             1428   1428     32  119    1 : tunables  120   60    0 : slabdata     12     12      0
kmem_cache           124    124    128   31    1 : tunables  120   60    0 : slabdata      4      4      0

Note the size-64, dentry_cache and ext3_inode_cache lines
Now if I can remember that shell line to check /proc/fs/ext3
for dups:

Unforch, that doesn't want to work, cat is using 90% of the cpu,
and the command line: cat /proc/fs/ext3|sort|uniq -c|sort -nr
is hung.  But it will ctl-c.  Humm, cat /proc/fs/ext3 by itself
is running, its just got so much data that I ctl-c'd it after 1 minute.
This may be an interesting report IF it ever gets done.  But at 
10 megs for shell history I may have to redo it directed to a file!
Yes, at least 10 megs scrolled off the end of the scrollback buffer.
However, as I watched it scrolling, I never saw the first digit
change to a non-1 value.  Odd effect, the cpu temp is falling, 
by about 5C.  And with only 7 megs free according to top, its
still not swapping!

The file is just short of 24 megs.  Now to grep it for errors.

Aha!  There are some non-1 first digit values in that file!
[root@coyote linux-2.6.8-rc4]# grep ' 2 ' /ext3-allocs
      2 3:8:8227974:100644
      2 3:8:8227973:100644
      2 3:8:8227972:100644
      2 3:8:8227971:100644
      2 3:8:8193936:100644
      2 3:8:8193935:100644
      2 3:8:8193934:100644
      2 3:8:8193738:100644
      2 3:8:7834144:100644
      2 3:8:7834143:100644
      2 3:8:7684604:100644
      2 3:8:7521425:100644
      2 3:8:7521411:100644
      2 3:8:6360398:40755
      2 3:8:6013120:40755
      2 3:8:6013101:40755
      2 3:8:5982111:40755
      2 3:8:5982098:40755
      2 3:8:5982088:40775
      2 3:8:5949697:40777
      2 3:8:5949683:40777
      2 3:8:5947892:42755
      2 3:8:5947890:42755
      2 3:8:5915386:42755
      2 3:8:5915379:42755
      2 3:8:5901299:42755
      2 3:8:5901289:42755
      2 3:8:5835169:42777
      2 3:8:5835162:40755
      2 3:8:5835159:40755
      2 3:8:1250790:100644
      2 3:8:1250789:100644

However, thats the end of it:
[root@coyote linux-2.6.8-rc4]# grep ' 3 ' /ext3-allocs
[root@coyote linux-2.6.8-rc4]# grep ' 4 ' /ext3-allocs
[root@coyote linux-2.6.8-rc4]# grep ' 5 ' /ext3-allocs
[root@coyote linux-2.6.8-rc4]# grep ' 6 ' /ext3-allocs
[root@coyote linux-2.6.8-rc4]# grep ' 7 ' /ext3-allocs
[root@coyote linux-2.6.8-rc4]# grep ' 8 ' /ext3-allocs
[root@coyote linux-2.6.8-rc4]# grep ' 9 ' /ext3-allocs
[root@coyote linux-2.6.8-rc4]# grep ' 10 ' /ext3-allocs

So now we have an odor of a problem, the question is what does
it smell like?  What can I do next to shine a light on this?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
